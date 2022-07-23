{
  description = "template";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    haskell-overlay.url = "github:evanrelf/haskell-overlay";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs =
          import nixpkgs {
            inherit system;
            overlays = [
              inputs.haskell-overlay.overlay
              inputs.gitignore.overlay
              (import ./nix/overlays/haskell-packages.nix)
            ];
          };
      in
      rec {
        packages = {
          default = packages.template;

          template = pkgs.haskellPackages.template;
        };

        devShells = {
          default = devShells.template;

          template = pkgs.haskellPackages.template-shell;
        };
      }
    );
}
