import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepository {
  SharedPreferences? _prefs;

  PrefsRepository._();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static final PrefsRepository _instance = PrefsRepository._();

  factory PrefsRepository() => _instance;

  bool get isRememberMeEnabled => _prefs?.getBool("rememberMe") ?? false;

  set isRememberMeEnabled(value) {
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
