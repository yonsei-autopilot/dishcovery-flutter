import 'package:camera/camera.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraImplRepository();
});

class CameraImplRepository implements CameraRepository {
  @override
  Future<List<CameraDescription>> getAvailableCameras() async {
    return await availableCameras();
  }

  @override
  Future<CameraController> initializeCamera(CameraDescription camera) async {
    final controller = CameraController(
      camera,
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg
    );
    await controller.initialize();
    return controller;
  }

  @override
  Future<XFile> takePicture(CameraController controller) async {
    return await controller.takePicture();
  }

  @override
  Future<void> disposeCamera(CameraController controller) async {
    await controller.dispose();
  }
}