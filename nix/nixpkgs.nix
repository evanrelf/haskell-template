let
  # nixos-20.03 on 2020-03-23
  rev = "b2935fbeceaea0b64df4401545d7c8ea29102120";
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "1z1631v7q2c8mavy7xnvfx0wz34zd49jqmjg66nk0qgsi605m3qp";
  };
in
  import nixpkgs
