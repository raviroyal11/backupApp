import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/bottom_navigation_screen_controller.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int selectIndex;
  BottomNavigationScreen({super.key, required this.selectIndex});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final bottomNaviController = Get.put(BottomNavigationScreenController());
  @override
  void initState() {
    bottomNaviController.currentId.value = widget.selectIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          body: bottomNaviController
              .screens.obs.value[bottomNaviController.currentId.value],
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              /* Color(0xFFFFFFFF), */
              selectedItemColor: AppColor.color95ED,
              unselectedItemColor: AppColor.colorB5BA,
              selectedFontSize: 12,
              selectedLabelStyle: const TextStyle(
                  color: AppColor.color95ED, fontWeight: FontWeight.w500),
              unselectedLabelStyle: const TextStyle(
                  color: AppColor.colorB5BA, fontWeight: FontWeight.w500),
              currentIndex: bottomNaviController.currentId.value,
              unselectedFontSize: 12,
              elevation: 0,
              onTap: (value) {
                var temp = 0.obs;
                temp.value = value;
                bottomNaviController.onTapped(temp.value);
              },
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  icon: SvgPicture.asset(
                    AppImg.home,
                    // ignore: deprecated_member_use
                    color: bottomNaviController.currentId.value == 0
                        ? AppColor.color95ED
                        : AppColor.colorB5BA,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Find Jobs",
                  icon: SvgPicture.asset(
                    AppImg.search,
                    color: bottomNaviController.currentId.value == 1
                        ? AppColor.color95ED
                        : AppColor.colorB5BA,
                  ),
                ),
                // BottomNavigationBarItem(
                //   label: "Roster",
                //   icon: SvgPicture.asset(
                //     AppImg.yourJob,
                //     color: bottomNaviController.currentId.value == 2
                //         ? AppColor.color95ED
                //         : AppColor.colorB5BA,
                //   ),
                // ),
                BottomNavigationBarItem(
                  label: "Reports",
                  icon: SvgPicture.asset(
                    AppImg.report,
                    color: bottomNaviController.currentId.value == 2
                        ? AppColor.color95ED
                        : AppColor.colorB5BA,
                  ),
                ),
                BottomNavigationBarItem(
                    label: "Message",
                    icon: Icon(
                      Icons.message,
                      color: bottomNaviController.currentId.value == 3
                          ? AppColor.color95ED
                          : AppColor.colorB5BA,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
