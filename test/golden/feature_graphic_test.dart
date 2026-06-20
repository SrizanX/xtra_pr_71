// Play Store feature graphic generator (1024×500 PNG).
//
//   Generate:  flutter test test/golden/feature_graphic_test.dart --update-goldens
//
// Output: test/golden/goldens/feature_graphic.png — upload under Play Console →
// Store listing → Graphics → Feature graphic.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/feature_graphic.dart';
import 'support/fonts.dart';

void main() {
  setUpAll(() async {
    await loadGoldenFonts();
  });

  testWidgets('feature graphic 1024x500', (tester) async {
    // 1024×500 logical at dpr 1 → exactly 1024×500 px.
    tester.view.physicalSize = const Size(1024, 500);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Render the soft glow/shadow instead of the test box outline.
    debugDisableShadows = false;

    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTextStyle(
          style: TextStyle(fontFamily: 'Roboto'),
          child: FeatureGraphic(),
        ),
      ),
    );
    await tester.pump();

    await expectLater(
      find.byType(FeatureGraphic),
      matchesGoldenFile('goldens/feature_graphic.png'),
    );

    // Restore before the test ends (painting-invariant check).
    debugDisableShadows = true;
  });
}
