import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  String feedback = '';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Form"),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
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
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your feedback here...",
                hintStyle: AppStyle().workSansSemiBold(context).copyWith(
                    fontSize: 16, color: AppColor.color8686), // Hint text color
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue), // Border color
                ),
              ),
              maxLines: 4,
              onChanged: (value) {
                setState(() {
                  feedback = value;
                });
              },
            ),
            Spacer(),
            ButtonWidget(
              width: width,
              height: height * 0.062,
              onTap: () {},
              btnColor: AppColor.color95ED,
              btnName: "Submit Feedback",
              btnTextColor: AppColor.white,
              isLoading: false.obs,
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize21),
          ],
        ),
      ),
    );
  }
}
