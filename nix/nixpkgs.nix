let
  # nixos-19.09 on 2020-02-17
  rev = "8731aaaf8b30888bc24994096db830993090d7c4";
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "16wdsazc7g09ibcxlqsa3kblzhbbpdpb6s29llliybw73cp37b9s";
  };
in
  import nixpkgs
