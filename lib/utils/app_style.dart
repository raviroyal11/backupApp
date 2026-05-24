import 'package:flutter/material.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';

class AppStyle {
  TextStyle workSansRegular(BuildContext context) {
    return const TextStyle(
      fontFamily: 'WorkSans',
      color: AppColor.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle workSansMedium(BuildContext context) {
    return const TextStyle(
      fontFamily: 'WorkSans',
      color: AppColor.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle workSansSemiBold(BuildContext context) {
    return const TextStyle(
      fontFamily: 'WorkSans',
      color: AppColor.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle workSansBold(BuildContext context) {
    return const TextStyle(
      fontFamily: 'WorkSans',
      color: AppColor.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }
}
