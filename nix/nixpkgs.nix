args:

let
  # master on 2021-10-24
  rev = "a3f85aedb1d66266b82d9f8c0a80457b4db5850c";
  sha256 = "1qq0d8nc3c16xxrx8awilz57kq6k23nzpq6782h7701zi7gikcax";

  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    inherit sha256;
  };

in
import nixpkgs ({ config = { }; } // args)
