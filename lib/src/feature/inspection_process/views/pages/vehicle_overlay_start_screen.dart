// vehicle_overlay_start_screen.dart

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/controllers/camera_controller.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/model/inspection_view_model.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/image_capture_verify_page.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/instruction_start_guide.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/step_timer_and_indicator.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/extensions.dart';

class VehicleOverlayStartScreen extends ConsumerWidget {
  final int stepIndex;
  const VehicleOverlayStartScreen({super.key, required this.stepIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifiedSteps = ref.watch(verifiedStepsProvider);
    final step = inspectionView[stepIndex];
    final controller = ref.watch(cameraControllerProvider);

    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: CameraPreview(controller)),
            Positioned(
              left: 70,
              child: StepTimerAndIndicator(
                verifiedSteps: verifiedSteps,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: double.infinity,
                  width: 35.width,
                  decoration: BoxDecoration(
                    color: AppColors.blackColor.withAlpha(90),
                  ),
                ),
              ),
            ),
            InstructionStartGuide(step: step, stepIndex: stepIndex),
          ],
        ),
      ),
    );
  }
}
