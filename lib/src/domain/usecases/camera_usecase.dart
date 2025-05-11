// lib/src/domain/usecases/camera_usecase.dart
import 'dart:io';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/repositories/camera_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';

final cameraUsecaseProvider = Provider<CameraUsecase>((ref) {
  final repo = ref.read(cameraRepositoryProvider);
  return CameraUsecase(repo);
});

class CameraUsecase {
  final CameraRepository _repo;
  CameraUsecase(this._repo);

  DocumentScannerController createScanner() => _repo.createScanner();

  Future<void> takePhoto(DocumentScannerController c,
          {double minContourArea = 80000}) =>
      _repo.takePhoto(c, minContourArea: minContourArea);

  Future<void> findContours(DocumentScannerController c, File img) =>
      _repo.findContoursFromImage(c, img);

  Future<File> saveCropped(DocumentScannerController c) =>
      _repo.saveCroppedImage(c);

  Future<void> disposeScanner(DocumentScannerController c) =>
      _repo.disposeScanner(c);
}
