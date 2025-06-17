import 'package:flutter/material.dart';
import 'package:my_cover_ai_test/src/shared/utils/app_colors.dart';
import 'package:my_cover_ai_test/src/shared/utils/enum.dart';

class StyledTextSegment {
  final String text;
  final StyledTextType type;

  const StyledTextSegment({
    required this.text,
    this.type = StyledTextType.normal,
  });
}

TextStyle getTextStyle(
  StyledTextType type,
) {
  const base = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
    height: 1.2,
  );

  switch (type) {
    case StyledTextType.bold:
      return base.copyWith(fontWeight: FontWeight.w500, fontSize: 16);
    case StyledTextType.highlightedBlue:
      return base.copyWith(
          fontWeight: FontWeight.w600, color: AppColors.blueColor);
    case StyledTextType.highlightedGreen:
      return base.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.greenColor,
          fontSize: 16);
    case StyledTextType.normal:
      return base.copyWith(fontWeight: FontWeight.w400, fontSize: 16);
    default:
      return base;
  }
}
