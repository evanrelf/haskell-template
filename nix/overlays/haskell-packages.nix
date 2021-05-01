pkgsFinal: pkgsPrev:

let
  overrideHaskellPackages = attrs:
    import ../lib/override-haskell-packages.nix attrs pkgsFinal pkgsPrev;

in
overrideHaskellPackages {
  packages = {
    "template" = pkgsPrev.lib.gitignoreSource ../../.;
  };
}
