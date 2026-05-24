import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/controller/roster_screen_controller.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/common_snackbar.dart';

class RosterScreen extends StatefulWidget {
  RosterScreen({super.key});

  @override
  State<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends State<RosterScreen> {
  final rosterScreenController = Get.put(RosterScreenController());

  @override
  void initState() {
    rosterScreenController.isSelectRoster.value = false;
    rosterScreenController.isWeeklyShow.value = false;
    rosterScreenController.getRosterScreenShiftLocationList(
      callback: (status) {},
    );
    rosterScreenController.setAcceptRosterIdList.clear();
    rosterScreenController.setRejectRosterIdList.clear();
    getRosterStatus();
    rosterScreenController.checkLoginStatus();
    super.initState();
  }

  getRosterStatus() async {
    rosterScreenController.isAcceptRoster.value =
        await SharePref().getAcceptRoster();
    rosterScreenController.isRejectRoster.value =
        await SharePref().getRejectRoster();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    debugPrint("Screen height : $height, screen width : $width");

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(rosterScreenController.userName.value)),
          titleTextStyle: AppStyle()
              .workSansSemiBold(context)
              .copyWith(fontSize: 20, color: AppColor.color4551),
          // leading: Container(),
          centerTitle: false,
          leading: Container(
              child: IconButton(
            onPressed: () {
              Get.back(result: rosterScreenController.isAcceptRoster.value);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          )),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: AppColor.colorB5BA,
              height: 1.0,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    rosterScreenController.isWeeklyShow.value =
                        !rosterScreenController.isWeeklyShow.value;
                  },
                  icon: Icon(
                    rosterScreenController.isWeeklyShow.value
                        ? Icons.list_alt_rounded
                        : Icons.list,
                    color: AppColor.color8EE9,
                  )),
            )
          ],
        ),
        body: Obx(
          () => ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHelper().verticalSpace(size: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  height: height * 0.055,
                  width: width,
                  child: Row(
                    children: [
                      Text(
                        "Roster",
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(fontSize: 20, color: AppColor.color4551),
                      ),
                      const Spacer(),
                      Text(
                        !rosterScreenController.isWeeklyShow.value
                            ? "Daily"
                            : "Weekly",
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(fontSize: 20, color: AppColor.color4551),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    /* Container(
                      height: height * 0.055,
                      width: width * 0.51,
                      decoration: BoxDecoration(
                        color: AppColor.colorF7F8,
                        border:
                            Border.all(width: 1.5, color: AppColor.borderColor),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ), */
                    SizedBox(
                      height: height * 0.055,
                      width: width * 0.93,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 2, left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColor.borderColor, width: 1.0),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColor.borderColor, width: 1.0),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColor.borderColor, width: 1.0),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        value:
                            rosterScreenController.selectRosterTypeValue.value,
                        onChanged: (newValue) {
                          rosterScreenController.selectRosterTypeValue.value =
                              newValue.toString();
                          debugPrint(
                              "Check roster filete value : ${rosterScreenController.selectRosterTypeValue.value}");
                          if (!rosterScreenController.isWeeklyShow.value) {
                            rosterScreenController.getRosterDailyaData(
                              locationId: rosterScreenController
                                  .selectLocationId.value
                                  .toString(),
                            );
                          } else {
                            debugPrint(
                                "Check 1234 : ${rosterScreenController.selectLocationId.value.toString()}");
                            rosterScreenController.getWeeklyRosterData(
                              locationId: rosterScreenController
                                  .selectLocationId.value
                                  .toString(),
                            );
                          }

                          // rosterScreenController.isSelectRoster.value = false;
                        },
                        items: rosterScreenController.selectRosterTypeList
                            .map((items) {
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
                    ),
                    /* const Spacer(),
                    InkWell(
                      onTap: () {
                        rosterScreenController.isSelectRoster.value = true;
                      },
                      child: Container(
                        height: height * 0.055,
                        width: width * 0.38,
                        decoration: BoxDecoration(
                          color: AppColor.colorFBFF,
                          border:
                              Border.all(width: 1.5, color: AppColor.colorF0FF),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "Roster",
                            style: AppStyle.workSansMedium
                                .copyWith(color: AppColor.color95ED),
                          ),
                        ),
                      ),
                    ), */
                  ],
                ),
              ),
              //// Roster Body

              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Shift Location",
                          style: AppStyle().workSansSemiBold(context).copyWith(
                              fontSize: 18, color: AppColor.color4551),
                        ),
                        const Spacer(),
                        Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              height: height * 0.05,
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: rosterScreenController
                                      .rosterScreenShiftLocationLoader.value
                                  ? const CircularProgressIndicator(
                                      color: AppColor.color8EE9,
                                    )
                                  : DropdownButton<String>(
                                      value: rosterScreenController
                                          .selectedShifLocationValue.value,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                      underline: Container(),
                                      isExpanded: true,
                                      onChanged: (newValue) {
                                        rosterScreenController
                                            .selectedShifLocationValue
                                            .value = newValue.toString();
                                        debugPrint(
                                            "select value : ${rosterScreenController.selectedShifLocationValue.value}");

                                        var temp = rosterScreenController
                                            .locationListRosterScreenList
                                            .indexWhere((element) =>
                                                element.locationName ==
                                                newValue.toString());
                                        debugPrint(
                                            "check My location id : $temp");

                                        var locationID = rosterScreenController
                                                .locationListRosterScreenList[
                                                    temp]
                                                .id ??
                                            "0";

                                        debugPrint(
                                            "Location Id : ${locationID}");

                                        rosterScreenController
                                                .selectLocationId.value =
                                            int.parse(locationID.toString());

                                        if (!rosterScreenController
                                            .isWeeklyShow.value) {
                                          rosterScreenController
                                              .getRosterDailyaData(
                                            locationId: locationID.toString(),
                                          );
                                        } else {
                                          debugPrint(
                                              "Check 1234 : ${rosterScreenController.selectLocationId.value.toString()}");
                                          rosterScreenController
                                              .getWeeklyRosterData(
                                            locationId: locationID.toString(),
                                          );
                                        }

                                        SharePref()
                                            .setSelectRosterShiftLocationid(
                                                selectRosterShiftLocationid:
                                                    locationID.toString());
                                      },
                                      items: rosterScreenController
                                          .locationListRosterScreenList
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value.locationName,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(value.locationName ?? ""),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                            )

                            /* DropdownButton<LocationDataList>(
                                      value:
                                          rosterScreenController.selectedValue,
                                      underline: Container(),
                                      isExpanded: true,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 10),
                                      hint: Text(
                                        rosterScreenController
                                                .locationListRosterScreenList
                                                .first
                                                .name ??
                                            "",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onChanged: (LocationDataList? newValue) {
                                        setState(() {
                                          rosterScreenController.selectedValue =
                                              newValue!;
                                        });

                                        debugPrint(
                                            "Select data :${rosterScreenController.selectedValue?.id}");
                                        rosterScreenController.selectLocationId
                                            .value = rosterScreenController
                                                .selectedValue?.id ??
                                            0;
                                        String locationID =
                                            rosterScreenController
                                                    .selectedValue?.id
                                                    .toString() ??
                                                "";
                                        rosterScreenController
                                            .getRosterDailyaData(
                                          locationId: locationID,
                                        );
                                        rosterScreenController
                                            .getWeeklyRosterData(
                                                locationId: locationID);
                                        SharePref()
                                            .setSelectRosterShiftLocationid(
                                                selectRosterShiftLocationid:
                                                    locationID);
                                      },
                                      menuMaxHeight: 400,
                                      items: rosterScreenController
                                          .locationListRosterScreenList
                                          .map((LocationDataList value) {
                                        return DropdownMenuItem<
                                            LocationDataList>(
                                          value: value,
                                          child: Text(value.name ?? ""),
                                        );
                                      }).toList(),
                                    )), */
                            )
                      ],
                    ),
                    AppHelper().verticalSpace(size: 7),
                    /* Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Job Position - ",
                            style: AppStyle()
                                .workSansSemiBold(context)
                                .copyWith(
                                    fontSize: 18, color: AppColor.color4551),
                            children: [
                              TextSpan(
                                text: "---",
                                style: AppStyle()
                                    .workSansMedium(context)
                                    .copyWith(
                                        fontSize: 16,
                                        color: AppColor.color4551),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        !rosterScreenController.isWeeklyShow.value
                            ? Container()
                            : Row(
                                children: [
                                  Text(
                                    "Job Details",
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(
                                            fontSize: 18,
                                            color: AppColor.color4551),
                                  ),
                                  AppHelper().horizontalSpace(size: 5),
                                  SizedBox(
                                    height: height * 0.034,
                                    width: height * 0.034,
                                    child: const Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: AppColor.color4551,
                                    ),
                                  ),
                                  AppHelper().horizontalSpace(size: 10)
                                ],
                              ),
                      ],
                    ), */
                  ],
                ),
              ),
              // RosterDesignWidget(
              //   height: height,
              //   width: width,
              // ),

              //// Each day Show Roster Design.
              rosterScreenController.isLoadingRosterDailyData.value
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.only(top: height * 0.2),
                      child: const CircularProgressIndicator(
                        color: AppColor.color8EE9,
                      ),
                    ))
                  : !rosterScreenController.isWeeklyShow.value
                      ? rosterScreenController.rosterListData.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: height * 0.2),
                                child: Text(
                                  "No Roster Found",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          color: AppColor.color969D,
                                          fontSize: 18),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: height * 0.59,
                              child: DailyRosterData(
                                height: height,
                                width: width,
                                rosterScreenController: rosterScreenController,
                              ),
                            )
                      : SizedBox(
                          height: height * 0.59,
                          child: WeeklyShowRosterDataWidget(
                              height: height,
                              width: width,
                              rosterScreenController: rosterScreenController),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

class DailyRosterData extends StatefulWidget {
  const DailyRosterData(
      {super.key,
      required this.height,
      required this.width,
      required this.rosterScreenController});
  final double height;
  final double width;
  final RosterScreenController rosterScreenController;

  @override
  State<DailyRosterData> createState() => _DailyRosterDataState();
}

class _DailyRosterDataState extends State<DailyRosterData> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.rosterScreenController.rosterListData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            // onTap: () {
            // var date = widget
            //         .rosterScreenController.rosterListData[index].rotasDate ??
            //     "";

            // Get.to(RosterDetaisScreen(
            //   date: date,
            //   day: "MON",
            //   rosterScreenController: widget.rosterScreenController,
            //   selectIndex: index,
            // ));
            // },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 0,
                  color: AppColor.colorABF5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: widget.height * 0.09,
                      width: widget.width * 0.297,
                      // height: 62.h,
                      // width: 107.w,
                      color: const Color.fromARGB(255, 213, 231, 251),
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(
                            "Date",
                            style: AppStyle()
                                .workSansSemiBold(context)
                                .copyWith(
                                    color: AppColor.color8EE9, fontSize: 15),
                          ),
                          Text(
                            widget.rosterScreenController.rosterListData[index]
                                    .rotasDate ??
                                "",
                            style: AppStyle().workSansMedium(context).copyWith(
                                color: const Color.fromARGB(255, 34, 34, 34),
                                fontSize: 15),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      height: widget.height * 0.09,
                      width: widget.width * 0.002,
                      color: AppColor.colorABF5,
                    ),
                    Container(
                      height: widget.height * 0.09,
                      width: widget.width * 0.297,
                      // height: 62.h,
                      // width: 107.w,
                      color: const Color.fromARGB(255, 213, 231, 251),
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(
                            "Day",
                            style: AppStyle()
                                .workSansSemiBold(context)
                                .copyWith(
                                    color: AppColor.color8EE9, fontSize: 15),
                          ),
                          Text(
                            DateFormat("EEE").format(DateTime.parse(
                              widget.rosterScreenController
                                      .rosterListData[index].rotasDate ??
                                  "",
                            )),
                            style: AppStyle()
                                .workSansMedium(context)
                                .copyWith(color: Colors.black, fontSize: 14),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      height: widget.height * 0.09,
                      width: widget.width * 0.002,
                      color: AppColor.colorABF5,
                    ),
                    Container(
                      height: widget.height * 0.09,
                      width: widget.width * 0.4,
                      // height: 62.h,
                      // width: 144.w,
                      color: const Color.fromARGB(255, 213, 231, 251),
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(
                            "Time",
                            style: AppStyle()
                                .workSansSemiBold(context)
                                .copyWith(
                                    color: AppColor.color8EE9,
                                    fontSize: 17,
                                    height: 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Start",
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 14,
                                            height: 1.3),
                                  ),
                                  Text(
                                    widget.rosterScreenController
                                            .rosterListData[index].startTime ??
                                        "",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                              Text(
                                "-",
                                style: AppStyle()
                                    .workSansSemiBold(context)
                                    .copyWith(
                                        color: Colors.black,
                                        fontSize: 16,
                                        height: 1),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "End",
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(
                                            color: Colors.black,
                                            fontSize: 14,
                                            height: 1.3),
                                  ),
                                  Text(
                                    widget.rosterScreenController
                                            .rosterListData[index].endTime ??
                                        "",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 0,
                  color: AppColor.colorABF5,
                ),
                Container(
                  color: const Color.fromARGB(255, 213, 231, 251),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: widget.height * 0.09,
                        width: widget.width * 0.5975,
                        // height: 62.h,
                        // width: 215.2.w,
                        color: const Color.fromARGB(255, 213, 231, 251),
                        child: Obx(
                          () => widget.rosterScreenController.isPastRoster.value
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 30),
                                  child: Container(
                                    height: widget.height * 0.06,
                                    width: widget.width * 0.3,
                                    decoration: BoxDecoration(
                                        color: widget
                                                    .rosterScreenController
                                                    .rosterListData[index]
                                                    .endTime ==
                                                "00:00"
                                            ? Colors.red.shade50
                                            : const Color.fromARGB(
                                                255, 214, 233, 215),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1,
                                            color: widget
                                                        .rosterScreenController
                                                        .rosterListData[index]
                                                        .endTime ==
                                                    "00:00"
                                                ? Colors.red
                                                : Colors.green)),
                                    child: Center(
                                      child: Text(
                                        widget
                                                    .rosterScreenController
                                                    .rosterListData[index]
                                                    .endTime ==
                                                "00:00"
                                            ? "Rejected"
                                            : "Completed",
                                        style: AppStyle()
                                            .workSansSemiBold(context)
                                            .copyWith(
                                                color: widget
                                                            .rosterScreenController
                                                            .rosterListData[
                                                                index]
                                                            .endTime ==
                                                        "00:00"
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontSize: 17,
                                                height: 1.1),
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (widget
                                            .rosterScreenController
                                            .rosterListData[index]
                                            .isRejectRoster
                                            .value) {
                                          CommonSnackBarWidget().snackBarWidget(
                                              context: context,
                                              message:
                                                  "Sorry! You can no longer accept because you have rejected the roster.",
                                              snackBarType: ContentType.failure,
                                              title: "Oh Snap!");
                                        }
                                        if (widget
                                                .rosterScreenController
                                                .rosterListData[index]
                                                .isAccepted ==
                                            1) {
                                          CommonSnackBarWidget().snackBarWidget(
                                              context: context,
                                              message: "Already Rejected",
                                              snackBarType: ContentType.failure,
                                              title: "Oh Snap!");
                                        } else {
                                          if (widget
                                                  .rosterScreenController
                                                  .rosterListData[index]
                                                  .isAccepted ==
                                              1) {
                                            CommonSnackBarWidget()
                                                .snackBarWidget(
                                                    context: context,
                                                    message: "Already Accepted",
                                                    snackBarType:
                                                        ContentType.failure,
                                                    title: "Oh Snap!");
                                          } else {
                                            var selectIndex = index;
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    RosterAreYouSureDialog(
                                                      height: widget.height,
                                                      width: widget.width,
                                                      rosterScreenController: widget
                                                          .rosterScreenController,
                                                      rosterId: widget
                                                              .rosterScreenController
                                                              .rosterListData[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      selectIndex: selectIndex,
                                                    ));
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: widget.height * 0.05,
                                        width: widget.width * 0.22,
                                        // height: 35.h,
                                        // width: 82.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.color95ED,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Obx(
                                            () => Text(
                                              widget
                                                      .rosterScreenController
                                                      .rosterListData[index]
                                                      .isAcceptRoster
                                                      .obs
                                                      .value
                                                      .value
                                                  ? "Accepted"
                                                  : widget
                                                              .rosterScreenController
                                                              .rosterListData[
                                                                  index]
                                                              .isAccepted ==
                                                          1
                                                      ? "Accepted"
                                                      : "Accept",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                    color: AppColor.white,
                                                    fontSize: 15,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Obx(() => widget.rosterScreenController
                                            .isPastRoster.value
                                        ? Container()
                                        : InkWell(
                                            onTap: () {
                                              if (widget
                                                  .rosterScreenController
                                                  .rosterListData[index]
                                                  .isAcceptRoster
                                                  .value) {
                                                CommonSnackBarWidget()
                                                    .snackBarWidget(
                                                        context: context,
                                                        message:
                                                            "Sorry! You can no longer reject because you have accepted the roster.",
                                                        snackBarType:
                                                            ContentType.failure,
                                                        title: "Oh Snap!");
                                              } else {
                                                if (widget
                                                        .rosterScreenController
                                                        .rosterListData[index]
                                                        .isAccepted ==
                                                    1) {
                                                  CommonSnackBarWidget()
                                                      .snackBarWidget(
                                                          context: context,
                                                          message:
                                                              "Already Accepted",
                                                          snackBarType:
                                                              ContentType
                                                                  .failure,
                                                          title: "Oh Snap!");
                                                } else {
                                                  if (widget
                                                          .rosterScreenController
                                                          .rosterListData[index]
                                                          .isAccepted ==
                                                      1) {
                                                    CommonSnackBarWidget()
                                                        .snackBarWidget(
                                                            context: context,
                                                            message:
                                                                "Already Rejected",
                                                            snackBarType:
                                                                ContentType
                                                                    .failure,
                                                            title: "Oh Snap!");
                                                  } else {
                                                    DateTime rosterDate =
                                                        DateTime.parse(widget
                                                                .rosterScreenController
                                                                .rosterListData[
                                                                    index]
                                                                .rotasDate ??
                                                            "");
                                                    DateTime nowDate =
                                                        DateTime.now();
                                                    if (rosterDate
                                                        .isAfter(nowDate)) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            RejectRosterDialogWidget(
                                                          height: widget.height,
                                                          width: widget.width,
                                                          rosterScreenController:
                                                              widget
                                                                  .rosterScreenController,
                                                          rosterId: widget
                                                                  .rosterScreenController
                                                                  .rosterListData[
                                                                      index]
                                                                  .id ??
                                                              0,
                                                        ),
                                                      );
                                                    } else {
                                                      final snackBar = SnackBar(
                                                        elevation: 0,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          title: "Oh Snap!",
                                                          message:
                                                              "Roster date has passed",
                                                          contentType:
                                                              ContentType
                                                                  .failure,
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                          Get.context!)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackBar);
                                                    }
                                                  }
                                                }
                                              }
                                            },
                                            child: Container(
                                              height: widget.height * 0.05,
                                              width: widget.width * 0.22,
                                              // height: 35.h,
                                              // width: 82.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Obx(
                                                  () => Text(
                                                    widget
                                                            .rosterScreenController
                                                            .rosterListData[
                                                                index]
                                                            .isRejectRoster
                                                            .obs
                                                            .value
                                                            .value
                                                        ? "Rejected"
                                                        : widget
                                                                    .rosterScreenController
                                                                    .rosterListData[
                                                                        index]
                                                                    .isAccepted ==
                                                                1
                                                            ? "Rejected"
                                                            : "Reject",
                                                    style: AppStyle()
                                                        .workSansSemiBold(
                                                            context)
                                                        .copyWith(
                                                          color: AppColor.white,
                                                          fontSize: 15,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                  ],
                                ),
                        ),
                      ),
                      Container(
                        height: widget.height * 0.09,
                        width: widget.width * 0.002,
                        color: AppColor.colorABF5,
                      ),
                      const Spacer(),
                      Container(
                        // height: height * 0.09,
                        // width: width * 0.4,
                        height: widget.height * 0.052,
                        width: widget.height * 0.052,
                        color: const Color.fromARGB(255, 213, 231, 251),
                        child: InkWell(
                          onTap: () {
                            debugPrint("share");
                          },
                          child: Container(
                            height: widget.height * 0.052,
                            width: widget.height * 0.052,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 248, 254),
                                boxShadow: const [
                                  BoxShadow(
                                      color: AppColor.colorABF5,
                                      blurRadius: 2.0,
                                      spreadRadius: 0
                                      // offset:
                                      //     Offset(0.1, 0.1)
                                      )
                                ],
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.share_sharp,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  color: AppColor.colorABF5,
                ),
                AppHelper().verticalSpace(size: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "How was your shift",
                    style: AppStyle()
                        .workSansSemiBold(context)
                        .copyWith(fontSize: 19, color: AppColor.color4551),
                  ),
                ),
                AppHelper().verticalSpace(size: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: RatingBar.builder(
                    initialRating: double.parse(widget.rosterScreenController
                            .rosterListData[index].averageRating.toString()),
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return const Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                          );
                        case 1:
                          return const Icon(
                            Icons.sentiment_neutral,
                            color: Colors.orange,
                          );
                        case 2:
                          return const Icon(
                            Icons.sentiment_dissatisfied,
                            color: Colors.amber,
                          );
                        case 3:
                          return const Icon(
                            Icons.sentiment_satisfied,
                            color: Color.fromARGB(255, 204, 187, 35),
                          );
                        case 4:
                          return const Icon(
                            Icons.sentiment_very_satisfied,
                            color: Colors.green,
                          );
                      }
                      return Container();
                    },
                    onRatingUpdate: (rating) {
                      Future.delayed(Duration(seconds: 2), () {
                        String ratings = rating.toInt().toString();
                        String rosterID = widget
                            .rosterScreenController.rosterListData[index].id
                            .toString();
                        if (widget.rosterScreenController.rosterListData[index]
                            .isAcceptRoster.obs.value.value) {
                          debugPrint("Roster id : ${rosterID}");
                          widget.rosterScreenController.rosterRatingApicall(
                              rosterID: rosterID, rating: ratings);
                        } else {
                          if (widget.rosterScreenController
                                  .rosterListData[index].isAccepted ==
                              1) {
                            debugPrint("Roster id : ${rosterID}");
                            widget.rosterScreenController.rosterRatingApicall(
                                rosterID: rosterID, rating: ratings);
                          } else {
                            final snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: "Oh Snap!",
                                message:
                                    "Cannot give rating without accepting app roaster",
                                contentType: ContentType.failure,
                              ),
                            );
                            ScaffoldMessenger.of(Get.context!)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        }
                      });
                    },
                  ),
                )
                /* SizedBox(
                  height: widget.height * 0.065,
                  width: widget.width,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      itemCount:
                          widget.rosterScreenController.rosterShifRating.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          child: Image.asset(
                            widget
                                .rosterScreenController.rosterShifRating[index],
                            color: widget.rosterScreenController
                                .rosterShiftRatingArray[index],
                          ),
                        );
                      }),
                ),
              */
              ],
            ),
          ),
        );
      },
    );
  }
}

