import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraControllerProvider =
    StateNotifierProvider<CameraControllerNotifier, CameraController?>(
  (ref) => CameraControllerNotifier(),
);

class CameraControllerNotifier extends StateNotifier<CameraController?> {
  CameraControllerNotifier() : super(null);

  Future<void> initializeController() async {
    state = await CameraService.setupBackCamera();
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}

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
