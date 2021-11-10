let
  mkOverlay =
    { compiler ? null
    , hackage ? null
    , extensions ? [ ]
    }:
    pkgsFinal: pkgsPrev:
    let
      canHydrate = f:
        builtins.isFunction f &&
        builtins.elem "INTERNAL" (builtins.attrNames (builtins.functionArgs f));

      hydrate = f:
        if canHydrate f then
          f { inherit pkgsFinal pkgsPrev; }
        else
          f;
    in
    {
      haskellPackages =
        (if compiler == null then
          pkgsPrev.haskellPackages
        else
          pkgsPrev.haskell.packages."${compiler}"
        ).override (prev: {
          overrides =
            pkgsPrev.lib.fold
              pkgsPrev.lib.composeExtensions
              (prev.overrides or (_: _: { }))
              (builtins.map hydrate extensions);
        });

      all-cabal-hashes =
        if hackage == null then
          pkgsPrev.all-cabal-hashes
        else
          pkgsPrev.fetchurl {
            url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/${hackage.rev}.tar.gz";
            sha256 = hackage.sha256;
          };
    };

  sources = extension:
    { pkgsFinal, pkgsPrev, INTERNAL ? null }:
    haskellPackagesFinal: haskellPackagesPrev:
      pkgsPrev.haskell.lib.packageSourceOverrides
        (extension haskellPackagesFinal haskellPackagesPrev)
        haskellPackagesFinal
        haskellPackagesPrev;

  override = extension:
    { pkgsFinal, pkgsPrev, INTERNAL ? null }:
    haskellPackagesFinal: haskellPackagesPrev:
      pkgsPrev.lib.mapAttrs
        (name: fn: haskellPackagesPrev."${name}".override fn)
        (extension haskellPackagesFinal haskellPackagesPrev);

  overrideCabal = extension:
    { pkgsFinal, pkgsPrev, INTERNAL ? null }:
    haskellPackagesFinal: haskellPackagesPrev:
      pkgsPrev.lib.mapAttrs
        (name: fn:
          pkgsPrev.haskell.lib.overrideCabal
            haskellPackagesPrev."${name}"
            fn)
        (extension haskellPackagesFinal haskellPackagesPrev);

  overrideAttrs = extension:
    { pkgsFinal, pkgsPrev, INTERNAL ? null }:
    haskellPackagesFinal: haskellPackagesPrev:
      pkgsPrev.lib.mapAttrs
        (name: fn: haskellPackagesPrev."${name}".overrideAttrs fn)
        (extension haskellPackagesFinal haskellPackagesPrev);

in
{
  inherit
    mkOverlay
    sources
    override
    overrideCabal
    overrideAttrs
    ;
}
