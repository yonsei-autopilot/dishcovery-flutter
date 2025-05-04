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
      state = CLoading();
      final cameras = await usecase.getAvailableCameras();
      controller = await usecase.initializeCamera(cameras.first);
      state = CReady(controller!);
    } catch (e) {
      state = CError(e.toString());
    }
  }

  Future<void> takePicture() async {
    if (state is! CReady) return;
    try {
      state = CCapturing();
      final file = await usecase.takePicture(controller!);
      state = CCapturedSuccess(file);
    } catch (e) {
      state = CError(e.toString());
    }
  }

  @override
  void dispose() {
    usecase.disposeCamera(controller!);
    super.dispose();
  }
}
