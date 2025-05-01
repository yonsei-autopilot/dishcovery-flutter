import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/google_auth_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';
import 'package:smart_menu_flutter/src/domain/usecases/login_usecase.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return GoogleAuthRepository(); // 예: Firebase 구현체
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginUseCase(repo);
});
