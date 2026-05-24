import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/login/controller/forgot_password_screen_controller.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/str_const.dart';
import 'package:zob/widget/text_form_field_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    final forgotPasswordScreenController =
        Get.put(ForgotPasswordScreenController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              AppColor.colorB3FF,
              AppColor.color8EE9,
              AppColor.color77DC
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  AppHelper().verticalSpace(size: 80),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: AppColor.white,
                          size: 35,
                        ),
                        AppHelper()
                            .horizontalSpace(size: AppFontSize.fontSize32),
                        Text(
                          AppText.appName,
                          style: AppStyle().workSansMedium(context).copyWith(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: height * 0.5,
                width: width,
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Form(
                  key: forgotPasswordScreenController.formKey,
                  child: Column(
                    children: [
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize32),
                      Text(
                        "Forgot your password?\n Don’t worry!",
                        textAlign: TextAlign.center,
                        style: AppStyle().workSansSemiBold(context).copyWith(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      Text(
                        "Enter the email address you used to create your account. Please make sure your email is active.",
                        textAlign: TextAlign.center,
                        style: AppStyle().workSansSemiBold(context).copyWith(
                              fontSize: 18,
                              color: Color.fromARGB(255, 131, 131, 131),
                            ),
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormFieldWidget(
                          height: height,
                          width: width,
                          controller:
                              forgotPasswordScreenController.emailController,
                          labelText: "Email",
                          hintText: 'Enter Your Email',
                        ),
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ButtonWidget(
                          width: width,
                          height: height * 0.072,
                          onTap: () {
                            if (forgotPasswordScreenController
                                .formKey.currentState!
                                .validate()) {
                              forgotPasswordScreenController.forgotPassword(
                                  email: forgotPasswordScreenController
                                      .emailController.text);
                            }
                          },
                          btnColor: AppColor.color95ED,
                          btnName: "Send Request",
                          btnTextColor: AppColor.white,
                          isLoading: forgotPasswordScreenController.isLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
