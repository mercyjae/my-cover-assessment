import 'package:flutter/material.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/extensions.dart';
import 'package:my_cover_ai_test/src/shared/utils/sizing.dart';

class StepTimerAndIndicator extends StatelessWidget {
  final List<bool> verifiedSteps;
  const StepTimerAndIndicator({super.key, required this.verifiedSteps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          AppSpacing.setVerticalSpace(200),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.errorColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                height: 40,
                width: 30,
                margin: EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.whiteColor,
                ),
                child: Center(
                  child: Text(
                    '1:59',
                    style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.errorColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.setVerticalSpace(50),
          Container(
            height: 280.height,
            width: 17.width,
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
                      height: 57.height,
                      width: 57.width,
                      decoration: BoxDecoration(
                        color: verifiedSteps[index]
                            ? AppColors.greenColor
                            : AppColors.grey1,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          size: 18, color: AppColors.whiteColor),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
