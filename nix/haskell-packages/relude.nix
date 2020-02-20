{ mkDerivation, base, bytestring, containers, deepseq, doctest
, gauge, ghc-prim, Glob, hashable, hedgehog, mtl, QuickCheck
, stdenv, stm, text, transformers, unordered-containers
}:
mkDerivation ({
  pname = "relude";
  version = "0.6.0.0";
  sha256 = "2c3a24a8e7b8143386bfec276046387300f66d5de523a0e3d653a50d4d0eae45";
  libraryHaskellDepends = [
    base bytestring containers deepseq ghc-prim hashable mtl stm text
    transformers unordered-containers
  ];
  testHaskellDepends = [
    base bytestring doctest Glob hedgehog QuickCheck text
  ];
  benchmarkHaskellDepends = [
    base containers gauge unordered-containers
  ];
  homepage = "https://github.com/kowainik/relude";
  description = "Custom prelude from Kowainik";
  license = stdenv.lib.licenses.mit;
} // {
  # Project-specific modifications
  doCheck = false;
  patches = [ ./relude.patch ];
})
