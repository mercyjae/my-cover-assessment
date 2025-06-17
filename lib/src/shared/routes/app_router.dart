import 'package:go_router/go_router.dart';
import 'package:my_cover_ai_test/src/feature/inspection_guide/views/pages/inspection_step_page.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/home_page.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/image_capture_confirm_page.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/image_capture_start_page.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/image_capture_verify_page.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/rotate_device.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/vehicle_overlay_start_screen.dart';
import 'package:my_cover_ai_test/src/shared/routes/app_path.dart';

class AppRouter {
  static final router = GoRouter(
    // routerNeglect: true,
    // debugLogDiagnostics: true,
    initialLocation:
        //'/image/capture/confirm',
        //'/rotate',
        '/inspect/step/1',
    routes: [
      GoRoute(
        path: AppPath.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '${AppPath.inspectStep}/:stepId',
        name: 'inspect-step',
        builder: (context, state) {
          final stepId =
              int.tryParse(state.pathParameters['stepId'] ?? '1') ?? 1;
          print("🛬 Navigated to inspect step: $stepId");
          return InspectionStepPage(step: stepId);
        },
      ),
      GoRoute(
        path: '${AppPath.startCamera}/:stepIndex',
        name: 'start-camera',
        builder: (context, state) {
          final stepIndex = int.parse(state.pathParameters['stepIndex']!);

          return VehicleOverlayStartScreen(
            stepIndex: stepIndex,
          );
        },
      ),
      GoRoute(
        path: AppPath.rotateDevice,
        name: 'rotate-device',
        builder: (context, state) => const RotateDeviceScreen(),
      ),
      GoRoute(
        path: '${AppPath.imageCaptureStart}/:stepIndex',
        name: 'image-capture-start',
        builder: (context, state) {
          final stepIndex = int.parse(state.pathParameters['stepIndex']!);
          return ImageCaptureStartScreen(
            stepIndex: stepIndex,
          );
        },
      ),
      GoRoute(
        path: '${AppPath.imageCaptureConfirm}/:stepIndex',
        name: 'image-capture-confirm',
        builder: (context, state) {
          final stepIndex = int.parse(state.pathParameters['stepIndex']!);
          return ImageCaptureConfirmScreen(
            stepIndex: stepIndex,
            imagePath: state.extra! as String,
          );
        },
      ),
      GoRoute(
        path: '${AppPath.imageCaptureVerify}/:stepIndex',
        name: 'image-capture-verify',
        builder: (context, state) {
          final stepIndex = int.parse(state.pathParameters['stepIndex']!);
          return ImageCaptureVerifyPage(
            stepIndex: stepIndex,
            imagePath: state.extra! as String,
          );
        },
      ),
    ],
  );
}
