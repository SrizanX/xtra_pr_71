import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepository {
  SharedPreferences? _prefs;

  PrefsRepository._();

  /// Refresh intervals in milliseconds; `0` means polling is paused (Off).
  /// Exposed as listenables so a change in Settings reaches the live Home
  /// cubits even though they live in a separate navigation branch.
  static const int defaultSpeedRefreshMs = 1000;
  static const int defaultDashboardRefreshMs = 15000;

  final ValueNotifier<int> speedRefreshMs =
      ValueNotifier(defaultSpeedRefreshMs);
  final ValueNotifier<int> dashboardRefreshMs =
      ValueNotifier(defaultDashboardRefreshMs);

  /// Light / dark / system appearance, exposed the same way as the refresh
  /// rates so MaterialApp picks up a change from Settings immediately.
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    speedRefreshMs.value =
        _prefs?.getInt("speedRefreshMs") ?? defaultSpeedRefreshMs;
    dashboardRefreshMs.value =
        _prefs?.getInt("dashboardRefreshMs") ?? defaultDashboardRefreshMs;
    final storedThemeMode = _prefs?.getString("themeMode");
    themeMode.value = ThemeMode.values.firstWhere(
      (mode) => mode.name == storedThemeMode,
      orElse: () => ThemeMode.system,
    );
  }

  void setThemeMode(ThemeMode mode) {
    _prefs?.setString("themeMode", mode.name);
    themeMode.value = mode;
  }

  void setSpeedRefreshMs(int value) {
    _prefs?.setInt("speedRefreshMs", value);
    speedRefreshMs.value = value;
  }

  void setDashboardRefreshMs(int value) {
    _prefs?.setInt("dashboardRefreshMs", value);
    dashboardRefreshMs.value = value;
  }

  static final PrefsRepository _instance = PrefsRepository._();

  factory PrefsRepository() => _instance;

  bool get isRememberMeEnabled => _prefs?.getBool("rememberMe") ?? false;

  set isRememberMeEnabled(bool value) {
    _prefs?.setBool("rememberMe", value);
  }

  String get username => _prefs?.getString("username") ?? "";

  set username(String value) {
    _prefs?.setString("username", value);
  }

  String get password => _prefs?.getString("password") ?? "";

  set password(String value) {
    _prefs?.setString("password", value);
  }

  /// Forgets the remembered session so the next launch lands back on Login.
  Future<void> clearCredentials() async {
    await _prefs?.remove("rememberMe");
    await _prefs?.remove("username");
    await _prefs?.remove("password");
  }
}
