import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/account_screen_controller.dart';
import 'package:zob/home/view/account/manage_profile.dart';
import 'package:zob/home/view/account/profile_details.dart';
import 'package:zob/home/view/account/reset_password_screen.dart';
import 'package:zob/home/view/account/upload_profile_picture.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/global_helper.dart';
import 'package:zob/utils/share_widget.dart.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final accountController = Get.put(AccountScreenController());
  var userName = "".obs;
  var userEmail = "".obs;

  @override
  void initState() {
    getUserNames();
    checkLoginStatus();
    super.initState();
  }

  checkLoginStatus() async {
    var checkLoginStatusApi = await MySingleton().checkMyLoginStatus();
    debugPrint("Check login status : ${checkLoginStatusApi}");
    if (checkLoginStatusApi == 1) {
      SharePref().setLogin(setLogin: false);
      Get.offAll(LoginScreen());
      CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          title: "Oh snap!",
          message:
              "Sorry!, you can't login because you are logged in to another device.",
          snackBarType: ContentType.failure);
    }
  }

  getUserNames() async {
    userName.value = await SharePref().getUserName();
    userEmail.value = await SharePref().getUserEmail();
    accountController.selectProfilePicsApi.value =
        await SharePref().getProfilePic();
    log('Profile pic LLL :::: ${accountController.selectProfilePicsApi.value}');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    var data = Get.arguments;
    debugPrint("Argument : $data");
    return Scaffold(
      body: Container(
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
          children: [
            SizedBox(
              height: height * 0.15,
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    AppHelper().horizontalSpace(size: 20),
                    Text(
                      "Profile",
                      style: AppStyle()
                          .workSansSemiBold(context)
                          .copyWith(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              height: height * 0.85,
              width: width,
              decoration: BoxDecoration(
                color: AppColor.colorF6F8,
                border: Border.all(width: 1, color: const Color(0xFFF1F1F2)),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.asset(AppImg.manImg),
                        Obx(
                          () => Container(
                            height: height * 0.1,
                            width: height * 0.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColor.color77DC, width: 1.5),
                              image: accountController
                                          .selectProfilePics.value !=
                                      ""
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(accountController
                                            .selectProfilePics.value),
                                      ),
                                    )
                                  : accountController
                                              .selectProfilePicsApi.value !=
                                          ""
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(accountController
                                              .selectProfilePicsApi.value))
                                      : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(AppImg.manImg),
                                        ),
                            ),
                          ),
                        ),
                        AppHelper().horizontalSpace(size: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                userName.value,
                                style: AppStyle()
                                    .workSansSemiBold(context)
                                    .copyWith(
                                      fontSize: 20,
                                      color: AppColor.color4551,
                                    ),
                              ),
                            ),
                            Obx(
                              () => Text(
                                userEmail.value,
                                style:
                                    AppStyle().workSansMedium(context).copyWith(
                                          fontSize: 15,
                                          color: AppColor.color969D,
                                        ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    AppHelper().verticalSpace(size: 16),
                    Text(
                      "Profile settings",
                      style: AppStyle().workSansMedium(context).copyWith(
                            fontSize: 15,
                            color: AppColor.color969D,
                          ),
                    ),
                    AppHelper().verticalSpace(size: 16),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                final data =
                                    await Get.to(UploadProfilePictureScreen());
                                accountController.selectProfilePicsApi.value =
                                    data ?? "";
                                debugPrint(
                                    "Networl url data : ${accountController.selectProfilePicsApi.value}");
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImg.account),
                                  AppHelper().horizontalSpace(size: 12),
                                  Text(
                                    "Update Profile Picture",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            fontSize: 15,
                                            color: AppColor.color4551),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppColor.colorB5BA,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppHelper().verticalSpace(size: 16),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                // var result = await Get.to(ManageProfileScreen());
                                // if(result == true){
                                //  getUserNames();
                                // }
                                Get.to(ManageProfileScreen());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImg.account),
                                  AppHelper().horizontalSpace(size: 12),
                                  Text(
                                    "Manage Profile",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            fontSize: 15,
                                            color: AppColor.color4551),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppColor.colorB5BA,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppHelper().verticalSpace(size: 10),
                    /* Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Get.to(ProfileDetailsScreen());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImg.account),
                                  AppHelper().horizontalSpace(size: 12),
                                  Text(
                                    "Profile Details",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            fontSize: 15,
                                            color: AppColor.color4551),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppColor.colorB5BA,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), 
                    AppHelper().verticalSpace(size: 10),*/
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(ResetPasswordScreen());
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  AppHelper().horizontalSpace(size: 12),
                                  Text(
                                    "Reset Password",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            fontSize: 15,
                                            color: AppColor.color4551),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppColor.colorB5BA,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppHelper().verticalSpace(size: 10),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                ShareWidget().share(
                                    shareText:
                                        "https://attendance.backupp.com/");
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: Colors.grey,
                                  ),
                                  AppHelper().horizontalSpace(size: 12),
                                  Text(
                                    "Share",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            fontSize: 15,
                                            color: AppColor.color4551),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppColor.colorB5BA,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppHelper().verticalSpace(size: 10),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            SharePref().setLogin(setLogin: false);
                            SharePref().setUserName(setUserName: "");
                            SharePref().setUserDOB(setUserDOB: "");
                            SharePref().setUserEmail(setUserEmail: "");
                            SharePref().setUserId(userID: 0);
                            Get.offAll(LoginScreen());
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(AppImg.logout),
                              AppHelper().horizontalSpace(size: 12),
                              Text(
                                "Logout",
                                style: AppStyle()
                                    .workSansMedium(context)
                                    .copyWith(
                                        fontSize: 15,
                                        color: AppColor.color4551),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.chevron_right,
                                color: AppColor.colorB5BA,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*Text(
                            "Name :",
                            style: AppStyle.workSansMedium.copyWith(
                              fontSize: 22,
                              color: Color(0xFF83878E),
                            ),
                          ),
                          AppHelper().verticalSpace(size: 8),
                          Text(
                            "Testing Guru",
                            style: AppStyle.workSansRegular.copyWith(
                              fontSize: 20,
                              color: AppColor.color4551,
                            ),
                          ),
                          AppHelper().verticalSpace(size: 24),
                          Text(
                            "DOB :",
                            style: AppStyle.workSansMedium.copyWith(
                              fontSize: 22,
                              color: Color(0xFF83878E),
                            ),
                          ),
                          AppHelper().verticalSpace(size: 8),
                          Text(
                            "22 Oct, 1994",
                            style: AppStyle.workSansRegular.copyWith(
                              fontSize: 20,
                              color: AppColor.color4551,
                            ),
                          ),
                          AppHelper().verticalSpace(size: 24),
                          Text(
                            "Country :",
                            style: AppStyle.workSansMedium.copyWith(
                              fontSize: 22,
                              color: Color(0xFF83878E),
                            ),
                          ),
                          AppHelper().verticalSpace(size: 8),
                          Text(
                            "India",
                            style: AppStyle.workSansRegular.copyWith(
                              fontSize: 20,
                              color: AppColor.color4551,
                            ),
                          ),
                          AppHelper().verticalSpace(size: 24),
                          Text(
                            "Email :",
                            style: AppStyle.workSansMedium.copyWith(
                              fontSize: 22,
                              color: Color(0xFF83878E),
                            ),
                          ),
                          AppHelper().verticalSpace(size: 8),
                          Text(
                            "Testing@gmail.com",
                            style: AppStyle.workSansRegular.copyWith(
                              fontSize: 20,
                              color: AppColor.color4551,
                            ),
                          ),
                          AppHelper().verticalSpace(size: 24),
                          Text(
                            "Password :",
                            style: AppStyle.workSansMedium.copyWith(
                              fontSize: 22,
                              color: Color(0xFF83878E),
                            ),
                          ),
                          AppHelper().verticalSpace(size: 8),
                          Text(
                            "*************",
                            style: AppStyle.workSansRegular.copyWith(
                              fontSize: 20,
                              color: AppColor.color4551,
                            ),
                          ),
                          AppHelper().verticalSpace(size: 24),
                          Text(
                            "Mobile No. :",
                            style: AppStyle.workSansMedium.copyWith(
                              fontSize: 22,
                              color: Color(0xFF83878E),
                            ),
                          ),
                          AppHelper().verticalSpace(size: 8),
                          Text(
                            "1234567890",
                            style: AppStyle.workSansRegular.copyWith(
                              fontSize: 20,
                              color: AppColor.color4551,
                            ),
                          ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
