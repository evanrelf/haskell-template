{ compiler ? null
, packages ? (_: _: { })
, override ? (_: _: { })
, overrideCabal ? (_: _: { })
, overrideAttrs ? (_: _: { })
, hackage ? null
}:

pkgsFinal: pkgsPrev:

let
  packagesExtension = haskellPackagesFinal: haskellPackagesPrev:
    pkgsPrev.haskell.lib.packageSourceOverrides
      (packages haskellPackagesFinal haskellPackagesPrev)
      haskellPackagesFinal
      haskellPackagesPrev;

  overrideExtension = haskellPackagesFinal: haskellPackagesPrev:
    pkgsPrev.lib.mapAttrs
      (name: fn: haskellPackagesPrev."${name}".override fn)
      (override haskellPackagesFinal haskellPackagesPrev);

  overrideAttrsExtension = haskellPackagesFinal: haskellPackagesPrev:
    pkgsPrev.lib.mapAttrs
      (name: fn: haskellPackagesPrev."${name}".overrideAttrs fn)
      (overrideAttrs haskellPackagesFinal haskellPackagesPrev);

  overrideCabalExtension = haskellPackagesFinal: haskellPackagesPrev:
    pkgsPrev.lib.mapAttrs
      (name: fn: pkgsPrev.haskell.lib.overrideCabal haskellPackagesPrev."${name}" fn)
      (overrideCabal haskellPackagesFinal haskellPackagesPrev);

  haskellPackages =
    (if compiler == null then
      pkgsPrev.haskellPackages
    else
      pkgsPrev.haskell.packages."${compiler}"
    ).override (old: {
      overrides =
        pkgsPrev.lib.fold
          pkgsPrev.lib.composeExtensions
          (old.overrides or (_: _: { }))
          [
            packagesExtension
            overrideExtension
            overrideCabalExtension
            overrideAttrsExtension
          ];
    });

  all-cabal-hashes =
    if hackage == null then
      pkgsPrev.all-cabal-hashes
    else
      pkgsPrev.fetchurl {
        url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/${hackage.rev}.tar.gz";
        sha256 = hackage.sha256;
      };

in
{
  inherit
    haskellPackages
    all-cabal-hashes
    ;
}
