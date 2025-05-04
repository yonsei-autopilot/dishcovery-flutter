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
      ResolutionPreset.ultraHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg
    );
    await controller.initialize();
    return controller;
  }

  @override
  Future<XFile> takePicture(CameraController controller) async {
    try {
      return await controller.takePicture();
    } catch (e) {
      throw Exception('사진 촬영 실패: $e');
    }
  }

  @override
  Future<void> disposeCamera(CameraController? controller) async {
    if (controller != null && controller.value.isInitialized) {
      await controller.dispose();
    }
  }
}