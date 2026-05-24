import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/dashboard_screen_controller.dart';
import 'package:zob/login/controller/intro_screen_controller.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/str_const.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final loginScreenController = Get.put(IntroScreenController());
  final dashboardScreenController = Get.put(DashboardScreenController());

  @override
  void initState() {
    dashboardScreenController.getCurrentLocationPermission();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: AppFontSize.paddingSize21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize64),
                      Text(
                        AppText.appName,
                        style: AppStyle()
                            .workSansMedium(context)
                            .copyWith(fontSize: 24),
                      ),
                      AppHelper()
                          .verticalSpace(size: AppFontSize.paddingSize22),
                      SizedBox(
                        width: width * 0.72,
                        child: Text(
                          "Locate workers or find new job opportunities.",
                          style: AppStyle()
                              .workSansBold(context)
                              .copyWith(fontSize: AppFontSize.fontSize32),
                        ),
                      ),
                      AppHelper().verticalSpace(size: 55),
                      Image.asset(AppImg.introScreen)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: height * 0.320,
              width: width,
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  AppHelper().verticalSpace(size: AppFontSize.paddingSize50),
                  Text(
                    AppText.welcome,
                    style: AppStyle().workSansSemiBold(context).copyWith(
                          fontSize: AppFontSize.fontSize20,
                          color: AppColor.color4551,
                        ),
                  ),
                  Text(
                    "Choose your account type to continue",
                    style: AppStyle().workSansMedium(context).copyWith(
                          fontSize: AppFontSize.fontSize18,
                          color: AppColor.color4551,
                        ),
                  ),
                  AppHelper().verticalSpace(size: AppFontSize.paddingSize50),
                  // Obx(
                  //   () => Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: AppFontSize.paddingSize16),
                  //     child: ButtonWidget(
                  //       width: width,
                  //       height: height * 0.072,
                  //       onTap: () {
                  //         loginScreenController.isSelectCompany.value = true;
                  //         loginScreenController.isSelectStaff.value = false;
                  //         Get.to(LoginScreen());
                  //       },
                  //       btnColor: loginScreenController.isSelectCompany.value
                  //           ? AppColor.color95ED
                  //           : Color(0x66E7E8E9),
                  //       btnName: "Company",
                  //       btnTextColor:
                  //           loginScreenController.isSelectCompany.value
                  //               ? AppColor.white
                  //               : Color(0xB393969D),
                  //     ),
                  //   ),
                  // ),
                  // AppHelper().verticalSpace(size: AppFontSize.paddingSize16),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppFontSize.paddingSize16),
                      child: ButtonWidget(
                        width: width,
                        height: height * 0.072,
                        onTap: () {
                          loginScreenController.isSelectStaff.value = true;
                          loginScreenController.isSelectCompany.value = false;
                          Get.offAll(LoginScreen());
                        },
                        btnColor: loginScreenController.isSelectStaff.value
                            ? AppColor.color95ED
                            : const Color(0x66E7E8E9),
                        btnName: "Staff",
                        btnTextColor: loginScreenController.isSelectStaff.value
                            ? AppColor.white
                            : const Color(0xB393969D),
                        isLoading: false.obs,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.btnColor,
    required this.btnName,
    required this.btnTextColor,
    required this.isLoading,
  });

  final double width;
  final double height;
  final Function onTap;
  final Color btnColor;
  final Color btnTextColor;
  final String btnName;
  final RxBool isLoading;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(color: const Color.fromARGB(255, 231, 225, 225)),
          borderRadius: BorderRadius.circular(32),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                onTap();
              },
              child: Center(
                child: isLoading.obs.value.value
                    ? const CircularProgressIndicator(
                        color: AppColor.white,
                      )
                    : Text(
                        btnName,
                        style: AppStyle().workSansSemiBold(context).copyWith(
                            fontSize: AppFontSize.fontSize20, color: btnTextColor),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
