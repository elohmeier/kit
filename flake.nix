{
  inputs = {
    nixpkgs.url = "github:elohmeier/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-linux" ];
      perSystem = { config, pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.nodePackages.pnpm ];
        };
      };
    };
}

