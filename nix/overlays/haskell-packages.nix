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
  ];
}
  pkgsFinal
  pkgsPrev
