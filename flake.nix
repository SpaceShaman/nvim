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

        nvim = pkgs.writeShellApplication {
          name = "nvim";
          runtimeInputs = runtimeDeps;
          text = ''
            XDG_CONFIG_HOME="$(mktemp -d)"
            export XDG_CONFIG_HOME

            mkdir -p "$XDG_CONFIG_HOME/nvim"

            cp ${./init.lua} "$XDG_CONFIG_HOME/nvim/init.lua"
            cp ${./lazy-lock.json} "$XDG_CONFIG_HOME/nvim/lazy-lock.json"
            cp -r ${./lua} "$XDG_CONFIG_HOME/nvim/lua"

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
