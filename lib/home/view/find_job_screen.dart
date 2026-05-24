import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/view/account/profile_details.dart';
import 'package:zob/home/view/job_detail_screen.dart';
import 'package:zob/home/view/library/job_screen.dart';
import 'package:zob/login/controller/find_job_screen_controller.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class FindJobsScreen extends StatelessWidget {
  FindJobsScreen({super.key});

  final findJobController = Get.put(FindJobScreenController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Find Jobs"),
          leading: Container(),
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
            InkWell(
              onTap: () {
                Get.to(JobScreen(initialIndex: 3,));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, top: 8, left: 10, bottom: 6),
                child: Row(
                  children: [
                    /* Text(
                      "Save Jobs",
                      style: AppStyle()
                          .workSansMedium(context)
                          .copyWith(color: AppColor.color8686, fontSize: 17),
                    ),
                    AppHelper().horizontalSpace(size: 10), */
                    SvgPicture.asset(AppImg.saveIcon, color: AppColor.color2982,),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Obx(() => findJobController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: AppColor.color8EE9),
              )
            : findJobController.jobList.isEmpty
                ? const Center(
                    child: Text(
                      "No Reord Found",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.color8EE9),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: findJobController.jobList.length,
                    itemBuilder: (context, index) {
                      var data = findJobController.jobList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: InkWell(
                          onTap: () {
                            Get.to(JobDetailScreen(
                              jobSlug: data.slug.toString(),
                              jobID: data.id.toString(),
                              isSavedScreen: true,
                            ));
                          },
                          child: Container(
                            width: width,
                            // height: height * 0.26,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.colorB3FF.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 10,
                                  offset: const Offset(0.5, 0.5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      data.logo != ''
                                          ? Container(
                                              height: height * 0.065,
                                              width: height * 0.065,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColor.color77DC
                                                        .withOpacity(0.2),
                                                    spreadRadius: 0.5,
                                                    blurRadius: 20,
                                                    offset:
                                                        const Offset(0.2, 0.2),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl: data.logo ?? '',
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                          colorFilter:
                                                              const ColorFilter
                                                                  .mode(
                                                                  AppColor
                                                                      .colorB3FF,
                                                                  BlendMode
                                                                      .colorBurn)),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      CircularProgressIndicator(
                                                    color: AppColor.color77DC,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: height * 0.065,
                                              width: height * 0.065,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColor.color77DC
                                                        .withOpacity(0.2),
                                                    spreadRadius: 0.5,
                                                    blurRadius: 20,
                                                    offset:
                                                        const Offset(0.2, 0.2),
                                                  ),
                                                ],
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      AppImg.aaplogo),
                                                ),
                                              ),
                                            ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              data.jobTitle ?? '',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              data.priceFrom == ''
                                                  ? (data.payTypeRequired ?? '')
                                                  : "\$${data.priceFrom ?? ''} - \$${data.priceTo ?? ''}/ ${data.payTypeRequired ?? ''}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColor.color77DC,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: width * 0.68,
                                            child: Text(
                                              "Created At : ${DateFormat("dd, MMM yy HH:mma").format(data.createdAt ?? DateTime.now())}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.color77DC),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "No of Vacancy: ${data.noOfWorkers == '' ? '0' : data.noOfWorkers}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.color77DC),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "Browse Job",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 52, 108)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.33,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 80, 171, 83),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'Casual',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                      ),
                                      const Spacer(),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.33,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 23, 112, 26),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Row(
                                          children: [
                                            Spacer(),
                                            Icon(
                                              Icons.share,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Share',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Obx(
                                        () => InkWell(
                                          onTap: () {
                                            findJobController
                                                .selectIndex.value = index;
                                            findJobController.saveJob(
                                                jobId: data.id.toString());
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: BoxDecoration(
                                              color: AppColor.color2982,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: (findJobController
                                                              .selectIndex
                                                              .value ==
                                                          index &&
                                                      findJobController
                                                          .isSaveJobLoading
                                                          .value)
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: AppColor.white,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : SvgPicture.asset(
                                                      AppImg.saveIcon,
                                                      color: Colors.white,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }))

        /* Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
Html(
            data: htmlData,
          ),
              // Lottie.asset("assets/images/coming_soon.json",
              //     height: height * 0.2),
              const SizedBox(height: 20),
              Text(
                "Coming Soon..",
                textAlign: TextAlign.center,
                style: AppStyle()
                    .workSansSemiBold(context)
                    .copyWith(color: AppColor.color8EE9, fontSize: 30),
              ),
            ],
          ),
        ), */ /* Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              child: Row(
                children: [
                  /* Container(
                    height: height * 0.055,
                    width: width * 0.51,
                    decoration: BoxDecoration(
                      color: AppColor.colorF7F8,
                      border:
                          Border.all(width: 1.5, color: AppColor.borderColor),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ), */
                  SizedBox(
                    height: height * 0.055,
                    width: width * 0.935,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 2, left: 10, right: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      value: findJobController.selectJobTypeValue.value,
                      onChanged: (newValue) {
                        findJobController.selectJobTypeValue.value =
                            newValue.toString();
                      },
                      items: findJobController.selectJobTypeList.map((items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: AppStyle()
                                .workSansMedium(context)
                                .copyWith(color: AppColor.color4551),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            //// Roster Body

            Column(
              children: [YourJobScreenWidget()],
            ),
          ],
        ),
       */
        );
  }
}

class YourJobScreenWidget extends StatelessWidget {
  const YourJobScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          TextFormFieldWidget(
            height: height,
            hintText: "Search jobs",
          ),
          AppHelper().verticalSpace(size: 15),
          Row(
            children: [
              Text(
                "Your Shift",
                style: AppStyle()
                    .workSansSemiBold(context)
                    .copyWith(fontSize: 15, color: AppColor.color4551),
              ),
              const Spacer(),
              Text(
                "4 Shift",
                style: AppStyle()
                    .workSansSemiBold(context)
                    .copyWith(fontSize: 15, color: AppColor.color4551),
              ),
            ],
          ),
          AppHelper().verticalSpace(size: 10),
          SizedBox(
            height: height * 0.57,
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColor.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Report to supervisor",
                        style: AppStyle.workSansSemiBold
                            .copyWith(fontSize: 15, color: AppColor.color4551),
                      ),
                    ),
                    AppHelper().verticalSpace(size: 5), */
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(AppImg.temp),
                              ),
                              AppHelper().horizontalSpace(size: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    // width: width * 0.70,
                                    child: Row(
                                      children: [
                                        Text(
                                          "DHL Express",
                                          style: AppStyle()
                                              .workSansSemiBold(context)
                                              .copyWith(
                                                  fontSize: 15 *
                                                      MediaQuery
                                                          .textScaleFactorOf(
                                                              context),
                                                  color: AppColor.color4551),
                                        ),
                                        AppHelper().horizontalSpace(size: 4),
                                        SvgPicture.asset(AppImg.verify),
                                        /* const Spacer(),
                                  Text(
                                    "Posted 15/05/2023",
                                    style: AppStyle.workSansSemiBold.copyWith(
                                      fontSize: 14,
                                      color: AppColor.color969D,
                                    ),
                                  ), */
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.72,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Melbourne, Australia",
                                          style: AppStyle()
                                              .workSansMedium(context)
                                              .copyWith(
                                                fontSize: 13.5,
                                                color: AppColor.color969D,
                                              ),
                                        ),
                                        const Spacer(),
                                        /*  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 15,
                                        color: AppColor.color969D,
                                      ),
                                      Text(
                                        "Mds Cleaning",
                                        style: AppStyle.workSansSemiBold.copyWith(
                                          fontSize: 14,
                                          color: AppColor.color969D,
                                        ),
                                      ),
                                    ],
                                  ), */
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Divider(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppHelper().verticalSpace(size: 10),
                              SizedBox(
                                width: width * 0.55,
                                child: Text(
                                  "Commercial Cleaning",
                                  style: AppStyle()
                                      .workSansSemiBold(context)
                                      .copyWith(
                                          fontSize: 16,
                                          color: AppColor.color4551),
                                ),
                              ),
                              const Spacer(),
                              /*  RichText(
                          text: TextSpan(
                            text: 'Pay Rate ',
                            style: AppStyle.workSansSemiBold
                                .copyWith(fontSize: 15, color: AppColor.color4551),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\$${20.75}',
                                  style: AppStyle.workSansMedium
                                      .copyWith(color: AppColor.color6E77)),
                            ],
                          ),
                        ),
                       */
                            ],
                          ),
                          AppHelper().verticalSpace(size: 12),
                          Row(
                            children: [
                              SvgPicture.asset(AppImg.location),
                              AppHelper().horizontalSpace(size: 8),
                              Text(
                                "Staff Req. 45",
                                style: AppStyle()
                                    .workSansMedium(context)
                                    .copyWith(
                                        fontSize: 15,
                                        color: AppColor.color969D),
                              ),
                            ],
                          ),
                          AppHelper().verticalSpace(size: 2),
                          Row(
                            children: [
                              SvgPicture.asset(AppImg.calenderIcon),
                              AppHelper().horizontalSpace(size: 8),
                              Text(
                                "24/12/2021 - 15/01/2022",
                                style: AppStyle()
                                    .workSansMedium(context)
                                    .copyWith(
                                        fontSize: 15,
                                        color: AppColor.color969D),
                              ),
                            ],
                          ),
                          AppHelper().verticalSpace(size: 10),
                          RichText(
                            text: TextSpan(
                              text: 'supervised by ',
                              style: AppStyle()
                                  .workSansMedium(context)
                                  .copyWith(
                                      fontSize: 15, color: AppColor.colorB5BA),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Corey Bator',
                                  style: AppStyle()
                                      .workSansMedium(context)
                                      .copyWith(color: AppColor.color6E77),
                                ),
                              ],
                            ),
                          ),
                          AppHelper().verticalSpace(size: 8),
                          Container(
                            height: height * 0.08,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 238, 234, 234),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Total Shifts  ',
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(
                                              fontSize: 16,
                                              color: AppColor.color4551),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '20 Shift',
                                          style: AppStyle()
                                              .workSansMedium(context)
                                              .copyWith(
                                                  color: AppColor.color6E77,
                                                  fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppHelper().verticalSpace(size: 2),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Shift Complete  ',
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(
                                              fontSize: 16,
                                              color: AppColor.color4551),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '5 Shift',
                                          style: AppStyle()
                                              .workSansMedium(context)
                                              .copyWith(
                                                  color: AppColor.color6E77,
                                                  fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 20,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Your next shift  ',
                                  style: AppStyle()
                                      .workSansMedium(context)
                                      .copyWith(
                                          fontSize: 15,
                                          color: AppColor.colorB5BA),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '12days 19hours',
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(
                                              color: AppColor.color6E77,
                                              fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: height * 0.045,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  border: Border.all(
                                    color: AppColor.colorABF5,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Text(
                                      "View Job",
                                      textAlign: TextAlign.center,
                                      style: AppStyle()
                                          .workSansSemiBold(context)
                                          .copyWith(
                                              fontSize: 14,
                                              height: 1.2,
                                              color: AppColor.colorABF5),
                                    ),
                                  ),
                                ),
                              ),

                              // TextButton(
                              //   onPressed: () {},
                              //   child: Text(
                              //     "Share",
                              //     textAlign: TextAlign.center,
                              //     style: AppStyle.workSansSemiBold
                              //         .copyWith(
                              //             fontSize: 18,
                              //             color:
                              //                 AppColor.color4551),
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
