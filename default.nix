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
      hackage = {
        rev = "52415450270fb5d146097c36e74d1117ba0e4fe4";
        sha256 = "0cc7ls5awhb83jfm8kcaskglgqala32q5s8j87frz0f6wx57gbl4";
      };
    };


  pkgs = import ./nix/nixpkgs.nix { overlays = [ haskellPackagesOverlay ]; };

in
  pkgs.haskellPackages.template
