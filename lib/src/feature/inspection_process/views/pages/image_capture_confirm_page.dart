import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/model/inspection_steps_model.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/pages/image_capture_verify_page.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/step_timer_and_indicator.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/extensions.dart';

class ImageCaptureConfirmScreen extends ConsumerWidget {
  final int stepIndex;
  final String imagePath;

  const ImageCaptureConfirmScreen(
      {super.key, required this.imagePath, required this.stepIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifiedSteps = ref.watch(verifiedStepsProvider);
    final step = inspectionSteps[stepIndex];
    return Scaffold(
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: Image.file(
              File(imagePath),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: DottedBorder(
          //     color: AppColors.blackColor,
          //     strokeWidth: 3,
          //     dashPattern: [10, 10],
          //     borderType: BorderType.RRect,
          //     radius: const Radius.circular(12),
          //     child: SizedBox(
          //       width: 400,
          //       height: 250,
          //       child: RotatedBox(
          //         quarterTurns: 3,
          //         child: AspectRatio(
          //           aspectRatio: 3 / 4,
          //           child: Container(
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               color: Colors.white,
          //             ),
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: ClipRRect(
          //                 borderRadius: BorderRadius.circular(12),
          //                 child: Image.file(
          //                   File(imagePath),
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 30),
            child: StepTimerAndIndicator(
              verifiedSteps: verifiedSteps,
            ),
          ),
          GestureDetector(
            onTap: () async {
              context.pushNamed('image-capture-verify',
                  extra: imagePath,
                  pathParameters: {'stepIndex': stepIndex.toString()});
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: double.infinity,
                width: 50.width,
                color: AppColors.blackColor.withAlpha(90),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor, shape: BoxShape.circle),
                    height: 50.height,
                    width: 50.width,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: 25.height,
                        width: 25.width,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greenColor,
                            border: Border.all(
                                color: AppColors.blackColor, width: 2)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
