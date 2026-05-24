import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Lottie.asset("assets/images/coming_soon.json",
                height: height * 0.2),
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
      ),
    );
  }
}
