{ pkgs ? import ./nixpkgs.nix {} }:

(import ./default.nix {}).env.overrideAttrs (old: {
  buildInputs = with pkgs; old.buildInputs ++ [ cabal-install ghcid hlint ];
})
