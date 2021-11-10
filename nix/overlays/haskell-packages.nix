pkgsFinal: pkgsPrev:

let
  inherit (pkgsPrev.lib) haskellOverlay;

in
haskellOverlay.mkOverlay {
  extensions = [
    (haskellOverlay.sources (haskellPackagesFinal: haskellPackagesPrev: {
      "template" = pkgsPrev.lib.gitignoreSource ../../.;
    }))
  ];
}
pkgsFinal
pkgsPrev
