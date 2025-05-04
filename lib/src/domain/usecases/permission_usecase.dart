import 'package:smart_menu_flutter/src/data/repositories/permission_check_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/permission_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final permissionUseCaseProvider = Provider<PermissionUsecase>((ref) {
  final repo = ref.read(permissionRepositoryProvider);
  return PermissionUsecase(repo);
});

class PermissionUsecase {
  final PermissionRepository repo;
  PermissionUsecase(this.repo);

  Future<bool> checkLocation() {
    return repo.locationPermission();
  }

  Future<bool> checkCamera() {
    return repo.cameraPermission();
  }
}