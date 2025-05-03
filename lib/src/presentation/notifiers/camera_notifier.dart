import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/core/di/repository_providers.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';
import 'package:smart_menu_flutter/src/presentation/states/camera_state.dart';

final cameraControllerProvider = StateNotifierProvider<CameraControllerNotifier, CameraState>((ref) {
  final notifier = CameraControllerNotifier(ref.watch(cameraRepositoryProvider));
  notifier.initialize();
  return notifier;
});

class CameraControllerNotifier extends StateNotifier<CameraState> {
  final CameraRepository repo;
  CameraController? controller;

  CameraControllerNotifier(this.repo) : super(CInitial());

  Future<void> initialize() async {
    try {
      state = CLoading();
      final cameras = await repo.getAvailableCameras();
      controller = await repo.initializeCamera(cameras.first);
      state = CReady(controller!);
    } catch (e) {
      state = CError(e.toString());
    }
  }

  Future<void> takePicture() async {
    if (state is! CReady) return;
    try {
      state = CCapturing();
      final file = await repo.takePicture(controller!);
      state = CCapturedSuccess(file);
    } catch (e) {
      state = CError(e.toString());
    }
  }

  @override
  void dispose() {
    repo.disposeCamera(controller!);
    super.dispose();
  }
}
