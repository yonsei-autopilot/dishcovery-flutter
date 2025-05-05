import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/usecases/camera_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/states/camera_state.dart';

final cameraControllerProvider = StateNotifierProvider<CameraControllerNotifier, CameraState>((ref) {
  final notifier = CameraControllerNotifier(ref.watch(cameraUseCaseProvider));
  notifier.initialize();
  return notifier;
});

class CameraControllerNotifier extends StateNotifier<CameraState> {
  final CameraUsecase usecase;
  CameraController? controller;

  CameraControllerNotifier(this.usecase) : super(CInitial());

  Future<void> initialize() async {
    try {
      await controller?.dispose();
      state = CLoading();
      final cameras = await usecase.getAvailableCameras();
      controller = await usecase.initializeCamera(cameras.first);
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
    if (state is! CReady || controller == null || !controller!.value.isInitialized) return;

    try {
      state = CCapturing();
      final file = await usecase.takePicture(controller!);
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
