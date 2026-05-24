import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:zob/home/view/library/controller/jobScreenController.dart';
import 'package:zob/login/controller/find_job_screen_controller.dart';
import 'package:zob/login/controller/job_detail_screen_controller.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_style.dart';

class JobDetailScreen extends StatefulWidget {
  String jobSlug;
  String jobID;
  bool isSavedScreen;

  JobDetailScreen(
      {super.key,
      required this.jobSlug,
      required this.jobID,
      required this.isSavedScreen});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  final jobDetailScreenController = Get.put(JobDetailScreenController());

  @override
  void initState() {
    log("Check my selected id ::: ${widget.jobSlug}");
    jobDetailScreenController.getjobList(jobSlug: widget.jobSlug);
    super.initState();
  }

  String dayCalculation({required String startsDate}) {
    // Parse the start date from the provided string
    DateTime startDate = DateFormat('dd-MM-yyyy').parse(startsDate);

    // Format the current date in 'dd-MM-yyyy' and parse it
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    DateTime endDate = DateFormat('dd-MM-yyyy').parse(formattedDate);

    // Calculate the difference in days
    int differenceInDays = endDate.difference(startDate).inDays;

    print(
        'Difference in days: $differenceInDays //// ${convertDaysToWeeksMonthsYears(differenceInDays)}');

    return convertDaysToWeeksMonthsYears(differenceInDays);
  }

