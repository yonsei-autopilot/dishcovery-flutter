import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_menu_flutter/src/data/camera_repo.dart';
import 'package:smart_menu_flutter/src/data/google_auth_repo.dart';
import 'package:smart_menu_flutter/src/data/permission_check_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';
import 'package:smart_menu_flutter/src/domain/repositories/permission_repository.dart';
import 'package:smart_menu_flutter/src/domain/usecases/camera_usecase.dart';
import 'package:smart_menu_flutter/src/domain/usecases/login_usecase.dart';
import 'package:smart_menu_flutter/src/domain/usecases/permission_usecase.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return GoogleAuthRepository(); // 예: Firebase 구현체
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginUseCase(repo);
});

final permissionRepositoryProvider = Provider<PermissionRepository>((ref) {
  return PermissionCheckRepo();
});

final permissionUseCaseProvider = Provider<PermissionUsecase>((ref) {
  final repo = ref.read(permissionRepositoryProvider);
  return PermissionUsecase(repo);
});

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraImplRepository();
});

