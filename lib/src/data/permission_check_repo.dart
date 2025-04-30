import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_menu_flutter/src/domain/repositories/permission_repository.dart';

class PermissionCheckRepo implements PermissionRepository {
  @override
  Future<bool> locationPermission() async { // 수정 필요
    var status = await Permission.location.status;
    Position position;
    if (status.isGranted) {
      // sharedpreferences에 위치 정보 저장 Geolocator 사용해서
      position = await Geolocator.getCurrentPosition();
      return true;
    } else {
      status =  await Permission.location.request();
      // var status = await Permission.location.status;
      if (status.isGranted && status.isLimited) {
        if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
          // sharedpreferences에 위치 정보 저장 Geolocator 사용해서
          position = await Geolocator.getCurrentPosition();
          return true;
        }
      } else if (status.isPermanentlyDenied) {
        openAppSettings(); // android
      } else if (status.isRestricted) {
        openAppSettings(); // ios
      } else if (status.isDenied) {
        print('location permission is denied');
      }
      return false;
    }
  }

  @override
  Future<bool> cameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    } else {
      status = await Permission.camera.request();
      if (status.isGranted) {
        return true;
      } else if (status.isDenied) {
        if (await cameraPermission()) {
          return true;
        } else {
          return false;
        }
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
        return false;
      }
    }
    return false;
  }
}