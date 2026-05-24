import 'dart:convert';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/home/clockIn/success_message_screen.dart';
import 'package:zob/home/view/map_screen.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/models/barcode_scanner_response_model.dart';
import 'package:zob/models/clock_in_response_model.dart';
import 'package:zob/models/find_job_list_response.dart';
import 'package:zob/models/get_break_list_response_model.dart';
import 'package:zob/models/get_user_clock_in_out_re4sponse_model.dart';
import 'package:zob/models/get_user_job_location_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/global_helper.dart';

class DashboardScreenController extends GetxController {
  var clockInTime = "".obs;
  var clockOutTime = "".obs;
  var isClockInLoading = false.obs;
  var breackInOut = false.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var userId = 0.obs;
  var totalHours = "".obs;
  var userName = "".obs;
  var cityName = "".obs;
  var areaName = "".obs;
  var address = "".obs;
  var dateList = <DayWeekModel>[].obs;
  var isSelectJob = false.obs;
  var breakStart = false.obs;
  var breackHistoryList = <BreakListData>[].obs;
  var breackListApiLoader = false.obs;
  var isAceptRoster = false.obs;
  var isRejectRoster = false.obs;
  var getUserClockInOutStatusValue = 0.obs;
  var attendanceId = "".obs;
  var userApiLati = "".obs;
  var userApiLongi = "".obs;
  var isGetAcceptRosterStatus = false.obs;
  var checkLoginStatusApi = 0.obs;
  var jobListLoading = false.obs;
  var jobList = <JobData>[].obs;

  @override
  void onInit() {
    getCurrentLocationPermission();
    getCurrentLocation();
    getUserId();
    getCheckInStatus();
    getjobList();
    super.onInit();
  }

  getCheckInStatus() async {
    breakStart.value = await SharePref().getBreackInOutStatus();
  }

  checkLoginStatus() async {
    var checkLoginStatusApi = await MySingleton().checkMyLoginStatus();
    debugPrint("Check login status : ${checkLoginStatusApi}");
    if (checkLoginStatusApi == 1) {
      Get.offAll(LoginScreen());
    }
  }

/*   dayWeekListAdd() {
    DayWeekModel mo =
        DayWeekModel(date: "09/10", weekNm: "Mo", isSelect: false.obs);
    DayWeekModel tu =
        DayWeekModel(date: "10/10", weekNm: "Tu", isSelect: false.obs);
    DayWeekModel we =
        DayWeekModel(date: "11/10", weekNm: "We", isSelect: false.obs);
    DayWeekModel th =
        DayWeekModel(date: "12/10", weekNm: "Th", isSelect: false.obs);
    DayWeekModel fr =
        DayWeekModel(date: "13/10", weekNm: "Fr", isSelect: false.obs);
    DayWeekModel sa =
        DayWeekModel(date: "14/10", weekNm: "Sa", isSelect: false.obs);
    DayWeekModel su =
        DayWeekModel(date: "15/10", weekNm: "Su", isSelect: false.obs);
    DayWeekModel mo1 =
        DayWeekModel(date: "16/10", weekNm: "Mo", isSelect: false.obs);
    DayWeekModel tu1 =
        DayWeekModel(date: "17/10", weekNm: "Tu", isSelect: false.obs);
    DayWeekModel we1 =
        DayWeekModel(date: "18/10", weekNm: "We", isSelect: false.obs);
    DayWeekModel th1 =
        DayWeekModel(date: "19/10", weekNm: "Th", isSelect: false.obs);

    DayWeekModel fr1 =
        DayWeekModel(date: "20/10", weekNm: "Fr", isSelect: false.obs);
    DayWeekModel sa1 =
        DayWeekModel(date: "21/10", weekNm: "Sa", isSelect: false.obs);
    DayWeekModel su1 =
        DayWeekModel(date: "22/10", weekNm: "Su", isSelect: false.obs);
    dateList.add(mo);
    dateList.add(tu);
    dateList.add(we);
    dateList.add(th);
    dateList.add(fr);
    dateList.add(sa);
    dateList.add(su);
    dateList.add(mo1);
    dateList.add(tu1);
    dateList.add(we1);
    dateList.add(th1);
    dateList.add(fr1);
    dateList.add(sa1);
    dateList.add(su1);
  }
 */
  getUserId() async {
    userId.value = await SharePref().getUserId();
    userName.value = await SharePref().getUserName();

    debugPrint(
        "Check user name : ${userName.value}, User Id : ${userId.value}");
  }

  snackbar(title, DateTime time, Icon icon) {
    Get.snackbar(
      title,
      "${DateFormat("dd-MM-yyyy HH:mm a").format(time)}",
      colorText: Colors.white,
      backgroundColor: const Color.fromARGB(255, 101, 155, 199),
      icon: icon,
    );
  }

