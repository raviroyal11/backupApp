import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarWidget {
  snackBar({required String message}) {
    Get.snackbar(
      "ZOB",
      message,
      colorText: Colors.white,
      backgroundColor: const Color.fromARGB(255, 101, 155, 199),
    );
  }
}
