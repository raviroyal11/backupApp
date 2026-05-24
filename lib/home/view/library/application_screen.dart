import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/view/library/application/apply_leave_form.dart';
import 'package:zob/home/view/library/application/apply_payment_form.dart';
import 'package:zob/home/view/library/application/apply_promotion_form.dart';
import 'package:zob/home/view/library/application/incident_form.dart';
import 'package:zob/home/view/library/application/report_form.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class ApplicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Application"),
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
                    onTap: () async {
                      Get.to(LeaveScreen());
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
                          "Apply For Leave",
                          textAlign: TextAlign.center,
                          style: AppStyle()
                              .workSansSemiBold(context)
                              .copyWith(fontSize: 26),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(PromotionForm());
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
                          "Apply For Promotion",
                          textAlign: TextAlign.center,
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
                    onTap: () async {
                      Get.to(IncidentForm());
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
                          "Incident Form",
                          textAlign: TextAlign.center,
                          style: AppStyle()
                              .workSansSemiBold(context)
                              .copyWith(fontSize: 26),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ReportForm());
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
                          "Report Form",
                          textAlign: TextAlign.center,
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
                    onTap: () async {
                      Get.to(PaymentForm());
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
                          "Apply For Payment",
                          textAlign: TextAlign.center,
                          style: AppStyle()
                              .workSansSemiBold(context)
                              .copyWith(fontSize: 26),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.14,
                    width: width * 0.44,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
