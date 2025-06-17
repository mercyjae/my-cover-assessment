// vehicle_overlay_start_screen.dart

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/controllers/camera_controller.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/data/inspection_view_model.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/image_capture_verify_page.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/instruction_start_guide.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/step_timer_and_indicator.dart';

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
            StepTimerAndIndicator(
              verifiedSteps: verifiedSteps,
            ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 30),
            //     child: Column(
            //       children: [
            //         AppSpacing.setVerticalSpace(200),
            //         Container(
            //           height: 40,
            //           width: 30,
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle, color: AppColors.whiteColor),
            //           child: Center(
            //             child: Text(
            //               '1:59',
            //               style: context.textTheme.displayLarge?.copyWith(
            //                   fontSize: 14,
            //                   // height: 1.5,
            //                   fontWeight: FontWeight.w600,
            //                   color: AppColors.errorColor),
            //             ),
            //           ),
            //         ),
            //         AppSpacing.setVerticalSpace(20),
            //         Container(
            //           height: 300.height,
            //           width: 20.width,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: AppColors.blackColor.withAlpha(50),
            //           ),
            //           child: Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: List.generate(3, (index) {
            //                 return Padding(
            //                   padding: const EdgeInsets.symmetric(vertical: 5),
            //                   child: Container(
            //                     height: 60.height,
            //                     width: 60.width,
            //                     decoration: BoxDecoration(
            //                       color: verifiedSteps[index]
            //                           ? AppColors.greenColor
            //                           : AppColors.grey1,
            //                       shape: BoxShape.circle,
            //                     ),
            //                     child: Icon(
            //                       Icons.check,
            //                       size: 20,
            //                       color: AppColors.whiteColor,
            //                     ),
            //                   ),
            //                 );
            //               }),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            InstructionStartGuide(step: step, stepIndex: stepIndex),
          ],
        ),
      ),
    );
  }
}
