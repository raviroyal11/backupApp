import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/models/my_assign_leave_api_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/widget/text_form_field_widget.dart';

class ApplyForLeaveScreen extends StatefulWidget {
  const ApplyForLeaveScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ApplyForLeaveScreenState createState() => _ApplyForLeaveScreenState();
}

class _ApplyForLeaveScreenState extends State<ApplyForLeaveScreen>
    with SingleTickerProviderStateMixin {
  // Controllers for text fields
  // TextEditingController employeeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  // TextEditingController recordHoursController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TabController? _tabController;

  // Variables for dropdowns
  RxString _selectedType = ''.obs;
  String _selectedTotal = 'Full Day';

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  RxBool isLoading = false.obs;
  RxList<MyAssignLeave> myAssignLeaveList = <MyAssignLeave>[].obs;
  RxBool isApplyingLeave = false.obs;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2026),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: startDate,
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  //// Apply Leave API Call
  void _applyLeave() async {
    isApplyingLeave.value = true;
    Map<String, dynamic> requestBody = {
      "leave_type": _selectedType.value,
      "from_date": DateFormat('yyyy-MM-dd').format(startDate),
      "to_date": DateFormat('yyyy-MM-dd').format(endDate),
      "total": _selectedTotal == "Full Day" ? "full_day" : "half_day",
      "reason": reasonController.text,
    };
    await Api.applyForLeaveApi(parameter: requestBody).then((response) {
      if (response != null) {
        if (response['success'] == true) {
          CommonSnackBarWidget().snackBarWidget(
            context: Get.context!,
            title: "Well done!",
            message: response['message'],
            snackBarType: ContentType.success,
          );
          Get.back(result: true);
        } else {
          CommonSnackBarWidget().snackBarWidget(
            context: Get.context!,
            title: 'Oh Snap!',
            message: response['message'],
            snackBarType: ContentType.failure,
          );
          Get.back(result: true);
        }
        isApplyingLeave.value = false;
      } else {
        // Handle the case where the response is null
        log("Apply Leave API returned null response");
        CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          title: 'Oh Snap!',
          message: response['message'],
          snackBarType: ContentType.failure,
        );
        isApplyingLeave.value = false;
      }
    }).catchError((error) {
      // Handle any errors that occur during the API call
      log("Error applying for leave: $error");
      CommonSnackBarWidget().snackBarWidget(
        context: Get.context!,
        title: 'Oh Snap!',
        message: "An error occurred while applying for leave. Please try again.",
        snackBarType: ContentType.failure,
      );
      isApplyingLeave.value = false;
    });
  }

  //// Get My assign leave
  Future<void> _getMyAssignLeave() async {
    isLoading.value = true;
    await Api.availableLeaveListApi().then((value) {
      if (value != null) {
        MyAssignLeaveListApiResponseModel responseModel =
            MyAssignLeaveListApiResponseModel.fromJson(value);
        if (responseModel.success == true) {
          log("My Assign Leave List : ${responseModel.data}");
          myAssignLeaveList.value = responseModel.data ?? [];
          if (myAssignLeaveList.isNotEmpty) {
            _selectedType.value = myAssignLeaveList.first.slug ?? '';
          }
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    }).catchError((error) {
      Get.snackbar("Error", "An error occurred: $error");
    });
  }

  @override
  void initState() {
    super.initState();
    _getMyAssignLeave();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply Leave"),
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
            // Text(
            //   "Employee",
            //   style: AppStyle().workSansMedium(context).copyWith(
            //         fontSize: 18,
            //         color: const Color(0xFF83878E),
            //       ),
            // ),
            // AppHelper().verticalSpace(size: 5),
            // TextFormFieldWidget(
            //   height: height,
            //   width: width,
            //   controller: employeeController,
            //   labelText: "",
            //   hintText: 'Employee',
            // ),
            // AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Type",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            Obx(
              () => isLoading.value
                  ? const Center(child: CircularProgressIndicator(
                    color: AppColor.color95ED,
                  ))
                  : DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 2, left: 10, right: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: _selectedType.value,
                      onChanged: (value) {
                        log("Selected Leave Type: $value");
                        setState(() {
                          // _selectedType = value!;
                        });
                      },
                      items: myAssignLeaveList.map((items) {
                        return DropdownMenuItem<String>(
                          value: items.slug ?? "",
                          child: Text(
                            items.leaveName ?? "",
                            style: AppStyle()
                                .workSansMedium(context)
                                .copyWith(color: AppColor.color4551),
                          ),
                        );
                      }).toList(),
                    ),
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "From Date",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            InkWell(
              onTap: () {
                _selectStartDate(context);
              },
              child: Container(
                height: height * 0.055,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(DateFormat('dd/MM/yyyy').format(startDate),
                        style: AppStyle()
                            .workSansMedium(context)
                            .copyWith(color: AppColor.color4551, fontSize: 17)),
                  ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "To Date",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            InkWell(
              onTap: () {
                _selectEndDate(context);
              },
              child: Container(
                height: height * 0.055,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(DateFormat('dd/MM/yyyy').format(endDate),
                        style: AppStyle()
                            .workSansMedium(context)
                            .copyWith(color: AppColor.color4551, fontSize: 17)),
                  ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Leave Duration",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 2, left: 10, right: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: _selectedTotal,
              onChanged: (value) {
                setState(() {
                  _selectedTotal = value!;
                });
              },
              items: ['Full Day', 'Half Day'].map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: AppStyle()
                        .workSansMedium(context)
                        .copyWith(color: AppColor.color4551),
                  ),
                );
              }).toList(),
            ),
            // _selectedTotal == "Daily"
            //     ? Container()
            //     : AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            // _selectedTotal == "Daily"
            //     ? Container()
            //     : Text(
            //         "Total Hours",
            //         style: AppStyle().workSansMedium(context).copyWith(
            //               fontSize: 18,
            //               color: const Color(0xFF83878E),
            //             ),
            //       ),
            // AppHelper().verticalSpace(size: 5),
            // _selectedTotal == "Daily"
            //     ? Container()
            //     : TextFormFieldWidget(
            //         height: height,
            //         width: width,
            //         keyboardType: TextInputType.number,
            //         controller: recordHoursController,
            //         labelText: "",
            //         hintText: 'Total',
            //       ),
            // AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Reason",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormField(
              cursorColor: AppColor.color8EE9,
              controller: reasonController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 10, left: 10, right: 5),
                hintText: 'I need to take leave because...',
                hintStyle: AppStyle()
                    .workSansMedium(context)
                    .copyWith(color: Colors.grey, fontSize: 17),
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
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                ),
              ),
              maxLines: 4,
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            ButtonWidget(
              width: width,
              height: height * 0.062,
              onTap: () {
                _applyLeave();
              },
              btnColor: AppColor.color95ED,
              btnName: "Apply",
              btnTextColor: AppColor.white,
              isLoading: isApplyingLeave,
            ),
          ],
        ),
      ),
    );
  }
}
