import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/login/login_screen.dart';
import 'package:zob/utils/common_snackbar.dart';
import 'package:zob/utils/const.dart';

Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.acceptHeader: 'application/json',
};

class ApiClient {
  //// POST REQUEST
  Future<http.Response> post(
    String apiurl,
    dynamic body,
  ) async {
    final token = await SharePref().getAccessToken();
    log("API Token : $token");
    if (token != '') {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    final resp = await http.post(
      Uri.parse(apiurl),
      headers: headers,
      body: jsonEncode(body),
    );

    log('POST METHOD API $apiurl → Status: ${resp.statusCode}');
    log('POST METHOD API $apiurl → Body: ${resp.body}');

    // Rest of your error-handling logic (same as your existing code)...
    if (resp.statusCode == 401 || resp.statusCode == 302) {
      debugPrint("Token expired");
      SharePref().setLogin(setLogin: false);
      SharePref().setAccessToken(accessToken: "");
      CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          message: "Your session has expired, please login again.",
          snackBarType: ContentType.failure,
          title: "Token expired!");
      Get.offAll(LoginScreen());
    }
    return resp;
  }

  //// GET REQUEST
  Future<http.Response> get(String path, bool passToken) async {
    final token = await SharePref().getAccessToken();
    log('Using token: $token');

    if (token != '') {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    } else {
      headers[HttpHeaders.authorizationHeader] = '';
    }

    final response = await http.get(
      Uri.parse(path),
      headers: passToken ? headers : {},
    );

    log('GET METHOD API $path → Status: ${response.statusCode}');
    log('GET METHOD API $path → Body: ${response.body}');

    if (response.statusCode == 401 || response.statusCode == 302) {
      debugPrint("Token expired");
      SharePref().setLogin(setLogin: false);
      SharePref().setAccessToken(accessToken: "");
      CommonSnackBarWidget().snackBarWidget(
          context: Get.context!,
          message: "Your session has expired, please login again.",
          snackBarType: ContentType.failure,
          title: "Token expired!");
      Get.offAll(LoginScreen());
    }

    return response;
  }

  ///// Pass Multipart Request
  Future<http.StreamedResponse> postMultipart(
      String apiurl, Map<String, String> body, File file) async {
    final token = await SharePref().getAccessToken();
    log("API Token : $token");
    if (token != '') {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(apiurl),
    );

    request.headers.addAll(headers);

    request.fields.addAll(body);

    request.files.add(
      await http.MultipartFile.fromPath(
        'attachment',
        file.path,
      ),
    );

    return await request.send();
  }
}

