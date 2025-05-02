import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/auth_state.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(Unauthenticated());

  void setAuthenticated() {
    state = Authenticated();
  }

  void setUnauthenticated() {
    state = Unauthenticated();
  }
}
