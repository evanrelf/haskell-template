pkgsFinal: pkgsPrev:

let
  mkOverlay =
    { compiler ? null
    , hackage ? null
    , extensions ? [ ]
    }:
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
              extensions;
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

  sources = extension: haskellPackagesFinal: haskellPackagesPrev:
    pkgsPrev.haskell.lib.packageSourceOverrides
      (extension haskellPackagesFinal haskellPackagesPrev)
      haskellPackagesFinal
      haskellPackagesPrev;

  override = extension: haskellPackagesFinal: haskellPackagesPrev:
    pkgsPrev.lib.mapAttrs
      (name: fn: haskellPackagesPrev."${name}".override fn)
      (extension haskellPackagesFinal haskellPackagesPrev);

  overrideCabal = extension: haskellPackagesFinal: haskellPackagesPrev:
    pkgsPrev.lib.mapAttrs
      (name: fn:
        pkgsPrev.haskell.lib.overrideCabal
          haskellPackagesPrev."${name}"
          fn)
      (extension haskellPackagesFinal haskellPackagesPrev);

  overrideAttrs = extension: haskellPackagesFinal: haskellPackagesPrev:
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
