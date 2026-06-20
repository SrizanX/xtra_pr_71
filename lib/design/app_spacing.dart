/// Spacing scale (logical pixels).
///
/// Use these instead of magic numbers so vertical rhythm and gaps stay
/// consistent across the app. For gaps that should *grow* on bigger screens,
/// wrap the value with `context.scaled(...)` (see responsive.dart).
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

/// Corner-radius scale.
abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 20;
  static const double xl = 28;

  /// Fully rounded (pill / circle).
  static const double pill = 999;
}
