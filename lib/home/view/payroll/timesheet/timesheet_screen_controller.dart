import 'dart:convert';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/models/timesheet_screen_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/global_helper.dart';

class TimeSheetsScreenController extends GetxController {
  var timesheetList = <TimeSheet>[].obs;
  var isLoading = false.obs;
  List<List<Map<String, dynamic>>> weeklyGroups = [];

  List<Map<String, dynamic>> timesheetLists = [];
  Map<int, List<Map<String, dynamic>>> groupedByWeek = {};

  getTimeSheetData() async {
    isLoading.value = true;
    var userId = await SharePref().getUserId();
    Api.getTimeSheetApi(userId: userId.toString()).then((response) {
      if (response != null) {
        isLoading.value = false;
        TimeSheetResponseModel responseModel =
            TimeSheetResponseModel.fromJson(response);
        if (responseModel.success == true) {
          timesheetList.value = responseModel.data ?? [];
          timesheetLists =
              List<Map<String, dynamic>>.from(response['data']);
          groupedByWeek = groupByWeek(timesheetLists);
        }
      }
    });
  }

  // Function to group entries by week
  Map<int, List<Map<String, dynamic>>> groupByWeek(
      List<Map<String, dynamic>> entries) {
    Map<int, List<Map<String, dynamic>>> groupedByWeek = {};

    for (Map<String, dynamic> entry in entries) {
      DateTime date = DateTime.parse(entry['date']);
      int weekNumber = getWeekNumber(date);

      if (!groupedByWeek.containsKey(weekNumber)) {
        groupedByWeek[weekNumber] = [];
      }

      groupedByWeek[weekNumber]!.add(entry);
    }

    return groupedByWeek;
  }

  /// Time formate flutter
  String formatTimeAMPM(String timeString) {
    // Parse the time string
    DateTime dateTime = DateFormat('HH:mm:ss').parse(timeString);

    // Format the time in AM/PM format
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedTime;
  }

  String getWeekInfo(int weekNumber) {
    DateTime now = DateTime.now();
    DateTime janFirst = DateTime(now.year, 1, 1);

    DateTime firstDayOfWeek =
        janFirst.add(Duration(days: (weekNumber - 1) * 7));
    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

    String firstDayFormatted = firstDayOfWeek.toString();
    String lastDayFormatted = lastDayOfWeek.toString();

    return '$firstDayFormatted - $lastDayFormatted';
  }

  List<List<DateTime>> getWeeksForRange(DateTime start, DateTime end) {
    List<List<DateTime>> result = [];

    var date = start;
    List<DateTime> week = [];

    while (date.difference(end).inDays <= 0) {
      // start new week on Monday
      if (date.weekday == 1 && week.length > 0) {
        print('Date $date is a Monday');
        result.add(week);
        // List<DateTime> week = [];
      }
      week.add(date);
      date = date.add(const Duration(days: 1));
    }

    result.add(week);

    return result;
  }

  // Function to get the week number for a given date
  int getWeekNumber(DateTime date) {
    DateTime janFirst = DateTime(date.year, 1, 1);
    int days = date.difference(janFirst).inDays;
    return ((days - date.weekday + 10) / 7).floor();
  }

  // Function to get the day name for a given date
  String getDayName(DateTime date) {
    List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
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
}
