import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/controller/login_screen_controller.dart';
import 'package:zob/login/forgot_password_screen.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/register/register_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/str_const.dart';
import 'package:zob/widget/text_form_field_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginScreenController = Get.put(LoginScreenController());
  @override
  void initState() {
    SharePref().setLogin(setLogin: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
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
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: AppFontSize.paddingSize21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize32),
                      // InkWell(
                      //   onTap: () {
                      //     Get.back();
                      //   },
                      //   child: Row(
                      //     children: [
                      //       const Icon(
                      //         Icons.arrow_back,
                      //         color: AppColor.white,
                      //       ),
                      //       AppHelper().horizontalSpace(
                      //           size: AppFontSize.paddingSize13),
                      //       Text(
                      //         AppText.back,
                      //         style: AppStyle()
                      //             .workSansMedium(context)
                      //             .copyWith(fontSize: AppFontSize.fontSize20),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize10),
                      SizedBox(
                        width: width * 0.72,
                        child: Text(
                          "Get your labour jobs fast.",
                          style: AppStyle()
                              .workSansBold(context)
                              .copyWith(fontSize: 32),
                        ),
                      ),
                      Image.asset(AppImg.loginScreen)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: height * 0.48,
              width: width,
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppFontSize.paddingSize16),
                child: Form(
                  key: loginScreenController.formKey,
                  child: ListView(
                    padding: EdgeInsets.only(top: AppFontSize.fontSize24),
                    children: [
                      Text(
                        "Login to staff Account",
                        style: AppStyle().workSansSemiBold(context).copyWith(
                              fontSize: AppFontSize.fontSize20,
                              color: AppColor.color4551,
                            ),
                      ),
                      Text(
                        "Enter your email & password to login",
                        style: AppStyle().workSansMedium(context).copyWith(
                              fontSize: AppFontSize.fontSize18,
                              color: AppColor.color4551,
                            ),
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      TextFormFieldWidget(
                        height: height,
                        width: width,
                        controller: loginScreenController.emailController,
                        labelText: "Email",
                        hintText: 'Enter Your Email',
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      Obx(
                        () => TextFormField(
                          cursorColor: AppColor.color8EE9,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill details.';
                            }
                            return null;
                          },
                          controller: loginScreenController.passwordController,
                          obscureText:
                              loginScreenController.isVisiblePassword.value,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 2, left: 10),
                            labelText: "Password",
                            labelStyle: AppStyle()
                                .workSansMedium(context)
                                .copyWith(
                                    color: AppColor.color4551, fontSize: 17),
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
                                loginScreenController.isVisiblePassword.value =
                                    !loginScreenController
                                        .isVisiblePassword.value;
                              },
                              icon: Icon(
                                  !loginScreenController.isVisiblePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                            ),
                            hintText: "Enter Your Password",
                            hintStyle:
                                AppStyle().workSansMedium(context).copyWith(
                                      fontSize: 18,
                                      color: const Color(0xFF83878E),
                                    ),
                          ),
                        ),
                      ),
                      AppHelper()
                          .verticalSpace(size: 5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(ForgotPasswordScreen());
                          },
                          child: Text(
                            "Forgot Password?",
                            style: AppStyle().workSansMedium(context).copyWith(
                                  fontSize: 18,
                                  color: const Color(0xFF83878E),
                                ),
                          ),
                        ),
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize10),
                      ButtonWidget(
                        width: width,
                        height: height * 0.072,
                        onTap: () {
                          if (loginScreenController.formKey.currentState!
                              .validate()) {
                            loginScreenController.loginApiCall();
                          }
                        },
                        btnColor: AppColor.color95ED,
                        btnName: "Login",
                        btnTextColor: AppColor.white,
                        isLoading: loginScreenController.isLogin,
                      ),

                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize16),
                       Center(
                        child: InkWell(
                          onTap: () {
                            Get.to( RegisterScreen());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't Have An Account ? ",
                              style: AppStyle().workSansMedium(context).copyWith(
                                fontSize: AppFontSize.fontSize18,
                                color: AppColor.color4551,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Create Account',
                                  style: AppStyle().workSansSemiBold(context).copyWith(
                                    fontSize: AppFontSize.fontSize18,
                                    color: AppColor.color95ED,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
