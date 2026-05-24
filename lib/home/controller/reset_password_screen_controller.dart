import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/services/api_services.dart';

class RestPasswordScreenController extends GetxController {
  TextEditingController currentPassCntrl = TextEditingController();
  TextEditingController newPassCntrl = TextEditingController();
  TextEditingController confirmPassCntrl = TextEditingController();
  var isVisiblePassword = false.obs;
  var isVisibleConfirmPassword = false.obs;
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  forgotPassword({required String currentPass, required String newPass}) async {
    var userId = await SharePref().getUserId();
    isLoading.value = true;
    return Api.resetPasswordApi(
      userId: userId.toString(),
      currentPass: currentPass,
      newPass: newPass,
    ).then(
      (response) async {
        if (response != null) {
          debugPrint("Check clockout : $response");
          if (response['success'] == true) {
            isLoading.value = false;
            Get.back();
            currentPassCntrl.clear();
            newPassCntrl.clear();
            confirmPassCntrl.clear();
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

            currentPassCntrl.clear();
            newPassCntrl.clear();
            confirmPassCntrl.clear();
            isLoading.value = false;
            // SnackBarWidget().snackBar(message: response['message'] ?? "");
          }
        }
      },
    );
  }
}
