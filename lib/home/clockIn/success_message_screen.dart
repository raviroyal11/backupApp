import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:zob/home/view/bottome_navigation.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

class SuccessMessageScreen extends StatelessWidget {
  String totalHours;
  String location;
  SuccessMessageScreen(
      {super.key, required this.totalHours, required this.location});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Lottie.asset("assets/images/check.json",
                      height: height * 0.2)),
              SizedBox(height: 40),
              Center(
                child: Text(
                  "You have done $totalHours hour",
                  textAlign: TextAlign.center,
                  style: AppStyle().workSansMedium(context).copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: AppColor.color4551,
                      size: 22,
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        text: "Date :- ",
                        style: AppStyle().workSansMedium(context).copyWith(
                            fontSize: 19,
                            color: AppColor.color4551,
                            fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                            text: DateFormat('d MMM, yyyy')
                                .format(DateTime.now()),
                            style: AppStyle().workSansMedium(context).copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: AppColor.color4551),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: AppColor.color4551,
                      size: 22,
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        text: "Day :- ",
                        style: AppStyle().workSansMedium(context).copyWith(
                            fontSize: 19,
                            color: AppColor.color4551,
                            fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                            text: DateFormat('EEEE').format(DateTime.now()),
                            style: AppStyle().workSansMedium(context).copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: AppColor.color4551),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColor.color4551,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    RichText(
                      text: TextSpan(
                        text: "Time :- ",
                        style: AppStyle().workSansMedium(context).copyWith(
                            fontSize: 18,
                            color: AppColor.color4551,
                            fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                            text: DateFormat('HH:mm a').format(DateTime.now()),
                            style: AppStyle().workSansMedium(context).copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: AppColor.color4551),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Icon(
                        Icons.location_on,
                        color: AppColor.color4551,
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Location :- ",
                      style: AppStyle().workSansMedium(context).copyWith(
                          fontSize: 19,
                          color: AppColor.color4551,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                        width: MediaQuery.sizeOf(context).width * 0.52,
                        child: Text(
                          location,
                          style: AppStyle().workSansMedium(context).copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: AppColor.color4551),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Thank you for your support.",
                  style: AppStyle().workSansMedium(context).copyWith(
                        fontSize: 23,
                        color: const Color.fromARGB(255, 104, 104, 104),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Text(
                  "Have a great day",
                  style: AppStyle().workSansMedium(context).copyWith(
                        fontSize: 23,
                        color: const Color.fromARGB(255, 104, 104, 104),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Center(
                  child: RatingBar.builder(
                    initialRating: 0.0,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5),
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
                      // Future.delayed(Duration(seconds: 2), () {
                      //   String ratings = rating.toInt().toString();
                      //   String rosterID = widget
                      //       .rosterScreenController.rosterListData[index].id
                      //       .toString();
                      //   if (widget.rosterScreenController.rosterListData[index]
                      //       .isAcceptRoster.obs.value.value) {
                      //     debugPrint("Roster id : ${rosterID}");
                      //     widget.rosterScreenController.rosterRatingApicall(
                      //         rosterID: rosterID, rating: ratings);
                      //   } else {
                      //     if (widget.rosterScreenController
                      //             .rosterListData[index].isAccepted ==
                      //         1) {
                      //       debugPrint("Roster id : ${rosterID}");
                      //       widget.rosterScreenController.rosterRatingApicall(
                      //           rosterID: rosterID, rating: ratings);
                      //     } else {
                      //       final snackBar = SnackBar(
                      //         elevation: 0,
                      //         behavior: SnackBarBehavior.floating,
                      //         backgroundColor: Colors.transparent,
                      //         content: AwesomeSnackbarContent(
                      //           title: "Oh Snap!",
                      //           message:
                      //               "Cannot give rating without accepting app roaster",
                      //           contentType: ContentType.failure,
                      //         ),
                      //       );
                      //       ScaffoldMessenger.of(Get.context!)
                      //         ..hideCurrentSnackBar()
                      //         ..showSnackBar(snackBar);
                      //     }
                      //   }
                      // });
                    },
                  ),
                ),
              ),
              Spacer(),
              Container(
                height: height * 0.060,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.colorABF5,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.colorABF5,
                        blurRadius: 8.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.offAll(BottomNavigationScreen(
                          selectIndex: 0,
                        ));
                      },
                      child: Center(
                        child: Text(
                          " Back To Home",
                          style: AppStyle().workSansMedium(context).copyWith(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
