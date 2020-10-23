let
  haskellPackagesOverlay =
    import ./nix/override-haskell-packages.nix {
      packages = {
        "template" = pkgs.nix-gitignore.gitignoreSource [ ./.nixignore ] ./.;
      };
      overrides = {
        "relude" = oldCabal: {
          patches = (oldCabal.patches or []) ++ [ ./nix/patches/relude.patch ];
        };
      };
    };


  pkgs = import ./nix/nixpkgs.nix { overlays = [ haskellPackagesOverlay ]; };


  template = pkgs.haskellPackages.template;


  executable = pkgs.haskell.lib.justStaticExecutables template;


  shell =
    template.env.overrideAttrs (old: {
      buildInputs = with pkgs; old.buildInputs ++ [
        cabal-install
        ghcid
        hlint
      ];
    });

in
  { inherit
      template
      executable
      shell
    ;
  }
