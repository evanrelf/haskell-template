pkgsFinal: pkgsPrev:

let
  gitignore = pkgsPrev.callPackage ../lib/gitignore.nix { };

in
{
  lib = pkgsPrev.lib // {
    inherit (gitignore)
      gitignoreSource
      gitignoreFilter
      ;
  };
}
