import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/view/payroll/timesheet/timesheet_screen_controller.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/global_helper.dart';

class TimesheetScreen extends StatefulWidget {
  const TimesheetScreen({super.key});

  @override
  State<TimesheetScreen> createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends State<TimesheetScreen> {
  var timesheetController = Get.put(TimeSheetsScreenController());
  @override
  void initState() {
    timesheetController.getTimeSheetData();
    timesheetController.checkLoginStatus();
    super.initState();
  }

  String getWeekNumber(DateTime date) {
    return '${date.year}-${date.weekday}';
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    List<Map<String, dynamic>> weekEntries = [];
    String dayaname = "";
    return Scaffold(
        appBar: AppBar(
          title: const Text("Timesheets"),
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
        body: Obx(() => timesheetController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: AppColor.color77DC,
                  ))
                : timesheetController.timesheetList.isEmpty
                    ? Center(
                        child: Text(
                          "No Record Found",
                          style: AppStyle().workSansSemiBold(context).copyWith(
                              color: AppColor.color969D, fontSize: 22),
                        ),
                      )
                    : ListView.builder(
                        itemCount: timesheetController.groupedByWeek.length,
                        itemBuilder: (context, weekIndex) {
                          int weekNumber = timesheetController
                              .groupedByWeek.keys
                              .elementAt(weekIndex);
                          weekEntries =
                              timesheetController.groupedByWeek[weekNumber]!;
                          dayaname =
                              timesheetController.getWeekInfo(weekNumber);
                          debugPrint("check my week name $dayaname ");
                          List<String> dateParts = dayaname.split(" - ");
                          String startDateString = dateParts[0];
                          String endDateString = dateParts[1];
                          debugPrint(
                              "check my week name 1 ${startDateString.runtimeType} ");
                          debugPrint("check my week name 2 ${DateTime.now()}");
                          var startDate = DateFormat('E d')
                              .format(DateTime.parse(startDateString));
                          var endDate = DateFormat('E d MMM')
                              .format(DateTime.parse(endDateString));

                          return
                              /* Column(
          children: [
            Text('$startDate - $endDate'),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, subIndex) {
                debugPrint("Check : ${weekEntries[weekIndex]}");
                var data = weekEntries.map(
                  (e) {
                    return e['date'];
                  },
                ).toList();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${DateFormat("E, dd MMM").format(DateTime.parse(data[subIndex]))}")
                      ]
                      // Add other details as needed...

                      ),
                );
              },
            )
          ],
        ); */
                              ExpansionTile(
                            initiallyExpanded: true,
                            maintainState: true,
                            title: Text('$startDate - $endDate'),
                            children: weekEntries.map((e) {
                              DateTime date = DateTime.parse(e['date']);
                              String clockIn = e['clock_in'];
                              String clockOut = e['clock_out'];
                              String totalRest = e['total_rest'];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 198, 224, 251),
                                            offset: Offset(0.2, 0.2),
                                            blurRadius: 1.5,
                                            spreadRadius: 0.5),
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: height * 0.056,
                                          width: height * 0.056,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.color77DC,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Z",
                                              style: AppStyle()
                                                  .workSansBold(context)
                                                  .copyWith(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        AppHelper().horizontalSpace(size: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${timesheetController.formatTimeAMPM(clockIn)} - ${timesheetController.formatTimeAMPM(clockOut)}",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 17,
                                                      color:
                                                          AppColor.color4551),
                                            ),
                                            AppHelper().verticalSpace(size: 2),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month_sharp,
                                                  size: 18,
                                                  color: AppColor.color969D,
                                                ),
                                                AppHelper()
                                                    .horizontalSpace(size: 2),
                                                SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.27,
                                                  child: Text(
                                                    DateFormat("E dd, MMM")
                                                        .format(date),
                                                    style: AppStyle()
                                                        .workSansMedium(context)
                                                        .copyWith(
                                                          fontSize: 15.5,
                                                          color: AppColor
                                                              .color969D,
                                                        ),
                                                  ),
                                                ),
                                                AppHelper()
                                                    .horizontalSpace(size: 15),
                                                Icon(
                                                  Icons.coffee,
                                                  size: 18,
                                                  color: AppColor.color969D,
                                                ),
                                                AppHelper()
                                                    .horizontalSpace(size: 2),
                                                Text(
                                                  totalRest,
                                                  style: AppStyle()
                                                      .workSansMedium(context)
                                                      .copyWith(
                                                        fontSize: 15.5,
                                                        color:
                                                            AppColor.color969D,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Spacer(),
                                        // Icon(
                                        //   Icons.check_rounded,
                                        //   size: 36,
                                        //   color: Colors.green,
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      )

            /* ListView.builder(
                      itemCount: timesheetController.timesheetList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10),
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 198, 224, 251),
                                    offset: Offset(0.2, 0.2),
                                    blurRadius: 1.5,
                                    spreadRadius: 0.5),
                              ],
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.056,
                                  width: height * 0.056,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.color77DC,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Z",
                                      style: AppStyle()
                                          .workSansBold(context)
                                          .copyWith(
                                              fontSize: 25,
                                              color: Colors.white),
                                    ),
                                  ),
                                ),
                                AppHelper().horizontalSpace(size: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${timesheetController.timesheetList[index].clockIn} - ${timesheetController.timesheetList[index].clockOut}",
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(
                                              fontSize: 17,
                                              color: AppColor.color4551),
                                    ),
                                    AppHelper().verticalSpace(size: 2),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_sharp,
                                          size: 18,
                                          color: AppColor.color969D,
                                        ),
                                        AppHelper().horizontalSpace(size: 2),
                                        Text(
                                          DateFormat("E dd, MMM").format(
                                              DateTime.parse(timesheetController
                                                      .timesheetList[index]
                                                      .date ??
                                                  "")),
                                          style: AppStyle()
                                              .workSansMedium(context)
                                              .copyWith(
                                                fontSize: 15.5,
                                                color: AppColor.color969D,
                                              ),
                                        ),
                                        AppHelper().horizontalSpace(size: 15),
                                        Icon(
                                          Icons.coffee,
                                          size: 18,
                                          color: AppColor.color969D,
                                        ),
                                        AppHelper().horizontalSpace(size: 2),
                                        Text(
                                          timesheetController
                                                  .timesheetList[index]
                                                  .totalRest ??
                                              "",
                                          style: AppStyle()
                                              .workSansMedium(context)
                                              .copyWith(
                                                fontSize: 15.5,
                                                color: AppColor.color969D,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Spacer(),
                                // Icon(
                                //   Icons.check_rounded,
                                //   size: 36,
                                //   color: Colors.green,
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
         */
            ));

    /*   ListView.builder(
            itemCount: timesheetController.weeklyGroups.length,
            itemBuilder: (context, index) => 
            Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                timesheetController.weeklyGroups[index].first['date'],
                                style: AppStyle()
                                    .workSansMedium(context)
                                    .copyWith(
                                        fontSize: 17,
                                        color: AppColor.color4551),
                              ),
                              const Spacer(),
                              Text(
                                "37h 30min.",
                                style: AppStyle()
                                    .workSansMedium(context)
                                    .copyWith(
                                        fontSize: 17,
                                        color: AppColor.color4551),
                              ),
                            ],
                          ),
                          AppHelper().verticalSpace(size: 10),
                          ListView.builder(
                            itemCount: 2,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 2),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              255, 198, 224, 251),
                                          offset: Offset(0.2, 0.2),
                                          blurRadius: 1.5,
                                          spreadRadius: 0.5),
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height * 0.056,
                                        width: height * 0.056,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.color77DC,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Z",
                                            style: AppStyle()
                                                .workSansBold(context)
                                                .copyWith(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      AppHelper().horizontalSpace(size: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "10:00 AM - 6:00 PM",
                                            style: AppStyle()
                                                .workSansSemiBold(context)
                                                .copyWith(
                                                    fontSize: 17,
                                                    color: AppColor.color4551),
                                          ),
                                          AppHelper().verticalSpace(size: 2),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month_sharp,
                                                size: 18,
                                                color: AppColor.color969D,
                                              ),
                                              AppHelper()
                                                  .horizontalSpace(size: 2),
                                              Text(
                                                "Mon, 27 Feb",
                                                style: AppStyle()
                                                    .workSansMedium(context)
                                                    .copyWith(
                                                      fontSize: 15.5,
                                                      color: AppColor.color969D,
                                                    ),
                                              ),
                                              AppHelper()
                                                  .horizontalSpace(size: 15),
                                              Icon(
                                                Icons.coffee,
                                                size: 18,
                                                color: AppColor.color969D,
                                              ),
                                              AppHelper()
                                                  .horizontalSpace(size: 2),
                                              Text(
                                                "30min",
                                                style: AppStyle()
                                                    .workSansMedium(context)
                                                    .copyWith(
                                                      fontSize: 15.5,
                                                      color: AppColor.color969D,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.check_rounded,
                                        size: 36,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )));
  */
  }
}
