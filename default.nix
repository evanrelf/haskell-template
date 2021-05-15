let
  pkgs = import ./nix/pkgs.nix;

in
{
  template = pkgs.haskellPackages.template;
}
