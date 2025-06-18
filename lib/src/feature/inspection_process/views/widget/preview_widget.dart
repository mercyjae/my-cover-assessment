import 'package:flutter/widgets.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/model/inspection_view_model.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/extensions.dart';
import 'package:my_cover_ai_test/src/shared/utils/sizing.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({
    super.key,
    required this.step,
  });

  final InspectionViewModel step;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.setVerticalSpace(50),
        RichText(
          text: TextSpan(
            text: 'Vehicle ',
            style: context.textTheme.displayLarge?.copyWith(
              fontSize: 20,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
            ),
            children: [
              TextSpan(
                text: step.viewStatus,
                style: context.textTheme.displayLarge?.copyWith(
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greenColor,
                ),
              ),
              TextSpan(
                text: ' View ',
                style: context.textTheme.displayLarge?.copyWith(
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.setVerticalSpace(50),
        Text(
          'Confirm Vehicle side view to\nmove to the next Vehicle view',
          style: context.textTheme.displayLarge?.copyWith(
            fontSize: 15,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color: AppColors.whiteColor,
          ),
        ),
        AppSpacing.setVerticalSpace(50),
      ],
    );
  }
}
