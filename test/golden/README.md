# Play Store screenshots (golden harness)

Renders each screen with canned sample data at three Play Store form factors and
writes PNGs to `goldens/`. No emulator, device, or router is needed — it runs
headless via `flutter test`.

## Commands

```bash
# Generate / refresh all screenshots + the feature graphic
flutter test test/golden --update-goldens

# Verify they still match (no regeneration) — useful in CI
flutter test test/golden
```

Output lands in `test/golden/goldens/<screen>_<formfactor>.png`.

## Feature graphic

`feature_graphic_test.dart` renders the 1024×500 Play Store feature graphic
(`goldens/feature_graphic.png`) — the branded banner shown atop the listing.
Edit `support/feature_graphic.dart` to change it. Upload under Play Console →
Store listing → Graphics → Feature graphic.

## Output

| Form factor | File suffix | Pixels | Use in Play Console |
|-------------|-------------|--------|---------------------|
| Phone       | `_phone`    | 1080×2340 | Phone screenshots (required) |
| 7" tablet   | `_tab7`     | 1200×1920 | 7-inch tablet (optional) |
| 10" tablet  | `_tab10`    | 1600×2560 | 10-inch tablet (optional) |

Screens captured: `login`, `home`, `network`, `contacts`, `messages`, `ussd`.

All sizes are within Play's limits (each side 320–3840 px, aspect ratio ≤ 2:1).
Upload the PNGs directly under Play Console → Store listing → Graphics.

## How it works

- `support/sample_data.dart` — the canned entities/states each screen shows.
- `support/fakes.dart` — cubit subclasses that emit the sample data instead of
  calling the router (they override the public `fetch…` method the real cubit
  calls from its constructor, so no network request is ever made).
- `support/harness.dart` — form-factor sizes, the `MaterialApp` wrapper (app
  theme + localizations), an offline `HttpOverrides` safety net, and
  `captureScreen()`. Refresh intervals are set to 0 so polling cubits don't arm
  timers, and the tree is disposed after each shot.
- `support/fonts.dart` — loads real Roboto + Material Icons (vendored under
  `fonts/`) so text and glyphs render instead of the test box font.

## Adding a screen

1. Add sample data to `sample_data.dart` (if needed).
2. Add a `Fake…Cubit` to `fakes.dart` for any cubit the screen reads.
3. Add an entry to the `screens` map in `screenshots_test.dart`.
4. Run with `--update-goldens`.

## Notes

- The vendored fonts in `fonts/` come from the Flutter SDK's `material_fonts`
  cache (Apache-2.0 / SIL OFL) and keep the harness machine-independent.
- These goldens are marketing artifacts, not pixel-regression tests. If a UI
  change shifts pixels, just re-run with `--update-goldens`.
