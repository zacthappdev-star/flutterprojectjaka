import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setLoginStatus(bool value) async {
    return await _prefs?.setBool('isLogin', value) ?? false;
  }

  static bool getLoginStatus() {
    return _prefs?.getBool('isLogin') ?? false;
  }

  static bool get isLogin => _prefs?.getBool('isLogin') ?? false;
  static Future<bool> setUserEmail(String email) async {
    return await _prefs?.setString('userEmail', email) ?? false;
  }

  static String getUserEmail() {
    return _prefs?.getString('userEmail') ?? '';
  }

  static Future<bool> setUserName(String name) async {
    return await _prefs?.setString('userName', name) ?? false;
  }

  static String getUserName() {
    return _prefs?.getString('userName') ?? '';
  }

  static Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }
}
