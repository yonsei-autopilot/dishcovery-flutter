import '../repositories/permission_repository.dart';

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