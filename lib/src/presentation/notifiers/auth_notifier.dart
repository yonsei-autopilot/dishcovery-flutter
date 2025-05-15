import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login/simple_login_request.dart';
import 'package:smart_menu_flutter/src/presentation/states/auth_state.dart';
import 'package:smart_menu_flutter/src/domain/usecases/auth_usecase.dart';
import '../../domain/errors/global_exception.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final notifier = AuthNotifier(ref.watch(authUseCaseProvider));
  return notifier;
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUseCase useCase;

  AuthNotifier(this.useCase) : super(Unauthenticated());

  Future<void> googleLogin() async {
    try {
      await useCase.googleLogin();
      state = Authenticated();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> simpleLogin(String loginId, String password) async {
    try {
      final request = SimpleLoginRequest(loginId: loginId, password: password);
      await useCase.simpleLogin(request);
      state = Authenticated();
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    if (error is GlobalException) {
      state = AuthenticationError(error.message);
    } else {
      state = AuthenticationError('알 수 없는 오류가 발생했습니다.');
    }
  }

  void clearError() => state = Unauthenticated();

  Future<void> test() async {
    state = Authenticated();
  }
}
