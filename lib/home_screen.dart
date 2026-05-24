import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:zob/break_screen.dart';
import 'package:zob/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scanBarcode = 'Unknown'.obs;
  var checkInTime = "".obs;
  var checkOutTime = "".obs;
  var breackTimeStartTime = "".obs;
  var breackTimeOutTime = "".obs;
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    debugPrint("Get scanner : ${barcodeScanRes}");

    _scanBarcode.value = barcodeScanRes;

    if (_scanBarcode != "-1") {
      log("Scann code : $_scanBarcode");
      var checkIn = DateTime.now();
      log("checkIn Time : $checkIn");
      snackbar(
        "Check In",
        DateTime.now(),
        Icon(
          Icons.watch_later_outlined,
          color: Colors.white,
        ),
      );
    }
  }

  snackbar(title, DateTime time, Icon icon) {
    Get.snackbar(
      title,
      "${DateFormat("dd-MM-yyyy HH:mm a").format(time)}",
      colorText: Colors.white,
      backgroundColor: Color.fromARGB(255, 101, 155, 199),
      icon: icon,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: height * 0.3,
              width: width,
              color: Color.fromARGB(255, 25, 60, 88),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.1,
                    width: height * 0.1,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 198, 198, 198),
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Image.asset(
                        "assets/images/qr-code.png",
                        height: height * 0.07,
                        width: height * 0.07,
                        color: const Color.fromARGB(255, 198, 198, 198),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hi & Welcome!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Attendance with QR Code",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 198, 198, 198)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      scanQR();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: height * 0.14,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 101, 155, 199),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                size: 45,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Check-In",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Text(
                                    "Check-in for you attendance",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 198, 198, 198)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Get.to(BreackScreen());
                      },
                      child: Container(
                        height: height * 0.14,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 101, 155, 199),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.free_breakfast_outlined,
                                size: 45,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Break",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: width * 0.7,
                                    child: Text(
                                      "Add your break status",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                              255, 198, 198, 198)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: height * 0.14,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 101, 155, 199),
                      ),
                      child: InkWell(
                        onTap: () {
                          checkOutTime.value = DateFormat("dd-MM-yyyy HH:mm a")
                              .format(DateTime.now());
                          snackbar(
                            "Check Out",
                            DateTime.now(),
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                size: 45,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Check-Out",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Container(
                                    width: width * 0.7,
                                    child: Text(
                                      "Check-out to complete your attendance",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                              255, 198, 198, 198)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Get.to(DetailsScreen(
                          checkIn: checkInTime.value,
                          checkOut: checkOutTime.value,
                          breackIn: breackTimeStartTime.value,
                          breackOut: breackTimeOutTime.value,
                        ));
                      },
                      child: Container(
                        height: height * 0.14,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 101, 155, 199),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 45,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Report",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  Container(
                                    width: width * 0.7,
                                    child: Text(
                                      "Check you attendance reports",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                              255, 198, 198, 198)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
