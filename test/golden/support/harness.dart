import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xtra_pr_71/data/shared_preferences/prefs_repository.dart';
import 'package:xtra_pr_71/l10n/app_localizations.dart';
import 'package:xtra_pr_71/presentation/app/theme.dart' as app_theme;

/// A target Play Store form factor. The output PNG is [logical] × [dpr] in
/// physical pixels, and [logical]'s shortest side picks the app's responsive
/// `DeviceType` (phone / 7" tablet / 10" tablet).
class FormFactor {
  const FormFactor(this.name, this.logical, this.dpr);

  final String name;
  final Size logical;
  final double dpr;

  Size get physical => Size(logical.width * dpr, logical.height * dpr);
}

/// phone → 1080×2340 · 7" → 1200×1920 · 10" → 1600×2560 (all portrait, within
/// Play's 320–3840 px / ≤2:1 limits).
const formFactors = <FormFactor>[
  FormFactor('phone', Size(360, 780), 3),
  FormFactor('tab7', Size(600, 960), 2),
  FormFactor('tab10', Size(800, 1280), 2),
];

/// Routes every HTTP request to a fast failure so any stray fetch a screen
/// fires (e.g. USSD's operator detection) can't reach the network or leave a
/// pending timeout timer. The fake cubits supply the real data.
class _OfflineHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _OfflineHttpClient();
}

class _OfflineHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw const SocketException('offline (golden screenshots)');
}

/// One-time setup: install offline networking, load fonts, and pause the live
/// refresh loops so polling cubits don't arm timers.
void installScreenshotEnvironment() {
  HttpOverrides.global = _OfflineHttpOverrides();
  // 0 = "Off" → the dashboard cubit won't schedule a refresh timer.
  PrefsRepository().dashboardRefreshMs.value = 0;
  // Keep the live speed meter visible on Home; the statistics cubit's timer is
  // cancelled when the widget tree is disposed at the end of each shot.
  PrefsRepository().speedRefreshMs.value = 1000;
}

final ThemeData _theme = app_theme.theme.copyWith(
  textTheme: app_theme.theme.textTheme.apply(fontFamily: 'Roboto'),
  primaryTextTheme: app_theme.theme.primaryTextTheme.apply(fontFamily: 'Roboto'),
);

Widget _wrap(Widget child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('bn')],
      home: DefaultTextStyle.merge(
        style: const TextStyle(fontFamily: 'Roboto'),
        child: child,
      ),
    );

/// Renders [screen] at [ff] and writes/compares goldens/[name]_[ff].png.
///
/// [screen] is rebuilt per form factor via a builder so each gets a fresh
/// widget (and fresh fake cubits).
Future<void> captureScreen(
  WidgetTester tester, {
  required String name,
  required FormFactor ff,
  required Widget Function() screen,
}) async {
  tester.view.physicalSize = ff.physical;
  tester.view.devicePixelRatio = ff.dpr;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  // Tests disable shadows by default, which draws Material elevation as a hard
  // black outline (e.g. a "border" around the FAB). Render real soft shadows so
  // the screenshots match the installed app. Restored before the test body ends
  // (below) or the framework's painting-invariant check fails.
  debugDisableShadows = false;

  await tester.pumpWidget(_wrap(screen()));
  // Let localization delegates resolve and the first data frame settle.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));

  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('goldens/${name}_${ff.name}.png'),
  );

  // Restore the default before the test ends (painting-invariant check).
  debugDisableShadows = true;

  // Dispose the tree so any cubit refresh timers are cancelled before teardown.
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
}
