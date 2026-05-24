import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/dashboard_screen_controller.dart';
import 'package:zob/home/view/bottome_navigation.dart';
import 'package:zob/home/view/job_detail_screen.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/utils/str_const.dart';
import 'package:uni_links/uni_links.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final dashboardScreenController = Get.put(DashboardScreenController());
  @override
  void initState() {
    getLoginStatus();
    dashboardScreenController.getCurrentLocationPermission();
    initDeepLinks();
    super.initState();
  }

  void initDeepLinks() async {
    /// 🔥 App closed → open via link
    final initialLink = await getInitialLink();
    log("Initial deep link: $initialLink");

    if (initialLink != null) {
      handleDeepLink(initialLink);
    }

    /// 🔥 App running / background
    linkStream.listen((link) {
      log("Received deep link: $link");
      if (link != null) {
        handleDeepLink(link);
      }
    });
  }

  void handleDeepLink(String url) {
    final uri = Uri.parse(url);

    /// Example: backupp://job/97/slug OR https://backupp.com/job/97/slug
    if (uri.pathSegments.contains("job")) {
      final slug = uri.pathSegments.last;
      final jobId = uri.pathSegments[uri.pathSegments.length - 2];

      Get.to(() => JobDetailScreen(
            jobID: jobId,
            isSavedScreen: true,
            jobSlug: slug,
          ));
    }
  }

  getLoginStatus() async {
    bool loginStatus = await SharePref().getLoginStatus();

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (loginStatus == false) {
        Get.offAll(IntroScreen());
      } else {
        Get.offAll(BottomNavigationScreen(
          selectIndex: 0,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              AppColor.colorB3FF,
              AppColor.color8EE9,
              AppColor.color77DC
            ],
          ),
        ),
        child: Center(
          child: Text(
            AppText.appName,
            style: AppStyle().workSansBold(context).copyWith(fontSize: 36),
          ),
        ),
      ),
    );
  }
}
