import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/models/get_roster_screen_location_response_model.dart';
import 'package:zob/models/roster_screen_response_model.dart';
import 'package:zob/models/weekly_roster_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/global_helper.dart';

class RosterScreenController extends GetxController {
  var selectRosterTypeValue = "Current Roster".obs;
  var selectRosterTypeList =
      ["Current Roster", "Upcoming Roster", "Past Roster"].obs;
  var isSelectRoster = false.obs;
  var userLocation = "".obs;
  var userName = "".obs;
  var isWeeklyShow = false.obs;
  var selectWeeklyRosterId = 0.obs;
  var rosterListData = <RosterDataList>[].obs;
  var weeklyRosterListData = <WeeklyRosterDataList>[].obs;
  var locationListRosterScreenList = <LocationDataList>[].obs;
  var selectedShifLocationValue = "".obs;
  var isLoadingRosterDailyData = false.obs;
  var isSelectAcceptRejectStatus = false.obs;
  var rosterScreenShiftLocationLoader = false.obs;
  TextEditingController selectRejectReasonTextController =
      TextEditingController();
  var isAcceptRoster = false.obs;
  var isRejectRoster = false.obs;
  var setRejectRosterIdList = <String>[].obs;
  var setAcceptRosterIdList = <String>[].obs;
  var isPastRoster = false.obs;
  var selectLocationId = 0.obs;
  var isRatingLoader = false.obs;

  @override
  void onInit() {
    geUserData();
    // addWeeklyData();
    super.onInit();
  }

  var rosterShifRating = [
    AppImg.sadEmotion,
    AppImg.badMood,
    AppImg.sadFaceIcon,
    AppImg.happyFaceIcon,
    AppImg.smileIcon,
  ].obs;

