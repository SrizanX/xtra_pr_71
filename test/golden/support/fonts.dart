import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads real Roboto + Material Icons fonts so golden screenshots render actual
/// text and glyphs instead of the test framework's box font.
///
/// The font files are vendored under test/golden/fonts (copied from the Flutter
/// SDK's material_fonts cache) so this is self-contained and machine-independent.
Future<void> loadGoldenFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final roboto = FontLoader('Roboto');
  for (final file in const [
    'Roboto-Regular.ttf',
    'Roboto-Medium.ttf',
    'Roboto-Bold.ttf',
  ]) {
    roboto.addFont(_load('test/golden/fonts/$file'));
  }
  await roboto.load();

  final icons = FontLoader('MaterialIcons')
    ..addFont(_load('test/golden/fonts/MaterialIcons-Regular.otf'));
  await icons.load();
}

Future<ByteData> _load(String path) async {
  final bytes = await File(path).readAsBytes();
  return ByteData.view(Uint8List.fromList(bytes).buffer);
}
