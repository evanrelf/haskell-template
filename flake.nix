{
  description = "template";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    ghciwatch-compat = {
      url = "github:evanrelf/ghciwatch-compat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haskell-overlay.url = "github:evanrelf/haskell-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem = { config, inputs', pkgs, system, ... }: {
        _module.args.pkgs =
          import inputs.nixpkgs {
            localSystem = system;
            overlays = [
              inputs.ghciwatch-compat.overlays.default
              inputs.haskell-overlay.overlay
              (import ./nix/overlays/haskell-packages.nix)
            ];
          };

        packages = {
          default = config.packages.template;

          template = pkgs.haskellPackages.template;
        };

        devShells.default =
          pkgs.mkShell {
            inputsFrom = [ config.packages.template.env ];
            packages = [
              pkgs.cabal-install
              pkgs.ghciwatch-compat-ghcid
              pkgs.nixpkgs-fmt
            ];
          };
      };
    };
}
