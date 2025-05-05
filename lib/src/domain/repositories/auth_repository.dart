import 'package:smart_menu_flutter/src/domain/dtos/login/login_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login/simple_login_request.dart';

abstract class AuthRepository {
  Future<String> googleAuthenticate();
  Future<LoginResponse> googleLogin(String accessToken);
  Future<LoginResponse> simpleLogin(SimpleLoginRequest request);
  void saveTokens(String accessToken, String refreshToken);
}
