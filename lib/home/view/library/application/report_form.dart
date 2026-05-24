import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/widget/text_form_field_widget.dart';

class ReportForm extends StatefulWidget {
  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxString selectAttachment = "".obs;
  RxBool isLoading = false.obs;

  ///// Apply Report Form Api
  applyReportFormApi() {
    isLoading.value = true;
    Map<String, String> parameter = {
      "title": titleController.text,
      "description": descriptionController.text,
    };
    if (selectAttachment.value.isEmpty) {
      Api.applyReportFormWithoutMultipartApi(parameter: parameter)
          .then((response) {
        isLoading.value = false;
        if (response != null) {
          if (response['success'] == true) {
            CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: 'Success',
              message: response['message'] ?? "",
              snackBarType: ContentType.success,
            );
            Get.back();
          } else {
            CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: 'Oh Snap!',
              message: response['message'] ?? "",
              snackBarType: ContentType.failure,
            );
          }
          isLoading.value = false;
        } else {
          CommonSnackBarWidget().snackBarWidget(
            context: Get.context!,
            title: 'Oh Snap!',
            message: "Something went wrong. Please try again.",
            snackBarType: ContentType.failure,
          );
          isLoading.value = false;
        }
      });
    } else {
      Api.reportFormApi(
              parameter: parameter, file: File(selectAttachment.value))
          .then((response) {
        isLoading.value = false;
        if (response != null) {
          if (response['success'] == true) {
            CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: 'Success',
              message: response['message'] ?? "",
              snackBarType: ContentType.success,
            );
            Get.back();
          } else {
            CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: 'Oh Snap!',
              message: response['message'] ?? "",
              snackBarType: ContentType.failure,
            );
          }
          isLoading.value = false;
        } else {
          CommonSnackBarWidget().snackBarWidget(
            context: Get.context!,
            title: 'Oh Snap!',
            message: "Something went wrong. Please try again.",
            snackBarType: ContentType.failure,
          );
          isLoading.value = false;
        }
      });
    }
  }

  selectAttachmentPic() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image?.path != null) {
      selectAttachment.value = image!.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Form"),
        titleTextStyle: AppStyle()
            .workSansSemiBold(context)
            .copyWith(fontSize: 20, color: AppColor.color4551),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppColor.colorB5BA,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Title",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormField(
              cursorColor: AppColor.color8EE9,
              controller: titleController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
                labelStyle: AppStyle()
                    .workSansMedium(context)
                    .copyWith(color: AppColor.color4551, fontSize: 17),
                hintText: 'Enter the title of your report',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColor.color77DC,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Description",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormField(
              cursorColor: AppColor.color8EE9,
              controller: descriptionController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
                labelStyle: AppStyle()
                    .workSansMedium(context)
                    .copyWith(color: AppColor.color4551, fontSize: 17),
                hintText: 'Enter the description of your report',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColor.color77DC,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                ),
              ),
              maxLines: 4,
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Attachment",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            Obx(
              () => InkWell(
                onTap: () {
                  selectAttachmentPic();
                },
                child: Container(
                  height: height * 0.1,
                  width: height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: selectAttachment.value.isEmpty
                        ? Container(
                            height: height * 0.055,
                            width: width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.borderColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Select attachment",
                                style: AppStyle()
                                    .workSansMedium(context)
                                    .copyWith(
                                        color: AppColor.color4551,
                                        fontSize: 17),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Image(
                                image: FileImage(File(selectAttachment.value)),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () => selectAttachment.value = "",
                                  child: Container(
                                    height: height * 0.035,
                                    width: height * 0.035,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border: Border.all(
                                          color: Colors.red, width: 1.0),
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            ButtonWidget(
              width: width,
              height: height * 0.062,
              onTap: () {
                applyReportFormApi();
              },
              btnColor: AppColor.color95ED,
              btnName: "Submit Report",
              btnTextColor: AppColor.white,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
