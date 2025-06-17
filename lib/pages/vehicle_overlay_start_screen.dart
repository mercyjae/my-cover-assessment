// vehicle_overlay_start_screen.dart

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cover_ai_test/data/inspection_view_model.dart';
import 'package:my_cover_ai_test/pages/image_capture_verify_page.dart';
import 'package:my_cover_ai_test/pages/rotate_device.dart';
import 'package:my_cover_ai_test/routes/app_path.dart';
import 'package:my_cover_ai_test/utils/app_colors.dart';
import 'package:my_cover_ai_test/utils/extensions.dart';
import 'package:my_cover_ai_test/utils/sizing.dart';

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
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    AppSpacing.setVerticalSpace(200),
                    Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.whiteColor),
                      child: Center(
                        child: Text(
                          '1:59',
                          style: context.textTheme.displayLarge?.copyWith(
                              fontSize: 14,
                              // height: 1.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.errorColor),
                        ),
                      ),
                    ),
                    AppSpacing.setVerticalSpace(20),
                    Container(
                      height: 300.height,
                      width: 20.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.blackColor.withAlpha(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 60.height,
                                width: 60.width,
                                decoration: BoxDecoration(
                                  color: verifiedSteps[index]
                                      ? AppColors.greenColor
                                      : AppColors.grey1,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 20,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: double.infinity,
                width: 150.width,
                color: AppColors.grey1.withAlpha(90),
                child: Column(
                  children: [
                    AppSpacing.setVerticalSpace(100),
                    RichText(
                        text: TextSpan(
                            text: 'Vehicle ',
                            style: context.textTheme.displayLarge?.copyWith(
                                fontSize: 20,
                                height: 1.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor),
                            children: [
                          TextSpan(
                            text: step.viewStatus,
                            style: context.textTheme.displayLarge?.copyWith(
                                fontSize: 20,
                                height: 1.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greenColor),
                          ),
                          TextSpan(
                              text: ' View ',
                              style: context.textTheme.displayLarge?.copyWith(
                                  fontSize: 20,
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColor)),
                        ])),
                    AppSpacing.setVerticalSpace(10),
                    Text(
                      'Take Vehicle ${step.viewTitle} view',
                      style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 15,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor),
                    ),
                    //AppSpacing.setVerticalSpace(10),
                    // Transform.rotate(
                    //     angle: 90 * 3.1416 / 180,
                    //     child:
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset(
                        step.overlayAsset,
                        fit: BoxFit.contain,
                        width: 150,
                        height: 120,
                      ),
                    ),
                    // ),
                    // AppSpacing.setVerticalSpace(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                          ),
                          child: Text(
                            "Go back",
                            style: context.textTheme.displayLarge?.copyWith(
                                fontSize: 15,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor),
                          ),
                        ),
                        AppSpacing.setHorizontalSpace(10),
                        ElevatedButton(
                          onPressed: () {
                            context.pushNamed('image-capture-start',
                                pathParameters: {
                                  'stepIndex': stepIndex.toString()
                                });
                         
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: AppColors.greenColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                          ),
                          child: Text(
                            "Start",
                            style: context.textTheme.displayLarge?.copyWith(
                                fontSize: 15,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
