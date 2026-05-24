import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/clockIn/break_in_out_screen.dart';
import 'package:zob/home/controller/dashboard_screen_controller.dart';
import 'package:zob/home/controller/map_screen_controller.dart';
import 'package:zob/home/view/map_screen.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class ClockInOutScreen extends StatefulWidget {
  ClockInOutScreen({super.key});

  @override
  State<ClockInOutScreen> createState() => _ClockInOutScreenState();
}

class _ClockInOutScreenState extends State<ClockInOutScreen> {
  final dashboardController = Get.find<DashboardScreenController>();
  final mapScreenController = Get.find<MapScreenController>();
  var getCloclInTime = "".obs;

  @override
  void initState() {
    getClockInTime();
    super.initState();
  }

  getClockInTime() async {
    getCloclInTime.value = await SharePref().getClockInTime();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        leading: IconButton(
            onPressed: () {
              Get.back(result: true);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 25,
            )),
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
      body: Column(
        children: [
          Obx(
            () => Container(
              height: height * 0.06,
              width: width,
              color: const Color.fromARGB(255, 145, 196, 251),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.red,
                    ),
                    Text(
                      dashboardController.address.value,
                      style: AppStyle()
                          .workSansMedium(context)
                          .copyWith(color: AppColor.color4551, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppHelper().verticalSpace(size: 20),
          /* Obx(
            () => getCloclInTime.obs.value.value == ""
                ? Container()
                : RichText(
                    text: TextSpan(
                      text: "Check In: ",
                      style: AppStyle().workSansMedium(context).copyWith(
                          fontSize: 29,
                          color: AppColor.color4551,
                          fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                          text: DateFormat('MMM d, h:mm a').format(
                              DateTime.parse(getCloclInTime.obs.value.value)),
                          style: AppStyle().workSansMedium(context).copyWith(
                              fontSize: 23, color: AppColor.color4551),
                        ),
                      ],
                    ),
                  ),
          ), */

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: TextSpan(
                  text: "Date: ",
                  style: AppStyle().workSansMedium(context).copyWith(
                      fontSize: 23,
                      color: AppColor.color4551,
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(
                      text: DateFormat('d MMM, yyyy ').format(DateTime.now()),
                      style: AppStyle()
                          .workSansMedium(context)
                          .copyWith(fontSize: 22, color: AppColor.color4551),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppHelper().verticalSpace(size: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: TextSpan(
                  text: "Time: ",
                  style: AppStyle().workSansMedium(context).copyWith(
                      fontSize: 23,
                      color: AppColor.color4551,
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(
                      text: DateFormat('hh:mm a').format(DateTime.now()),
                      style: AppStyle()
                          .workSansMedium(context)
                          .copyWith(fontSize: 21, color: AppColor.color4551),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppHelper().verticalSpace(size: 40),
          Obx(
            () => dashboardController.getUserClockInOutStatusValue.value == 0
                ? Container()
                : InkWell(
                    onTap: () {},
                    child: Container(
                      height: height * 0.20,
                      width: height * 0.20,
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
                          Get.to(BreakInOutScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImg.touchImg,
                              height: 48,
                              color: Colors.white,
                            ),
                            AppHelper().verticalSpace(size: 10),
                            Text(
                              "${!dashboardController.breakStart.value ? "Start" : "Stop"} break",
                              style: AppStyle()
                                  .workSansMedium(context)
                                  .copyWith(fontSize: 19),
                            ),
                            AppHelper().verticalSpace(size: 10)
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          AppHelper().verticalSpace(size: 40),
          Obx(
            () => Container(
              height: height * 0.20,
              width: height * 0.20,
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
                onTap: () async {
                  bool checkStatus = await SharePref().getisClockinByQr();
                  // if (checkStatus == true) {
                  //   mapScreenController.isSelectMapTab.value = false;
                  //   Get.to(GoogleMapScreen());
                  // } else {
                  mapScreenController.getUserJobLocationData(
                      getUserClockInOutStatus: dashboardController
                          .getUserClockInOutStatusValue.value,
                      mapTapLocationLati:
                          dashboardController.latitude.value.toString(),
                      mapTapLocationLongi:
                          dashboardController.longitude.value.toString(),
                      location: dashboardController.address.obs.value.value,
                      callback: (status) {
                        if (status == true) {
                          dashboardController.getUserClockInOutStatus();
                        }
                      });
                  // }
                },
                child: mapScreenController.isLoading.value
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
                            "${dashboardController.getUserClockInOutStatusValue.value == 0 ? "Check In" : "Check Out"}",
                            style: AppStyle()
                                .workSansMedium(context)
                                .copyWith(fontSize: 20),
                          ),
                          AppHelper().verticalSpace(size: 10)
                        ],
                      ),
              ),
            ),
          ),
          AppHelper().verticalSpace(size: 60),
          /* Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColor.color77DC,
                      size: 30,
                    ),
                    AppHelper().verticalSpace(size: 5),
                    Obx(
                      () => Text(
                        dashboardController.clockInTime.value.isEmpty
                            ? "--:--"
                            : dashboardController.clockInTime.value,
                        style: AppStyle.workSansSemiBold
                            .copyWith(color: AppColor.color4551, fontSize: 18),
                      ),
                    ),
                    AppHelper().verticalSpace(size: 3),
                    Text(
                      "Check In",
                      style: AppStyle.workSansMedium
                          .copyWith(color: AppColor.color969D, fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColor.color77DC,
                      size: 30,
                    ),
                    AppHelper().verticalSpace(size: 5),
                    Text(
                      "--:--",
                      style: AppStyle.workSansSemiBold
                          .copyWith(color: AppColor.color4551, fontSize: 18),
                    ),
                    AppHelper().verticalSpace(size: 3),
                    Text(
                      "Check Out",
                      style: AppStyle.workSansMedium
                          .copyWith(color: AppColor.color969D, fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColor.color77DC,
                      size: 30,
                    ),
                    AppHelper().verticalSpace(size: 5),
                    Obx(
                      () => Text(
                        dashboardController.clockOutTime.value.isEmpty
                            ? "--:--"
                            : dashboardController.clockOutTime.value,
                        style: AppStyle.workSansSemiBold
                            .copyWith(color: AppColor.color4551, fontSize: 18),
                      ),
                    ),
                    AppHelper().verticalSpace(size: 3),
                    Text(
                      "Working Hr's",
                      style: AppStyle.workSansMedium
                          .copyWith(color: AppColor.color969D, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ) */
        ],
      ),
    );
  }
}
