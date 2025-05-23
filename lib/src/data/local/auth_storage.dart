import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';

final authStorageProvider = Provider<AuthStorage>((ref) {
  return AuthStorage(ref.read(sharedPreferencesProvider));
});

class AuthStorage {
  final SharedPreferences prefs;

  AuthStorage(this.prefs);

  String? getAccessToken() {
    return prefs.getString("ACCESS_TOKEN");
  }

  String? getRefreshToken() {
    return prefs.getString("REFRESH_TOKEN");
  }

  Future<void> setAccessToken(String token) {
    return prefs.setString("ACCESS_TOKEN", token);
  }

  Future<void> setRefreshToken(String token) {
    return prefs.setString("REFRESH_TOKEN", token);
  }

  Future<void> removeAccessToken() {
    return prefs.remove("ACCESS_TOKEN");
  }

  Future<void> removeRefreshToken() {
    return prefs.remove("ACCESS_TOKEN");
  }
}
