import ./nixpkgs.nix {
  overlays = [
    (import ./overlays/haskell-packages.nix)
  ];
}