class Api {
  /// Login Api Call
  static Future loginApi(Map<String, dynamic> parameter) {
    return http.post(Uri.parse(ApiUrl.staffLogin),
        body: jsonEncode(parameter),
        headers: {'Content-Type': 'application/json'}).then((response) {
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Login Error $error"));
  }

  ///// Staff Register Api Call
  static Future staffRegisterApi(Map<String, dynamic> parameter) {
    return http.post(Uri.parse(ApiUrl.staffRegister),
        body: jsonEncode(parameter),
        headers: {'Content-Type': 'application/json'}).then((response) {
      log("Staff Register Api response : ${response.statusCode} /////  ");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Staff Register Api Error $error"));
  }

  /// Clock In Api Call
  static Future clockInApi({
    required String userId,
    required String locationId,
    required String locatioLati,
    required String locatioLongi,
    required String userLocatioLati,
    required String userLocatioLongi,
  }) async {
    return ApiClient().post(ApiUrl.clockIn, {
      // "user_id": userId,
      "location_id": locationId,
      "location_latitude": locatioLati,
      "location_longitude": locatioLongi,
      "user_latitude": userLocatioLati,
      "user_longitude": userLocatioLongi
    }).then((response) {
      debugPrint(
          "Clock in id param : userId :$userId, location lati : $locatioLati, location longi : $locatioLongi, user location lati : $userLocatioLati, user location longi : $userLocatioLongi");
      debugPrint("Clock in response status code : ${response.statusCode}");
      return jsonDecode(response.body);
      // return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Clock In Api Error $error"));
  }

  /// Clock Out Api Call
  static Future clockOutApi({
    required String userId,
    required String locationId,
    required String locatioLati,
    required String locatioLongi,
    required String userLocatioLati,
    required String userLocatioLongi,
  }) {
    return ApiClient().post(ApiUrl.clockOut, {
      // "user_id": userId,
      // "location_id": locationId,
      "location_latitude": locatioLati,
      "location_longitude": locatioLongi,
      "user_latitude": userLocatioLati,
      "user_longitude": userLocatioLongi,
      // "type": "employee"
    }).then((response) {
      debugPrint("Check clock out code : ${response.statusCode}");
      debugPrint(
          "Clock out api : $userId, locationLAti : $locatioLati, locationLogi $locatioLongi, user lati $userLocatioLati, user longi $userLocatioLongi");
      return jsonDecode(response.body);
      // return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Clock Out Api Error $error"));
  }

  /// Get Country List Api Call
  static Future getCountryListApi() {
    return ApiClient().get(ApiUrl.getCountryList, false).then((response) {
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Country List Api Error $error"));
  }

  /// Update Profile Api Call
  static Future updateProfileApi(Map<String, dynamic> parameter) async {
    debugPrint("Update Profile Parameter : $parameter");
    String token = await SharePref().getAccessToken();
    return http.post(Uri.parse(ApiUrl.updateprofile),
        body: parameter,
        headers: {
          'Authorization': 'Bearer $token'
        }).then((response) {
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Update Profile Api Error $error"));
  }

  //// Get roster screen data
  static Future getDailyRosterApi(
      {required String locationId, required int status}) async {
    ///// status = 1 => current, 2 => upcoming, 3 => past
    debugPrint(
        "get daily roster api call user id  locationId :$locationId, status : $status");
    String token = await SharePref().getAccessToken();
    debugPrint("Token : $token");
    return http
        .post(
      headers: {'Authorization': 'Bearer $token'},
      Uri.parse(ApiUrl.getDailyRoster),
      body: {
        "current": status.toString(),
        "location_id": locationId.toString(),
      },
    )
        .then((response) {
      debugPrint("get daily roster api call response : ${response.statusCode}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError(
            (error) => debugPrint("Daily Rostrer Get Data Api Error : $error"));
  }

  //// Get Weekly roster data
  static Future getWeeklyRosterApi(
      {required String userId,
      required String locationId,
      required int status}) async {
    debugPrint(
        "get weekly roster api call user id : $userId, location id : $locationId, status : $status");
    ///// status = 1 => current, 2 => upcoming, 3 => past
    String token = await SharePref().getAccessToken();
    return http.post(
      Uri.parse(ApiUrl.getWeeklyRoster),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "current": status.toString(),
        "location_id": locationId.toString(),
      },
    ).then((response) {
      debugPrint("get weekly roster api call response : $response");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError(
        (error) => debugPrint("Weekly Rostrer Get Data Api Error : $error"));
  }

  //// Break in api call
  static Future employeeBreakInApi({
    required String userId,
    required String attendanceId,
    required String locatioLati,
    required String locatioLongi,
    required String userLocatioLati,
    required String userLocatioLongi,
    required String clockinwithmap,
  }) {
    var param = jsonEncode({
      // "user_id": userId,
      "attendance_id": attendanceId,
      // "clockin_with_map": clockinwithmap,
      "location_latitude": locatioLati,
      "location_longitude": locatioLongi,
      "user_latitude": userLocatioLati,
      "user_longitude": userLocatioLongi,
    });
    debugPrint("Breack in status : $param");
    return ApiClient().post(ApiUrl.breakIn, {
      "user_id": userId,
      "attendance_id": attendanceId,
      "clockin_with_map": clockinwithmap,
      "location_latitude": locatioLati,
      "location_longitude": locatioLongi,
      "user_latitude": userLocatioLati,
      "user_longitude": userLocatioLongi,
    }).then((response) {
      debugPrint("Response status code :::: ${response.statusCode}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Employee Break In Api Error $error"));
  }

  //// Breack out api call
  static Future employeeBreakOutApi({
    required String userId,
    required String locationId,
    required String locatioLati,
    required String locatioLongi,
    required String userLocatioLati,
    required String userLocatioLongi,
    required String clockinwithmap,
  }) {
    return ApiClient().post(ApiUrl.breakOut, {
      // "user_id": userId,
      "attendance_id": locationId,
      // "clockin_with_map": clockinwithmap,
      "location_latitude": locatioLati,
      "location_longitude": locatioLongi,
      "user_latitude": userLocatioLati,
      "user_longitude": userLocatioLongi,
    }).then((response) {
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Employee Break Out Api Error $error"));
  }

  //// Accept Or Reject shif
  static Future acceptOrRejectShift({
    required int rosterId,
    required int isAccept,
    required String rejectMessage,
  }) async {
    debugPrint("Parameter : $rosterId, $isAccept, $rejectMessage");

    Map<String, dynamic> acceptParam = {
      "roster_id": rosterId.toString(),
      "accept_flag": isAccept.toString(), //1=accept,2=reject
    };
    Map<String, dynamic> rejectParam = {
      "roster_id": rosterId.toString(),
      "accept_flag": isAccept.toString(), //1=accept,2=reject
      "reject_message": rejectMessage.toString()
    };

    return ApiClient()
        .post(ApiUrl.shiftAcceptOrReject,
            isAccept == 1 ? acceptParam : rejectParam)
        .then((response) {
      debugPrint("response status code : ${response.body}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError(
            (error) => debugPrint("Accept Reject Roster Api Error $error"));
  }

  //// Get Roster History list api
  static Future getRosterHistoryListApi(
      {required String userId, required String locationID}) {
    debugPrint("Check my location : $userId, location : $locationID");
    return http.get(Uri.parse("${ApiUrl.getRosterHistory}$userId"),
        headers: {'Content-Type': 'application/json'}).then((response) {
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError(
        (error) => debugPrint("Roster History List Api Error $error"));
  }

  //// Get Roster Screen Location list api
  static Future getRosterScreenLocationListApi({required String userId}) async {
    String token = await SharePref().getAccessToken();
    log("Roster Screen Location List Api token : $token");
    return ApiClient()
        .post(ApiUrl.getRosterScreenLocationList, {}).then((response) {
      debugPrint(
          "Roster Screen Location List Api response : ${response.statusCode}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) =>
            debugPrint("Roster Screen Shift Location List Api Error $error"));
  }

  //// Get Breack Screen History list api
  static Future breackScreenHistoryListApi(
      {required String userId, required String attendanceId}) {
    return ApiClient().post(ApiUrl.getBNreackScreenHistoryList,
        {'attendance_id': attendanceId}).then((response) {
      debugPrint(
          "Breack Screen History List Api response : ${response.statusCode}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) =>
        debugPrint("Roster Screen Shift Location List Api Error $error"));
  }

  //// Get User Clock in and Clock Out status
  static Future getUserClockInOutStatusApi({required String userId}) {
    debugPrint("Check roster id : $userId");
    return ApiClient()
        .post(ApiUrl.getUserCheckInOutStatus, {}).then((response) {
      return jsonDecode(response.body);
    });
  }

  //// Get User Job Location
  static Future getUserJobLocationApi(
      {required String userId, required String currentDate}) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return ApiClient()
        .post(ApiUrl.getUserJobLocation, {'date': date}).then((response) {
      debugPrint(
          "Chek job location data : ${jsonDecode(response.body)}, status code :${response.statusCode}");
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError(
            (error) => debugPrint("Get User Job Location Api Error $error"));
  }

  ///// User Clock in By Map api call
  static Future userClockInByMapApi({
    required String userId,
    required String locationId,
    required String locatioLati,
    required String locatioLongi,
    required String userLocatioLati,
    required String userLocatioLongi,
  }) async {
    log("Clock in by map api parameter : ${json.encode({
          "user_id": userId,
          "location_id": locationId,
          "location_latitude": locatioLati,
          "location_longitude": locatioLongi,
          "user_latitude": userLocatioLati,
          "user_longitude": userLocatioLongi
        })}");
    return ApiClient().post(ApiUrl.userClockInByMap, {
      "location_id": locationId,
      "location_latitude": locatioLati,
      "location_longitude": locatioLongi,
      "user_latitude": userLocatioLati,
      "user_longitude": userLocatioLongi
    }).then((response) {
      debugPrint("Check user Clock in by map code : ${response.statusCode}");
      debugPrint(
          "Check user Clock in by map out api : $userId, locationLAti : $locatioLati, locationLogi $locatioLongi, user lati $userLocatioLati, user longi $userLocatioLongi, location id : $locationId");
      return jsonDecode(response.body);
      // return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError(
        (error) => debugPrint("User clock in by google map Api Error $error"));
  }

  ///// User Clock out By Map api call
  static Future userClockOutByMapApi({
    required String userId,
    required String locationId,
    required String locatioLati,
    required String locatioLongi,
    required String userLocatioLati,
    required String userLocatioLongi,
  }) {
    log('Clock out param :::: ${{
      // "user_id": userId,
      "location_id": locationId,
      "location_latitude": locatioLati,
      "location_longitude": locatioLongi,
      "user_latitude": userLocatioLati,
      "user_longitude": userLocatioLongi,
      // "type": "employee"
    }}');
    return ApiClient().post(ApiUrl.userClockOutByMap, {
      // "user_id": userId,
      "location_id": locationId,
      "location_latitude": locatioLati,
      "location_longitude": locatioLongi,
      "user_latitude": userLocatioLati,
      "user_longitude": userLocatioLongi,
      // "type": "employee"
    }).then((response) {
      debugPrint("Check user Clock Out by map code : ${response.statusCode}");
      debugPrint(
          "Check user Clock Otu by map out api : $userId, locationLAti : $locatioLati, locationLogi $locatioLongi, user lati $userLocatioLati, user longi $userLocatioLongi");
      return jsonDecode(response.body);
      // return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError(
        (error) => debugPrint("User clock out by google map Api Error $error"));
  }

  ///// Forgot Password api call
  static Future forgotPasswordApi({
    required String email,
  }) {
    return http.post(Uri.parse(ApiUrl.forgotpassword),
        body: json.encode({
          "email": email,
        }),
        headers: {'Content-Type': 'application/json'}).then((response) {
      debugPrint("Check user Clock Out by map code : ${response.statusCode}");

      return jsonDecode(response.body);
      // return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Forgot PAssword Api Error $error"));
  }

  ///// Reset Password api call
  static Future resetPasswordApi({
    required String userId,
    required String currentPass,
    required String newPass,
  }) {
    return http.post(Uri.parse(ApiUrl.resetPassword),
        body: json.encode({
          "id": userId,
          "current_password": currentPass,
          "new_password": newPass
        }),
        headers: {'Content-Type': 'application/json'}).then((response) {
      debugPrint("Check user Clock Out by map code : ${response.statusCode}");

      return jsonDecode(response.body);
      // return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Forgot PAssword Api Error $error"));
  }

  ///// Submit Rating Password api call
  static Future rosterRatingApi({
    required String userId,
    required String rosterId,
    required String rating,
  }) {
    return ApiClient().post(ApiUrl.submitRating,
        {"roster_id": rosterId, "rating": rating}).then((response) {
      debugPrint("User rating status : ${response.statusCode}");

      return jsonDecode(response.body);
      // return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Forgot PAssword Api Error $error"));
  }

  //// Upload profile pic
  static Future uploadProfilePic(
      {required String userID,
      required String profilePath,
      required BuildContext context,
      required Function(bool status) callBack}) async {
    // var param = json.encode({"profile_logo": profilePath});

    callBack(true);
    // log("Parameter 1234 :$param");
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        ApiUrl.uploadProfilePic,
      ),
    );
    final token = await SharePref().getAccessToken();
    log("API Token : $token");
    if (token != '') {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    request.headers.addAll(headers);

    request.files.add(
      await http.MultipartFile.fromPath(
        'profile_logo',
        profilePath,
      ),
    );

    request.send().then(
      (response) async {
        if (response.statusCode == 200) {
          debugPrint("Profile pic upload path : $response");
          final res = await http.Response.fromStream(response);
          debugPrint("Profile pic upload path 1 : $res");
          debugPrint(res.body);

          var jsonResponse = json.decode(res.body);
          debugPrint(
              "Profile pic upload path 2 : ${jsonResponse['data']['profile_logo_url']}");
          SharePref().setProfilePic(
              setProfilePic: jsonResponse['data']['profile_logo_url']);
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Well done!",
              message: jsonResponse['message'],
              contentType: ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          callBack(false);
          Get.back(result: jsonResponse['data']['profile_image']);
        } else if (response.statusCode == 401 || response.statusCode == 302) {
          debugPrint("Token expired");
          SharePref().setLogin(setLogin: false);
          SharePref().setAccessToken(accessToken: "");
          CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              message: "Your session has expired, please login again.",
              snackBarType: ContentType.failure,
              title: "Token expired!");
          Get.offAll(LoginScreen());
        } else {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: "Oh Snap!",
              message: "Your profile picture not upload, Please try again!",
              contentType: ContentType.failure,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
          callBack(false);
        }
      },
    );
  }

  //// Check Accept reject roster data
  static Future isRosterAvailable({required String userId}) {
    return ApiClient().post(ApiUrl.isRosterAvilable, {}).then((response) {
      debugPrint("Check user Clock Out by map code : ${userId}");

      return jsonDecode(response.body);
      // return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Is Roster available $error"));
  }

  //// Get Login Status Check api
  static Future getLoginStatusCheckApi({required String userId}) {
    return ApiClient().post(ApiUrl.getClocinStatus, {}).then((response) {
      debugPrint("Chek Status Api data : status code :${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Chek Status Api $error"));
  }

  //// Get Time sheet api
  static Future getTimeSheetApi({required String userId}) {
    return ApiClient().post(ApiUrl.getTimeSheet, {}).then((response) {
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Chek Time Sheet Api $error"));
  }

  ///// Get Job list api
  static Future getJobListApi({required String userId}) {
    return ApiClient().get(ApiUrl.getJobList, false).then((response) {
      return response.statusCode == 200 ? jsonDecode(response.body) : null;
    }).catchError((error) => debugPrint("Chek Time Sheet Api $error"));
  }

  ///// Get Job details api
  static Future getJobDetaislApi({required String jobSlug}) {
    return ApiClient()
        .get(ApiUrl.getJobDetails + jobSlug, false)
        .then((response) {
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Chek Time Sheet Api $error"));
  }

  //// Quick Job Apply api
  static Future jobApplyApi({required String jobId}) {
    return ApiClient()
        .post(ApiUrl.jobApply, {'job_id': jobId}).then((response) {
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Chek Job Apply Api $error"));
  }

  //// Save Job api
  static Future jobSaveApi({required String jobId}) {
    return ApiClient()
        .post(ApiUrl.getSaveJobList, {'job_id': jobId}).then((response) {
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Chek Job Save Api $error"));
  }

  ///// Get Job details api
  static Future getSaveJobListApi() {
    return ApiClient().get(ApiUrl.getSaveJobList, true).then((response) {
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Get Save Job List Api $error"));
  }

  ///// Get Apply Job api
  static Future getApplyJobListApi() {
    return ApiClient().get(ApiUrl.getApplyJobList, true).then((response) {
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Get Save Job List Api $error"));
  }

  ///// Get Notification list api
  static Future getNotificatinListApi() {
    return ApiClient().get(ApiUrl.getNotification, true).then((response) {
      log("Check Notification List api response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Get Notificaiton List Api $error"));
  }

  //// View Notification api
  static Future viewNotificationApi({required String notificationId}) {
    return ApiClient()
        .get(ApiUrl.viewNotification + notificationId, true)
        .then((response) {
      log("Check view notification api response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("View Notification Api $error"));
  }

  //// View Applye Leave List api
  static Future applyLeaveListApi() {
    return ApiClient().post(ApiUrl.applyLeaveList, true).then((response) {
      log("Check view notification api response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("View Notification Api $error"));
  }

  //// View Available Leave List api
  static Future availableLeaveListApi() {
    return ApiClient().post(ApiUrl.availableLeaveList, true).then((response) {
      log("Check view notification api response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("View Notification Api $error"));
  }

  //// Apply For Leave api
  static Future applyForLeaveApi({required Map<String, dynamic> parameter}) {
    return ApiClient().post(ApiUrl.applyLeave, parameter).then((response) {
      log("Apply Leave Api Response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("Apply Leave Api $error"));
  }

  //// Apply incident form api
  static Future applyIncidentFormApi(
      {required Map<String, String> parameter, required File file}) {
    return ApiClient()
        .postMultipart(ApiUrl.incidentFormApi, parameter, file)
        .then((response) async {
      log("Apply Incident Form Api Response : ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        return null;
      }
    }).catchError((error) => debugPrint("Apply Incident Form Api $error"));
  }

  //// Apply incident form api with out file
  static Future applyIncidentFormWithoutMultipartApi(
      {required Map<String, String> parameter}) {
    return ApiClient().post(ApiUrl.incidentFormApi, parameter).then((response) {
      log("Apply Incident Form Api Response : ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    }).catchError((error) => debugPrint("Apply Incident Form Api $error"));
  }

  //// Apply Report form api
  static Future reportFormApi(
      {required Map<String, String> parameter, required File file}) {
    return ApiClient()
        .postMultipart(ApiUrl.reportFormApi, parameter, file)
        .then((response) async {
      log("Apply Report Form Api Response : ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(await response.stream.bytesToString());
      } else {
        return null;
      }
    }).catchError((error) => debugPrint("Apply Report Form Api $error"));
  }

  //// Apply incident form api with out file
  static Future applyReportFormWithoutMultipartApi(
      {required Map<String, String> parameter}) {
    return ApiClient().post(ApiUrl.reportFormApi, parameter).then((response) {
      log("Apply Report Form Api Response : ${response.statusCode}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    }).catchError((error) => debugPrint("Apply Report Form Api $error"));
  }

  //// Blog List Api api
  static Future blogListApi() {
    return ApiClient().get(ApiUrl.blogListApi, true).then((response) {
      log("Check view notification api response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("View Notification Api $error"));
  }

  //// Blog Details api
  static Future blogDetailsApis({required String blogSlug}) {
    return ApiClient()
        .get(ApiUrl.blogDetailsApi + blogSlug, true)
        .then((response) {
      log("Check view notification api response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("View Notification Api $error"));
  }

  //// News List api
  static Future newsApis() {
    return ApiClient().get(ApiUrl.newsListApi, true).then((response) {
      log("Check view notification api response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("View Notification Api $error"));
  }

  //// Get Me data api
  static Future getLoginUSerDetailsApis() {
    return ApiClient().get(ApiUrl.me, true).then((response) {
      log("Check view notification api response : ${response.statusCode}");
      return jsonDecode(response.body);
    }).catchError((error) => debugPrint("View Notification Api $error"));
  }
}
