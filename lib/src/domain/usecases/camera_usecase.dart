import 'package:camera/camera.dart';
import 'package:smart_menu_flutter/src/data/repositories/camera_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraUseCaseProvider = Provider<CameraUsecase>((ref) {
  final repo = ref.read(cameraRepositoryProvider);
  return CameraUsecase(repo);
});

class CameraUsecase {
  final CameraRepository repo;
  CameraUsecase(this.repo);

  Future<List<CameraDescription>> getAvailableCameras() => repo.getAvailableCameras();
  Future<CameraController> initializeCamera(CameraDescription camera) => repo.initializeCamera(camera);
  Future<XFile> takePicture(CameraController controller) => repo.takePicture(controller);
  Future<void> disposeCamera(CameraController controller) => repo.disposeCamera(controller);
}
