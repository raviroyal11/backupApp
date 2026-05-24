import 'dart:convert';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zob/home/view/bottome_navigation.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/register/Model/register_api_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/common_snackbar.dart';

class RegisterScreenController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController lastNmController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden = true.obs;
  RxBool isLoading = false.obs;
  RxBool isTermsAgreed = false.obs;

  registerApiCall() {
    isLoading.value = true;
    Map<String, dynamic> param = {
      "user_name": usernameController.text,
      "email": emailController.text,
      "phone_number": phoneNumberController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text
    };
    debugPrint("parametyer : $param");
    return Api.staffRegisterApi(param).then((response) async {
      isLoading.value = false;

      if (response['success'] == true) {
        RegisterApiResponseModel responseModel =
            RegisterApiResponseModel.fromJson(response);
        SharePref().setUserId(userID: responseModel.user?.id ?? 0);
        SharePref()
            .setAccessToken(accessToken: responseModel.accessToken ?? '');
        SharePref().setLogin(setLogin: true);
        SharePref()
            .setUserName(setUserName: responseModel.user?.firstName ?? '');
        SharePref().setUserEmail(setUserEmail: responseModel.user?.email ?? '');
        SharePref()
            .setUserMobile(setUserMobile: responseModel.user?.phone ?? '');

        Get.offAll(BottomNavigationScreen(
          selectIndex: 0,
        ));
        CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          title: "Well done!",
          message: response['message'],
          snackBarType: ContentType.success,
        );
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        usernameController.clear();
        lastNmController.clear();
        phoneNumberController.clear();
      } else {
        log("Staff Register Api response : 11 $response");
        if(response['data'].containsKey('email') == false){
          response['data']['email'] = [''];
        }
        if(response['data'].containsKey('phone_number') == false){
          response['data']['phone_number'] = [''];
        }
        String emailError = response['data']['email'][0];
        String phoneNumberError = response['data']['phone_number'][0];

        if (emailError != '') {
          CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: "Oh Snap!",
              message: emailError,
              snackBarType: ContentType.failure);
        } else if (phoneNumberError != '') {
          CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: "Oh Snap!",
              message: phoneNumberError,
              snackBarType: ContentType.failure);
        }
      }
    });
  }
}
