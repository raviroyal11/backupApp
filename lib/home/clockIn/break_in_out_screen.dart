import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/controller/dashboard_screen_controller.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class BreakInOutScreen extends StatefulWidget {
  BreakInOutScreen({super.key});

  @override
  State<BreakInOutScreen> createState() => _BreakInOutScreenState();
}

class _BreakInOutScreenState extends State<BreakInOutScreen> {
  final dashboardController = Get.find<DashboardScreenController>();

  @override
  void initState() {
    dashboardController.getBreackListData();
    dashboardController.checkLoginStatus();
    startTimer();
    super.initState();
  }

  String time = "";
  startTimer() {
    Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime timenow = DateTime.now(); //get current date and time
      time = timenow.hour.toString() +
          ":" +
          timenow.minute.toString() +
          ":" +
          timenow.second.toString();
      setState(() {});
      //mytimer.cancel() //to terminate this timer
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Break Time"),
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
      body: Center(
        child: Column(
          children: [
            AppHelper().verticalSpace(size: 20),
            // RichText(
            //   text: TextSpan(
            //     text: 'You have already taken ',
            //     style: AppStyle.workSansSemiBold
            //         .copyWith(color: AppColor.color4551, fontSize: 16),
            //     children: <TextSpan>[
            //       TextSpan(
            //         text: '00:00:35',
            //         style: AppStyle.workSansSemiBold
            //             .copyWith(color: Colors.red, fontSize: 16),
            //       ),
            //       TextSpan(
            //         text: ' break',
            //         style: AppStyle.workSansSemiBold
            //             .copyWith(color: AppColor.color4551, fontSize: 16),
            //       ),
            //     ],
            //   ),
            // ),
            // AppHelper().verticalSpace(size: 10),
            Text(
              time,
              style: AppStyle()
                  .workSansMedium(context)
                  .copyWith(fontSize: 35, color: AppColor.color4551),
            ),
            AppHelper().verticalSpace(size: 30),
            Container(
              height: height * 0.25,
              width: height * 0.25,
              // height: 138.h,
              // width: 138.h,
              decoration: const BoxDecoration(
                color: AppColor.colorABF5,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: AppColor.colorABF5,
                      blurRadius: 50.0,
                      spreadRadius: 1,
                      offset: Offset(0.0, 0.75))
                ],
              ),
              child: InkWell(
                onTap: () {
                  dashboardController.breakStart.value =
                      !dashboardController.breakStart.value;
                  if (dashboardController.breakStart.value) {
                    dashboardController.breackInApi();
                  } else {
                    dashboardController.breackOutApi();
                  }
                },
                child: Obx(
                  () => dashboardController.breackInOut.value
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImg.touchImg,
                              height: 48,
                              color: Colors.white,
                            ),
                            AppHelper().verticalSpace(size: 10),
                            Text(
                              !dashboardController.breakStart.value
                                  ? "Start"
                                  : "Stop",
                              style: AppStyle()
                                  .workSansMedium(context)
                                  .copyWith(fontSize: 25),
                            ),
                            AppHelper().verticalSpace(size: 10)
                          ],
                        ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: 35),
            Text(
              "Last Breaks",
              style: AppStyle()
                  .workSansSemiBold(context)
                  .copyWith(fontSize: 25, color: AppColor.color4551),
            ),
            AppHelper().verticalSpace(size: 15),
            Obx(
              () => dashboardController.breackListApiLoader.value
                  ? const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator(
                        backgroundColor: AppColor.color77DC,
                        color: AppColor.borderColor,
                      ),
                    )
                  : dashboardController.breackHistoryList.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: height * 0.1),
                          child: Text(
                            "No Data Found",
                            style: AppStyle()
                                .workSansSemiBold(context)
                                .copyWith(
                                    color: AppColor.color969D, fontSize: 20),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount:
                                  dashboardController.breackHistoryList.length,
                              itemBuilder: (context, index) {
                                var data = dashboardController
                                    .breackHistoryList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, bottom: 15),
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Text(
                                          "Break",
                                          style: AppStyle()
                                              .workSansBold(context)
                                              .copyWith(
                                                  fontSize: 17,
                                                  color: AppColor.color4551),
                                        ),
                                      ),
                                      AppHelper().horizontalSpace(size: 20),
                                      Container(
                                        height: height * 0.06,
                                        width: width * 0.01,
                                        decoration: BoxDecoration(
                                            color: AppColor.color77DC,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                      AppHelper().horizontalSpace(size: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat("dd MMM, yyyy").format(
                                                DateTime.parse(
                                                    data.createdAt ?? "")),
                                            style: AppStyle()
                                                .workSansBold(context)
                                                .copyWith(
                                                    fontSize: 17,
                                                    color: AppColor.color4551),
                                          ),
                                          Text(
                                            "${data.clockIn ?? ""} to ${data.clockOut ?? ""}",
                                            style: AppStyle()
                                                .workSansMedium(context)
                                                .copyWith(
                                                  fontSize: 19,
                                                  color: AppColor.color969D,
                                                ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
