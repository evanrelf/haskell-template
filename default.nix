let
  src =
    pkgs.nix-gitignore.gitignoreSource [
      ".git/"
      "/nix/"
      "/default.nix"
      "/shell.nix"
      "/README.md"
      "/LICENSE"
    ] ./.;

  overlay = pkgsNew: pkgsOld: {
    haskellPackages = pkgsOld.haskellPackages.override (old: {
      overrides =
        let
          extension = haskellPackagesNew: haskellPackagesOld: {
            template =
              haskellPackagesNew.callCabal2nix "template" src {};
            relude =
              haskellPackagesNew.callPackage ./nix/haskell-packages/relude.nix {};
          };
        in
          pkgsNew.lib.composeExtensions
            (old.overrides or (_: _: {}))
            extension;
    });
  };

  pkgs =
    import ./nix/nixpkgs.nix {
      overlays = [ overlay ];
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
