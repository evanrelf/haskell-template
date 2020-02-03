let
  # HEAD of nixos-19.09 branch as of 2020-02-02
  rev = "8b76b1252052ed36eb0cd6e002d299fdff4859e3";
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "11m5gwldg20ai1hpf4k7bclncm6z22468ydiig07scxz2kaiwvcg";
  };
in
  import nixpkgs
