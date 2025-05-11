import 'dart:async';
import 'dart:io';

import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/usecases/camera_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/states/camera_state.dart';

final cameraControllerProvider =
    StateNotifierProvider.autoDispose<CameraControllerNotifier, CameraState>(
        (ref) {
  final notifier = CameraControllerNotifier(
    ref.read(cameraUsecaseProvider),
    ref.read(routerProvider),
  );
  notifier.initialize();
  return notifier;
});

class CameraControllerNotifier extends StateNotifier<CameraState> {
  final CameraUsecase _usecase;
  final GoRouter _router;
  DocumentScannerController? _controller;
  StreamSubscription<AppStatus>? _saveSub;

  CameraControllerNotifier(this._usecase, this._router) : super(CInitial());

  Future<void> initialize() async {
    state = CLoading();
    try {
      _controller = _usecase.createScanner();
      _saveSub?.cancel();
      _saveSub = _controller!.statusSavePhotoDocument.listen((status) async {
        if (status == AppStatus.success) {
          final file = await _usecase.saveCropped(_controller!);
          state = CCapturedSuccess(file);
          _router.go('/generating', extra: (filePath: file.path));
        }
      });

      state = CReady(_controller!);
    } catch (e) {
      state = CError(e.toString());
    }
  }

  Future<void> takePicture() async {
    if (state is! CReady || _controller == null) return;
    state = CCapturing();
    try {
      await _usecase.takePhoto(_controller!);
    } catch (e) {
      state = CError(e.toString());
    }
  }

  Future<void> selectPicture() async {
    if (_controller == null) return;
    state = CCapturing();
    try {
      final ImagePicker picker = ImagePicker();
      final file = await picker.pickImage(source: ImageSource.gallery);
      state = CCapturedSuccess(File(file!.path));
      await _usecase.findContours(_controller!, File(file.path));
    } catch (e) {
      state = CError(e.toString());
    }
  }

  Future<void> safeDispose() async {
    _saveSub?.cancel();
    if (_controller != null) {
      await _usecase.disposeScanner(_controller!);
      _controller = null;
    }
  }

  @override
  void dispose() {
    safeDispose();
    super.dispose();
  }
}
