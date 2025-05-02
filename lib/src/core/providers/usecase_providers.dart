import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/core/providers/repository_providers.dart';
import 'package:smart_menu_flutter/src/domain/usecases/login_usecase.dart';
import 'package:smart_menu_flutter/src/domain/usecases/permission_usecase.dart';

final permissionUseCaseProvider = Provider<PermissionUsecase>((ref) {
  final repo = ref.read(permissionRepositoryProvider);
  return PermissionUsecase(repo);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginUseCase(repo);
});
