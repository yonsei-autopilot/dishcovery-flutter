import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/domain/repositories/permission_repository.dart';

class PermissionCheckRepo implements PermissionRepository {
  @override
  Future<bool> locationPermission() async { // 수정 필요
    final status = await Permission.location.status;
    if (status.isGranted) {
      await saveLocation();
      return true;
    }
      final newStatus = await Permission.location.request();
      if (newStatus.isGranted) {
        saveLocation();
        return true;
      }

      if (newStatus.isPermanentlyDenied || newStatus.isRestricted) {
        await openAppSettings();
      }
      return false;
    }

  @override
  Future<void> saveLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble('latitude', position.latitude);
      prefs.setDouble('longitude', position.longitude);
    });
  }

  @override
  Future<bool> cameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) return true;

    final newStatus = await Permission.camera.request();
    if (newStatus.isGranted) return true;

    if (newStatus.isPermanentlyDenied || newStatus.isRestricted) {
      await openAppSettings();
    }
    return false;
  }
}