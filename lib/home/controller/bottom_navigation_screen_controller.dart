import 'package:get/get.dart';

import 'package:zob/home/view/dashboard_screen.dart';
import 'package:zob/home/view/find_job_screen.dart';
import 'package:zob/home/view/message/message_screen.dart';
import 'package:zob/home/view/reports_screen.dart';
import 'package:zob/home/view/roster/roster_screen.dart';

class BottomNavigationScreenController extends GetxController {
  var currentId = 0.obs;
  onTapped(int index) {
    print(index);
    currentId.value = index;
  }

  var screens = [
    DashboardScreen(),
    FindJobsScreen(),
    // RosterScreen(),
    ReportsScreen(),
    MessageScreen()
  ].obs;
}
