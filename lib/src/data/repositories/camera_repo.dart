import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:smart_menu_flutter/src/domain/repositories/camera_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:path_provider/path_provider.dart';

final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return DocumentScannerRepository();
});

class DocumentScannerRepository implements CameraRepository {
  final _controller = DocumentScannerController();

  @override
  DocumentScannerController createScanner() => _controller;

  @override
  Future<void> takePhoto(DocumentScannerController controller,
      {double minContourArea = 80000}) {
    return controller.takePhoto(minContourArea: minContourArea);
  }

  @override
  Future<void> findContoursFromImage(
      DocumentScannerController controller, File image) {
    return controller.findContoursFromExternalImage(image: image);
  }

  @override
  Future<File> saveCroppedImage(
      DocumentScannerController controller) async {
    try {
      // 1) Crop & save inside the scanner
      await controller.cropPhoto();
      await controller.savePhotoDocument();

      // 2) Grab the cropped bytes
      final Uint8List? bytes = controller.pictureCropped;
      if (bytes == null || bytes.isEmpty) {
        throw Exception("Cropped image bytes are empty");
      }

      // 3) Write asynchronously to a temp file
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(path);
      await file.writeAsBytes(bytes, flush: true);

      return file;
    } catch (e, st) {
      // 4) Log and rethrow so your notifier sees the failure
      debugPrint('❌ saveCroppedImage failed: $e\n$st');
      rethrow;
    }
  }

  @override
  Future<void> disposeScanner(DocumentScannerController controller) {
    controller.dispose();
    return Future.value();
  }
}
