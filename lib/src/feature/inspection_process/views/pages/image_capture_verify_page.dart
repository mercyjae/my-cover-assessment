import 'dart:io';

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
      body: SafeArea(
        child: Stack(
          children: [
            Image.file(
              File(widget.imagePath),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            StepTimerAndIndicator(
              verifiedSteps: verifiedSteps,
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
                    isVerifying
                        ? VerifyingWidget(rotation: _rotation)
                        : PreviewWidget(step: step),
                    AppSpacing.setVerticalSpace(100),
                    Row(
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: AppColors.whiteColor,
                            foregroundColor: AppColors.blackColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                          ),
                          child: const Text("Re capture"),
                        ),
                        AppSpacing.setHorizontalSpace(10),
                        ElevatedButton(
                          onPressed:
                              // isVerifying
                              //     ? null
                              //     :
                              () {
                            ref.read(isVerifyingProvider.notifier).state = true;
                            Future.delayed(const Duration(seconds: 3), () {
                              final updatedSteps = [
                                ...ref.read(verifiedStepsProvider),
                              ];
                              updatedSteps[widget.stepIndex] = true;
                              ref.read(verifiedStepsProvider.notifier).state =
                                  updatedSteps;

                              ref.read(isVerifyingProvider.notifier).state =
                                  true;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Verifying image...")),
                              );
                              ref.read(isVerifyingProvider.notifier).state =
                                  false;

                              final nextIndex = widget.stepIndex + 1;
                              if (nextIndex < inspectionView.length) {
                                context.pushNamed('start-camera',
                                    pathParameters: {
                                      'stepIndex': nextIndex.toString()
                                    });
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            foregroundColor: AppColors.whiteColor,
                            backgroundColor: AppColors.greenColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 12,
                            ),
                          ),
                          child: const Text("Verify"),
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

// final isVerifyingProvider = StateProvider<bool>((ref) => false);
// final verifiedStepsProvider =
//     StateProvider<List<bool>>((ref) => [false, false, false]);

// class ImageCaptureVerifyPage extends ConsumerWidget {
//   final int stepIndex;
//   final String imagePath;
//   const ImageCaptureVerifyPage({
//     super.key,
//     required this.imagePath,
//     required this.stepIndex,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final step = inspectionView[stepIndex];
//     final isVerifying = ref.watch(isVerifyingProvider);

//     final verifiedSteps = ref.watch(verifiedStepsProvider);
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Image.file(
//               File(imagePath),
//               width: double.infinity,
//               height: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 30),
//                 child: Column(
//                   children: [
//                     AppSpacing.setVerticalSpace(200),
//                     Container(
//                       height: 40,
//                       width: 30,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle, color: AppColors.whiteColor),
//                       child: Center(
//                         child: Text(
//                           '1:59',
//                           style: context.textTheme.displayLarge?.copyWith(
//                               fontSize: 14,
//                               // height: 1.5,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.errorColor),
//                         ),
//                       ),
//                     ),
//                     AppSpacing.setVerticalSpace(20),
//                     Container(
//                       height: 300.height,
//                       width: 20.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: AppColors.blackColor.withAlpha(50),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(3, (index) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 5),
//                               child: Container(
//                                 height: 60.height,
//                                 width: 60.width,
//                                 decoration: BoxDecoration(
//                                   color: verifiedSteps[index]
//                                       ? AppColors.greenColor
//                                       : AppColors.grey1,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   Icons.check,
//                                   size: 20,
//                                   color: AppColors.whiteColor,
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 height: double.infinity,
//                 width: 150.width,
//                 color: AppColors.grey1.withAlpha(90),
//                 child: Column(
//                   children: [
//                     AppSpacing.setVerticalSpace(100),
//                     isVerifying
//                         ? Column(
//                             children: [
//                               AppSpacing.setVerticalSpace(40),
//                               RichText(
//                                   text: TextSpan(
//                                       text: 'Verifying  ',
//                                       style: context.textTheme.displayLarge
//                                           ?.copyWith(
//                                               fontSize: 20,
//                                               height: 1.5,
//                                               fontWeight: FontWeight.w600,
//                                               color: AppColors.whiteColor),
//                                       children: [
//                                     TextSpan(
//                                       text: 'Vehicle image ',
//                                       style: context.textTheme.displayLarge
//                                           ?.copyWith(
//                                               fontSize: 20,
//                                               height: 1.5,
//                                               fontWeight: FontWeight.w600,
//                                               color: AppColors.greenColor),
//                                     ),
//                                   ])),
//                               AppSpacing.setVerticalSpace(40),
//                               Image.asset('assets/images/verify_logo.png'),
//                               AppSpacing.setVerticalSpace(40),
//                               Text(
//                                 'Hold on while we verify\nyour image',
//                                 textAlign: TextAlign.center,
//                                 style: context.textTheme.displayLarge?.copyWith(
//                                     fontSize: 15,
//                                     height: 1.5,
//                                     fontWeight: FontWeight.w500,
//                                     color: AppColors.whiteColor),
//                               ),
//                               AppSpacing.setVerticalSpace(20),
//                             ],
//                           )
//                         : Column(
//                             children: [
//                               AppSpacing.setVerticalSpace(50),
//                               RichText(
//                                   text: TextSpan(
//                                       text: 'Vehicle ',
//                                       style: context.textTheme.displayLarge
//                                           ?.copyWith(
//                                               fontSize: 20,
//                                               height: 1.5,
//                                               fontWeight: FontWeight.w600,
//                                               color: AppColors.whiteColor),
//                                       children: [
//                                     TextSpan(
//                                       text: step.viewStatus,
//                                       style: context.textTheme.displayLarge
//                                           ?.copyWith(
//                                               fontSize: 20,
//                                               height: 1.5,
//                                               fontWeight: FontWeight.w600,
//                                               color: AppColors.greenColor),
//                                     ),
//                                     TextSpan(
//                                       text: 'View ',
//                                       style: context.textTheme.displayLarge
//                                           ?.copyWith(
//                                               fontSize: 20,
//                                               height: 1.5,
//                                               fontWeight: FontWeight.w600,
//                                               color: AppColors.whiteColor),
//                                     ),
//                                   ])),
//                               AppSpacing.setVerticalSpace(50),
//                               Text(
//                                 'Confirm Vehicle side view to\nmove to the next Vehicle view',
//                                 style: context.textTheme.displayLarge?.copyWith(
//                                     fontSize: 15,
//                                     height: 1.5,
//                                     fontWeight: FontWeight.w500,
//                                     color: AppColors.whiteColor),
//                               ),
//                               AppSpacing.setVerticalSpace(50),
//                             ],
//                           ),
//                     AppSpacing.setVerticalSpace(100),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             backgroundColor: isVerifying
//                                 ? const Color.fromARGB(175, 255, 255, 255)
//                                 : AppColors.whiteColor,
//                             foregroundColor: AppColors.blackColor,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 32, vertical: 12),
//                           ),
//                           child: const Text("Re capture"),
//                         ),
//                         AppSpacing.setHorizontalSpace(10),
//                         ElevatedButton(
//                           onPressed: () {
//                             ref.read(isVerifyingProvider.notifier).state = true;
//                             Future.delayed(Duration(seconds: 3), () {
//                               final updatedSteps = [
//                                 ...ref.read(verifiedStepsProvider)
//                               ];
//                               updatedSteps[stepIndex] = true;
//                               ref.read(verifiedStepsProvider.notifier).state =
//                                   updatedSteps;
//                               ref.read(isVerifyingProvider.notifier).state =
//                                   true;
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text("Verifying image...")));
//                               ref.read(isVerifyingProvider.notifier).state =
//                                   false;
//                               // if (currentIndex < 2) {
//                               //   ref
//                               //       .read(inspectionStepIndexProvider.notifier)
//                               //       .state++;
//                               // }
//                               final nextIndex = stepIndex + 1;

//                               if (nextIndex < inspectionView.length) {
//                                 context
//                                     .push('${AppPath.startCamera}/$nextIndex');
//                               } else {
//                                 //   context.go('/inspection/summary');
//                               }
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             backgroundColor: AppColors.greenColor,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 40, vertical: 12),
//                           ),
//                           child: const Text("Verify"),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
