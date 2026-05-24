import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BreackScreen extends StatefulWidget {
  const BreackScreen({super.key});

  @override
  State<BreackScreen> createState() => _BreackScreenState();
}

class _BreackScreenState extends State<BreackScreen> {
  var isStartBreack = false.obs;
  var startBreackTime = "".obs;
  var stopBreackTime = "".obs;
  Timer? timer;
  var remainingTime = 0.obs;

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int remainingSeconds = seconds % 3600;
    int minutes = remainingSeconds ~/ 60;
    int remainingSecondsFinal = remainingSeconds % 60;

    // Create a formatted string
    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSecondsFinal.toString().padLeft(2, '0')}';

    return formattedTime;
  }

  startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 60, 88),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: const Text(
          "Breack",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.35,
              width: width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.09, horizontal: width * 0.33),
                child: InkWell(
                  onTap: () {
                    isStartBreack.value = !isStartBreack.value;
                    if (isStartBreack.value) {
                      startCountdown();
                      startBreackTime.value =
                          DateFormat("dd MMM, yyyy HH:mm:ss a")
                              .format(DateTime.now());

                      debugPrint("cjec : ${startBreackTime.value}");
                    } else {
                      timer?.cancel();
                      stopBreackTime.value = DateFormat("dd-MM-yyyy HH:mm:ss a")
                          .format(DateTime.now());
                    }
                    // if (isStartBreack.value) {
                    //   isStartBreack.value = false;

                    // }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        isStartBreack.obs.value.value != true
                            ? "Start"
                            : "Stop",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: height * 0.07,
                width: width,
                child: Obx(
                  () => Text(
                    "Brack Time Count :  ${remainingTime.value == 0 ? "00:00:00" : remainingTime.obs.value}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 25, 60, 88),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 0,
              color: Color.fromARGB(255, 91, 90, 90),
            ),
            SizedBox(
              height: height * 0.1,
              width: width,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.32,
                    child: Text(
                      "Start Break",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.03,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Obx(
                    () => Text(
                      startBreackTime.obs.value.value.isEmpty
                          ? "00:00:00"
                          : startBreackTime.obs.value.value,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 99, 99, 99),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
              color: Color.fromARGB(255, 91, 90, 90),
            ),
            SizedBox(
              height: height * 0.1,
              width: width,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.32,
                    child: Text(
                      "Stop Break",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.03,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Obx(
                    () => Text(
                      stopBreackTime.obs.value.value.isEmpty
                          ? "00:00:00"
                          : stopBreackTime.obs.value.value,
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 99, 99, 99),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
              color: Color.fromARGB(255, 91, 90, 90),
            ),
          ],
        ),
      ),
    );
  }
}
