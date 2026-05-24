import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/view/blog/blog_screen.dart';
import 'package:zob/home/view/library/application_screen.dart';
import 'package:zob/home/view/library/events_screen.dart';
import 'package:zob/home/view/library/job_screen.dart';
import 'package:zob/home/view/library/work_history_screen.dart';
import 'package:zob/home/view/news/news_screen.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/global_helper.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  checkLoginStatus() async {
    var checkLoginStatusApi = await MySingleton().checkMyLoginStatus();
    debugPrint("Check login status : ${checkLoginStatusApi}");
    if (checkLoginStatusApi == 1) {
      SharePref().setLogin(setLogin: false);
      Get.offAll(LoginScreen());
      CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          title: "Oh snap!",
          message:
              "Sorry!, you can't login because you are logged in to another device.",
          snackBarType: ContentType.failure);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
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
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(JobScreen());
                  },
                  child: Container(
                    height: height * 0.14,
                    width: width * 0.44,
                    // height: 100.h,
                    // width: 160.w,
                    decoration: BoxDecoration(
                      color: AppColor.colorABF5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Job",
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(fontSize: 26),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(ApplicationScreen());
                  },
                  child: Container(
                    height: height * 0.14,
                    width: width * 0.44,
                    // height: 100.h,
                    // width: 160.w,
                    decoration: BoxDecoration(
                      color: AppColor.colorABF5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Application",
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(fontSize: 26),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(EventScreen());
                  },
                  child: Container(
                    height: height * 0.14,
                    width: width * 0.44,
                    // height: 100.h,
                    // width: 160.w,
                    decoration: BoxDecoration(
                      color: AppColor.colorABF5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Events",
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(fontSize: 26),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(WorkHistoryScreen());
                  },
                  child: Center(
                    child: Container(
                      height: height * 0.14,
                      width: width * 0.44,
                      // height: 100.h,
                      // width: 160.w,
                      decoration: BoxDecoration(
                        color: AppColor.colorABF5,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Center(
                          child: Text(
                            "Work History",
                            textAlign: TextAlign.center,
                            style: AppStyle()
                                .workSansSemiBold(context)
                                .copyWith(fontSize: 26),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(const BlogListScreen());
                  },
                  child: Container(
                    height: height * 0.14,
                    width: width * 0.44,
                    // height: 100.h,
                    // width: 160.w,
                    decoration: BoxDecoration(
                      color: AppColor.colorABF5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Blog",
                        textAlign: TextAlign.center,
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(fontSize: 24),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to( NewsScreen());
                  },
                  child: Container(
                    height: height * 0.14,
                    width: width * 0.44,
                    // height: 100.h,
                    // width: 160.w,
                    decoration: BoxDecoration(
                      color: AppColor.colorABF5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "News",
                        textAlign: TextAlign.center,
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(fontSize: 23),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
