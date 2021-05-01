import ./nixpkgs.nix {
  overlays = [
    (import ./overlays/lib.nix)
    (import ./overlays/haskell-packages.nix)
  ];
}
