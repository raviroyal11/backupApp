import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
        titleTextStyle: AppStyle()
            .workSansSemiBold(context)
            .copyWith(fontSize: 20, color: AppColor.color4551),
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppColor.colorB5BA,
            height: 1.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: width * 0.29,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: const Color(0x66E7E8E9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1.3, color: AppColor.colorB5BA),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "My Jobs",
                          style: AppStyle().workSansMedium(context).copyWith(
                              fontSize: 14, color: AppColor.color969D),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColor.color969D,
                        )
                      ],
                    ),
                  ),
                ),
                AppHelper().horizontalSpace(size: 12),
                Container(
                  width: width * 0.33,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: const Color(0x66E7E8E9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1.3, color: AppColor.colorB5BA),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "All Job ID",
                          style: AppStyle().workSansMedium(context).copyWith(
                              fontSize: 14, color: AppColor.color969D),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColor.color969D,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 90),
            Column(
              children: [
                SvgPicture.asset(AppImg.findJobImg),
                AppHelper().verticalSpace(size: AppFontSize.paddingSize32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Text(
                    "You don't have job yet,\nFind your job on Backupp. We’ve many job for you!",
                    textAlign: TextAlign.center,
                    style: AppStyle().workSansMedium(context).copyWith(
                          color: AppColor.color4551,
                        ),
                  ),
                ),
                AppHelper().verticalSpace(size: AppFontSize.paddingSize32),
                Container(
                  height: 38,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 1,
                      color: AppColor.color95ED,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Go to Find Job",
                      style: AppStyle()
                          .workSansMedium(context)
                          .copyWith(color: AppColor.color95ED),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
