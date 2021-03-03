pkgsFinal: pkgsPrev:

import ./lib/override-haskell-packages.nix {
  packages = {
    "template" = pkgsPrev.nix-gitignore.gitignoreSource [ ../.nixignore ] ../.;
  };
} pkgsFinal pkgsPrev
