import 'package:tmdb/services/pref_service.dart';
import 'package:mobx/mobx.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  final PrefService _prefs;

  _SettingsStore(this._prefs);

  @observable
  bool isDarkMode = false;

  @action
  void init() {
    isDarkMode = _prefs.isDarkMode;
  }

  @action
  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;
    await _prefs.setDarkMode(isDarkMode);
  }
}
