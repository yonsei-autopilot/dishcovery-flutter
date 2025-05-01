import 'package:camera/camera.dart';

abstract class CameraRepository {
  Future<List<CameraDescription>> getAvailableCameras();
  Future<CameraController> initializeCamera(CameraDescription camera);
  Future<XFile> takePicture(CameraController controller);
  Future<void> disposeCamera(CameraController controller);
}