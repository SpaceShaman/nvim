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

        runtimeDeps = with pkgs; [
          neovim
          git
          ripgrep
          fd
          curl
          unzip
          gcc
        ];

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
          runtimeInputs = runtimeDeps;
          text = ''
            export XDG_CONFIG_HOME="${nvim-config}"
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