class WeeklyShowRosterDataWidget extends StatefulWidget {
  const WeeklyShowRosterDataWidget({
    super.key,
    required this.height,
    required this.width,
    required this.rosterScreenController,
  });

  final double height;
  final double width;
  final RosterScreenController rosterScreenController;

  @override
  State<WeeklyShowRosterDataWidget> createState() =>
      _WeeklyShowRosterDataWidgetState();
}

class _WeeklyShowRosterDataWidgetState
    extends State<WeeklyShowRosterDataWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.rosterScreenController.weeklyRosterListData.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                "No Roster Found",
                style: AppStyle()
                    .workSansSemiBold(context)
                    .copyWith(color: AppColor.color969D, fontSize: 18),
              ),
            ),
          )
        : Column(
            children: [
              Column(
                children: [
                  const Divider(
                      height: 1, thickness: 0.6, color: AppColor.color4551),
                  Container(
                    color: AppColor.colorE8E9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: widget.height * 0.05,
                            width: widget.width * 0.12,
                            // height: 30.h,
                            // width: 43.w,
                            color: AppColor.colorE8E9,
                            child: Center(
                                child: Text(
                              "DATE",
                              style: AppStyle()
                                  .workSansSemiBold(context)
                                  .copyWith(color: AppColor.color4551,fontSize: 14),
                            )),
                          ),
                          Container(
                              height: widget.height * 0.05,
                              width: widget.width * 0.002,
                              color: AppColor.color4551),
                          Container(
                            height: widget.height * 0.05,
                            width: widget.width * 0.09,
                            // height: 30.h,
                            // width: 32.w,
                            color: AppColor.colorE8E9,
                            child: Center(
                                child: Text(
                              "DAY",
                              style: AppStyle()
                                  .workSansSemiBold(context)
                                  .copyWith(color: AppColor.color4551, fontSize: 14),
                            )),
                          ),
                          Container(
                              height: widget.height * 0.05,
                              width: widget.width * 0.002,
                              color: AppColor.color4551),
                          Container(
                            height: widget.height * 0.05,
                            width: widget.width * 0.23,
                            // height: 30.h,
                            // width: 83.w,
                            color: AppColor.colorE8E9,
                            child: Row(
                              children: [
                                Text(
                                  "Start",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          color: AppColor.colorABF5,
                                          fontSize: 13),
                                ),
                                Text(
                                  "-",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          color: AppColor.color4551,
                                          fontSize: AppFontSize.fontSize14),
                                ),
                                Text(
                                  "Finish",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          color: AppColor.color77DC,
                                          fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              height: widget.height * 0.05,
                              width: widget.width * 0.002,
                              color: AppColor.color4551),
                          Container(
                            height: widget.height * 0.05,
                            width: widget.width * 0.325,
                            // height: 30.h,
                            // width: 117.w,
                            color: AppColor.colorE8E9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                (widget.rosterScreenController
                                            .selectRosterTypeValue.value ==
                                        "Past Roster")
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          for (var i = 0;
                                              i <
                                                  widget
                                                      .rosterScreenController
                                                      .weeklyRosterListData
                                                      .length;
                                              i++) {
                                            widget
                                                .rosterScreenController
                                                .weeklyRosterListData[i]
                                                .accept
                                                .value = 1;
                                          }

                                          // showDialog(
                                          //     context: context,
                                          //     builder: (context) =>
                                          //         RosterAreYouSureDialog(
                                          //           height: widget.height,
                                          //           width: widget.width,
                                          //           rosterScreenController: widget
                                          //               .rosterScreenController,
                                          //         ));
                                        },
                                        child: Container(
                                          height: widget.height * 0.042,
                                          width: widget.width * 0.15,
                                          // height: 29.h,
                                          // width: 54.w,
                                          decoration: BoxDecoration(
                                              color: AppColor.color95ED,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              "Accept All",
                                              textAlign: TextAlign.center,
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      color: AppColor.white,
                                                      fontSize: 13,
                                                      height: 1.1),
                                            ),
                                          ),
                                        ),
                                      ),
                                (widget.rosterScreenController
                                            .selectRosterTypeValue.value ==
                                        "Past Roster")
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          for (var i = 0;
                                              i <
                                                  widget
                                                      .rosterScreenController
                                                      .weeklyRosterListData
                                                      .length;
                                              i++) {
                                            widget
                                                .rosterScreenController
                                                .weeklyRosterListData[i]
                                                .accept
                                                .value = 2;
                                          }
                                          // showDialog(
                                          //   context: context,
                                          //   builder: (context) =>
                                          //       RejectRosterDialogWidget(
                                          //     height: widget.height,
                                          //     width: widget.width,
                                          //     rosterScreenController:
                                          //         widget.rosterScreenController,
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          height: widget.height * 0.042,
                                          width: widget.width * 0.15,
                                          // height: 29.h,
                                          // width: 54.w,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              "Reject All",
                                              textAlign: TextAlign.center,
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      color: AppColor.white,
                                                      fontSize: 13,
                                                      height: 1.1),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                              height: widget.height * 0.05,
                              width: widget.width * 0.002,
                              color: AppColor.color4551),
                          Container(
                            height: widget.height * 0.042,
                            width: widget.width * 0.13,
                            // height: 29.h,
                            // width: 47.w,
                            decoration: BoxDecoration(
                                color: Colors.green.shade900,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                "Share All",
                                textAlign: TextAlign.center,
                                style: AppStyle()
                                    .workSansSemiBold(context)
                                    .copyWith(
                                        color: AppColor.white,
                                        fontSize: 13,
                                        height: 1.1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                      height: 0, thickness: 0.5, color: AppColor.color4551)
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: widget
                        .rosterScreenController.weeklyRosterListData.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print("on Tap : $index");
                              /*  Get.to(
                                RosterDetaisScreen(
                                  date: widget
                                          .rosterScreenController
                                          .weeklyRosterListData[index]
                                          .rotasDate ??
                                      "",
                                  selectIndex: index,
                                  day: DateFormat("EEE").format(DateTime.parse(
                                      widget
                                              .rosterScreenController
                                              .weeklyRosterListData[index]
                                              .rotasDate ??
                                          "")),
                                  rosterScreenController:
                                      widget.rosterScreenController,
                                ),
                              ); */
                            },
                            child: Container(
                              color: AppColor.colorFBFF,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: widget.height * 0.07,
                                          width: widget.width * 0.12,
                                          // height: 30.h,
                                          // width: 43.w,
                                          color: AppColor.colorFBFF,
                                          child: Center(
                                              child: Text(
                                            DateFormat("dd/MM").format(
                                                DateTime.parse(widget
                                                        .rosterScreenController
                                                        .weeklyRosterListData[
                                                            index]
                                                        .rotasDate ??
                                                    "")),
                                            style: AppStyle()
                                                .workSansSemiBold(context)
                                                .copyWith(
                                                    color: AppColor.color4551,fontSize: 14),
                                          )),
                                        ),
                                        Container(
                                            height: widget.height * 0.07,
                                            width: widget.width * 0.002,
                                            color: AppColor.color4551),
                                        Container(
                                          height: widget.height * 0.07,
                                          width: widget.width * 0.09,
                                          // height: 30.h,
                                          // width: 32.w,
                                          color: AppColor.colorFBFF,
                                          child: Center(
                                              child: Text(
                                            DateFormat("EE").format(
                                                DateTime.parse(widget
                                                        .rosterScreenController
                                                        .weeklyRosterListData[
                                                            index]
                                                        .rotasDate ??
                                                    "")),
                                            style: AppStyle()
                                                .workSansSemiBold(context)
                                                .copyWith(
                                                    color: AppColor.color4551,fontSize: 14),
                                          )),
                                        ),
                                        Container(
                                            height: widget.height * 0.07,
                                            width: widget.width * 0.002,
                                            color: AppColor.color4551),
                                        Container(
                                          height: widget.height * 0.07,
                                          width: widget.width * 0.23,
                                          // height: 30.h,
                                          // width: 83.w,
                                          color: AppColor.colorFBFF,
                                          child: Row(
                                            children: [
                                              const Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    widget
                                                            .rosterScreenController
                                                            .weeklyRosterListData[
                                                                index]
                                                            .startTime ??
                                                        "",
                                                    style: AppStyle()
                                                        .workSansBold(context)
                                                        .copyWith(
                                                            color: AppColor
                                                                .colorABF5,
                                                            fontSize: 13),
                                                  ),
                                                  /* Text(
                                                    "AM",
                                                    style: AppStyle.workSansBold
                                                        .copyWith(
                                                            color: AppColor
                                                                .colorABF5,
                                                            fontSize: 13),
                                                  ), */
                                                ],
                                              ),
                                              const Spacer(),
                                              Text(
                                                "-",
                                                style: AppStyle()
                                                    .workSansMedium(context)
                                                    .copyWith(
                                                        color:
                                                            AppColor.color4551,
                                                        fontSize: 15),
                                              ),
                                              const Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    widget
                                                            .rosterScreenController
                                                            .weeklyRosterListData[
                                                                index]
                                                            .endTime ??
                                                        "",
                                                    style: AppStyle()
                                                        .workSansBold(context)
                                                        .copyWith(
                                                            color: AppColor
                                                                .color77DC,
                                                            fontSize: 13),
                                                  ),
                                                  /* Text(
                                                    "PM",
                                                    style: AppStyle.workSansBold
                                                        .copyWith(
                                                            color: AppColor
                                                                .color77DC,
                                                            fontSize: 13),
                                                  ), */
                                                ],
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: widget.height * 0.07,
                                            width: widget.width * 0.002,
                                            color: AppColor.color4551),
                                        Container(
                                          height: widget.height * 0.07,
                                          width: widget.width * 0.325,
                                          // height: 30.h,
                                          // width: 117.w,
                                          color: AppColor.colorFBFF,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Obx(
                                                () => Radio(
                                                    value: widget
                                                                .rosterScreenController
                                                                .weeklyRosterListData[
                                                                    index]
                                                                .isAccepted ==
                                                            1
                                                        ? 1
                                                        : widget
                                                            .rosterScreenController
                                                            .weeklyRosterListData[
                                                                index]
                                                            .accept
                                                            .value,
                                                    groupValue: 1,
                                                    activeColor:
                                                        AppColor.color77DC,
                                                    onChanged: (value) {
                                                      if (widget
                                                              .rosterScreenController
                                                              .selectRosterTypeValue
                                                              .value !=
                                                          "Past Roster") {
                                                        if (widget
                                                                .rosterScreenController
                                                                .weeklyRosterListData[
                                                                    index]
                                                                .isAccepted ==
                                                            1) {
                                                          CommonSnackBarWidget()
                                                              .snackBarWidget(
                                                                  context:
                                                                      context,
                                                                  message:
                                                                      "Sorry! You have already reject roster",
                                                                  snackBarType:
                                                                      ContentType
                                                                          .failure,
                                                                  title:
                                                                      "Oh Snap!");
                                                        }
                                                        debugPrint(
                                                            "Index : $value");

                                                        debugPrint(
                                                            "Check id : ${widget.rosterScreenController.weeklyRosterListData[index].id}");
                                                        widget
                                                            .rosterScreenController
                                                            .setAcceptRosterIdList
                                                            .add(widget
                                                                .rosterScreenController
                                                                .weeklyRosterListData[
                                                                    index]
                                                                .id
                                                                .toString());
                                                        debugPrint(
                                                            "Set data : ${widget.rosterScreenController.setAcceptRosterIdList}");

                                                        widget
                                                            .rosterScreenController
                                                            .weeklyRosterListData[
                                                                index]
                                                            .accept
                                                            .value = 1;
                                                      } else {
                                                        CommonSnackBarWidget()
                                                            .snackBarWidget(
                                                                context:
                                                                    context,
                                                                message:
                                                                    "Sorry! You can't accept the roster in past",
                                                                snackBarType:
                                                                    ContentType
                                                                        .failure,
                                                                title:
                                                                    "Oh Snap!");
                                                      }
                                                    }),
                                              ),
                                              Obx(
                                                () => Radio(
                                                    value: widget
                                                        .rosterScreenController
                                                        .weeklyRosterListData[
                                                            index]
                                                        .accept
                                                        .value,
                                                    groupValue: 2,
                                                    activeColor: Colors.red,
                                                    onChanged: (value) {
                                                      if (widget
                                                              .rosterScreenController
                                                              .selectRosterTypeValue
                                                              .value !=
                                                          "Past Roster") {
                                                        if (widget
                                                                .rosterScreenController
                                                                .weeklyRosterListData[
                                                                    index]
                                                                .isAccepted ==
                                                            1) {
                                                          CommonSnackBarWidget()
                                                              .snackBarWidget(
                                                                  context:
                                                                      context,
                                                                  message:
                                                                      "Sorry! You have already accept roster",
                                                                  snackBarType:
                                                                      ContentType
                                                                          .failure,
                                                                  title:
                                                                      "Oh Snap!");
                                                        } else {
                                                          debugPrint(
                                                              "Select my reject id : ${widget.rosterScreenController.weeklyRosterListData[index].id}");
                                                          widget
                                                              .rosterScreenController
                                                              .setRejectRosterIdList
                                                              .add(widget
                                                                  .rosterScreenController
                                                                  .weeklyRosterListData[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                          debugPrint(
                                                              "Set data reject : ${widget.rosterScreenController.setRejectRosterIdList}");
                                                          widget
                                                              .rosterScreenController
                                                              .weeklyRosterListData[
                                                                  index]
                                                              .accept
                                                              .value = 2;
                                                        }
                                                      } else {
                                                        CommonSnackBarWidget()
                                                            .snackBarWidget(
                                                                context:
                                                                    context,
                                                                message:
                                                                    "Sorry! You can't reject the roster in past",
                                                                snackBarType:
                                                                    ContentType
                                                                        .failure,
                                                                title:
                                                                    "Oh Snap!");
                                                      }
                                                    }),
                                              )
                                            ],
                                            /* children: [
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          RosterAreYouSureDialog(
                                                            height: height,
                                                            width: width,
                                                            rosterScreenController:
                                                                rosterScreenController,
                                                          ));
                                                },
                                                child: Container(
                                                  height: height * 0.05,
                                                  width: width * 0.15,
                                                  decoration: BoxDecoration(
                                                      color: AppColor.color95ED,
                                                      borderRadius:
                                                          BorderRadius.circular(7)),
                                                  child: Center(
                                                    child: Text(
                                                      "Accept",
                                                      style: AppStyle.workSansSemiBold
                                                          .copyWith(
                                                        color: AppColor.white,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        RejectRosterDialogWidget(
                                                      height: height,
                                                      width: width,
                                                      rosterScreenController:
                                                          rosterScreenController,
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: height * 0.05,
                                                  width: width * 0.15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(7)),
                                                  child: Center(
                                                    child: Text(
                                                      "Reject",
                                                      style: AppStyle.workSansSemiBold
                                                          .copyWith(
                                                        color: AppColor.white,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                           */
                                          ),
                                        ),

                                        /* Container(
                                          height: height * 0.07,
                                          width: width * 0.16,
                                          color: AppColor.colorFBFF,
                                          child: Center(
                                              child: Text(
                                            "Surat",
                                            style: AppStyle.workSansSemiBold
                                                .copyWith(
                                                    color: AppColor.color4551),
                                          )),
                                        ),
                                        Container(
                                            height: height * 0.07,
                                            width: width * 0.002,
                                            color: AppColor.color4551),
                                        Container(
                                          height: height * 0.07,
                                          width: width * 0.165,
                                          color: AppColor.colorFBFF,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1),
                                            child: Center(
                                              child: Text(
                                                "Casual",
                                                textAlign: TextAlign.center,
                                                style: AppStyle.workSansSemiBold
                                                    .copyWith(
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                            ),
                                          ),
                                        ),
                                         */
                                        Container(
                                            height: widget.height * 0.07,
                                            width: widget.width * 0.002,
                                            color: AppColor.color4551),
                                        Container(
                                          height: widget.height * 0.07,
                                          width: widget.width * 0.13,
                                          // height: 30.h,
                                          // width: 47.w,
                                          color: AppColor.colorFBFF,
                                          child: InkWell(
                                            onTap: () {
                                              debugPrint("share");
                                            },
                                            child: Center(
                                              child: Container(
                                                height: widget.height * 0.045,
                                                width: widget.height * 0.045,
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
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                      height: 0,
                                      thickness: 0.5,
                                      color: AppColor.color4551),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),

              // SizedBox(
              //   // height: widget.height * 0.6,
              //   width: widget.width,
              //   child:),
              Column(
                children: [
                  const Divider(
                      height: 1, thickness: 0.6, color: AppColor.color4551),
                  Container(
                    color: AppColor.colorE8E9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: widget.height * 0.05,
                            width: widget.width * 0.12,
                            color: AppColor.colorE8E9,
                          ),
                          SizedBox(
                            height: widget.height * 0.05,
                            width: widget.width *
                                0.002, /* color: AppColor.color4551 */
                          ),
                          Container(
                            height: widget.height * 0.05,
                            width: widget.width * 0.09,
                            color: AppColor.colorE8E9,
                          ),
                          SizedBox(
                            height: widget.height * 0.05,
                            width: widget.width *
                                0.002, /* color: AppColor.color4551 */
                          ),
                          Container(
                            height: widget.height * 0.05,
                            width: widget.width * 0.23,
                            color: AppColor.colorE8E9,
                          ),
                          SizedBox(
                            height: widget.height * 0.05,
                            width: widget.width *
                                0.002, /* color: AppColor.color4551 */
                          ),
                          Container(
                            height: widget.height * 0.05,
                            width: widget.width * 0.350,
                            color: AppColor.colorE8E9,
                            child: (widget.rosterScreenController
                                        .selectRosterTypeValue.value ==
                                    "Past Roster")
                                ? Container()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (widget.rosterScreenController
                                              .setAcceptRosterIdList.isEmpty) {
                                            CommonSnackBarWidget()
                                                .snackBarWidget(
                                                    context: context,
                                                    message:
                                                        "Please seleact roster",
                                                    snackBarType:
                                                        ContentType.failure,
                                                    title: "Oh Snap!");
                                          } else {
                                            if (widget.rosterScreenController
                                                .isRejectRoster.value) {
                                              CommonSnackBarWidget().snackBarWidget(
                                                  context: context,
                                                  message:
                                                      "Sorry! You can no longer accept because you have rejected the roster.",
                                                  snackBarType:
                                                      ContentType.failure,
                                                  title: "Oh Snap!");
                                            } else {
                                              if (widget.rosterScreenController
                                                  .isAcceptRoster.value) {
                                                CommonSnackBarWidget()
                                                    .snackBarWidget(
                                                        context: context,
                                                        message:
                                                            "Already Accepted",
                                                        snackBarType:
                                                            ContentType.failure,
                                                        title: "Oh Snap!");
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        RosterAreYouSureDialog(
                                                          height: widget.height,
                                                          width: widget.width,
                                                          rosterId: 0,
                                                          rosterScreenController:
                                                              widget
                                                                  .rosterScreenController,
                                                        ));
                                              }
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: widget.height * 0.042,
                                          width: widget.width * 0.17,
                                          // height: 29.h,
                                          // width: 60.w,
                                          decoration: BoxDecoration(
                                              color: AppColor.color95ED,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Obx(
                                              () => Text(
                                                widget.rosterScreenController
                                                        .isAcceptRoster.value
                                                    ? "Accepted"
                                                    : "Accept",
                                                textAlign: TextAlign.center,
                                                style: AppStyle()
                                                    .workSansSemiBold(context)
                                                    .copyWith(
                                                        color: AppColor.white,
                                                        fontSize: 13,
                                                        height: 1.1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (widget.rosterScreenController
                                              .setRejectRosterIdList.isEmpty) {
                                            CommonSnackBarWidget()
                                                .snackBarWidget(
                                                    context: context,
                                                    message:
                                                        "Please seleact roster",
                                                    snackBarType:
                                                        ContentType.failure,
                                                    title: "Oh Snap!");
                                          } else {
                                            if (widget.rosterScreenController
                                                .isAcceptRoster.value) {
                                              CommonSnackBarWidget().snackBarWidget(
                                                  context: context,
                                                  message:
                                                      "Sorry! You can no longer reject because you have accepted the roster.",
                                                  snackBarType:
                                                      ContentType.failure,
                                                  title: "Oh Snap!");
                                            } else {
                                              if (widget.rosterScreenController
                                                  .isRejectRoster.value) {
                                                if (widget
                                                    .rosterScreenController
                                                    .isAcceptRoster
                                                    .value) {
                                                  CommonSnackBarWidget()
                                                      .snackBarWidget(
                                                          context: context,
                                                          message:
                                                              "Already Rejected",
                                                          snackBarType:
                                                              ContentType
                                                                  .failure,
                                                          title: "Oh Snap!");
                                                }
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      RejectRosterDialogWidget(
                                                    height: widget.height,
                                                    width: widget.width,
                                                    rosterScreenController: widget
                                                        .rosterScreenController,
                                                    rosterId: 0,
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: widget.height * 0.042,
                                          width: widget.width * 0.16,
                                          // height: 29.h,
                                          // width: 60.w,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Obx(
                                              () => Text(
                                                widget.rosterScreenController
                                                        .isRejectRoster.value
                                                    ? "Rejected"
                                                    : "Reject",
                                                textAlign: TextAlign.center,
                                                style: AppStyle()
                                                    .workSansSemiBold(context)
                                                    .copyWith(
                                                        color: AppColor.white,
                                                        fontSize: 13,
                                                        height: 1.1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          /* Container(
                                    height: height * 0.05,
                                    width: width * 0.16,
                                    color: AppColor.colorE8E9,
                                    child: Center(
                                        child: Text(
                                      "Location",
                                      style: AppStyle.workSansSemiBold
                                          .copyWith(
                                              color: AppColor.color4551),
                                    )),
                                  ),
                                  Container(
                                      height: height * 0.05,
                                      width: width * 0.002,
                                      color: AppColor.color4551),
                                  Container(
                                    height: height * 0.05,
                                    width: width * 0.165,
                                    color: AppColor.colorE8E9,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Text(
                                        "Job Type",
                                        textAlign: TextAlign.center,
                                        style: AppStyle.workSansSemiBold
                                            .copyWith(
                                                color:
                                                    AppColor.color4551),
                                      ),
                                    ),
                                  ), */
                          SizedBox(
                            height: widget.height * 0.05,
                            width: widget.width *
                                0.002, /* color: AppColor.color4551 */
                          ),
                          SizedBox(
                            height: widget.height * 0.042,
                            width: widget.width * 0.13,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                      height: 0, thickness: 0.5, color: AppColor.color4551)
                ],
              )
            ],
          );
  }
}

class RejectRosterDialogWidget extends StatelessWidget {
  const RejectRosterDialogWidget({
    super.key,
    required this.height,
    required this.width,
    required this.rosterScreenController,
    required this.rosterId,
  });

  final double height;
  final double width;
  final RosterScreenController rosterScreenController;
  final int rosterId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      actions: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHelper().verticalSpace(size: 15),
                Center(
                  child: Text(
                    "Are you sure you want to reject",
                    textAlign: TextAlign.center,
                    style: AppStyle()
                        .workSansSemiBold(context)
                        .copyWith(color: AppColor.color77DC, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: height * 0.26,
                  width: width,
                  child: ListView.builder(
                      itemCount: rosterScreenController.rejectRosterList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: <Widget>[
                            Obx(
                              () => Checkbox(
                                  activeColor: AppColor.color77DC,
                                  value: rosterScreenController
                                              .selectRejectRosterValue.value ==
                                          rosterScreenController
                                              .rejectRosterList[index]
                                      ? true
                                      : false,
                                  onChanged: (bool? changeValue) {
                                    rosterScreenController
                                            .selectRejectRosterValue.value =
                                        rosterScreenController
                                            .rejectRosterList[index];
                                    debugPrint(
                                        "Select Reject Message : ${rosterScreenController.selectRejectRosterValue.value}");
                                  }),
                            ),
                            Text(
                              rosterScreenController.rejectRosterList[index],
                              style: AppStyle()
                                  .workSansSemiBold(context)
                                  .copyWith(
                                      color: AppColor.color4551, fontSize: 18),
                            ),
                          ],
                        );
                      }),
                ),
                rosterScreenController.selectRejectRosterValue.value != "Other"
                    ? Container()
                    : Container(
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 230, 239, 250),
                          border:
                              Border.all(color: AppColor.color77DC, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 15),
                          child: TextFormField(
                            style: AppStyle()
                                .workSansMedium(context)
                                .copyWith(color: Colors.black),
                            controller: rosterScreenController
                                .selectRejectReasonTextController,
                            cursorColor: AppColor.color77DC,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Other Reason",
                              hintStyle: AppStyle()
                                  .workSansMedium(context)
                                  .copyWith(color: AppColor.color4551),
                            ),
                          ),
                        ),
                      ),
                AppHelper().verticalSpace(size: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.35,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 230, 239, 250),
                          border:
                              Border.all(color: AppColor.color77DC, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: AppStyle()
                                .workSansSemiBold(context)
                                .copyWith(
                                    color: AppColor.color77DC, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if ((rosterScreenController
                                    .selectRejectRosterValue.value ==
                                "Other") &&
                            (rosterScreenController
                                    .selectRejectReasonTextController.text !=
                                "")) {
                          rosterScreenController.selectRejectRosterValue.value =
                              rosterScreenController
                                  .selectRejectReasonTextController.text;
                          debugPrint(
                              "Hello :${rosterScreenController.selectRejectRosterValue.value}");
                        }

                        if ((rosterScreenController
                                    .selectRejectRosterValue.value !=
                                "") &&
                            (rosterScreenController
                                    .selectRejectRosterValue.value !=
                                "Other")) {
                          rosterScreenController.acceptNrejectApi(
                              acceptRejectStatus: 2,
                              rostersId: rosterId,
                              rejectMessage: rosterScreenController
                                  .selectRejectRosterValue.value,
                              callback: (status) {
                                rosterScreenController.isRejectRoster.value =
                                    true;
                                SharePref()
                                    .setRejectRoster(setRejectRoster: true);
                                rosterScreenController.isAcceptRoster.value =
                                    false;
                                SharePref()
                                    .setAcceptRoster(setAcceptRoster: false);
                              });
                        } else {
                          final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: "Oh Snap!",
                              message: "Please select reason",
                              contentType: ContentType.failure,
                            ),
                          );
                          ScaffoldMessenger.of(Get.context!)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      },
                      child: Obx(
                        () => Container(
                          height: height * 0.06,
                          width: width * 0.35,
                          decoration: BoxDecoration(
                            color: AppColor.color77DC,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: rosterScreenController
                                    .isSelectAcceptRejectStatus.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Ok",
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(
                                            color: AppColor.white,
                                            fontSize: 20),
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                AppHelper().verticalSpace(size: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//// Are You Sure Dialog
class RosterAreYouSureDialog extends StatefulWidget {
  RosterAreYouSureDialog({
    super.key,
    required this.height,
    required this.width,
    required this.rosterId,
    required this.rosterScreenController,
    this.selectIndex,
  });
  final double height;
  final double width;
  final int rosterId;
  int? selectIndex;
  final RosterScreenController rosterScreenController;

  @override
  State<RosterAreYouSureDialog> createState() => _RosterAreYouSureDialogState();
}

class _RosterAreYouSureDialogState extends State<RosterAreYouSureDialog> {
  @override
  void initState() {
    widget.rosterScreenController.isSelectAcceptRejectStatus.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actionsPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHelper().verticalSpace(size: 15),
              Center(
                child: Text(
                  "Are you sure you want to accept",
                  textAlign: TextAlign.center,
                  style: AppStyle()
                      .workSansSemiBold(context)
                      .copyWith(color: AppColor.color77DC, fontSize: 19),
                ),
              ),
              AppHelper().verticalSpace(size: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: widget.height * 0.06,
                      width: widget.width * 0.35,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 230, 239, 250),
                        border: Border.all(color: AppColor.color77DC, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: AppStyle().workSansSemiBold(context).copyWith(
                              color: AppColor.color77DC, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.rosterScreenController.acceptNrejectApi(
                          acceptRejectStatus: 1,
                          rostersId: widget.rosterId,
                          rejectMessage: "",
                          selectIndex: widget.selectIndex,
                          callback: (status) {
                            if (status == true) {
                              SharePref().setAcceptnRejectShiftStatus(
                                  shiftAcceptnRejectStatus: true);
                              widget.rosterScreenController.isAcceptRoster
                                  .value = true;
                              SharePref()
                                  .setAcceptRoster(setAcceptRoster: true);
                              widget.rosterScreenController.isRejectRoster
                                  .value = false;
                              SharePref()
                                  .setRejectRoster(setRejectRoster: false);
                            }
                          });
                    },
                    child: Obx(
                      () => Container(
                        height: widget.height * 0.06,
                        width: widget.width * 0.35,
                        decoration: BoxDecoration(
                          color: AppColor.color77DC,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: widget.rosterScreenController
                                  .isSelectAcceptRejectStatus.obs.value.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Ok",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          color: AppColor.white, fontSize: 20),
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              AppHelper().verticalSpace(size: 10),
            ],
          ),
        ),
      ],
    );
  }
}
