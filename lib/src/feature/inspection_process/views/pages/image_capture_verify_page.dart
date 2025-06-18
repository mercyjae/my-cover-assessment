import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/model/inspection_view_model.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/preview_widget.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/step_timer_and_indicator.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/verifying_widget.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/extensions.dart';
import 'package:my_cover_ai_test/src/shared/utils/sizing.dart';

final isVerifyingProvider = StateProvider<bool>((ref) => false);
final verifiedStepsProvider =
    StateProvider<List<bool>>((ref) => [false, false, false]);

class ImageCaptureVerifyPage extends ConsumerStatefulWidget {
  final int stepIndex;
  final String imagePath;

  const ImageCaptureVerifyPage({
    super.key,
    required this.imagePath,
    required this.stepIndex,
  });

  @override
  ConsumerState<ImageCaptureVerifyPage> createState() =>
      _ImageCaptureVerifyPageState();
}

class _ImageCaptureVerifyPageState extends ConsumerState<ImageCaptureVerifyPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat();
    _rotation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = inspectionView[widget.stepIndex];
    final isVerifying = ref.watch(isVerifyingProvider);
    final verifiedSteps = ref.watch(verifiedStepsProvider);

    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Stack(
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Image.file(
                File(widget.imagePath),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 130,
              top: 100,
              child: Align(
                alignment: Alignment.center,
                child: DottedBorder(
                  color: AppColors.blackColor,
                  strokeWidth: 3,
                  dashPattern: [10, 10],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: SizedBox(
                    width: 330,
                    height: 200,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(widget.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
            Positioned(
              left: 70,
              child: StepTimerAndIndicator(
                verifiedSteps: verifiedSteps,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: double.infinity,
                width: 128.width,
                color: AppColors.blackColor.withAlpha(90),
                child: Column(
                  children: [
                    AppSpacing.setVerticalSpace(100),
                    isVerifying
                        ? VerifyingWidget(rotation: _rotation)
                        : PreviewWidget(step: step),
                    AppSpacing.setVerticalSpace(100),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.goNamed(
                                'start-camera',
                                pathParameters: {
                                  'stepIndex': widget.stepIndex.toString(),
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppColors.whiteColor,
                              foregroundColor: AppColors.blackColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            child: const Text("Re capture"),
                          ),
                          AppSpacing.setHorizontalSpace(5),
                          ElevatedButton(
                            onPressed:
                                //    isVerifying
                                // ? null
                                // :
                                () {
                              ref.read(isVerifyingProvider.notifier).state =
                                  true;
                              Future.delayed(const Duration(seconds: 3), () {
                                final updatedSteps = [
                                  ...ref.read(verifiedStepsProvider),
                                ];
                                updatedSteps[widget.stepIndex] = true;
                                ref.read(verifiedStepsProvider.notifier).state =
                                    updatedSteps;

                                ref.read(isVerifyingProvider.notifier).state =
                                    true;
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //       backgroundColor: AppColors.greenColor,
                                //       content: Text("Verifying image...")),
                                // );
                                ref.read(isVerifyingProvider.notifier).state =
                                    false;

                                final nextIndex = widget.stepIndex + 1;
                                if (nextIndex < inspectionView.length) {
                                  context.pushNamed('start-camera',
                                      pathParameters: {
                                        'stepIndex': nextIndex.toString()
                                      });
                                } else {
                                  context.go('/inspect/step/1');
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: AppColors.whiteColor,
                              backgroundColor: isVerifying
                                  ? AppColors.greenColor.withOpacity(0.2)
                                  : AppColors.greenColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            child: const Text("Verify"),
                          ),
                        ],
                      ),
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
