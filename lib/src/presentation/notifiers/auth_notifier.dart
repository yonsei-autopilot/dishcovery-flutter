import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login/simple_login_request.dart';
import 'package:smart_menu_flutter/src/presentation/states/auth_state.dart';
import 'package:smart_menu_flutter/src/domain/usecases/auth_usecase.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final notifier = AuthNotifier(ref.watch(authUseCaseProvider));
  return notifier;
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUseCase useCase;

  AuthNotifier(this.useCase) : super(Unauthenticated());

  Future<void> googleLogin() async {
    await useCase.googleLogin();
    state = Authenticated();
  }

  Future<void> simpleLogin(String loginId, String password) async {
    final request = SimpleLoginRequest(loginId: loginId, password: password);
    await useCase.simpleLogin(request);
    state = Authenticated();
  }

  Future<void> test() async {
    state = Authenticated();
  }
}
