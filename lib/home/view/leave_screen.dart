import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/leave_screen_controller.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  final leaveScreenController = Get.put(LeaveHistoryScreenController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text("Leave"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
        titleTextStyle: AppStyle()
            .workSansSemiBold(context)
            .copyWith(fontSize: 20, color: AppColor.color4551),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: height * 0.14,
                  width: width * 0.44,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.color77DC,
                    ),
                    color: AppColor.colorF0FF,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Leave\nBalance",
                          style: AppStyle()
                              .workSansSemiBold(context)
                              .copyWith(fontSize: 19, color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "20",
                          style: AppStyle().workSansSemiBold(context).copyWith(
                                fontSize: 21,
                                color: AppColor.color77DC,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: height * 0.14,
                  width: width * 0.44,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 174, 222, 41),
                    ),
                    color: const Color.fromARGB(255, 251, 254, 241),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Leave\nApproved",
                          style: AppStyle()
                              .workSansSemiBold(context)
                              .copyWith(fontSize: 19, color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "10",
                          style: AppStyle().workSansSemiBold(context).copyWith(
                              fontSize: 21,
                              color: const Color.fromARGB(255, 118, 154, 19)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 15),
            Row(
              children: [
                Container(
                  height: height * 0.14,
                  width: width * 0.44,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 89, 81, 7),
                    ),
                    color: const Color.fromARGB(255, 255, 253, 235),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Leave\nPending",
                          style: AppStyle()
                              .workSansSemiBold(context)
                              .copyWith(fontSize: 19, color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "04",
                          style: AppStyle().workSansSemiBold(context).copyWith(
                                fontSize: 21,
                                color: const Color.fromARGB(255, 89, 81, 7),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: height * 0.14,
                  width: width * 0.44,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 222, 41, 41),
                    ),
                    color: const Color.fromARGB(255, 254, 241, 241),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Leave\nCancelled",
                          style: AppStyle()
                              .workSansSemiBold(context)
                              .copyWith(fontSize: 19, color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          "10",
                          style: AppStyle().workSansSemiBold(context).copyWith(
                              fontSize: 21,
                              color: const Color.fromARGB(255, 199, 27, 27)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.025,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.062,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 243, 243),
                    borderRadius: BorderRadius.circular(15)),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          leaveScreenController.isSelectUpcoming.value = true;
                        },
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.062,
                          width: MediaQuery.sizeOf(context).width / 2 - 41,
                          decoration: BoxDecoration(
                            color: leaveScreenController.isSelectUpcoming.value
                                ? AppColor.colorABF5
                                : const Color.fromARGB(255, 243, 243, 243),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Upcoming",
                              style: AppStyle()
                                  .workSansSemiBold(context)
                                  .copyWith(
                                      fontSize: 19,
                                      color: leaveScreenController
                                              .isSelectUpcoming.value
                                          ? Colors.white
                                          : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          leaveScreenController.isSelectUpcoming.value = false;
                        },
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.062,
                          width: MediaQuery.sizeOf(context).width / 2 - 41,
                          decoration: BoxDecoration(
                            color: !leaveScreenController.isSelectUpcoming.value
                                ? AppColor.colorABF5
                                : const Color.fromARGB(255, 243, 243, 243),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Past",
                              style: AppStyle()
                                  .workSansSemiBold(context)
                                  .copyWith(
                                      fontSize: 19,
                                      color: !leaveScreenController
                                              .isSelectUpcoming.value
                                          ? Colors.white
                                          : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Obx(
              () => //// Past Leave data
                  !leaveScreenController.isSelectUpcoming.value
                      ? Expanded(
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Date",
                                              style: AppStyle()
                                                  .workSansMedium(context)
                                                  .copyWith(
                                                      fontSize: 17,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Tue 5, 2023 - Fri 8, 2023",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: height * 0.038,
                                          width: width * 0.21,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 222, 41, 41),
                                              ),
                                              color: const Color.fromARGB(
                                                  255, 254, 241, 241),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              "Approved",
                                              style: AppStyle()
                                                  .workSansRegular(context)
                                                  .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromARGB(
                                                          255, 199, 27, 27)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: height * 0.04,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Apply Days",
                                              style: AppStyle()
                                                  .workSansMedium(context)
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "2 Days",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Leave Balance",
                                              style: AppStyle()
                                                  .workSansMedium(context)
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "19",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Approved By",
                                              style: AppStyle()
                                                  .workSansMedium(context)
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Sunny",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        )

///// Upcoming Leave data
                      : Expanded(
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Date",
                                              style: AppStyle()
                                                  .workSansMedium(context)
                                                  .copyWith(
                                                      fontSize: 17,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Sun 10, 2023 - Wed 13, 2023",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: height * 0.038,
                                          width: width * 0.21,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 174, 222, 41),
                                              ),
                                              color: const Color.fromARGB(
                                                  255, 251, 254, 241),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              "Approved",
                                              style: AppStyle()
                                                  .workSansRegular(context)
                                                  .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              118,
                                                              154,
                                                              19)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: height * 0.04,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Apply Days",
                                              style: AppStyle()
                                                  .workSansMedium(context)
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "3 Days",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Leave Balance",
                                              style: AppStyle()
                                                  .workSansMedium(context)
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "19",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Approved By",
                                              style: AppStyle()
                                                  .workSansMedium(context)
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Sunny",
                                              style: AppStyle()
                                                  .workSansSemiBold(context)
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