  /// Convert Day to week, months, year
  String convertDaysToWeeksMonthsYears(int totalDays) {
    // Start date
    DateTime startDate = DateTime(2000, 1, 1); // Arbitrary reference date

    // End date after adding totalDays
    DateTime endDate = startDate.add(Duration(days: totalDays));

    // Calculate the difference
    int years = endDate.year - startDate.year;
    int months = endDate.month - startDate.month;
    int days = endDate.day - startDate.day;

    // Adjust for negative values (when day/month overflow happens)
    if (days < 0) {
      months -= 1;
      days += DateTime(startDate.year, startDate.month + 1, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    // Convert remaining days into weeks
    int weeks = days ~/ 7;
    days %= 7;

    if (years == 0 && months == 0 && weeks == 0) {
      return '$days days';
    } else if (years == 0 && months == 0) {
      return '$weeks weeks, $days days';
    } else if (years == 0) {
      return '$months months, $weeks weeks, $days days';
    } else {
      return '$years years, $months months, $weeks weeks, $days days';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Job Details'),
          leading: Container(
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: () {
                    Share.share('''
Apply now 🚀

If app installed:
https://backupp.com/job/${widget.jobID}/${widget.jobSlug}

Or download:
https://play.google.com/store/apps/details?id=com.backupp.zob
''');
                  },
                  icon: const Icon(
                    Icons.share,
                    color: AppColor.color77DC,
                  )),
            ),
          ],
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
        body: jobDetailScreenController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColor.color77DC,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: height * 0.115,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          jobDetailScreenController
                                  .jobDetailsData.value.contactCompanyName ??
                              '',
                          style: AppStyle().workSansSemiBold(context).copyWith(
                              fontSize: 40, color: AppColor.color77DC),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.065,
                          width: height * 0.065,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.color77DC.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 20,
                                offset: const Offset(0.2, 0.2),
                              ),
                            ],
                            image: jobDetailScreenController
                                        .jobDetailsData.value.logo !=
                                    ''
                                ? DecorationImage(
                                    image: NetworkImage(
                                        jobDetailScreenController
                                                .jobDetailsData.value.logo ??
                                            ''))
                                : const DecorationImage(
                                    image: AssetImage(AppImg.aaplogo),
                                  ),
                          ),
                        ),
                        /* Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.33,
                          decoration: BoxDecoration(
                            color: AppColor.color2982,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  FindJobScreenController jobScreenController =
                                      Get.find<FindJobScreenController>();
                                  jobScreenController.saveJob(jobId: widget.jobID.toString());
                                },
                                child: Center(
                                  child: Text(
                                    'Save Now',
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(
                                            fontSize: 19, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ), */
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      jobDetailScreenController.jobDetailsData.value.jobTitle ??
                          '',
                      style: AppStyle()
                          .workSansBold(context)
                          .copyWith(fontSize: 19, color: AppColor.color2982),
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Icon(Icons.location_on,
                              color: AppColor.color2982),
                        ),
                        const SizedBox(width: 3),
                        SizedBox(
                          width: width * 0.85,
                          child: Text(
                            'Location: ${jobDetailScreenController.jobDetailsData.value.location}',
                            style: AppStyle().workSansMedium(context).copyWith(
                                fontSize: 16,
                                height: 1.6,
                                color: AppColor.color77DC),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.028,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.work,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Job Type: ',
                            style: AppStyle().workSansRegular(context).copyWith(
                                fontSize: 17, height: 1.6, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: jobDetailScreenController
                                        .jobDetailsData.value.jobType?.name ??
                                    '',
                                style: AppStyle()
                                    .workSansSemiBold(context)
                                    .copyWith(
                                        fontSize: 17,
                                        height: 1.6,
                                        color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        // const Spacer(),
                        // RichText(
                        //   text: TextSpan(
                        //     text: 'Vacancy: ',
                        //     style: AppStyle().workSansRegular(context).copyWith(
                        //         fontSize: 17, height: 1.6, color: Colors.black),
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //         text: jobDetailScreenController
                        //                     .jobDetailsData.value.noOfWorkers ==
                        //                 ''
                        //             ? '0'
                        //             : jobDetailScreenController
                        //                 .jobDetailsData.value.noOfWorkers,
                        //         style: AppStyle()
                        //             .workSansSemiBold(context)
                        //             .copyWith(
                        //                 fontSize: 17,
                        //                 height: 1.6,
                        //                 color: Colors.black),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),

                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.category_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: width * 0.86,
                          child: RichText(
                            text: TextSpan(
                              text: 'Job Category: ',
                              style: AppStyle()
                                  .workSansRegular(context)
                                  .copyWith(
                                      fontSize: 17,
                                      height: 1.6,
                                      color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: jobDetailScreenController
                                      .jobDetailsData.value.jobCategory
                                      .toString(),
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          fontSize: 17,
                                          height: 1.6,
                                          color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    SizedBox(
                      width: width * 0.86,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.work,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Qualification: ',
                              style: AppStyle()
                                  .workSansRegular(context)
                                  .copyWith(
                                      fontSize: 17,
                                      height: 1.6,
                                      color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Qualification Required: ',
                                  // jobDetailScreenController.jobDetailsData
                                  //             .value.qualificationRequired ==
                                  //         jobDetailScreenController
                                  //             .jobDetailsData.value.qualification

                                  //     ? jobDetailScreenController.jobDetailsData
                                  //         .value.qualificationRequired
                                  //     : "${jobDetailScreenController.jobDetailsData.value.qualificationRequired ?? ''} ${jobDetailScreenController.jobDetailsData.value.qualification ?? ''}",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          fontSize: 17,
                                          height: 1.6,
                                          color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    SizedBox(
                      width: width * 0.86,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(
                              Icons.calendar_month,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Date Posted: ',
                              style: AppStyle()
                                  .workSansRegular(context)
                                  .copyWith(
                                      fontSize: 17,
                                      height: 1.6,
                                      color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: DateFormat("dd, MMM yy HH:mma").format(
                                      jobDetailScreenController
                                              .jobDetailsData.value.createdAt ??
                                          DateTime.now()),
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          fontSize: 17,
                                          height: 1.6,
                                          color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: height * 0.008,
                    ),
                    SizedBox(
                      width: width * 0.86,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(
                              Icons.watch_later_sharp,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'No. of Workers required: ',
                              style: AppStyle()
                                  .workSansRegular(context)
                                  .copyWith(
                                      fontSize: 17,
                                      height: 1.6,
                                      color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: jobDetailScreenController
                                      .jobDetailsData.value.noOfWorkers,
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          fontSize: 17,
                                          height: 1.6,
                                          color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    SizedBox(
                      width: width * 0.86,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(
                              Icons.watch_later_sharp,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Experience: ',
                              style: AppStyle()
                                  .workSansRegular(context)
                                  .copyWith(
                                      fontSize: 17,
                                      height: 1.6,
                                      color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: jobDetailScreenController.jobDetailsData
                                          .value.jobExperience?.name ??
                                      '',
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          fontSize: 17,
                                          height: 1.6,
                                          color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.008,
                    ),
                    SizedBox(
                      width: width * 0.86,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(
                              Icons.money,
                              size: 19,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Salary: ',
                              style: AppStyle()
                                  .workSansRegular(context)
                                  .copyWith(
                                      fontSize: 17,
                                      height: 1.6,
                                      color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: jobDetailScreenController
                                              .jobDetailsData.value.priceFrom ==
                                          ''
                                      ? jobDetailScreenController
                                          .jobDetailsData.value.payTypeRequired
                                      : "\$${jobDetailScreenController.jobDetailsData.value.priceFrom} - \$${jobDetailScreenController.jobDetailsData.value.priceTo}/ ${jobDetailScreenController.jobDetailsData.value.jobType?.name}",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          fontSize: 17,
                                          height: 1.6,
                                          color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    jobDetailScreenController
                                .jobDetailsData.value.description ==
                            null
                        ? SizedBox()
                        : Text(
                            'Job Description:',
                            style: AppStyle().workSansBold(context).copyWith(
                                fontSize: 20,
                                height: 1.6,
                                color: AppColor.color2982),
                          ),
                    jobDetailScreenController
                                .jobDetailsData.value.description ==
                            null
                        ? SizedBox()
                        : Divider(
                            endIndent: width * 0.79,
                            thickness: 2,
                            color: AppColor.color2982,
                          ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    jobDetailScreenController
                                .jobDetailsData.value.description ==
                            null
                        ? SizedBox()
                        : Html(
                            data: jobDetailScreenController
                                .jobDetailsData.value.description,
                            style: {
                              "h1": Style(fontSize: FontSize(20)),
                              "p": Style(fontSize: FontSize(17)),
                              "li": Style(fontSize: FontSize(15)),
                            },
                          ),
                    // Text('We are seeking a talented and passionate Web Developer to join our team. The ideal candidate will have strong technical skills, a creative mindset, and the ability to develop user-friendly, responsive websites and web applications. You will collaborate with designers, project managers, and other developers to bring projects to life while ensuring seamless performance and scalability.',
                    // textAlign: TextAlign.justify,
                    //     style: AppStyle()
                    //             .workSansRegular(context)
                    //             .copyWith(fontSize: 17, height: 1.6, color: Colors.black,),),
                    //             SizedBox(
                    //   height: height * 0.04,
                    // ),

                    // jobDetailScreenController
                    //             .jobDetailsData.value.employerQuestions ==
                    //         null
                    //     ? SizedBox()
                    //     : Text(
                    //         'Employer Questions',
                    //         style: AppStyle().workSansBold(context).copyWith(
                    //             fontSize: 20,
                    //             height: 1.6,
                    //             color: AppColor.color2982),
                    //       ),
                    // jobDetailScreenController
                    //             .jobDetailsData.value.employerQuestions ==
                    //         null
                    //     ? SizedBox()
                    //     : Divider(
                    //         endIndent: width * 0.79,
                    //         thickness: 2,
                    //         color: AppColor.color2982,
                    //       ),
                    // SizedBox(
                    //   height: height * 0.012,
                    // ),
                    // jobDetailScreenController
                    //             .jobDetailsData.value.employerQuestions ==
                    //         null
                    //     ? SizedBox()
                    //     : Html(
                    //         data: jobDetailScreenController
                    //             .jobDetailsData.value.employerQuestions,
                    //         style: {
                    //           "h1": Style(fontSize: FontSize(20)),
                    //           "p": Style(fontSize: FontSize(17)),
                    //           "li": Style(fontSize: FontSize(15)),
                    //         },
                    //       ),
                    //         Text('• Develop, test, and maintain websites and web applications.',
                    //         textAlign: TextAlign.justify,
                    //             style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black,height: 1.6),),
                    //                     SizedBox(
                    //           height: height * 0.012,
                    //         ),
                    //                     Text('• Write clean, efficient, and maintainable code using [programming languages, e.g., HTML, CSS, JavaScript, etc.].',

                    //             style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black,height: 1.6),),
                    //                     SizedBox(
                    //           height: height * 0.012,
                    //         ),
                    //                     Text('• Collaborate with designers to transform UI/UX designs into functional web pages.',

                    //             style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black,height: 1.6),),
                    //                     SizedBox(
                    //           height: height * 0.012,
                    //         ),
                    //                     Text('• Optimize websites for maximum speed and scalability.',

                    //             style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black,height: 1.6),),
                    //                     SizedBox(
                    //           height: height * 0.012,
                    //         ),
                    //                     Text('• Ensure cross-platform compatibility and responsiveness of web solutions.',

                    //             style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black,height: 1.6),),
                    //                     SizedBox(
                    //           height: height * 0.012,
                    //         ),
                    //                     Text('• Debug and troubleshoot issues to improve performance and user experience.',

                    //             style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black,height: 1.6),),
                    //                     SizedBox(
                    //           height: height * 0.012,
                    //         ),
                    //                     Text('• Stay updated with emerging trends and technologies in web development.',

                    //             style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black,height: 1.6),),
                    //                     SizedBox(
                    //           height: height * 0.04,
                    //         ),

                    //         Text('Attention: Please Be Careful',
                    //             style: AppStyle()
                    //                 .workSansBold(context)
                    //                 .copyWith(fontSize: 20, height: 1.6, color: AppColor.color2982),),

                    //         Divider(endIndent: width * 0.79,thickness: 2,color: AppColor.color2982,),
                    // SizedBox(
                    //           height: height * 0.012,
                    //         ),
                    //         RichText(
                    //               text:  TextSpan(
                    //                 text: 'When applying for jobs or interacting with any online platforms, ',
                    //                 style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black, height: 1.6),
                    //                 children: <TextSpan>[
                    //                   TextSpan(
                    //                     text: 'DO NOT provide your credit card details, bank account information, passwords, or PINs. ',
                    //                     style: AppStyle()
                    //                         .workSansBold(context)
                    //                         .copyWith(fontSize: 17, color: Colors.black),
                    //                   ),
                    //                   TextSpan(
                    //                     text: 'Protect your personal and financial information to avoid potential scams or fraud. Stay safe and vigilant!',
                    //                     style: AppStyle()
                    //                     .workSansRegular(context)
                    //                     .copyWith(fontSize: 17, color: Colors.black,),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),

                    if (widget.isSavedScreen)
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.04,
                          ),
                          ButtonWidget(
                            width: width,
                            height: height * 0.07,
                            onTap: () {
                              jobDetailScreenController.jobApply(
                                  jobId: widget.jobID);
                            },
                            btnColor: AppColor.color77DC,
                            btnName: "Apply Now",
                            btnTextColor: AppColor.white,
                            isLoading:
                                jobDetailScreenController.isJobApplyLoading,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
