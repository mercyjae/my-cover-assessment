import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/service/camera_service.dart';

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


