import 'package:smart_menu_flutter/src/domain/dtos/login_response.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository;
  AuthUseCase(this.authRepository);

  Future<void> loginWithGoogle() async {
    String accessToken = await authRepository.googleAuthenticate();
    LoginResponse response = await authRepository.login(accessToken);
    authRepository.saveTokens(response.accessToken, response.refreshToken);
  }
}
