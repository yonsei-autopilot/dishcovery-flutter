import 'dart:io';

import 'package:flutter_document_scanner/flutter_document_scanner.dart';

sealed class CameraState {}

class CInitial extends CameraState {}

class CLoading extends CameraState {}

class CReady extends CameraState {
  final DocumentScannerController controller;
  CReady(this.controller);
}

class CCapturing extends CameraState {}

class CCapturedSuccess extends CameraState {
  final File file;
  CCapturedSuccess(this.file);
}

class CError extends CameraState {
  final String message;
  CError(this.message);
}
