import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_menu_flutter/src/domain/usecases/camera_usecase.dart';
import 'package:smart_menu_flutter/src/domain/usecases/menu_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/states/camera_state.dart';

final cameraControllerProvider =
    StateNotifierProvider<CameraControllerNotifier, CameraState>((ref) {
  final notifier = CameraControllerNotifier(
      ref.read(cameraUseCaseProvider), ref.read(menuUsecaseProvider));
  notifier.initialize();
  return notifier;
});

class CameraControllerNotifier extends StateNotifier<CameraState> {
  final CameraUsecase cameraUsecase;
  final MenuUsecase menuUsecase;
  CameraController? controller;

  CameraControllerNotifier(this.cameraUsecase, this.menuUsecase)
      : super(CInitial());

  Future<void> initialize() async {
    try {
      await controller?.dispose();
      state = CLoading();
      final cameras = await cameraUsecase.getAvailableCameras();
      controller = await cameraUsecase.initializeCamera(cameras.first);
      if (!controller!.value.isInitialized) {
        await controller!.initialize();
      }
      state = CReady(controller!);
    } catch (e) {
      state = CError(e.toString());
      await _safeDispose();
    }
  }

  Future<void> takePicture() async {
    if (state is! CReady ||
        controller == null ||
        !controller!.value.isInitialized) return;

    try {
      state = CCapturing();
      // Take Picture
      final file = await cameraUsecase.takePicture(controller!);

      // Send Server
      final response = await menuUsecase.analyzeMenuImage(file.path);

      state = CCapturedSuccess(file);
    } catch (e) {
      state = CError(e.toString());
      await _safeDispose();
    }
  }

  Future<void> selectPicture() async {
    try {
      // Take Picture
      final ImagePicker picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.gallery);

      state = CCapturing();

      // Send Server
      final response = await menuUsecase.analyzeMenuImage(file!.path);

      state = CCapturedSuccess(file);
    } catch (e) {
      state = CError(e.toString());
      await _safeDispose();
    }
  }

  Future<void> _safeDispose() async {
    if (controller != null) {
      await controller!.dispose();
      controller = null;
    }
  }

  @override
  Future<void> dispose() async {
    await controller?.dispose();
    controller = null;
    state = CInitial();
    super.dispose();
  }
}
