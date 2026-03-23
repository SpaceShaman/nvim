{
  description = "My packaged Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        baseDeps = with pkgs; [
          neovim
          git
          ripgrep
          fd
          curl
          unzip
          gcc
        ];

        lspDeps = with pkgs; [
          lua-language-server
          ruff
          ty
          typescript-language-server
          tailwindcss-language-server
          vue-language-server
          elixir-ls
          dockerfile-language-server
          docker-compose-language-service
          stylua
          prettier
          tombi
        ];

        runtimeDeps = baseDeps ++ lspDeps;

        nvim-config = pkgs.stdenvNoCC.mkDerivation {
          name = "nvim-config";
          src = ./.;

          installPhase = ''
            mkdir -p $out/nvim
            cp ${./init.lua} $out/nvim/init.lua
            cp ${./lazy-lock.json} $out/nvim/lazy-lock.json
            cp -r ${./lua} $out/nvim/lua
          '';
        };

        nvim = pkgs.writeShellApplication {
          name = "nvim";
          runtimeInputs = baseDeps ++ lspDeps;
          text = ''
            export XDG_CONFIG_HOME="${nvim-config}"
            export PATH="${pkgs.lib.makeBinPath runtimeDeps}"
            exec nvim "$@"
          '';
        };
      in {
        packages.default = nvim;

        apps.default = {
          type = "app";
          program = "${nvim}/bin/nvim";
        };
      }
    );
}
