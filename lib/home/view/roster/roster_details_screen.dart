import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/roster_screen_controller.dart';
import 'package:zob/home/view/roster/break_details_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_style.dart';

class RosterDetaisScreen extends StatelessWidget {
  final String day;
  final String date;
  final RosterScreenController rosterScreenController;
  final int selectIndex;
  const RosterDetaisScreen({
    super.key,
    required this.day,
    required this.date,
    required this.rosterScreenController,
    required this.selectIndex,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roster Details"),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Card(
              color: AppColor.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: SvgPicture.asset(
                        AppImg.account,
                        height: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Team Member",
                          style: AppStyle().workSansMedium(context).copyWith(
                              color: AppColor.color4551, fontSize: 17),
                        ),
                        Text(
                          "${rosterScreenController.rosterListData[selectIndex].getrotauser?.firstName} ${rosterScreenController.rosterListData[selectIndex].getrotauser?.lastName}",
                          style: AppStyle().workSansRegular(context).copyWith(
                              color: AppColor.color878E,
                              fontSize: 16,
                              height: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: AppColor.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: SvgPicture.asset(
                        AppImg.location,
                        height: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          style: AppStyle().workSansMedium(context).copyWith(
                              color: AppColor.color4551, fontSize: 17),
                        ),
                        Text(
                          "--",
                          style: AppStyle().workSansRegular(context).copyWith(
                              color: AppColor.color878E,
                              fontSize: 15,
                              height: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: AppColor.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: SvgPicture.asset(
                        AppImg.calenderIcon,
                        height: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: AppStyle().workSansMedium(context).copyWith(
                              color: AppColor.color4551, fontSize: 17),
                        ),
                        Text(
                          "$day $date",
                          style: AppStyle().workSansRegular(context).copyWith(
                                color: AppColor.color878E,
                                fontSize: 16,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: 1,
                            width: width * 0.75,
                            color: AppColor.color969D,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.75,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Start",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            color: AppColor.color4551,
                                            fontSize: 17),
                                  ),
                                  Text(
                                    rosterScreenController
                                            .rosterListData[selectIndex]
                                            .startTime ??
                                        "",
                                    style: AppStyle()
                                        .workSansRegular(context)
                                        .copyWith(
                                          color: AppColor.color878E,
                                          fontSize: 16,
                                        ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: height * 0.06,
                                width: width * 0.003,
                                color: AppColor.color969D,
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Finish",
                                    style: AppStyle()
                                        .workSansMedium(context)
                                        .copyWith(
                                            color: AppColor.color4551,
                                            fontSize: 17),
                                  ),
                                  Text(
                                    rosterScreenController
                                            .rosterListData[selectIndex]
                                            .endTime ??
                                        "",
                                    style: AppStyle()
                                        .workSansRegular(context)
                                        .copyWith(
                                          color: AppColor.color878E,
                                          fontSize: 16,
                                        ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: 1,
                            width: width * 0.75,
                            color: AppColor.color969D,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(BreakDetaislScreen());
                          },
                          child: SizedBox(
                            width: width * 0.75,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Breaks Taken",
                                      style: AppStyle()
                                          .workSansMedium(context)
                                          .copyWith(
                                              color: AppColor.color4551,
                                              fontSize: 16),
                                    ),
                                    Text(
                                      "${rosterScreenController.rosterListData[selectIndex].breakTime} Min",
                                      style: AppStyle()
                                          .workSansRegular(context)
                                          .copyWith(
                                            color: AppColor.color878E,
                                            fontSize: 16,
                                          ),
                                    ),
                                    // Text(
                                    //   "0 Meal Break(Tot. 0 Min.)",
                                    //   style: AppStyle.workSansRegular.copyWith(
                                    //     color: AppColor.color878E,
                                    //     fontSize: 16,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.chevron_right_outlined,
                                  size: 35,
                                  color: AppColor.color878E,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: AppColor.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(
                          Icons.message,
                          color: AppColor.color878E,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notes",
                          style: AppStyle().workSansMedium(context).copyWith(
                              color: AppColor.color4551, fontSize: 17),
                        ),
                        Text(
                          rosterScreenController
                                  .rosterListData[selectIndex].note ??
                              "",
                          style: AppStyle().workSansRegular(context).copyWith(
                              color: AppColor.color878E,
                              fontSize: 15,
                              height: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: AppColor.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(
                          Icons.message,
                          color: AppColor.color878E,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Comments",
                          style: AppStyle().workSansMedium(context).copyWith(
                              color: AppColor.color4551, fontSize: 17),
                        ),
                        Text(
                          "Comments",
                          style: AppStyle().workSansRegular(context).copyWith(
                              color: AppColor.color878E,
                              fontSize: 15,
                              height: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