  /// Get Current Location Permission
  getCurrentLocationPermission() async {
    bool serviceEnabled;
    LocationPermission? permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  /// Get Current Location
  Future<void> getCurrentLocation() async {
    debugPrint("check hello ");
    // final permissin = await getCurrentLocationPermission();
    // if (!permissin) {
    //   return;
    // }

    /* await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      await placemarkFromCoordinates(position.latitude, position.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];

        var _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

        debugPrint("check my address : $_currentAddress");
      }).catchError((e) {
        debugPrint(e);
      });
    }); */

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint("check hello 1213 ${position.latitude}");

    latitude.value = position.latitude;
    longitude.value = position.longitude;

    print('Latitude: $latitude, Longitude: $longitude');

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude.value, longitude.value);
    Placemark place = placemarks[0];
    cityName.value = place.locality ?? "";
    areaName.value = place.subLocality ?? "";
    address.value =
        "${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

    SharePref().setUserCurrentLocation(
        setUserCurrentLocation: "${areaName.value} ${cityName.value}");

    debugPrint("Address : ${placemarks}");
  }

  /// Clock In Api Call
  clockInApiCall(
      {String? locationId,
      String? locationLati,
      String? locationLongi,
      required Function(bool status) callBack}) async {
    var date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    var time = DateFormat("HH:mm:ss").format(DateTime.now());
    checkLoginStatus();
    // bool getShifAceeptnRejectStatus =
    //     await SharePref().getAcceptnRejectShiftStatus();

    // Map<String, dynamic> param = {
    //   "user_id": userId.value,
    //   "location_id": locationId,
    //   "location_latitude": locationLati,
    //   "location_longitude": locationLongi,
    //   "user_latitude": latitude.value,
    //   "user_longitude": longitude.value
    // };
    isClockInLoading.value = true;
    // debugPrint("Clock In Param = :$param");
    if (isAceptRoster.value == true) {
      return Api.clockInApi(
              userId: userId.value.toString(),
              locationId: locationId ?? "",
              locatioLati: locationLati ?? "",
              locatioLongi: locationLongi ?? "",
              userLocatioLati: latitude.value.toString(),
              userLocatioLongi: longitude.value.toString())
          .then(
        (response) {
          debugPrint("Clock in clock in api : ${response}");
          if (response['success'] == true) {
            debugPrint("Success clockin");
            isClockInLoading.value = false;
            clockInTime.value = DateFormat("HH:mm:ss").format(DateTime.now());
            String dates = DateTime.now().toString();
            SharePref().setCheckInOutStatus(setCheckInOutStatus: true);
            SharePref().isClockinByQr(isClockinByQr: true);
            SharePref().setClockinTime(setClockInTime: dates);
            callBack(true);
            getUserClockInOutStatus();
            CommonSnackBarWidget().snackBarWidget(
                context: Get.context!,
                title: "Well done!",
                message: response['message'],
                snackBarType: ContentType.success);
            // Get.back();
          } else {
            debugPrint("Not clockin");

            callBack(false);
            CommonSnackBarWidget().snackBarWidget(
                context: Get.context!,
                title: "Oh snap!",
                message: response['message'],
                snackBarType: ContentType.failure);

            isClockInLoading.value = false;
          }
        },
      );
    } else {
      CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          title: "Oh Snap!",
          message: "Please accept shift first",
          snackBarType: ContentType.failure);
    }
  }

  /// Clock Out Api Call
  clockOutApiCall(
      {String? locationLati,
      String? locationLongi,
      String? location,
      required String locationId,
      required Function(bool status) callBack}) async {
    var date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    checkLoginStatus();
    // var time = DateFormat("HH:mm:ss").format(DateTime.now());

    String qrdata = await SharePref().getBarcodeResponse();
    Map<String, dynamic> param = json.decode(qrdata);
    var qrSaveData = BarcodeScannerResponseModel.fromJson(param);
    debugPrint("Loction : ${qrSaveData.locationLatitude}");
    isClockInLoading.value = true;
    // debugPrint("Clock In Param = :$param");
    return Api.clockOutApi(
            userId: userId.value.toString(),
            locationId: locationId ?? qrSaveData.locationId.toString(),
            locatioLati: locationLati ?? qrSaveData.locationLatitude,
            locatioLongi: locationLongi ?? qrSaveData.locationLongitude,
            userLocatioLati: latitude.value.toString(),
            userLocatioLongi: longitude.value.toString())
        .then(
      (response) async {
        if (response != null) {
          debugPrint("Check clockout : $response");
          if (response['success'] == true) {
            isClockInLoading.value = false;

            clockOutTime.value = DateFormat("HH:mm:ss").format(DateTime.now());
            clockInTime.value = await SharePref().getClockInTime();
            SharePref().isClockinByQr(isClockinByQr: false);
            SharePref().setCheckInOutStatus(setCheckInOutStatus: false);
            isAceptRoster.value = await SharePref().getAcceptRoster();
            // callBack(false);
            var clockOutTimes = DateTime.now().toString();
            var totalHour = timeCalculation(
                enterFromTime: clockInTime.value, enterToTime: clockOutTimes);
            debugPrint("check clockout total hours : $totalHours");
            Get.to(SuccessMessageScreen(
              totalHours: totalHour,
              location: location ?? "",
            ));
            SharePref().removeCheckInOutStatus();
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
            isClockInLoading.value = false;
            // SnackBarWidget().snackBar(message: response['message'] ?? "");
            isClockInLoading.value = false;
          }
          ClockInResponseModel clockOutResponseModel =
              ClockInResponseModel.fromJson(response);
          debugPrint(
              "Clock Out Param = :${clockOutResponseModel.success}, data : ${clockOutResponseModel.data}");
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
    return totalHours;
  }

  /// Breack in Api call
  breackInApi() async {
    checkLoginStatus();
    breackInOut.value = true;
    String locationLati = "";
    String locationLongi = "";
    String locationID = "";
    String clockinWithMap = "";

    String qrData = await SharePref().getBarcodeResponse();

    if (qrData != "") {
      Map<String, dynamic> barcodeQrData = json.decode(qrData);
      BarcodeScannerResponseModel barcodeScannerResponseModel =
          BarcodeScannerResponseModel.fromJson(barcodeQrData);
      locationLati = barcodeScannerResponseModel.locationLatitude;
      locationLongi = barcodeScannerResponseModel.locationLongitude;
      locationID = barcodeScannerResponseModel.locationId.toString();
      clockinWithMap = "";
    } else {
      locationID = attendanceId.value;
      locationLati = userApiLati.value;
      locationLongi = userApiLongi.value;
      clockinWithMap = "1";
    }

    String attendanceIds = await SharePref().getClockInID();

    log("Breack in api param : userId : ${userId.value.toString()}, attendanceId : ${attendanceIds}, clockinwithmap : ${clockinWithMap}, locatioLati : ${locationLati}, locatioLongi : ${locationLongi}, userLocatioLati : ${latitude.value.toString()}, userLocatioLongi : ${longitude.value.toString()}");

    return Api.employeeBreakInApi(
            userId: userId.value.toString(),
            attendanceId: attendanceIds,
            clockinwithmap: clockinWithMap,
            locatioLati: locationLati,
            locatioLongi: locationLongi,
            userLocatioLati: latitude.value.toString(),
            userLocatioLongi: longitude.value.toString())
        .then((response) {
      if (response != null) {
        breackInOut.value = false;
        if (response['success'] == true) {
          SharePref()
              .setBreackInOutStatus(setBreackInOutStatus: breakStart.value);
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
          getBreackListData();
        } else {
          breackInOut.value = false;
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
          // SnackBarWidget().snackBar(message: response['message'] ?? "");
        }
      }
    });
  }

  /// Breack Out Api call
  breackOutApi() async {
    checkLoginStatus();
    breackInOut.value = true;
    String locationLati = "";
    String locationLongi = "";
    String locationID = "";
    String clockinWithMap = "";
    String qrData = await SharePref().getBarcodeResponse();
    if (qrData != "") {
      Map<String, dynamic> barcodeQrData = json.decode(qrData);
      BarcodeScannerResponseModel barcodeScannerResponseModel =
          BarcodeScannerResponseModel.fromJson(barcodeQrData);
      locationLati = barcodeScannerResponseModel.locationLatitude;
      locationLongi = barcodeScannerResponseModel.locationLongitude;
      locationID = barcodeScannerResponseModel.locationId.toString();
      clockinWithMap = "";
    } else {
      locationID = attendanceId.value;
      locationLati = userApiLati.value;
      clockinWithMap = "1";
      locationLongi = userApiLongi.value;
    }

    return Api.employeeBreakOutApi(
            userId: userId.value.toString(),
            locationId: locationID,
            clockinwithmap: clockinWithMap,
            locatioLati: locationLati,
            locatioLongi: locationLongi,
            userLocatioLati: latitude.value.toString(),
            userLocatioLongi: longitude.value.toString())
        .then((response) {
      if (response != null) {
        if (response['success'] == true) {
          breackInOut.value = false;
          SharePref().removeBreackInOutStatus();
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
          getBreackListData();
        } else {
          breackInOut.value = false;
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

          // SnackBarWidget().snackBar(message: response['message'] ?? "");
        }
      }
    });
  }

  ///// Get Breack List api
  getBreackListData() async {
    checkLoginStatus();
    breackListApiLoader.value = true;

    var userID = await SharePref().getUserId();
    var qrCodeData = await SharePref().getBarcodeResponse();
    var attendanceIds = "";

    debugPrint("Check qr code data : $qrCodeData");
    if (qrCodeData != "") {
      Map<String, dynamic> qrResultMap = jsonDecode(qrCodeData);
      debugPrint("Atteandance ID : ${qrResultMap['location_id']}");
      attendanceIds = "${qrResultMap['location_id']}";
    } else {
      attendanceIds = attendanceId.value;
    }
    debugPrint("Attendance id : $attendanceIds");

    return Api.breackScreenHistoryListApi(
            userId: userID.toString(), attendanceId: attendanceIds.toString())
        .then((response) {
      debugPrint("Breack List api : ${response}");
      if (response != null) {
        BreackScreenHistroyListResponseModel responseModel =
            BreackScreenHistroyListResponseModel.fromJson(response);
        if (responseModel.success == true) {
          breackHistoryList.value = responseModel.data?.data ?? [];
          debugPrint("Breack List api : ${breackHistoryList}");
        }
        breackListApiLoader.value = false;
      } else {
        breackListApiLoader.value = false;
      }
    });
  }

  //// Get User Clock in Out Status
  getUserClockInOutStatus() {
    checkLoginStatus();
    Api.getUserClockInOutStatusApi(userId: userId.value.toString())
        .then((response) {
      if (response != null) {
        GetUserClockInOutApiResponeModel responseModel =
            GetUserClockInOutApiResponeModel.fromJson(response);
        debugPrint("Get User Clock In Out Status 2 : $response");
        if (responseModel.success == true) {
          /// isClockin = 0 ? show clockin : clockout
          getUserClockInOutStatusValue.value =
              responseModel.data;
          debugPrint(
              "Get User Clock In Out Status 1 : ${getUserClockInOutStatusValue.value}");
          if (getUserClockInOutStatusValue.value == 0) {
            debugPrint("Check Data ");
            SharePref().isClockinByQr(isClockinByQr: false);
            SharePref().isClockinByMap(isClockinByMap: false);
            SharePref().setClockinTime(setClockInTime: "");
            SharePref().setClockInID(setClockInId: '');
          }
          // else {
          //   debugPrint("Check Data 123");
          //   SharePref().setAcceptRoster(setAcceptRoster: true);
          // }
          debugPrint(
              "Get User Clock In Out Status : ${getUserClockInOutStatusValue.value}");
        }
      }
    });
  }

  //// get is Roster available or not
  getIsRosterAvailableStatus() async {
    checkLoginStatus();
    isGetAcceptRosterStatus.value = true;
    var userId = await SharePref().getUserId();

    return Api.isRosterAvailable(userId: userId.toString()).then((response) {
      log('Rostr response :::: ${response}');
      isGetAcceptRosterStatus.value = false;
      if (response != null) {
        if (response['success'] == true) {
          SharePref().setAcceptRoster(setAcceptRoster: true);
          isAceptRoster.value = true;
          Get.to(GoogleMapScreen());
          getUserClockInOutStatus();
        } else {
          SharePref().setAcceptRoster(setAcceptRoster: false);
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
          getUserClockInOutStatus();
        }
      }
    });
  }

  getUserLoctionUsingApi() async {
    checkLoginStatus();
    var userId = await SharePref().getUserId();
    String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
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
          attendanceId.value =
              "${responseModel.data?.locationdetails?.id ?? 0}";
          userApiLati.value =
              responseModel.data?.locationdetails?.latitude ?? "0.0";
          userApiLongi.value =
              responseModel.data?.locationdetails?.longitude ?? "0.0";
        }
      }
    });
  }

  //// Get Job list
  getjobList() async {
    jobListLoading.value = true;
    var userId = await SharePref().getUserId();
    log("My user Id L: $userId");
    Api.getJobListApi(userId: userId.toString()).then((response) {
      log("Check My api response : 1 $response");
      if (response != null) {
        JobListApiResponseModel responseModel =
            JobListApiResponseModel.fromJson(response);
        if (responseModel.success == true) {
          jobList.value = responseModel.data ?? [];
          jobListLoading.value = false;
        } else {
          jobListLoading.value = false;
        }
      } else {
        jobListLoading.value = false;
      }
    });
  }
}

class DayWeekModel {
  String date;
  String weekNm;
  RxBool isSelect;

  DayWeekModel(
      {required this.date, required this.weekNm, required this.isSelect});
}
