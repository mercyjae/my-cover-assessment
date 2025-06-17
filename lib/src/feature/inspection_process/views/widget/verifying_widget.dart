import 'package:flutter/widgets.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/extensions.dart';
import 'package:my_cover_ai_test/src/shared/utils/sizing.dart';

class VerifyingWidget extends StatelessWidget {
  const VerifyingWidget({
    super.key,
    required Animation<double> rotation,
  }) : _rotation = rotation;

  final Animation<double> _rotation;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          AppSpacing.setVerticalSpace(40),
          RichText(
            text: TextSpan(
              text: 'Verifying  ',
              style:
                  context.textTheme.displayLarge?.copyWith(
                fontSize: 20,
                height: 1.5,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
              children: [
                TextSpan(
                  text: 'Vehicle image ',
                  style: context.textTheme.displayLarge
                      ?.copyWith(
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.greenColor,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.setVerticalSpace(40),
          RotationTransition(
            turns: _rotation,
            child: Image.asset(
              'assets/images/verify_logo.png',
            ),
          ),
          AppSpacing.setVerticalSpace(40),
          Text(
            'Hold on while we verify\nyour image',
            textAlign: TextAlign.center,
            style: context.textTheme.displayLarge?.copyWith(
              fontSize: 15,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
          AppSpacing.setVerticalSpace(20),
        ],
      );
  }
}