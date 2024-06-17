final: prev:

let
  inherit (prev) haskell-overlay;

in
haskell-overlay.mkOverlay
{
  extensions = [
    (haskell-overlay.sources (hfinal: hprev: {
      template = ../../.;
    }))

    (haskell-overlay.overrideCabal (hfinal: hprev: {
      template = attrs: {
        doBenchmark = true;
      };
    }))
  ];
}
  final
  prev
