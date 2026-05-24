import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/register/controller/register_screen_controller.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/str_const.dart';
import 'package:zob/widget/text_form_field_widget.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterScreenController controller = Get.put(RegisterScreenController());

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
          child: Padding(
            padding: const EdgeInsets.only(left: AppFontSize.paddingSize21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHelper().verticalSpace(size: AppFontSize.paddingSize64),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: AppColor.white,
                      ),
                      AppHelper()
                          .horizontalSpace(size: AppFontSize.paddingSize13),
                      Text(
                        AppText.back,
                        style: AppStyle()
                            .workSansMedium(context)
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                AppHelper().verticalSpace(size: AppFontSize.paddingSize10),
                SizedBox(
                  width: width * 0.72,
                  child: Text(
                    "Get your labour jobs fast.",
                    style:
                        AppStyle().workSansBold(context).copyWith(fontSize: 40),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: height * 0.675,
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
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize24),
                      Text(
                        "Create staff Account",
                        style: AppStyle().workSansSemiBold(context).copyWith(
                              fontSize: AppFontSize.fontSize20,
                              color: AppColor.color4551,
                            ),
                      ),
                      Text(
                        "Please enter the data with active email",
                        style: AppStyle().workSansMedium(context).copyWith(
                              fontSize: 18,
                              color: AppColor.color4551,
                            ),
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      TextFormFieldWidget(
                        height: height,
                        width: width,
                        controller: controller.usernameController,
                        labelText: "First Name",
                        hintText: 'Enter Your First Name',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      TextFormFieldWidget(
                        height: height,
                        width: width,
                        controller: controller.lastNmController,
                        labelText: "Last Name",
                        hintText: 'Enter Your Last Name',
                        validator: (value) {
                          // if (value == null || value.trim().isEmpty) {
                          //   return 'First Name is required';
                          // }
                          // return null;
                        },
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      TextFormFieldWidget(
                        height: height,
                        width: width,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Email",
                        hintText: 'Enter Your Email',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      TextFormFieldWidget(
                        height: height,
                        width: width,
                        controller: controller.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        labelText: "Phone Number",
                        hintText: 'Enter Your Phone Number',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                          if (!RegExp(r'^\d{10,}$').hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      Obx(() => TextFormFieldWidget(
                            height: height,
                            width: width,
                            labelText: "Password",
                            hintText: 'Enter Your password',
                            obscureText: controller.isPasswordHidden.value,
                            controller: controller.passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                controller.isPasswordHidden.value =
                                    !controller.isPasswordHidden.value;
                              },
                            ),
                          )),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      Obx(() => TextFormFieldWidget(
                            height: height,
                            width: width,
                            labelText: "Confirm Password",
                            hintText: 'Enter Your Confirm Password',
                            controller: controller.confirmPasswordController,
                            obscureText:
                                controller.isConfirmPasswordHidden.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm password is required';
                              }
                              if (value != controller.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isConfirmPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                controller.isConfirmPasswordHidden.value =
                                    !controller.isConfirmPasswordHidden.value;
                              },
                            ),
                          )),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize18),
                      Obx(() => CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            value: controller.isTermsAgreed.value,
                            onChanged: (value) {
                              controller.isTermsAgreed.value = value ?? false;
                            },
                            title: RichText(
                              text: TextSpan(
                                text: 'I agree with ',
                                style:
                                    AppStyle().workSansMedium(context).copyWith(
                                          fontSize: AppFontSize.fontSize14,
                                          color: AppColor.color4551,
                                        ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                          fontSize: AppFontSize.fontSize14,
                                          color: AppColor.color95ED,
                                          decoration: TextDecoration.underline,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (!await launchUrl(
                                          Uri.parse(
                                              'https://backupp.com/company/terms-conditions'),
                                          mode: LaunchMode.externalApplication,
                                        )) {
                                          throw Exception(
                                              'Could not launch ${Uri.parse('https://backupp.com/company/terms-conditions')}');
                                        }
                                      },
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                          fontSize: AppFontSize.fontSize14,
                                          color: AppColor.color4551,
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                          fontSize: AppFontSize.fontSize14,
                                          color: AppColor.color95ED,
                                          decoration: TextDecoration.underline,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (!await launchUrl(
                                          Uri.parse(
                                              'https://backupp.com/company/privacy-policy'),
                                          mode: LaunchMode.externalApplication,
                                        )) {
                                          throw Exception(
                                              'Could not launch ${Uri.parse('https://backupp.com/company/terms-conditions')}');
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          )),
                      AppHelper()
                          .verticalSpace(size: 5),
                      ButtonWidget(
                        width: width,
                        height: height * 0.072,
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (controller.isTermsAgreed.value == false) {
                              CommonSnackBarWidget().snackBarWidget(
                                  context: Get.context!,
                                  title: "Oh Snap!",
                                  message:
                                      "You must agree to the Terms & Conditions and Privacy Policy",
                                  snackBarType: ContentType.failure);
                              return;
                            } else {
                              controller.registerApiCall();
                            }
                          }
                        },
                        btnColor: AppColor.color95ED,
                        btnName: "Create Account",
                        btnTextColor: AppColor.white,
                        isLoading: controller.isLoading,
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize13),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Get.offAll(LoginScreen());
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style:
                                  AppStyle().workSansMedium(context).copyWith(
                                        fontSize: AppFontSize.fontSize18,
                                        color: AppColor.color4551,
                                      ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Login',
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
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
                          .verticalSpace(size: AppFontSize.paddingSize24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
