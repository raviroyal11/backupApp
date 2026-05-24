import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskManagementScreenController extends GetxController {
  var selectTaskPhoto = "".obs;
  //// document selection
  selectDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      selectTaskPhoto.value = result.files.single.path ?? "";
      debugPrint("Selectd File : ${selectTaskPhoto.value}");
    }
  }
}
