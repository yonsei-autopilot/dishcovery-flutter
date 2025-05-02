import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/core/di/repository_providers.dart';
import 'package:smart_menu_flutter/src/domain/usecases/auth_usecase.dart';
import 'package:smart_menu_flutter/src/domain/usecases/permission_usecase.dart';

final permissionUseCaseProvider = Provider<PermissionUsecase>((ref) {
  final repo = ref.read(permissionRepositoryProvider);
  return PermissionUsecase(repo);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginUseCase(repo);
});

final checkLoginUseCaseProvider = Provider<CheckLoginUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return CheckLoginUseCase(repo);
});
