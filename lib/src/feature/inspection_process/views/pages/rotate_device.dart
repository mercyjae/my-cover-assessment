import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/controllers/camera_controller.dart';

class RotateDeviceScreen extends ConsumerStatefulWidget {
  const RotateDeviceScreen({super.key});

  @override
  ConsumerState<RotateDeviceScreen> createState() => _RotateDeviceScreenState();
}

class _RotateDeviceScreenState extends ConsumerState<RotateDeviceScreen>
    with WidgetsBindingObserver {
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

    final controller = ref.read(cameraControllerProvider);
    controller?.dispose();

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
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.previewSize!.height,
                height: controller.value.previewSize!.width,
                child: CameraPreview(controller),
              ),
            ),
          ),
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
