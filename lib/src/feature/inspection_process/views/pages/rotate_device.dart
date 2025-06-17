import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/controllers/camera_controller.dart';

// final cameraControllerProvider =
//     StateProvider<CameraController?>((ref) => null);

class RotateDeviceScreen extends ConsumerStatefulWidget {
  const RotateDeviceScreen({super.key});

  @override
  ConsumerState<RotateDeviceScreen> createState() => _RotateDeviceScreenState();
}

class _RotateDeviceScreenState extends ConsumerState<RotateDeviceScreen>
    with WidgetsBindingObserver {
  // late Future<void> _initializeControllerFuture;
  // bool hasNavigated = false;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  //   _initializeCamera();
  // }

  // Future<void> _initializeCamera() async {
  //   final cameras = await availableCameras();
  //   final backCamera =
  //       cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.back);
  //   final controller = CameraController(backCamera, ResolutionPreset.medium);
  //   ref.read(cameraControllerProvider.notifier).state = controller;
  //   _initializeControllerFuture = controller.initialize();
  //   await _initializeControllerFuture;
  //   setState(() {});
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   ref.read(cameraControllerProvider)?.dispose();
  //   super.dispose();
  // }

  bool hasNavigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(cameraControllerProvider.notifier).initializeController();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(cameraControllerProvider);

    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    if (!isPortrait && !hasNavigated) {
      print('i am');
      hasNavigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.pushNamed('start-camera', pathParameters: {'stepIndex': '0'});
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CameraPreview(controller),
          if (isPortrait)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Rotate Device",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            )
        ],
      ),
    );
  }
}
