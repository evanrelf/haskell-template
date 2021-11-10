pkgsFinal: pkgsPrev:

let
  gitignore = pkgsPrev.callPackage ../lib/gitignore.nix { };

in
{
  lib = pkgsPrev.lib // {
    haskellOverlay = import ../lib/haskell-overlay.nix;

    inherit (gitignore)
      gitignoreSource
      gitignoreFilter
      ;
  };
}
