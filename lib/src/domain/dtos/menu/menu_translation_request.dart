import 'dart:io';
import 'package:dio/dio.dart';

class MenuTranslationRequest {
  final File imageFile;

  MenuTranslationRequest(this.imageFile);

  Future<FormData> toFormData() async {
    final fileName = imageFile.path.split('/').last;

    return FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: DioMediaType('image', _getExtension(fileName)),
      ),
    });
  }

  String _getExtension(String filename) {
    if (filename.endsWith('.png')) return 'png';
    if (filename.endsWith('.jpg') || filename.endsWith('.jpeg')) return 'jpeg';
    return 'octet-stream';
  }
}
