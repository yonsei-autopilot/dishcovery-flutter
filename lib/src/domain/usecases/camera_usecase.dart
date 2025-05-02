import 'package:camera/camera.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';

class InitializeCamera {
  final CameraRepository repo;
  InitializeCamera(this.repo);

  Future<List<CameraDescription>> find() => repo.getAvailableCameras();
  Future<CameraController> init(CameraDescription camera) => repo.initializeCamera(camera);
}

class TakePicture {
  final CameraRepository repo;
  TakePicture(this.repo);

  Future<XFile> call(CameraController controller) => repo.takePicture(controller);
}

class DisposeCamera {
  final CameraRepository repo;
  DisposeCamera(this.repo);

  Future<void> call(CameraController controller) => repo.disposeCamera(controller);
}