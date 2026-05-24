import 'package:flutter/material.dart';

class AppFontSize {
  //// Font Size
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 14.0;
  static const double fontSize18 = 14.0;
  static const double fontSize20 = 20.0;
  static const double fontSize22 = 22.0;
  static const double fontSize24 = 24.0;
  static const double fontSize32 = 32.0;
  static const double fontSize36 = 36.0;
  static const double fontSize48 = 48.0;

  //// Padding Size
  static const double paddingSize10 = 10.0;
  static const double paddingSize13 = 13.0;
  static const double paddingSize16 = 16.0;
  static const double paddingSize18 = 18.0;
  static const double paddingSize21 = 21.0;
  static const double paddingSize22 = 22.0;
  static const double paddingSize24 = 24.0;
  static const double paddingSize32 = 32.0;
  static const double paddingSize50 = 50.0;
  static const double paddingSize64 = 64.0;
}

class AppHelper {
  Widget horizontalSpace({required double size}) {
    return SizedBox(
      width: size,
    );
  }

  Widget verticalSpace({required double size}) {
    return SizedBox(
      height: size,
    );
  }
}
