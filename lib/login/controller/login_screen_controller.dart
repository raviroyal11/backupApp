import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/dashboard_screen_controller.dart';
import 'package:zob/home/view/bottome_navigation.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/models/login_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/common_snackbar.dart';

class LoginScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final dashboardScreenController = Get.put(DashboardScreenController());
  var isVisiblePassword = false.obs;
  final formKey = GlobalKey<FormState>();
  var isLogin = false.obs;
  loginApiCall() {
    isLogin.value = true;
    Map<String, dynamic> param = {
      "email": emailController.text,
      "password": passwordController.text
    };
    debugPrint("parametyer : $param");
    return Api.loginApi(param).then((response) async {
      isLogin.value = false;
      debugPrint("Logni response = $response");
      if (response != null) {
        LoginResponseModel responseModel =
            LoginResponseModel.fromJson(response);
        var userId = await SharePref().getUserId();
        if (userId != responseModel.data?.id) {
          // SharePref().setRejectRoster(setRejectRoster: false);
          // SharePref().setAcceptRoster(setAcceptRoster: false);

          SharePref()
              .setAcceptnRejectShiftStatus(shiftAcceptnRejectStatus: false);
        }
        if (responseModel.data != null) {
          debugPrint(
              "userId ${responseModel.data?.id}}");
          SharePref().setUserId(userID: responseModel.data?.id ?? 0);
          SharePref().setAccessToken(accessToken: responseModel.accessToken ?? '');
          SharePref().setLogin(setLogin: true);
          SharePref().setUserName(setUserName: responseModel.data?.firstName ?? '');
          SharePref().setUserEmail(setUserEmail: responseModel.data?.email ?? '');
          SharePref().setUserDOB(setUserDOB: responseModel.data?.dob ?? '');
          SharePref().setUserMobile(setUserMobile: responseModel.data?.phone ?? '');
          dashboardScreenController.getUserClockInOutStatus();

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
        }
      } else {
        CommonSnackBarWidget().snackBarWidget(
            context: Get.context!,
            title: "Oh Snap!",
            message: "Please enter valid email and password",
            snackBarType: ContentType.failure);
      }
    });
  }
}
