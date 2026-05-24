import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/clockIn/success_message_screen.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/models/get_user_job_location_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/global_helper.dart';

class MapScreenController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoadingMap = false.obs;
  var isSelectMapTab = true.obs;
  var ischeckIn = false.obs;
  Set<Marker> markers = Set<Marker>();
  var address = "".obs;
  var isLoading = false.obs;
  var isClockinByQr = false.obs;
  var isClockinByMap = false.obs;

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  checkLoginStatus() async {
    var checkLoginStatusApi = await MySingleton().checkMyLoginStatus();
    debugPrint("Check login status : ${checkLoginStatusApi}");
    if (checkLoginStatusApi == 1) {
      Get.offAll(LoginScreen());
    }
  }

  getCurrentLocation() async {
    isLoadingMap.value = true;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude.value = position.latitude;
    longitude.value = position.longitude;

    debugPrint("Check data");
    isLoadingMap.value = false;
  }

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  /// Get lat long to address name
  getLatLongToAddress(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    address.value =
        "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

    debugPrint("Check lat long : address : $address");
  }

  ///// Get User Job Location Api
  getUserJobLocationData(
      {required int getUserClockInOutStatus,
      required String mapTapLocationLati,
      required String mapTapLocationLongi,
      required String location,
      Function(bool status)? callback}) async {
    checkLoginStatus();
    var userId = await SharePref().getUserId();
    String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    debugPrint("CurrentDate : $currentDate, user Id : $userId");
    return Api.getUserJobLocationApi(
            userId: userId.toString(), currentDate: currentDate.toString())
        .then((response) {
      debugPrint("Get status response : $response");
      if (response != null) {
        debugPrint("Get status response 1 : $response");
        GetUserJobLocationResponseModel responseModel =
            GetUserJobLocationResponseModel.fromJson(response);
        if (responseModel.success == true) {
          debugPrint("Get status response 2 : $response");
          String latitude =
              responseModel.data?.locationdetails?.latitude ?? "0.0";
          String longitude =
              responseModel.data?.locationdetails?.longitude ?? "0.0";
          String locationID =
              responseModel.data?.locationdetails?.id.toString() ?? "0";
          if (getUserClockInOutStatus == 0) {
            debugPrint("Get status response 3 : $response");

            ///  Clock in By Map api call
            debugPrint("Startt work");
            userClockInByMapApiCall(
              userID: userId.toString(),
              locationId: locationID,
              locationLati: latitude.toString(),
              locationLongi: longitude.toString(),
              tapingLati: mapTapLocationLati.toString(),
              tapingLongi: mapTapLocationLongi.toString(),
              callback: (status) {
                callback!(status);
              },
            );
          } else {
            ///  Clock out By Map api call
            userClockOutByMapApiCall(
              userID: userId.toString(),
              locationLati: latitude,
              locationId: locationID,
              locationLongi: longitude,
              tapingLati: mapTapLocationLati,
              location: location,
              tapingLongi: mapTapLocationLongi,
              callback: (status) {
                callback!(status);
              },
            );
          }
        }
      } else {
        debugPrint("Get user location api response null");
      }
    });
  }

  //// Get user Clock in using map
  userClockInByMapApiCall(
      {String? locationLati,
      String? locationLongi,
      String? tapingLati,
      String? tapingLongi,
      String? userID,
      required String locationId,
      Function(bool status)? callback}) async {
    checkLoginStatus();
    isLoading.value = true;
    debugPrint(
        "cuttern location : $locationLati, longi : $locationLati, tap lati : $tapingLati, taplongi $tapingLongi, userId : $userID");
    return Api.userClockInByMapApi(
      userId: userID.toString(),
      locationId: locationId,
      locatioLati: locationLati ?? "",
      locatioLongi: locationLongi ?? "",
      userLocatioLati: tapingLati.toString(),
      userLocatioLongi: tapingLongi.toString(),
    ).then(
      (response) {
        debugPrint("User By map clock in api : $response");
        isLoading.value = false;
        if (response['success'] == true) {
          debugPrint("Success clockin");
          isLoading.value = false;
          // clockInTime.value = DateFormat("HH:mm:ss").format(DateTime.now());
          // SharePref().setCheckInOutStatus(setCheckInOutStatus: true);
          String date = DateTime.now().toString();
          debugPrint("Check date : $date");
          SharePref().isClockinByMap(isClockinByMap: true);
          SharePref().setClockinTime(setClockInTime: date);
          SharePref().setClockInID(setClockInId: response['data']['clockInID'].toString());
          callback!(true);
          debugPrint("Chekc message : ${response['message']}");
          CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: "Well done!",
              message: response['message'],
              snackBarType: ContentType.success);
          // Get.back(result: true);
          // Get.back();
        } else {
          debugPrint("Not clockin");
          CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: "Oh snap!",
              message: response['message'],
              snackBarType: ContentType.failure);

          isLoading.value = false;
        }
        isLoading.value = false;
      },
    );
  }

  /// Clock Out Api Call
  userClockOutByMapApiCall({
    String? locationLati,
    String? locationLongi,
    String? tapingLati,
    String? tapingLongi,
    String? userID,
    String? location,
    required String locationId,
    Function(bool status)? callback,
  }) async {
    checkLoginStatus();
    var clockInTime = await SharePref().getClockInTime();
    isLoading.value = true;
    // debugPrint("Clock In Param = :$param");
    return Api.userClockOutByMapApi(
            userId: userID.toString(),
            locationId: locationId.toString(),
            locatioLati: locationLati.toString(),
            locatioLongi: locationLongi.toString(),
            userLocatioLati: tapingLati.toString(),
            userLocatioLongi: tapingLongi.toString())
        .then(
      (response) async {
        // isLoading.value = false;
        if (response != null) {
          debugPrint("Check clockout : $response");
          if (response['success'] == true) {
            isLoading.value = false;

            // clockOutTime.value = DateFormat("HH:mm:ss").format(DateTime.now());
            // clockInTime.value = await SharePref().getClockInTime();
            // SharePref().setCheckInOutStatus(setCheckInOutStatus: false);
            // isAceptRoster.value = await SharePref().getAcceptRoster();

            SharePref().isClockinByMap(isClockinByMap: false);
            SharePref().setClockInID(setClockInId: '');
            callback!(true);
            var clockOutTime = DateTime.now().toString();
            var totalHour = timeCalculation(
                enterFromTime: clockInTime, enterToTime: clockOutTime);
            Get.to(SuccessMessageScreen(
              totalHours: totalHour,
              location: location ?? "",
            ));
            // Get.back(result: true);
            // Get.back();
            debugPrint("Chekc message : ${response['message']}");

            // timeCalculation(
            //   enterFromTime: "$date ${clockInTime.value}",
            //   enterToTime: "$date ${clockOutTime.value}",
            // );
            SharePref().removeCheckInOutStatus();
            SharePref().setClockinTime(setClockInTime: "");
            // final snackBar = SnackBar(
            //   elevation: 0,
            //   behavior: SnackBarBehavior.floating,
            //   backgroundColor: Colors.transparent,
            //   content: AwesomeSnackbarContent(
            //     title: "Well done!",
            //     message: response['message'],
            //     contentType: ContentType.success,
            //   ),
            // );
            // ScaffoldMessenger.of(Get.context!)
            //   ..hideCurrentSnackBar()
            //   ..showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: "Oh Snap!",
                message: response['data'],
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(Get.context!)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
            isLoading.value = false;
            // SnackBarWidget().snackBar(message: response['message'] ?? "");
          }
        }
      },
    );
  }

  /// Time Calculation
  String timeCalculation(
      {required String enterFromTime, required String enterToTime}) {
    String totalHours = "";
    debugPrint("start time : $enterFromTime, end taime : $enterToTime");
    DateTime startTime = DateTime.parse(enterFromTime);
    DateTime endTime = DateTime.parse(enterToTime);
    Duration durationDifference = endTime.difference(startTime);

    int hours = durationDifference.inHours;
    int minutes = durationDifference.inMinutes.remainder(60);

    debugPrint("Diffrance time : $hours, min : $minutes");

    totalHours = "$hours:$minutes";
    /* DateTime fromTime = DateTime.parse(enterFromTime);
    DateTime toTime = DateTime.parse(enterToTime);

    // String timeString1 =
    //     "2023-10-06 15:30:00"; // Replace with your first time string
    // String timeString2 =
    //     "2023-10-06 16:45:10"; // Replace with your second time string

    // DateTime fromTime = DateTime.parse(timeString1);
    // DateTime toTime = DateTime.parse(timeString2);

    var convertSecond = toTime.difference(fromTime).inSeconds % 60;
    var convertMinute = toTime.difference(fromTime).inMinutes % 60;
    var convertHour = toTime.difference(fromTime).inHours;

    var second = "";
    var min = "";
    var hours = "";

    if (convertSecond < 60) {
      second = "${convertSecond.toString()} Seconds";
    } else if (convertMinute < 60) {
      min = "${convertMinute.toString()} Minutes";
    } else {
      hours = "${convertHour.toString()} Hours";
    }

    if ((second != "")) {
      totalHours = second;
    } else if ((min != "")) {
      totalHours = min;
    } else if ((hours != "")) {
      totalHours = hours;
    }

    // if (60 <= second) {
    //   totalHours.value = "$minute Minutes";
    // } else if (60 <= minute) {
    //   totalHours.value = "$hour Hours";
    // } else {
    //   totalHours.value = "$second Seconds";
    // }

    debugPrint(
        "Diffrance time : $second, min $min, hour : $hours, $totalHours"); */
    return totalHours;
  }
}
