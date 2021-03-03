{ pkgs ? import ./nix/pkgs.nix }:

{
  template = pkgs.haskellPackages.template;
}
