pkgsFinal: pkgsPrev:

let
  haskellOverlay = import ../lib/haskell-overlay.nix pkgsFinal pkgsPrev;

in
haskellOverlay.mkOverlay {
  extensions = [
    (haskellOverlay.sources (haskellPackagesFinal: haskellPackagesPrev: {
      "template" = pkgsPrev.lib.gitignoreSource ../../.;
    }))
  ];
}
