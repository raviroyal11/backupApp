import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  final String checkIn;
  final String checkOut;
  final String breackIn;
  final String breackOut;
  const DetailsScreen({
    super.key,
    required this.checkIn,
    required this.checkOut,
    required this.breackIn,
    required this.breackOut,
  });

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
        title: Text(
          "Report",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.1,
              width: width,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.3,
                    child: Text(
                      "27-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check In",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "09:00 AM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
                    width: width * 0.3,
                    child: Text(
                      "27-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Break",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "01:00 PM  To  02:00 PM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
                    width: width * 0.3,
                    child: Text(
                      "27-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check Out",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "06:00 PM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
                    width: width * 0.3,
                    child: Text(
                      "28-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check In",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "09:00 AM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
                    width: width * 0.3,
                    child: Text(
                      "28-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Break",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "01:00 PM  To  02:00 PM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
                    width: width * 0.3,
                    child: Text(
                      "28-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check Out",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "06:00 PM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
                    width: width * 0.3,
                    child: Text(
                      "29-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check In",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "09:00 AM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
                    width: width * 0.3,
                    child: Text(
                      "29-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Break",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "01:00 PM  To  02:00 PM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
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
                    width: width * 0.3,
                    child: Text(
                      "29-09-2023",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 91, 90, 90),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.01,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 25, 60, 88),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check Out",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "06:00 PM",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 99, 99, 99),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
              color: Color.fromARGB(255, 91, 90, 90),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
