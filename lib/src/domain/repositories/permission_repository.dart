abstract class PermissionRepository {
  Future<bool> locationPermission();
  Future<bool> cameraPermission();
  Future<void> saveLocation();
}