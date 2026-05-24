import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/account_screen_controller.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_style.dart';

class UploadProfilePictureScreen extends StatefulWidget {
  const UploadProfilePictureScreen({super.key});

  @override
  State<UploadProfilePictureScreen> createState() =>
      _UploadProfilePictureScreenState();
}

class _UploadProfilePictureScreenState
    extends State<UploadProfilePictureScreen> {
  final accountController = Get.put(AccountScreenController());

  @override
  void initState() {
    getProfilePic();
    super.initState();
  }

  getProfilePic() async {
    accountController.selectProfilePicsApi.value =
        await SharePref().getProfilePic();
    debugPrint(
        "Check mu profile : ${accountController.selectProfilePicsApi.value}");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.white,
          title: Text(
            "Upload Profile Picture",
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
      body: Column(
        children: [
          SizedBox(
            height: height * 0.1,
          ),
          Align(
            alignment: Alignment.center,
            child: Obx(
              () => Container(
                height: height * 0.2,
                width: height * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.color77DC, width: 1.5),
                  image: accountController.selectProfilePics.value != ""
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(accountController.selectProfilePics.value),
                          ),
                        )
                      : accountController.selectProfilePicsApi.value != ""
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  accountController.selectProfilePicsApi.value))
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AppImg.manImg),
                            ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.color77DC, width: 1.5),
            ),
            child: TextButton(
              onPressed: () {
                accountController.selectProfilePic();
              },
              child: Text(
                "Select Profile Picture",
                style: AppStyle()
                    .workSansSemiBold(context)
                    .copyWith(fontSize: 16, color: AppColor.color4551),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: ButtonWidget(
                width: width,
                height: height * 0.065,
                onTap: () {
                  if (accountController.selectProfilePics.value == "") {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: "Oh Snap!",
                        message: "Please Select Profile Picture",
                        contentType: ContentType.failure,
                      ),
                    );
                    ScaffoldMessenger.of(Get.context!)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  } else {
                    accountController.uploadProfilePhoto(
                        accountController.selectProfilePics.value, context);
                  }
                },
                btnColor: AppColor.color8EE9,
                btnName: "Upload",
                btnTextColor: Colors.white,
                isLoading: accountController.isUploading),
          )
        ],
      ),
    );
  }
}
