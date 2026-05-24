import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:zob/home/controller/dashboard_screen_controller.dart';
import 'package:zob/home/controller/roster_screen_controller.dart';
import 'package:zob/home/view/account/account_screen.dart';
import 'package:zob/home/view/grow_with_backup/grow_with_backup.dart';
import 'package:zob/home/view/job_detail_screen.dart';
import 'package:zob/home/view/notification/notification_screen.dart';
import 'package:zob/home/view/payroll/library_screen.dart';
import 'package:zob/home/view/payroll/payroll_screen.dart';
import 'package:zob/home/view/quick_action/quick_action_screen.dart';
import 'package:zob/home/view/roster/roster_screen.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/share_widget.dart.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardController = Get.put(DashboardScreenController());
  final rosterController = Get.put(RosterScreenController());
  @override
  void initState() {
    dashboardController.getCurrentLocation();
    dashboardController.getUserClockInOutStatus();
    dashboardController.getCurrentLocationPermission();

    dashboardController.getUserId();
    dashboardController.checkLoginStatus();

    // dashboardController.dayWeekListAdd();
    dashboardController.getCheckInStatus();
    getCheckInCheckOutStatus();

    super.initState();
  }

  getCheckInCheckOutStatus() async {
    // dashboardController.checkInOutStatus.value =
    //     await SharePref().getCheckInOutStatus();

    dashboardController.isAceptRoster.value =
        await SharePref().getAcceptRoster();
    debugPrint(
        "Accept Roster Status : ${dashboardController.isAceptRoster.value}");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    var data = Get.arguments;

    debugPrint("Argument : $data");
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, top: 50, right: 14),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  // "WelCome Zob Mate,",
                                  "WelCome ${dashboardController.userName.value},",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(fontSize: 21),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.6,
                                child: Text(
                                  "${dashboardController.areaName.value} ${dashboardController.cityName.value}, ${DateFormat('MMM d, h:mm a').format(DateTime.now())}",
                                  style: AppStyle()
                                      .workSansRegular(context)
                                      .copyWith(fontSize: 16
                                          // color: const Color(0x99FFFFFF),
                                          ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.to(const NotificationScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: SizedBox(
                                height: height * 0.04,
                                width: width * 0.08,
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppImg.bell,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AppHelper().horizontalSpace(size: 10),
                          InkWell(
                            onTap: () {
                              Get.to(const AccountScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: SizedBox(
                                height: height * 0.04,
                                width: width * 0.08,
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppImg.account,
                                    color: AppColor.white,
                                    height: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AppHelper().horizontalSpace(size: 10),
                          InkWell(
                            onTap: () {
                              Share.share('''
                                https://play.google.com/store/apps/details?id=com.backupp.zob
                              ''');
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: SizedBox(
                                height: height * 0.04,
                                width: width * 0.08,
                                child: const Center(
                                    child: Icon(
                                  Icons.share,
                                  color: AppColor.white,
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppHelper().verticalSpace(size: 12),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              dashboardController.getIsRosterAvailableStatus();
                              // if (dashboardController.isAceptRoster.value) {
                              //   Get.to(GoogleMapScreen());
                              // } else {
                              //   CommonSnackBarWidget().snackBarWidget(
                              //       context: Get.context!,
                              //       title: "Oh Snap!",
                              //       message: "Please accept shift first",
                              //       snackBarType: ContentType.failure);
                              // }
                            },
                            child: Container(
                              height: height * 0.14,
                              width: width * 0.44,
                              // height: 100.h,
                              // width: 160.w,
                              decoration: BoxDecoration(
                                  color: AppColor.colorABF5,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.color77DC, width: 1.5)),
                              child: /* dashboardController
                                        .isClockInLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColor.white,
                                        ),
                                      )
                                    :  */
                                  Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => dashboardController
                                            .isGetAcceptRosterStatus.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            dashboardController
                                                        .getUserClockInOutStatusValue
                                                        .obs
                                                        .value
                                                        .value ==
                                                    0
                                                ? "Check In"
                                                : "Check Out",
                                            style: AppStyle()
                                                .workSansSemiBold(context)
                                                .copyWith(fontSize: 26),
                                          ),
                                  ),
                                  /* AppHelper().verticalSpace(size: 10),
                                          SizedBox(
                                            width: width,
                                            child: Center(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Start :- ',
                                                  style: AppStyle
                                                      .workSansSemiBold
                                                      .copyWith(
                                                          color: AppColor.white,
                                                          fontSize: 18),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: dashboardController
                                                          .clockInTime.value,
                                                      style: AppStyle
                                                          .workSansRegular
                                                          .copyWith(
                                                              color: const Color(
                                                                  0x99FFFFFF),
                                                              fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          AppHelper().verticalSpace(size: 3),
                                          SizedBox(
                                            width: width,
                                            child: Center(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'End :- ',
                                                  style: AppStyle
                                                      .workSansSemiBold
                                                      .copyWith(
                                                          color: AppColor.white,
                                                          fontSize: 18),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: dashboardController
                                                          .clockOutTime.value,
                                                      style: AppStyle
                                                          .workSansRegular
                                                          .copyWith(
                                                              color: const Color(
                                                                  0x99FFFFFF),
                                                              fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        */
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.to(const LibraryScreen());
                            },
                            child: Container(
                              height: height * 0.14,
                              width: width * 0.44,
                              // height: 100.h,
                              // width: 160.w,
                              decoration: BoxDecoration(
                                  color: AppColor.colorABF5,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.color77DC, width: 1.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Library",
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(fontSize: 26),
                                  ),
                                  // AppHelper().verticalSpace(size: 10),
                                  // Obx(
                                  //   () => SizedBox(
                                  //     width: width * 0.3,
                                  //     child: Text(
                                  //       dashboardController.totalHours.value,
                                  //       textAlign: TextAlign.center,
                                  //       style: AppStyle.workSansMedium.copyWith(
                                  //           color: const Color(0x99FFFFFF),
                                  //           fontSize: 17),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppHelper().verticalSpace(size: 16),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              debugPrint("cjeck");
                              final data = await Get.to(() => RosterScreen());
                              dashboardController.isAceptRoster.value = data;
                              debugPrint(
                                  "Check Is Accept Roster or not : ${dashboardController.isAceptRoster.value}");
                              // if (!dashboardController.isClockIn.value) {
                              //   dashboardController.scanQR(scanType: "clockIn");
                              // } else {
                              //   dashboardController.scanQR(
                              //       scanType: "clockOut");
                              // }
                            },
                            child: Container(
                              height: height * 0.14,
                              width: width * 0.44,
                              // height: 100.h,
                              // width: 160.w,
                              decoration: BoxDecoration(
                                  color: AppColor.colorABF5,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.color77DC, width: 1.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Roster",
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(fontSize: 26),
                                  ),
                                  // AppHelper().verticalSpace(size: 10),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.to(const GrowWithBackupScreen());
                            },
                            child: Container(
                              height: height * 0.14,
                              width: width * 0.44,
                              // height: 100.h,
                              // width: 160.w,
                              decoration: BoxDecoration(
                                  color: AppColor.colorABF5,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.color77DC, width: 1.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Grow with backup",
                                    textAlign: TextAlign.center,
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(fontSize: 26),
                                  ),
                                  // AppHelper().verticalSpace(size: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppHelper().verticalSpace(size: 16),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // dashboardController.scanQR();
                              // Get.to(HistoryScreen());
                              Get.to(const PayRollScreen());
                            },
                            child: Container(
                                height: height * 0.14,
                                width: width * 0.44,
                                // height: 100.h,
                                // width: 160.w,
                                decoration: BoxDecoration(
                                    color: AppColor.colorABF5,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppColor.color77DC, width: 1.5)),
                                child: Center(
                                  child: Text("Reports",
                                      textAlign: TextAlign.center,
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(fontSize: 26)),
                                )),
                            /* Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Payroll\nReports",
                                      style: AppStyle.workSansSemiBold
                                          .copyWith(fontSize: 26)),
                                  /* AppHelper().verticalSpace(size: 10),
                                  Obx(
                                    () => SizedBox(
                                      width: width * 0.3,
                                      child: Text(
                                        dashboardController.totalHours.value,
                                        textAlign: TextAlign.center,
                                        style: AppStyle.workSansMedium.copyWith(
                                            color: const Color(0x99FFFFFF),
                                            fontSize: 17),
                                      ),
                                    ),
                                  ), */
                                ],
                              ),
                            ), */
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              Get.to(const QuickActionScreen());
                            },
                            child: Container(
                              height: height * 0.14,
                              width: width * 0.44,
                              // height: 100.h,
                              // width: 160.w,
                              decoration: BoxDecoration(
                                  color: AppColor.colorABF5,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.color77DC, width: 1.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      "Quick Action",
                                      textAlign: TextAlign.center,
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(fontSize: 26),
                                    ),
                                  ),
                                  // AppHelper().verticalSpace(size: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      /* AppHelper().verticalSpace(size: 16),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                                height: height * 0.14,
                                width: width * 0.44,
                                // height: 100.h,
                                // width: 160.w,
                                decoration: BoxDecoration(
                                    color: AppColor.colorABF5,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppColor.color77DC, width: 1.5)),
                                child: Center(
                                  child: Text("Help",
                                      textAlign: TextAlign.center,
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(fontSize: 26)),
                                )),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: height * 0.14,
                              width: width * 0.44,
                              // height: 100.h,
                              // width: 160.w,
                              decoration: BoxDecoration(
                                  color: AppColor.colorABF5,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppColor.color77DC, width: 1.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Reference",
                                    textAlign: TextAlign.center,
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(fontSize: 26),
                                  ),
                                  // AppHelper().verticalSpace(size: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ), */
                    ],
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.18,
                minChildSize: 0.18,
                maxChildSize: 0.85,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Container(
                            height: height * 0.01,
                            width: width * 0.16,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 211, 212, 213),
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 12, right: 12, top: 5, bottom: 2),
                        //   child: Row(
                        //     children: [
                        //       InkWell(
                        //         onTap: () {
                        //           dashboardController.isSelectJob.value = false;
                        //         },
                        //         child: Container(
                        //           height: height * 0.045,
                        //           width: width * 0.19,
                        //           // height: 31.h,
                        //           // width: 70.w,
                        //           decoration: BoxDecoration(
                        //             // color: AppColor.color77DC
                        //             color: Colors.red,
                        //             borderRadius: BorderRadius.circular(5),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               "Shift",
                        //               style: AppStyle()
                        //                   .workSansSemiBold(context)
                        //                   .copyWith(
                        //                       color: AppColor.white,
                        //                       fontSize: 18),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       AppHelper().horizontalSpace(size: 5),
                        //       InkWell(
                        //         onTap: () {
                        //           dashboardController.isSelectJob.value = true;
                        //         },
                        //         child: Container(
                        //           height: height * 0.045,
                        //           width: width * 0.19,
                        //           // height: 31.h,
                        //           // width: 70.w,
                        //           decoration: BoxDecoration(
                        //             // color: Colors.black,
                        //             color: AppColor.color77DC,
                        //             borderRadius: BorderRadius.circular(5),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               "Job",
                        //               style: AppStyle()
                        //                   .workSansSemiBold(context)
                        //                   .copyWith(fontSize: 18),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       const Spacer(),
                        //       Container(
                        //         height: height * 0.045,
                        //         width: width * 0.45,
                        //         // height: 31.h,
                        //         // width: 162.w,
                        //         decoration: BoxDecoration(
                        //           color:
                        //               const Color.fromARGB(255, 230, 239, 250),
                        //           border: Border.all(
                        //               color: AppColor.color77DC, width: 1),
                        //           borderRadius: BorderRadius.circular(5),
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             const Padding(
                        //               padding: EdgeInsets.only(left: 8),
                        //               child: Icon(
                        //                 Icons.search,
                        //                 size: 20,
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: TextFormField(
                        //                 style: AppStyle()
                        //                     .workSansMedium(context)
                        //                     .copyWith(color: Colors.black),
                        //                 // controller: loginController.passwordController,
                        //                 cursorColor: AppColor.color77DC,

                        //                 decoration: InputDecoration(
                        //                   contentPadding: EdgeInsets.only(
                        //                       left: width * 0.02,
                        //                       bottom: height * 0.015),
                        //                   border: InputBorder.none,
                        //                   hintText: "Search...",
                        //                   hintStyle: AppStyle()
                        //                       .workSansMedium(context)
                        //                       .copyWith(
                        //                           color: AppColor.color4551),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 8,),
                        const Center(
                                      child: Text(
                                        "Browse Jobs",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.underline,
                                            color: AppColor.color77DC),
                                      ),
                                    ),
                                    // const SizedBox(height: 10,),
                        Expanded(
                          child: dashboardController.jobListLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColor.color8EE9),
                                )
                              : dashboardController.jobList.isEmpty
                                  ? const Center(
                                      child: Text(
                                        "No Reord Found",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.color8EE9),
                                      ),
                                    )
                                  : ListView.builder(
                                      controller: scrollController,
                                      itemCount:
                                          dashboardController.jobList.length,
                                          padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        var data = dashboardController
                                            .jobList[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(JobDetailScreen(
                                                jobSlug: data.slug.toString(),
                                                jobID: data.id.toString(),
                                                isSavedScreen: true,
                                              ));
                                            },
                                            child: Container(
                                              width: width,
                                              // height: height * 0.26,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColor.colorB3FF
                                                        .withOpacity(0.3),
                                                    spreadRadius: 0.5,
                                                    blurRadius: 10,
                                                    offset:
                                                        const Offset(0.5, 0.5),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 15),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        data.logo != ''
                                                            ? Container(
                                                                height: height *
                                                                    0.065,
                                                                width: height *
                                                                    0.065,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: AppColor
                                                                          .color77DC
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          0.5,
                                                                      blurRadius:
                                                                          20,
                                                                      offset: const Offset(
                                                                          0.2,
                                                                          0.2),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        data.logo ??
                                                                            '',
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                imageProvider,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            colorFilter: const ColorFilter.mode(AppColor.colorB3FF, BlendMode.colorBurn)),
                                                                      ),
                                                                    ),
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            const CircularProgressIndicator(
                                                                      color: AppColor
                                                                          .color77DC,
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
                                                                height: height *
                                                                    0.065,
                                                                width: height *
                                                                    0.065,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: AppColor
                                                                          .color77DC
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          0.5,
                                                                      blurRadius:
                                                                          20,
                                                                      offset: const Offset(
                                                                          0.2,
                                                                          0.2),
                                                                    ),
                                                                  ],
                                                                  image:
                                                                      const DecorationImage(
                                                                    image: AssetImage(
                                                                        AppImg
                                                                            .aaplogo),
                                                                  ),
                                                                ),
                                                              ),
                                                        const SizedBox(
                                                            width: 20),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width * 0.68,
                                                              child: Text(
                                                                data.jobTitle ??
                                                                    '',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.68,
                                                              child: Text(
                                                                data.priceFrom ==
                                                                        ''
                                                                    ? (data.payTypeRequired ??
                                                                        '')
                                                                    : "\$${data.priceFrom ?? ''} - \$${data.priceTo ?? ''}/ ${data.payTypeRequired ?? ''}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: AppColor
                                                                        .color77DC,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.68,
                                                              child: Text(
                                                                "Created At : ${DateFormat("dd, MMM yy HH:mma").format(data.createdAt ?? DateTime.now())}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColor
                                                                        .color77DC),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "No of Vacancy: ${data.noOfWorkers == '' ? '0' : data.noOfWorkers}",
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColor
                                                                  .color77DC),
                                                        ),
                                                        const Spacer(),
                                                        const Text(
                                                          "Browse Job",
                                                          style: TextStyle(
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      0,
                                                                      52,
                                                                      108)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                          /* ListView.builder(
                            controller: scrollController,
                            itemCount: 10,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: Card(
                                  color: AppColor.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 10,
                                        top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "Report to supervisor",
                                            style: AppStyle()
                                                .workSansSemiBold(context)
                                                .copyWith(
                                                    fontSize: 15,
                                                    color: AppColor.color4551),
                                          ),
                                        ),
                                        AppHelper().verticalSpace(size: 5),
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.asset(AppImg.temp),
                                            ),
                                            AppHelper()
                                                .horizontalSpace(size: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: width * 0.73,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "DHL Express",
                                                        style: AppStyle()
                                                            .workSansSemiBold(
                                                                context)
                                                            .copyWith(
                                                                fontSize: 15,
                                                                color: AppColor
                                                                    .color4551),
                                                      ),
                                                      AppHelper()
                                                          .horizontalSpace(
                                                              size: 4),
                                                      SvgPicture.asset(
                                                          AppImg.verify),
                                                      // const Spacer(),
                                                      // Text(
                                                      //   "Posted 15/05/2023",
                                                      //   style: AppStyle
                                                      //       .workSansSemiBold
                                                      //       .copyWith(
                                                      //     fontSize: 14,
                                                      //     color: AppColor
                                                      //         .color969D,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.73,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Melbourne, Australia",
                                                        style: AppStyle()
                                                            .workSansMedium(
                                                                context)
                                                            .copyWith(
                                                              fontSize: 13.5,
                                                              color: AppColor
                                                                  .color969D,
                                                            ),
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.location_on,
                                                            size: 15,
                                                            color: AppColor
                                                                .color969D,
                                                          ),
                                                          Text(
                                                            "Mds Cleaning",
                                                            style: AppStyle()
                                                                .workSansSemiBold(
                                                                    context)
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                  color: AppColor
                                                                      .color969D,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const Divider(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: width * 0.55,
                                              child: Text(
                                                "Commercial and Domestic Cleaning",
                                                style: AppStyle()
                                                    .workSansMedium(context)
                                                    .copyWith(
                                                        fontSize: 15,
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: 'Pay Rate ',
                                                    style: AppStyle()
                                                        .workSansSemiBold(
                                                            context)
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: AppColor
                                                                .color4551),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '\$${20.75}',
                                                          style: AppStyle()
                                                              .workSansMedium(
                                                                  context)
                                                              .copyWith(
                                                                  color: AppColor
                                                                      .color6E77)),
                                                    ],
                                                  ),
                                                ),
                                                AppHelper()
                                                    .verticalSpace(size: 2),
                                                Text(
                                                  "Staff Req. 45",
                                                  style: AppStyle()
                                                      .workSansSemiBold(context)
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: AppColor
                                                              .color4551),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        AppHelper().verticalSpace(size: 5),
                                        Row(
                                          children: [
                                            Text(
                                              "Posted 15/05/2023",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                    fontSize: 16,
                                                    color: AppColor.color969D,
                                                  ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 15,
                                                    color: AppColor.color969D,
                                                  ),
                                                  Text(
                                                    "Mds Cleaning",
                                                    style: AppStyle()
                                                        .workSansSemiBold(
                                                            context)
                                                        .copyWith(
                                                          fontSize: 16,
                                                          color: AppColor
                                                              .color969D,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        AppHelper().verticalSpace(size: 10),
                                        // const Divider(
                                        //   height: 20,
                                        // ),
                                        SizedBox(
                                          height: height * 0.080,
                                          // width: width * 0.67,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: dashboardController
                                                .dateList.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      dashboardController
                                                          .dateList[index].date,
                                                      style: AppStyle()
                                                          .workSansSemiBold(
                                                              context)
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color: AppColor
                                                                  .color4551),
                                                    ),
                                                    AppHelper()
                                                        .verticalSpace(size: 5),
                                                    Obx(
                                                      () => InkWell(
                                                        onTap: () {
                                                          dashboardController
                                                                  .dateList[index]
                                                                  .isSelect
                                                                  .value =
                                                              !dashboardController
                                                                  .dateList[
                                                                      index]
                                                                  .isSelect
                                                                  .value;
                                                          debugPrint(
                                                              "index : ${dashboardController.dateList[index].isSelect}");
                                                        },
                                                        child: Container(
                                                          height:
                                                              height * 0.050,
                                                          width: height * 0.050,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: (dashboardController
                                                                            .dateList[
                                                                                index]
                                                                            .weekNm ==
                                                                        "Sa" ||
                                                                    dashboardController
                                                                            .dateList[
                                                                                index]
                                                                            .weekNm ==
                                                                        "Su")
                                                                ? Colors.red
                                                                : dashboardController
                                                                        .dateList[
                                                                            index]
                                                                        .isSelect
                                                                        .value
                                                                    ? AppColor
                                                                        .color8EE9
                                                                    : AppColor
                                                                        .color969D,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              dashboardController
                                                                  .dateList[
                                                                      index]
                                                                  .weekNm,
                                                              style: AppStyle()
                                                                  .workSansSemiBold(
                                                                      context)
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      color: AppColor
                                                                          .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        AppHelper().verticalSpace(size: 8),
                                        Text(
                                          "Start Time 12:00 Finish Time 06:00",
                                          style: AppStyle()
                                              .workSansSemiBold(context)
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: AppColor.color4551),
                                        ),
                                        const Divider(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: height * 0.055,
                                              width: width * 0.25,
                                              decoration: BoxDecoration(
                                                color: AppColor.white,
                                                border: Border.all(
                                                  color: AppColor.colorABF5,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 2),
                                                  child: Text(
                                                    "View",
                                                    textAlign: TextAlign.center,
                                                    style: AppStyle()
                                                        .workSansMedium(context)
                                                        .copyWith(
                                                            fontSize: 14,
                                                            height: 1.2,
                                                            color: AppColor
                                                                .colorABF5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // const Spacer(),
                                            InkWell(
                                              onTap: () {
                                                ShareWidget().share(
                                                    shareText:
                                                        "http://zobmate.com.au/login");
                                              },
                                              child: Container(
                                                height: height * 0.052,
                                                width: height * 0.052,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 245, 248, 254),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: AppColor
                                                              .colorABF5,
                                                          blurRadius: 2.0,
                                                          spreadRadius: 0
                                                          // offset:
                                                          //     Offset(0.1, 0.1)
                                                          )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: const Icon(
                                                  Icons.share_sharp,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            // const Spacer(),

                                            Obx(
                                              () => Container(
                                                height: height * 0.055,
                                                width: width * 0.25,
                                                decoration: BoxDecoration(
                                                  color: AppColor.colorABF5,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2),
                                                    child: Text(
                                                      dashboardController
                                                              .isSelectJob.value
                                                          ? "Apply job"
                                                          : "Accept",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppStyle()
                                                          .workSansMedium(
                                                              context)
                                                          .copyWith(
                                                              fontSize: 14,
                                                              height: 1.2,
                                                              color: AppColor
                                                                  .white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // const Spacer(),

                                            Container(
                                              height: height * 0.062,
                                              width: width * 0.16,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Check \nIn",
                                                  textAlign: TextAlign.center,
                                                  style: AppStyle()
                                                      .workSansMedium(context)
                                                      .copyWith(
                                                          fontSize: 15,
                                                          height: 1,
                                                          color:
                                                              AppColor.white),
                                                ),
                                              ),
                                            )
                                            // TextButton(
                                            //   onPressed: () {},
                                            //   child: Text(
                                            //     "Share",
                                            //     textAlign: TextAlign.center,
                                            //     style: AppStyle.workSansSemiBold
                                            //         .copyWith(
                                            //             fontSize: 18,
                                            //             color:
                                            //                 AppColor.color4551),
                                            //   ),
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                         */
                        ),
                      ],
                    ),
                  );
                },
              ),
              /*  Positioned(
                bottom: 0,
                child: Container(
                  height: height * 0.35,
                  width: width,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Container(
                    color: const Color(0x33F7F7F8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Recommended job",
                                style: AppStyle.workSansMedium.copyWith(
                                    fontSize: 18, color: AppColor.color878E),
                              ),
                              const Spacer(),
                              Text(
                                "See all",
                                style: AppStyle.workSansMedium.copyWith(
                                    fontSize: 18,
                                    color: const Color(0X99B3B5BA)),
                              ),
                            ],
                          ),
                          AppHelper().verticalSpace(size: 16),
                          
                          /*  Container(
                            height: height * 0.3,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              border: Border.all(
                                  width: 1, color: const Color(0xFFF1F1F2)),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(AppImg.temp),
                                      ),
                                      AppHelper().horizontalSpace(size: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "DHL Express",
                                                style: AppStyle.workSansSemiBold
                                                    .copyWith(
                                                        fontSize: 15,
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                              AppHelper()
                                                  .horizontalSpace(size: 4),
                                              SvgPicture.asset(AppImg.verify),
                                            ],
                                          ),
                                          Text(
                                            "Melbourne, Australia",
                                            style: AppStyle.workSansMedium
                                                .copyWith(
                                              fontSize: 14,
                                              color: AppColor.color969D,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    height: 20,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'supervised by ',
                                      style: AppStyle.workSansMedium
                                          .copyWith(color: AppColor.colorB5BA),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Corey Bator',
                                            style: AppStyle.workSansMedium
                                                .copyWith(
                                                    color: AppColor.color6E77)),
                                      ],
                                    ),
                                  ),
                                  AppHelper().verticalSpace(size: 12),
                                  Text(
                                    "Warehouse Assistant",
                                    style: AppStyle.workSansMedium.copyWith(
                                        fontSize: 16,
                                        color: AppColor.color4551),
                                  ),
                                  AppHelper().verticalSpace(size: 4),
                                  Text(
                                    "Posted 12/12/2021",
                                    style: AppStyle.workSansMedium.copyWith(
                                        fontSize: 13,
                                        color: AppColor.color969D),
                                  ),
                                  AppHelper().verticalSpace(size: 4),
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppImg.location),
                                      AppHelper().horizontalSpace(size: 8),
                                      Text(
                                        "36 Edwardes St, Reservoir VIC 3073",
                                        style: AppStyle.workSansMedium.copyWith(
                                            fontSize: 13,
                                            color: AppColor.color969D),
                                      ),
                                    ],
                                  ),
                                  AppHelper().verticalSpace(size: 4),
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppImg.location),
                                      AppHelper().horizontalSpace(size: 8),
                                      Text(
                                        "8502 Preston Rd. Inglewood, Maine 98380",
                                        style: AppStyle.workSansMedium.copyWith(
                                            fontSize: 13,
                                            color: AppColor.color969D),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                         */
                        ],
                      ),
                    ),
                  ),
                ),
              )
             */
            ],
          ),
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context, Function scanTap, Function mapTap) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            mapTap();
            Get.back();
          },
          child: Text(
            'Map',
            style: AppStyle()
                .workSansSemiBold(context)
                .copyWith(fontSize: 20, color: AppColor.color4551),
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            scanTap();
            Get.back();
          },
          child: Text(
            'Scan',
            style: AppStyle()
                .workSansSemiBold(context)
                .copyWith(fontSize: 20, color: AppColor.color4551),
          ),
        ),
      ],
    ),
  );
}
