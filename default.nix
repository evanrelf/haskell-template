{ pkgs ? import ./nixpkgs.nix {} }:

pkgs.haskellPackages.callCabal2nix "template" ./. {}