  var rosterShiftRatingArray = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.green
  ].obs;

  var selectBreakTimeList = ["10", "15", "20", "30", "45", "60", "Custom"].obs;
  var rejectRosterList =
      ["Not available", "Feeling sick", "Urgent work", "Other"].obs;
  var isSelectBreak = "".obs;
  var selectMealBrackRadio = 0.obs;
  var selectRejectRosterValue = "".obs;
  TimeOfDay selectedTime = TimeOfDay.now();
  var breakStartTime = "".obs;
  var breakEndTime = "".obs;
  // var userId = 0.obs;

  checkLoginStatus() async {
    var checkLoginStatusApi = await MySingleton().checkMyLoginStatus();
    debugPrint("Check login status : ${checkLoginStatusApi}");
    if (checkLoginStatusApi == 1) {
      Get.offAll(LoginScreen());
      CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          title: "Oh snap!",
          message:
              "Sorry!, you can't login because you are logged in to another device.",
          snackBarType: ContentType.failure);
    }
  }

  geUserData() async {
    // userId.value = await SharePref().getUserId();
    userLocation.value = await SharePref().getUserCurrentLocation();
    userName.value = await SharePref().getUserName();
    debugPrint("Check user location : ${userName.value}");
  }

  Future<void> selectTime(BuildContext context, String selectBreackType) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      if (selectBreackType == "BreakStartTime") {
        breakStartTime.value = selectedTime.format(context);
      }
      if (selectBreackType == "BreakEndTime") {
        breakEndTime.value = selectedTime.format(context);
      }
    }
  }

  /// Select Date Picker
  Future<void> selectDate(BuildContext context) async {
    checkLoginStatus();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      debugPrint("select time : ${picked}");
    }
  }

  //// Get Roster Screen Data
  getRosterDailyaData({required String locationId}) async {
    checkLoginStatus();
    int userId = await SharePref().getUserId();
    rosterListData.clear();
    isLoadingRosterDailyData.value = true;
///// status = 1 => current, 2 => upcoming, 3 => past
    int status = 1;
    if (selectRosterTypeValue.value == "Current Roster") {
      isPastRoster.value = false;
      status = 1;
    } else if (selectRosterTypeValue.value == "Upcoming Roster") {
      isPastRoster.value = false;
      status = 2;
    } else if (selectRosterTypeValue.value == "Past Roster") {
      isPastRoster.value = true;
      status = 3;
    }

    debugPrint("Check status : $status, location id : $locationId, ");
    Api.getDailyRosterApi(locationId: locationId, status: status)
        .then((response) {
      debugPrint("Get roster 123 response : $response");

      if (response != null) {
        debugPrint("Get roster 12345 response : $response");
        RosterScreenResponseModel responseModel =
            RosterScreenResponseModel.fromJson(response);

        debugPrint("Get roster 1234 response : ${responseModel.success}");

        if (responseModel.success == true) {
          rosterListData.value = responseModel.data!;

          debugPrint("Roster Data daily : $rosterListData");
          /* isAcceptRoster.value =
                rosterDailyData.isAccepted == 1 ? true : false; */
        }
        isLoadingRosterDailyData.value = false;
      } else {
        isLoadingRosterDailyData.value = false;
      }
    });
  }

  /// Get Weekly Roster Data
  getWeeklyRosterData({required String locationId}) async {
    checkLoginStatus();
    int userId = await SharePref().getUserId();
    weeklyRosterListData.clear();
    isLoadingRosterDailyData.value = true;

    ///// status = 1 => current, 2 => upcoming, 3 => past
    int status = 1;
    if (selectRosterTypeValue.value == "Current Roster") {
      isPastRoster.value = false;
      status = 1;
    } else if (selectRosterTypeValue.value == "Upcoming Roster") {
      isPastRoster.value = false;
      status = 2;
    } else if (selectRosterTypeValue.value == "Past Roster") {
      isPastRoster.value = true;
      status = 3;
    }
    Api.getWeeklyRosterApi(
            userId: userId.toString(), locationId: locationId, status: status)
        .then((response) {
      debugPrint("Get roster weekly response : $response");
      if (response != null) {
        RosterScreenWeeklyRosterResponseModel weeklyRosterResponseModel =
            RosterScreenWeeklyRosterResponseModel.fromJson(response);
        try {
          if (weeklyRosterResponseModel.success == true) {
            weeklyRosterListData.value =
                weeklyRosterResponseModel.data ?? [];
            debugPrint("Roster Data Weekly : ${weeklyRosterListData.value}");
            List<bool> temp = weeklyRosterListData
                .map((element) => element.isAccepted == 1)
                .toList();
            debugPrint(
                "check my blue : ${temp.contains(false)}, check list : ${temp}");
            if (temp.contains(true)) {
              debugPrint("Alerady accept");
            } else {
              debugPrint("Alerady not accept");
            }
          }

          isLoadingRosterDailyData.value = false;
        } catch (e) {
          isLoadingRosterDailyData.value = false;
          debugPrint("Roster Daily Get Data Error : $e");
        }
      }
    });
  }

  //// Accept Reject Api calling
  /// 1=Accept
  /// 2=Reject
  acceptNrejectApi(
      {required int acceptRejectStatus,
      required String rejectMessage,
      required int rostersId,
      required Function(bool status) callback,
      int? selectIndex}) async {
    checkLoginStatus();
    // int userId = await SharePref().getUserId();

    isSelectAcceptRejectStatus.value = true;
    String rosterIdAccept = "";
    // String rosterIdReject = "";
    if (setAcceptRosterIdList.isNotEmpty) {
      rosterIdAccept = setAcceptRosterIdList
          .reduce((value, element) => value + ',' + element);

      print("Accept RosterId : $rosterIdAccept");
    } else {
      rosterIdAccept = rostersId.toString();
    }

    if (setRejectRosterIdList.isNotEmpty) {
      rosterIdAccept = setAcceptRosterIdList
          .reduce((value, element) => value + ',' + element);

      print("Reject RosterId : $rosterIdAccept");
    } else {
      rosterIdAccept = rostersId.toString();
    }

    return Api.acceptOrRejectShift(
            rosterId: int.parse(rosterIdAccept),
            isAccept: acceptRejectStatus,
            rejectMessage: rejectMessage)
        .then((response) {
      debugPrint("Accept Roster : $response");
      if (response != null) {
        if (response['success'] == true) {
          setAcceptRosterIdList.clear();
          setRejectRosterIdList.clear();
          SharePref().setAcceptRoster(setAcceptRoster: true);

          if (acceptRejectStatus == 1) {
            /// Is Accept
            rosterListData[selectIndex ?? 0].isAcceptRoster.value = true;
            isAcceptRoster.value = true;
          } else {
            //! Id Reject
            rosterListData[selectIndex ?? 0].isRejectRoster.value = true;
            isRejectRoster.value = false;
          }

          callback(true);

          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Well done!",
              message: response['message'],
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(Get.context!)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          selectRejectReasonTextController.clear();

          Get.back();
        } else {
          isSelectAcceptRejectStatus.value = false;
          callback(false);
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Oh Snap!",
              message: response['message'],
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(Get.context!)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          Get.back();
        }
      }
    });
  }

  //// Get Roster Screen Location List Api
  getRosterScreenShiftLocationList(
      {required Function(bool status) callback}) async {
    checkLoginStatus();
    rosterScreenShiftLocationLoader.value = true;
    var userID = await SharePref().getUserId();
    locationListRosterScreenList.value = [];
    return Api.getRosterScreenLocationListApi(userId: userID.toString())
        .then((response) {
      debugPrint("Roster Screen Location List Api : $response");
      if (response != null) {
        if((response['data'] is List) && response['data'].isEmpty){
          log("Roster Screen Location List Api : ${response['message']}");
          rosterScreenShiftLocationLoader.value = false;
          callback(false);
          return;
        }
        GetRosterScreenLocationResponseModel responseData =
            GetRosterScreenLocationResponseModel.fromJson(response);
        if (responseData.success == true) {
          locationListRosterScreenList.value = responseData.data ?? [];
          selectedShifLocationValue.value =
              locationListRosterScreenList.first.locationName ?? "";
          debugPrint(
              "Roster Screen Location Data : ${selectedShifLocationValue.value}");
          if (locationListRosterScreenList.isNotEmpty) {
            selectLocationId.value = locationListRosterScreenList.first.id ?? 0;
            getRosterDailyaData(
              locationId: locationListRosterScreenList.first.id.toString(),
            );
            getWeeklyRosterData(
                locationId: locationListRosterScreenList.first.id.toString());
          }

          rosterScreenShiftLocationLoader.value = false;
        }
      }
    });
  }

  //// Submit roster Api call
  rosterRatingApicall(
      {required String rosterID, required String rating}) async {
    checkLoginStatus();
    var userId = await SharePref().getUserId();
    return Api.rosterRatingApi(
            userId: userId.toString(), rosterId: rosterID, rating: rating)
        .then(
      (response) async {
        if (response != null) {
          debugPrint("Check clockout : $response");
          if (response['success'] == true) {
            isRatingLoader.value = false;
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: "Well done!",
                message: response['message'],
                contentType: ContentType.success,
              ),
            );
            ScaffoldMessenger.of(Get.context!)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: "Oh Snap!",
                message: response['message'],
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(Get.context!)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);

            isRatingLoader.value = false;
            // SnackBarWidget().snackBar(message: response['message'] ?? "");
          }
        }
      },
    );
  }
}

class SelectWeeklyData {
  String rotasDate;
  String day;
  String startTime;
  String endTime;
  RxInt accept;
  RxInt reject;
  SelectWeeklyData({
    required this.rotasDate,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.accept,
    required this.reject,
  });
}
