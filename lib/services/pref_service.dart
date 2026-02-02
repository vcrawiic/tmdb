import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static const String _themeModeKey = 'theme_mode';
  static const String _isFirstLaunchKey = 'is_first_launh';

  final SharedPreferences _prefs;
  PrefService(this._prefs);

  static Future<PrefService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefService(prefs);
  }

  bool get isDarkMode => _prefs.getBool(_themeModeKey) ?? false;

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_themeModeKey, value);
  }

  bool get isFirstLaunch => _prefs.getBool(_isFirstLaunchKey) ?? true;

  Future<void> setFirstLauchComplete() async {
    await _prefs.setBool(_isFirstLaunchKey, false);
  }
}
