import 'package:smart_menu_flutter/src/data/repositories/auth_repo.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login/login_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login/simple_login_request.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthUseCase(repo);
});

class AuthUseCase {
  final AuthRepository authRepository;
  AuthUseCase(this.authRepository);

  Future<void> googleLogin() async {
    String accessToken = await authRepository.googleAuthenticate();
    LoginResponse response = await authRepository.googleLogin(accessToken);
    authRepository.saveTokens(response.accessToken, response.refreshToken);
  }

  Future<void> simpleLogin(SimpleLoginRequest request) async {
    LoginResponse response = await authRepository.simpleLogin(request);
    authRepository.saveTokens(response.accessToken, response.refreshToken);
  }
}
