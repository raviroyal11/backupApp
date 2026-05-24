import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/roster_screen_controller.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class BreakDetaislScreen extends StatelessWidget {
  BreakDetaislScreen({super.key});

  final rosterScreenController = Get.put(RosterScreenController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Breaks Summary"),
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
          actions: [
            IconButton(
              onPressed: () {
                rosterScreenController.selectDate(context);
              },
              icon: const Icon(
                Icons.calendar_month_outlined,
                size: 30,
                color: AppColor.color77DC,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.check_rounded,
                size: 30,
                color: AppColor.color77DC,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHelper().verticalSpace(size: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Select Break Time",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                      color: AppColor.color77DC, fontSize: 18, height: 1),
                ),
              ),
              AppHelper().verticalSpace(size: 20),
              Card(
                color: AppColor.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_box, color: AppColor.color77DC),
                      AppHelper().horizontalSpace(size: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              rosterScreenController.isSelectBreak.value == ""
                                  ? ""
                                  : "${rosterScreenController.isSelectBreak.value} Min",
                              style: AppStyle()
                                  .workSansMedium(context)
                                  .copyWith(
                                      color: AppColor.color77DC, fontSize: 16),
                            ),
                          ),
                          AppHelper().verticalSpace(size: 10),
                          SizedBox(
                            height: height * 0.05,
                            width: width * 0.8,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: rosterScreenController
                                    .selectBreakTimeList.length,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.only(right: 7),
                                      child: InkWell(
                                        onTap: () {
                                          debugPrint(
                                              "select : ${rosterScreenController.selectBreakTimeList[index]}");

                                          rosterScreenController
                                                  .isSelectBreak.value =
                                              rosterScreenController
                                                  .selectBreakTimeList[index];
                                        },
                                        child: Container(
                                          height: height * 0.050,
                                          width: rosterScreenController
                                                          .selectBreakTimeList[
                                                      index] ==
                                                  "Custom"
                                              ? width * 0.22
                                              : height * 0.050,
                                          decoration: BoxDecoration(
                                            color: rosterScreenController
                                                            .selectBreakTimeList[
                                                        index] ==
                                                    rosterScreenController
                                                        .isSelectBreak.value
                                                ? AppColor.color8EE9
                                                : const Color.fromARGB(
                                                    255, 201, 203, 204),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Center(
                                            child: Text(
                                              rosterScreenController
                                                  .selectBreakTimeList[index],
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      color: rosterScreenController
                                                                      .selectBreakTimeList[
                                                                  index] ==
                                                              rosterScreenController
                                                                  .isSelectBreak
                                                                  .value
                                                          ? AppColor.white
                                                          : AppColor.color4551,
                                                      fontSize: 16.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          AppHelper().verticalSpace(size: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 1,
                              width: width * 0.8,
                              color: AppColor.color969D,
                            ),
                          ),
                          Obx(
                            () => SizedBox(
                              width: width * 0.8,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      rosterScreenController.selectTime(
                                          context, "BreakStartTime");
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Break Start Time",
                                          style: AppStyle()
                                              .workSansSemiBold(context)
                                              .copyWith(
                                                color: AppColor.color77DC,
                                                fontSize: 16,
                                              ),
                                        ),
                                        Text(
                                          rosterScreenController
                                                      .breakStartTime.value ==
                                                  ""
                                              ? "-"
                                              : rosterScreenController
                                                  .breakStartTime.value,
                                          style: AppStyle()
                                              .workSansSemiBold(context)
                                              .copyWith(
                                                color: AppColor.color4551,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.003,
                                    color: AppColor.color969D,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      rosterScreenController.selectTime(
                                          context, "BreakEndTime");
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Break End Time",
                                          style: AppStyle()
                                              .workSansSemiBold(context)
                                              .copyWith(
                                                  color: AppColor.color77DC,
                                                  fontSize: 16),
                                        ),
                                        Text(
                                          rosterScreenController
                                                      .breakEndTime.value ==
                                                  ""
                                              ? "-"
                                              : rosterScreenController
                                                  .breakEndTime.value,
                                          style: AppStyle()
                                              .workSansSemiBold(context)
                                              .copyWith(
                                                color: AppColor.color4551,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 1,
                              width: width * 0.8,
                              color: AppColor.color969D,
                            ),
                          ),
                          Text(
                            "Break Type",
                            style:
                                AppStyle().workSansSemiBold(context).copyWith(
                                      color: AppColor.color77DC,
                                      fontSize: 16,
                                    ),
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                    activeColor: AppColor.color77DC,
                                    value: 1,
                                    groupValue: rosterScreenController
                                        .selectMealBrackRadio.value,
                                    onChanged: (value) {
                                      rosterScreenController
                                          .selectMealBrackRadio.value = 1;
                                    }),
                                Text(
                                  "Meal Break (Unpaid)",
                                  style: AppStyle()
                                      .workSansMedium(context)
                                      .copyWith(
                                        color: AppColor.color4551,
                                        fontSize: 16,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: width * 0.8,
                            color: AppColor.color969D,
                          ),
                          Obx(
                            () => Row(
                              children: [
                                Radio(
                                    activeColor: AppColor.color77DC,
                                    value: 2,
                                    groupValue: rosterScreenController
                                        .selectMealBrackRadio.value,
                                    onChanged: (value) {
                                      rosterScreenController
                                          .selectMealBrackRadio.value = 2;
                                    }),
                                Text(
                                  "Rest Break (Paid)",
                                  style: AppStyle()
                                      .workSansMedium(context)
                                      .copyWith(
                                        color: AppColor.color4551,
                                        fontSize: 16,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              /* AppHelper().verticalSpace(size: height * 0.14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                height: height * 0.065,
                width: width,
                decoration: BoxDecoration(
                  color: AppColor.colorB3FF,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ) */
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: AppColor.color77DC,
          foregroundColor: AppColor.white,
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}

class SelectBreakTime {
  final String time;
  RxBool isSelect;
  SelectBreakTime({required this.time, required this.isSelect});
}
