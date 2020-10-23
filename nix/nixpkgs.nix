args:

let
  # release-20.09 on 2020-10-22
  rev = "1d10a2af91d31e0da00b3259cc976c7c0033ba85";
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "05iday54fvsrpri8sdmib59w1kq2afwd2zxwgdrhwiaj77s676fc";
  };

in
  import nixpkgs ({ config = {}; } // args)
