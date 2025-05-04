import 'package:smart_menu_flutter/src/domain/dtos/login/login_response.dart';

abstract class AuthRepository {
  Future<String> googleAuthenticate();
  Future<LoginResponse> login(String accessToken);
  void saveTokens(String accessToken, String refreshToken);
}
