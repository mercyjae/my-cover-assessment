import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
}

extension ResponsiveExtension on num {
  double get width => w;
  double get height => h;
  double get fontSize => sp;
  double get radius => r;
}
