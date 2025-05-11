import 'dart:io';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';

abstract class CameraRepository {
  DocumentScannerController createScanner();

  Future<void> takePhoto(DocumentScannerController controller,
      {double minContourArea});

  Future<void> findContoursFromImage(
      DocumentScannerController controller, File image);

  Future<File> saveCroppedImage(DocumentScannerController controller);
  
  Future<void> disposeScanner(DocumentScannerController controller);
}
