import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/core/di/repository_providers.dart';
import 'package:smart_menu_flutter/src/domain/usecases/auth_usecase.dart';
import 'package:smart_menu_flutter/src/domain/usecases/permission_usecase.dart';

final permissionUseCaseProvider = Provider<PermissionUsecase>((ref) {
  final repo = ref.read(permissionRepositoryProvider);
  return PermissionUsecase(repo);
});

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthUseCase(repo);
});
