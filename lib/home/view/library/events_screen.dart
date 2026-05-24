import 'package:flutter/material.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Event"),
          titleTextStyle: AppStyle()
              .workSansSemiBold(context)
              .copyWith(fontSize: 20, color: AppColor.color4551),
          bottom: TabBar(
            labelStyle: AppStyle()
                .workSansMedium(context)
                .copyWith(fontSize: 16, color: AppColor.color4551),
            labelColor: AppColor.color8EE9,
            indicatorColor: AppColor.color8EE9,
            tabs: [
              Tab(
                text: 'Upcoming\n Event',
              ),
              Tab(text: 'Past Event'),
              Tab(text: 'Seminar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Applied Job tab
            Center(child: Text('No Record Found')),

            // Content for Favourite Job tab
            Center(child: Text('No Record Found')),

            // Content for Upcoming Job tab
            Center(child: Text('No Record Found')),
          ],
        ),
      ),
    );
  }
}
