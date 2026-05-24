import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zob/home/view/quick_action/controller/task_management_screen_controller.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/widget/text_form_field_widget.dart';

class TaskManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Task Management"),
          titleTextStyle: AppStyle()
              .workSansSemiBold(context)
              .copyWith(fontSize: 20, color: AppColor.color4551),
          bottom: TabBar(
            labelStyle: AppStyle()
                .workSansMedium(context)
                .copyWith(fontSize: 16, color: AppColor.color4551),
            labelColor: AppColor.color8EE9,
            indicatorColor: AppColor.color8EE9,
            tabs: [
              Tab(text: 'Completed\n Task'),
              Tab(text: 'Current\n Task'),
              Tab(text: 'Upcoming\n Task'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Completed Task
            // TaskFormWidget(),
            ComingSoonLotti(),

            // Content for Current Task
            // TaskFormWidget(),
            ComingSoonLotti(),

            // Content for Upcoming Task
            // TaskFormWidget(),
            ComingSoonLotti(),
          ],
        ),
      ),
    );
  }
}

class ComingSoonLotti extends StatelessWidget {
  const ComingSoonLotti({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 150),
          Lottie.asset("assets/images/coming_soon.json", height: height * 0.2),
          const SizedBox(height: 20),
          Text(
            "Coming Soon..",
            textAlign: TextAlign.center,
            style: AppStyle()
                .workSansSemiBold(context)
                .copyWith(color: AppColor.color8EE9, fontSize: 30),
          ),
        ],
      ),
    );
  }
}

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  TextEditingController tasknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController equipmentController = TextEditingController();
  TextEditingController worklocationController = TextEditingController();
  TextEditingController supervisorController = TextEditingController();
  TextEditingController personalNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  final taskMngScreenController = Get.put(TaskManagementScreenController());

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
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
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Task Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: tasknameController,
              labelText: "",
              hintText: 'Task Name',
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
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: descriptionController,
              labelText: "",
              hintText: 'Description',
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Task Photos",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            InkWell(
              onTap: () {
                taskMngScreenController.selectDocument();
              },
              child: Container(
                height: height * 0.09,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.borderColor, width: 2),
                ),
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.borderColor, width: 1),
                    ),
                    child: taskMngScreenController.selectTaskPhoto.value != ""
                        ? Image.file(
                            File(taskMngScreenController.selectTaskPhoto.value),
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Select Photo",
                                style: AppStyle()
                                    .workSansSemiBold(context)
                                    .copyWith(
                                        color: AppColor.color4551,
                                        fontSize: 17),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Equipment OR Tools Required",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: equipmentController,
              labelText: "",
              hintText: 'Equipment OR Tools Required',
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Work Location",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: worklocationController,
              labelText: "",
              hintText: 'Work Location',
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Start Date",
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
              "Finish Date",
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
              "Supervisor Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: supervisorController,
              labelText: "",
              hintText: 'Supervisor Name',
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Personal Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: personalNameController,
              labelText: "",
              hintText: 'Personal Name',
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Personal Email",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: emailController,
              labelText: "",
              hintText: 'Personal Email',
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWidget(
                  width: width / 2.3,
                  height: height * 0.062,
                  onTap: () {},
                  btnColor: AppColor.color95ED,
                  btnName: "Accept",
                  btnTextColor: AppColor.white,
                  isLoading: false.obs,
                ),
                ButtonWidget(
                  width: width / 2.3,
                  height: height * 0.062,
                  onTap: () {},
                  btnColor: AppColor.color95ED,
                  btnName: "Reject",
                  btnTextColor: AppColor.white,
                  isLoading: false.obs,
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
