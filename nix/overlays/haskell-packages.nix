pkgsFinal: pkgsPrev:

let
  inherit (pkgsPrev) haskell-overlay;

in
haskell-overlay.mkOverlay
{
  extensions = [
    (haskell-overlay.sources (haskellPackagesFinal: haskellPackagesPrev: {
      "template" = pkgsPrev.gitignoreSource ../../.;
    }))

    (haskellPackagesFinal: haskellPackagesPrev: {
      "template-shell" =
        pkgsFinal.haskellPackages.shellFor {
          packages = p: [
            p.template
          ];

          buildInputs = [
            pkgsFinal.cabal-install
            pkgsFinal.ghcid
            pkgsFinal.haskellPackages.fourmolu
            pkgsFinal.nixpkgs-fmt
          ];

          withHoogle = true;
        };
    })
  ];
}
  pkgsFinal
  pkgsPrev
