import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/controller/history_controller.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final historyController = Get.put(HistoryScreenController());
  @override
  void initState() {
    historyController.getRosterHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: const Text("Paroll Reports"),
          titleTextStyle: AppStyle()
              .workSansSemiBold(context)
              .copyWith(fontSize: 20, color: AppColor.color4551),
        ),
        body: Obx(
          () => historyController.historyLoader.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColor.color77DC),
                )
              : historyController.rosterHistoryList.isEmpty
                  ? Center(
                      child: Text(
                        "No History Found",
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(color: AppColor.color969D, fontSize: 18),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppColor.borderColor,
                                  blurRadius: 15.0,
                                  offset: Offset(0.0, 0.0))
                            ],
                          ),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              /* Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Text(
                                  "05 Oct - 12 Oct 23",
                                  style: AppStyle.workSansSemiBold.copyWith(
                                      fontSize: 20, color: AppColor.color4551),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.ios_share,
                                  color: AppColor.color4551,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                          AppHelper().verticalSpace(size: 10), */
                              Divider(height: 0),
                              /* Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      height: height * 0.045,
                                      width: height * 0.045,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColor.colorABF5,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          AppImg.account,
                                          height: 28,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    ),
                                    AppHelper().horizontalSpace(size: 10),
                                    Obx(
                                      () => Text(
                                        historyController.userName.value,
                                        style: AppStyle.workSansSemiBold
                                            .copyWith(
                                                fontSize: 20,
                                                color: AppColor.color4551),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Get.to(LeaveHistoryScreen());
                                      },
                                      child: Container(
                                        height: height * 0.044,
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 240, 240, 240),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 4.0,
                                                spreadRadius: 2.0,
                                                color: AppColor.colorF0FF)
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Leave",
                                            style: AppStyle.workSansSemiBold
                                                .copyWith(
                                                    fontSize: 20,
                                                    color: AppColor.color4551),
                                          ),
                                        ),
                                      ),
                                    ),
                                    /* const Icon(
                                      Icons.calendar_month,
                                      size: 25,
                                      color: AppColor.color8EE9,
                                    ) */
                                  ],
                                ),
                              ),
                               */
                              AppHelper().verticalSpace(size: 10),

                              // Obx(
                              //   () => Text(
                              //     historyController.userName.value,
                              //     style: AppStyle.workSansMedium
                              //         .copyWith(color: AppColor.color4551, fontSize: 18),
                              //   ),
                              // ),
                              // Center(
                              //   child: Column(
                              //     children: [
                              //       Text(
                              //         "Nothing To See Here",
                              //         style: AppStyle.workSansMedium
                              //             .copyWith(color: AppColor.color8EE9, fontSize: 18),
                              //       ),
                              //       Text(
                              //         "No Recorded Activity",
                              //         style: AppStyle.workSansMedium
                              //             .copyWith(color: Colors.black, fontSize: 15),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        /* Padding(
                          padding: const EdgeInsets.only(left: 25, top: 10),
                          child: Text(
                            DateFormat("EEE, dd MMM yy").format(DateTime.parse(
                                historyController
                                        .rosterHistoryList.first.rotasDate ??
                                    "")),
                            style: AppStyle.workSansBold.copyWith(
                                fontSize: 21,
                                color: const Color.fromARGB(255, 36, 38, 43)),
                          ),
                        ),*/
                        AppHelper().verticalSpace(size: 10),
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  historyController.rosterHistoryList.length,
                              itemBuilder: (context, index) {
                                var historydata =
                                    historyController.rosterHistoryList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5),
                                  child: Card(
                                    color: AppColor.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                DateFormat("EEE, dd MMM yy")
                                                    .format(DateTime.parse(
                                                        historyController
                                                                .rosterHistoryList
                                                                .first
                                                                .rotasDate ??
                                                            "")),
                                                style: AppStyle()
                                                    .workSansMedium(context)
                                                    .copyWith(
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                              Text(
                                                historydata.startTime ?? "",
                                                style: AppStyle()
                                                    .workSansBold(context)
                                                    .copyWith(
                                                        fontSize: 19,
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                              Text(
                                                "Clock in",
                                                style: AppStyle()
                                                    .workSansMedium(context)
                                                    .copyWith(
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                "${historydata.breakTime ?? ""} min",
                                                style: AppStyle()
                                                    .workSansRegular(context)
                                                    .copyWith(
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                              Text(
                                                "Breaks",
                                                style: AppStyle()
                                                    .workSansRegular(context)
                                                    .copyWith(
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                DateFormat("EEE, dd MMM yy")
                                                    .format(DateTime.parse(
                                                        historyController
                                                                .rosterHistoryList
                                                                .first
                                                                .rotasDate ??
                                                            "")),
                                                style: AppStyle()
                                                    .workSansMedium(context)
                                                    .copyWith(
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                              Text(
                                                historydata.endTime ?? "",
                                                style: AppStyle()
                                                    .workSansBold(context)
                                                    .copyWith(
                                                        fontSize: 19,
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                              Text(
                                                "Clock out",
                                                style: AppStyle()
                                                    .workSansMedium(context)
                                                    .copyWith(
                                                        color:
                                                            AppColor.color4551),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
        ));
  }
}
