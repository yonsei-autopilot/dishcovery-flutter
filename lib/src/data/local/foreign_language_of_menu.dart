import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';

final foreignLanguageOfMenuStorageProvider =
    Provider<ForeignLanguageOfMenuStorage>((ref) {
  return ForeignLanguageOfMenuStorage(ref.read(sharedPreferencesProvider));
});

class ForeignLanguageOfMenuStorage {
  final SharedPreferences prefs;

  ForeignLanguageOfMenuStorage(this.prefs);

  String? getLanguageCodeForGoogleCode() {
    return prefs.getString("LANGUAGE_CODE_FOR_GOOGLE_TTS");
  }

  Future<void> savegetLanguageCodeForGoogleCode(String languageCode) {
    return prefs.setString("LANGUAGE_CODE_FOR_GOOGLE_TTS", languageCode);
  }

  String? getLanguageName() {
    return prefs.getString("LANGUAGE_NAME");
  }

  Future<void> saveLanguageName(String languageName) {
    return prefs.setString("LANGUAGE_NAME", languageName);
  }
}
