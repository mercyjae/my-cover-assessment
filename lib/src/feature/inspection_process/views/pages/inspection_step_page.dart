import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cover_ai_test/src/feature/inspection_process/views/widget/style_text_segment.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/extensions.dart';
import 'package:my_cover_ai_test/src/shared/utils/sizing.dart';

import '../../model/inspection_steps_model.dart';

class InspectionStepPage extends StatefulWidget {
  final int step;
  const InspectionStepPage({super.key, required this.step});

  @override
  State<InspectionStepPage> createState() => _InspectionStepPageState();
}

class _InspectionStepPageState extends State<InspectionStepPage> {
  @override
  Widget build(BuildContext context) {
    final stepData = inspectionSteps[widget.step - 1];
    final isLast = widget.step == inspectionSteps.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              AppSpacing.verticalSpaceMedium,
              Center(
                child: Text(
                  "Step on how to inspect",
                  style: context.textTheme.displayLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor),
                ),
              ),
              AppSpacing.verticalSpaceMedium,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'It is important to note all these ',
                    style: context.textTheme.displayLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor),
                    children: [
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'STEP ',
                            style: context.textTheme.displayLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.purpleColor),
                          ),
                          TextSpan(
                            text: 'before\nstarting your inspection',
                            style: context.textTheme.displayLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyColor),
                          ),
                        ],
                      ),
                    ]),
              ),
              AppSpacing.verticalSpaceMassive,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.lightPurple),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(8, (i) {
                        final isActive = (i + 1) == widget.step;
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Container(
                              height: 30,
                              width: isActive ? 60 : 30,
                              decoration: BoxDecoration(
                                  borderRadius: isActive
                                      ? BorderRadius.circular(10)
                                      : BorderRadius.circular(20),
                                  color: AppColors.whiteColor),
                              child: isActive
                                  ? Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text: 'STEP  ',
                                            style: context
                                                .textTheme.displayLarge
                                                ?.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.blackColor),
                                            children: [
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '${i + 1}',
                                                    style: context
                                                        .textTheme.displayLarge
                                                        ?.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .purpleColor),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        '${i + 1}',
                                        style: context.textTheme.displayLarge
                                            ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.greyColor),
                                      ),
                                    ),
                            ));
                      }),
                    ),
                    AppSpacing.verticalSpaceMedium,
                    RichText(
                      text: TextSpan(
                        children: stepData.instructionSegments.map((seg) {
                          return TextSpan(
                            text: seg.text,
                            style: getTextStyle(
                              seg.type,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    widget.step == 6
                        ? Column(
                            children: [
                              AppSpacing.setVerticalSpace(10),
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.purpleColor,
                                            width: 2)),
                                  ),
                                  AppSpacing.horizontalSpaceMedium,
                                  RichText(
                                      text: TextSpan(
                                          text:
                                              'You can locate the chassis number on the\n',
                                          style: context.textTheme.displayLarge
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey1),
                                          children: [
                                        TextSpan(
                                          text: 'front windshield, ',
                                          style: context.textTheme.displayLarge
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.greenColor),
                                        ),
                                        TextSpan(
                                          text: 'or',
                                          style: context.textTheme.displayLarge
                                              ?.copyWith(
                                                  height: 1.5,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.blackColor),
                                        ),
                                      ]))
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.purpleColor,
                                            width: 2)),
                                  ),
                                  AppSpacing.horizontalSpaceMedium,
                                  RichText(
                                      text: TextSpan(
                                          text: 'You can find it on the ',
                                          style: context.textTheme.displayLarge
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey1),
                                          children: [
                                        TextSpan(
                                          text: 'interior door ',
                                          style: context.textTheme.displayLarge
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.greenColor),
                                        ),
                                        TextSpan(
                                          text: 'of the\n',
                                          style: context.textTheme.displayLarge
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey1),
                                        ),
                                        TextSpan(
                                          text: "driver's side",
                                          style: context.textTheme.displayLarge
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.greenColor),
                                        ),
                                      ]))
                                ],
                              )
                            ],
                          )
                        : SizedBox(),
                    widget.step == 6
                        ? AppSpacing.setVerticalSpace(50)
                        : widget.step == 1
                            ? AppSpacing.setVerticalSpace(110)
                            : AppSpacing.setVerticalSpace(120),
                    Text(
                      stepData.viewText,
                      style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey1),
                    ),
                    AppSpacing.setVerticalSpace(15),
                    widget.step == 1
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(stepData.image,
                                width: double.infinity,
                                height: 220,
                                fit: BoxFit.cover),
                          )
                        : SizedBox(
                            // height: 200.height,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              color: Colors.grey,
                              strokeWidth: 1.5,
                              dashPattern: const [10, 10],
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(stepData.image,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              AppSpacing.setVerticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      context.go('/rotate');
                      // context.go('/inspect/step/${step - 1}');
                    },
                    child: Text(
                      "Skip",
                      style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isLast) {
                        context.go('/rotate');
                      } else {
                        context.pushNamed('inspect-step',
                            pathParameters: {'stepId': '${widget.step + 1}'});
                        // context.push('/inspect/step/${step + 1}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenColor,
                      foregroundColor: Colors.white, // text/icon color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //  elevation: 4,
                    ),
                    child: Text(
                      isLast ? "Start Inspection" : "Next Step",
                      style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
              //  AppSpacing.setVerticalSpace(0),
            ],
          ),
        ),
      ),
    );
  }
}
