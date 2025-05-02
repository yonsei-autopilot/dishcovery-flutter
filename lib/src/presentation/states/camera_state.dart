import 'package:camera/camera.dart';

sealed class CameraState {}

class CInitial extends CameraState {}

class CLoading extends CameraState {}

class CReady extends CameraState {
  final CameraController controller;
  CReady(this.controller);
}

class CCapturing extends CameraState {}

class CCapturedSuccess extends CameraState {
  final XFile file;
  CCapturedSuccess(this.file);
}

class CError extends CameraState {
  final String error;
  CError(this.error);
}
