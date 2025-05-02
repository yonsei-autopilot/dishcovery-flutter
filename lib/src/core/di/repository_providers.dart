import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/local/token_storage.dart';
import 'package:smart_menu_flutter/src/data/repositories/camera_repo.dart';
import 'package:smart_menu_flutter/src/data/repositories/auth_repo.dart';
import 'package:smart_menu_flutter/src/data/repositories/permission_check_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';
import 'package:smart_menu_flutter/src/domain/repositories/permission_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final tokenStorage = ref.read(tokenStorageProvider);
  return AuthRepositoryImpl(tokenStorage);
});

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraImplRepository();
});

final permissionRepositoryProvider = Provider<PermissionRepository>((ref) {
  return PermissionCheckRepo();
});
