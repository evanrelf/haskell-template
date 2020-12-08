let
  pkgs = import ./nix/nixpkgs.nix {};

  template = import ./default.nix;

in
  template.env.overrideAttrs (old: {
    buildInputs = with pkgs; old.buildInputs ++ [
      cabal-install
      ghcid
      hlint
    ];
  })
