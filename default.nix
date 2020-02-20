let
  haskellPackagesOverlay = pkgsNew: pkgsOld: {
    haskellPackages = pkgsOld.haskellPackages.override (old: {
      overrides =
        let
          extension =
            (pkgsNew.haskell.lib.packagesFromDirectory {
              directory = ./nix/haskell-packages;
            });
        in
          pkgsNew.lib.composeExtensions
            (old.overrides or (_: _: {}))
            extension;
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
