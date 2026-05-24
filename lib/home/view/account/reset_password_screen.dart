import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/reset_password_screen_controller.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final restPasswordScreenController =
        Get.put(RestPasswordScreenController());
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.white,
          title: Text(
            "Reset Password",
            style: AppStyle()
                .workSansSemiBold(context)
                .copyWith(fontSize: 20, color: AppColor.color4551),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              color: AppColor.color969D,
              height: 1.0,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Obx(
          () => Form(
            key: restPasswordScreenController.formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                TextFormField(
                  cursorColor: AppColor.color8EE9,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill details.';
                    }
                    return null;
                  },
                  controller: restPasswordScreenController.currentPassCntrl,
                  obscureText:
                      restPasswordScreenController.isVisiblePassword.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 2, left: 10),
                    labelText: "current Password",
                    labelStyle: AppStyle()
                        .workSansMedium(context)
                        .copyWith(color: AppColor.color4551, fontSize: 17),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColor.color77DC,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColor.borderColor, width: 1.0),
                    ),
                    hintText: "Enter Your Current Password",
                    hintStyle: AppStyle().workSansMedium(context).copyWith(
                          fontSize: 18,
                          color: const Color(0xFF83878E),
                        ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: AppColor.color8EE9,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill details.';
                    }
                    return null;
                  },
                  controller: restPasswordScreenController.newPassCntrl,
                  obscureText:
                      restPasswordScreenController.isVisiblePassword.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 2, left: 10),
                    labelText: "New Password",
                    labelStyle: AppStyle()
                        .workSansMedium(context)
                        .copyWith(color: AppColor.color4551, fontSize: 17),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColor.color77DC,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColor.borderColor, width: 1.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        restPasswordScreenController.isVisiblePassword.value =
                            !restPasswordScreenController
                                .isVisiblePassword.value;
                      },
                      icon: Icon(
                          !restPasswordScreenController.isVisiblePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                    ),
                    hintText: "Enter Your New Password",
                    hintStyle: AppStyle().workSansMedium(context).copyWith(
                          fontSize: 18,
                          color: const Color(0xFF83878E),
                        ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  cursorColor: AppColor.color8EE9,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill details.';
                    }
                    return null;
                  },
                  controller: restPasswordScreenController.confirmPassCntrl,
                  obscureText: restPasswordScreenController
                      .isVisibleConfirmPassword.value,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 2, left: 10),
                    labelText: "Confirm Password",
                    labelStyle: AppStyle()
                        .workSansMedium(context)
                        .copyWith(color: AppColor.color4551, fontSize: 17),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColor.color77DC,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColor.borderColor, width: 1.0),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        restPasswordScreenController
                                .isVisibleConfirmPassword.value =
                            !restPasswordScreenController
                                .isVisibleConfirmPassword.value;
                      },
                      icon: Icon(!restPasswordScreenController
                              .isVisibleConfirmPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    hintText: "Enter Your Confirm Password",
                    hintStyle: AppStyle().workSansMedium(context).copyWith(
                          fontSize: 18,
                          color: const Color(0xFF83878E),
                        ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ButtonWidget(
                    width: width,
                    height: height * 0.072,
                    onTap: () {
                      if (restPasswordScreenController.formKey.currentState!
                          .validate()) {
                        if (restPasswordScreenController.newPassCntrl.text ==
                            restPasswordScreenController
                                .confirmPassCntrl.text) {
                          restPasswordScreenController.forgotPassword(
                              currentPass: restPasswordScreenController
                                  .currentPassCntrl.text,
                              newPass: restPasswordScreenController
                                  .newPassCntrl.text);
                        } else {
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: "Oh Snap!",
                              message: "Password doen't match",
                              contentType: ContentType.failure,
                            ),
                          );
                          ScaffoldMessenger.of(Get.context!)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      }
                    },
                    btnColor: AppColor.color95ED,
                    btnName: "Send Request",
                    btnTextColor: AppColor.white,
                    isLoading: restPasswordScreenController.isLoading,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
