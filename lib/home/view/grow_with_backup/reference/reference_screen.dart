import 'package:flutter/material.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reference"),
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
                  onTap: () async {},
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
                        "Refer A Staff",
                        textAlign: TextAlign.center,
                        style: AppStyle()
                            .workSansSemiBold(context)
                            .copyWith(fontSize: 23),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
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
                        "Refer A Company",
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
