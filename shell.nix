{ pkgs ? import ./nix/pkgs.nix }:

pkgs.haskellPackages.shellFor {
  packages = p: [
    p.template
  ];

  buildInputs = [
    pkgs.cabal-install
    pkgs.ghcid
  ];

  withHoogle = true;
}
