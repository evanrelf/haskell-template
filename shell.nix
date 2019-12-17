{ pkgs ? import ./nixpkgs.nix {} }:

let
  template = import ./default.nix {};
in
  pkgs.lib.overrideDerivation template.env (old: {
    buildInputs = with pkgs; old.buildInputs ++ [ cabal-install ghcid hlint ];
  })
