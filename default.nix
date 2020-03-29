let
  haskellPackagesOverlay = pkgsNew: pkgsOld: {
    haskellPackages = pkgsOld.haskellPackages.override (old: {
      overrides =
        let
          directory = ./nix/haskell-packages;

          overridePackages =
            pkgsNew.haskell.lib.packagesFromDirectory { inherit directory; };

          patchPackages = haskellPkgsNew: haskellPkgsOld:
            let
              packageNames =
                builtins.map
                  (pkgsNew.lib.removeSuffix ".patch")
                  (builtins.filter
                    (pkgsNew.lib.hasSuffix ".patch")
                    (builtins.attrNames (builtins.readDir directory)));

              patchPackage = name:
                if haskellPkgsOld ? "${name}" then
                  pkgsNew.haskell.lib.overrideCabal haskellPkgsOld."${name}" (oldDrv: {
                    patches =
                      (if oldDrv ? patches then oldDrv.patches else [])
                      ++ [ (directory + "/${name}.patch") ];
                  })
                else
                  throw "'${name}' is not in the Haskell package set";
            in
              builtins.listToAttrs
                (builtins.map
                  (name: { inherit name; value = patchPackage name; })
                  packageNames);
        in
          pkgsNew.lib.fold
            pkgsNew.lib.composeExtensions
            (old.overrides or (_: _: {}))
            [ overridePackages
              patchPackages
            ];
    });
  };


  pkgs =
    import ./nix/nixpkgs.nix {
      overlays = [ haskellPackagesOverlay ];
      config = {};
    };


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
