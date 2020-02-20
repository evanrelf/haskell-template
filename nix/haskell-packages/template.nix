{ callCabal2nix, ... }:

let
  pkgs = import ../nixpkgs.nix { config = {}; };

  src =
    pkgs.nix-gitignore.gitignoreSource [
      ".git/"
      "/nix/"
      "/*.nix"
    ] ../../.;
in
  callCabal2nix "template" src {}
