import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/services/api_services.dart';

class ForgotPasswordScreenController extends GetxController {
  var isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  forgotPassword({required String email}) {
    isLoading.value = true;
    return Api.forgotPasswordApi(
      email: email,
    ).then(
      (response) async {
        if (response != null) {
          debugPrint("Check clockout : $response");
          if (response['success'] == true) {
            isLoading.value = false;
            Get.back();
            emailController.clear();
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: "Well done!",
                message: response['message'],
                contentType: ContentType.success,
              ),
            );
            ScaffoldMessenger.of(Get.context!)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: "Oh Snap!",
                message: response['message'],
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(Get.context!)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
            emailController.clear();
            isLoading.value = false;
            // SnackBarWidget().snackBar(message: response['message'] ?? "");
          }
        }
      },
    );
  }
}
