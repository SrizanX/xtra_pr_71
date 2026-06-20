import 'package:flutter/foundation.dart';
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

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    speedRefreshMs.value =
        _prefs?.getInt("speedRefreshMs") ?? defaultSpeedRefreshMs;
    dashboardRefreshMs.value =
        _prefs?.getInt("dashboardRefreshMs") ?? defaultDashboardRefreshMs;
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
}
