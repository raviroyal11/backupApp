import 'dart:convert';
import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/services/api_services.dart';

class AccountScreenController extends GetxController {
  var selectProfilePics = "".obs;
  var selectProfilePicsApi = "".obs;
  var isUploading = false.obs;

  selectProfilePic() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image?.path != null) {
      selectProfilePics.value = image?.path ?? "";
    }
  }

  uploadProfilePhoto(String selectPath, BuildContext context) async {
    debugPrint("Selected path : $selectPath");

    var userID = await SharePref().getUserId();

    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(selectPath);
    log("Encode file path : $encoded");
    if (selectProfilePics.value == "") {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: "Oh Snap!",
          message: "Please select profile picture.",
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(Get.context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      // ignore: use_build_context_synchronously
      return Api.uploadProfilePic(
        userID: userID.toString(),
        profilePath: selectPath,
        context: context,
        callBack: (status) {
          if (status == true) {
            isUploading.value = true;
          } else {
            selectProfilePics.value = "";
            isUploading.value = false;
          }
        },
      );
    }
  }
}
