import 'package:shared_preferences/shared_preferences.dart';
import 'package:viettel_app/config/app_key.dart';

class SPref {
  static final SPref instance = SPref._internal();

  SPref._internal();

  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future set(String key, String value) async {
    late SharedPreferences prefs;
    prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  get(String key) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return _prefs?.get(key) ?? "";
  }

  clear() {
    // _prefs?.clear();
    _prefs?.setString(AppKey.xToken, "");
    _prefs?.setString(AppKey.avatar, "");
    _prefs?.setString(AppKey.phoneNumber, "");
    _prefs?.setString(AppKey.staffId, "");
  }

  Future remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
