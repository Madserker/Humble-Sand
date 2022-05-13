import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static const String languageCode = "language";
}

class SharedPreferencesService {
  SharedPreferencesService(this._preferences);

  final SharedPreferences _preferences;

  String? getLanguage() {
    return _preferences.getString(_Keys.languageCode);
  }

  saveLanguage(String languageCode) {
    _preferences.setString(_Keys.languageCode, languageCode);
  }
}
