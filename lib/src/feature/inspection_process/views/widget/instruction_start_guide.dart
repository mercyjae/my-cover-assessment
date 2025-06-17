
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/data/inspection_view_model.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/extensions.dart';
import 'package:my_cover_ai_test/src/shared/utils/sizing.dart';

class InstructionStartGuide extends StatelessWidget {
  const InstructionStartGuide({
    super.key,
    required this.step,
    required this.stepIndex,
  });

  final InspectionViewModel step;
  final int stepIndex;

  @override
  Widget build(BuildContext context) {
    return Align(
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                step.overlayAsset,
                fit: BoxFit.contain,
                width: 150,
                height: 120,
              ),
            ),
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
    );
  }
}
