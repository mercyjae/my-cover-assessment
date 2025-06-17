import 'package:camera/camera.dart';

class CameraService {
  static Future<CameraController> setupBackCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
    );
    final controller = CameraController(backCamera, ResolutionPreset.medium);
    await controller.initialize();
    return controller;
  }
}
