import 'package:camera/camera.dart';
import 'package:smart_menu_flutter/src/data/repositories/camera_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/usecases/cart_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/cart_notifier.dart';

final cameraUseCaseProvider = Provider<CameraUsecase>((ref) {
  final repo = ref.read(cameraRepositoryProvider);
  final cartUseCase = ref.read(cartUseCaseProvider);
  return CameraUsecase(repo, cartUseCase);
});

class CameraUsecase {
  final CameraRepository repo;
  final CartUseCase cartUseCase;
  CameraUsecase(this.repo, this.cartUseCase);

  Future<List<CameraDescription>> getAvailableCameras() => repo.getAvailableCameras();
  Future<CameraController> initializeCamera(CameraDescription camera) async {
    await cartUseCase.clear();
    return repo.initializeCamera(camera);
  }
  Future<XFile> takePicture(CameraController controller) => repo.takePicture(controller);
  Future<void> disposeCamera(CameraController controller) => repo.disposeCamera(controller);
}
