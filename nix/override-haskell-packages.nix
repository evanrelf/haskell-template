{ packages ? {}  # Add or replace Haskell packages
, overrides ? {} # Override existing Haskell packages
, hackage ? null # Specify revision of all-cabal-hashes
}:

pkgsNew: pkgsOld:

let
  packagesExtension = pkgsOld.haskell.lib.packageSourceOverrides packages;

  overridesExtension = haskellPackagesNew: haskellPackagesOld:
    let
      applyOverride = name: fn:
        pkgsOld.haskell.lib.overrideCabal haskellPackagesOld."${name}" fn;
    in
      pkgsOld.lib.mapAttrs applyOverride overrides;

  haskellPackages = pkgsOld.haskellPackages.override (old: {
    overrides =
      pkgsOld.lib.fold
        pkgsOld.lib.composeExtensions
        (old.overrides or (_: _: {}))
        [ packagesExtension
          overridesExtension
        ];
  });

  all-cabal-hashes =
    if builtins.isNull hackage then
      pkgsOld.all-cabal-hashes
    else
      pkgsOld.fetchurl {
        url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/${hackage.rev}.tar.gz";
        sha256 = hackage.sha256;
      };

in
  { inherit
      haskellPackages
      all-cabal-hashes
    ;
  }
