/// Global toggle for the in-app demo / guest mode.
///
/// When enabled, every API service returns canned [DemoData] instead of talking
/// to the router, so the whole app can be explored without the hardware. It is
/// entered through a built-in demo account ([username] / [password]) on the
/// normal login screen — this is what lets Play reviewers reach every screen
/// (the app can't otherwise be used without the physical router on the local
/// network). Those credentials are declared in Play Console → App access.
///
/// The flag itself isn't persisted; signing in with the demo account each
/// session sets it (and "stay logged in" re-enters it on relaunch via the
/// saved credentials).
abstract final class DemoMode {
  static bool enabled = false;

  /// Built-in demo credentials. Entering these on the login screen opens the
  /// app in demo mode instead of contacting a router.
  static const String username = 'demo';
  static const String password = 'demo';

  static bool matches(String user, String pass) =>
      user.trim() == username && pass == password;
}
