import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/presentation/states/auth_state.dart';
import 'package:smart_menu_flutter/src/domain/usecases/auth_usecase.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final notifier = AuthNotifier(ref.watch(authUseCaseProvider));
  return notifier;
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUseCase useCase;

  AuthNotifier(this.useCase) : super(Unauthenticated());

  Future<void> loginWithGoogle() async {
    await useCase.loginWithGoogle();
    state = Authenticated();
  }

  Future<void> test() async {
    state = Authenticated();
  }
}
