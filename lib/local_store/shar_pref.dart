import 'package:shared_preferences/shared_preferences.dart';

class SharePref {

  /// Set access token
  setAccessToken({required String accessToken}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);}

  // Get access token
  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    return accessToken ?? "";
  }

  /// Set User Id
  setUserId({required int userID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userID', userID);
  }

  // Get User Id
  Future<int> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userID");
    return userId ?? 0;
  }

  /// Set Login
  setLogin({required bool setLogin}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setLogin', setLogin);
  }

  // Get Login status
  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? login = prefs.getBool("setLogin");
    return login ?? false;
  }

  /// Set Login
  setUserName({required String setUserName}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setUserName', setUserName);
  }

  // Get Login status
  Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("setUserName");
    return name ?? "";
  }

  /// Set Email
  setUserEmail({required String setUserEmail}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setUserEmail', setUserEmail);
  }

  // Get Email
  Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("setUserEmail");
    return email ?? "";
  }

  /// Set Email
  setUserDOB({required String setUserDOB}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setUserDOB', setUserDOB);
  }

  // Get Email
  Future<String> getUserDOB() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("setUserDOB");
    return email ?? "";
  }

  /// Set Email
  setUserMobile({required String setUserMobile}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setUserMobile', setUserMobile);
  }

  // Get Email
  Future<String> getUserMobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("setUserMobile");
    return email ?? "";
  }

  /// Set Location
  setUserCurrentLocation({required String setUserCurrentLocation}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setUserCurrentLocation', setUserCurrentLocation);
  }

  // Get Email
  Future<String> getUserCurrentLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("setUserCurrentLocation");
    return email ?? "";
  }

  /// Set CheckIn
  setCheckInOutStatus({required bool setCheckInOutStatus}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setCheckInOutStatus', setCheckInOutStatus);
  }

  // Get CheckIn
  Future<bool> getCheckInOutStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? checkInOutStatus = prefs.getBool("setCheckInOutStatus");
    return checkInOutStatus ?? false;
  }

  /// Remove Check in
  Future removeCheckInOutStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("setCheckInOutStatus");
  }

  /// Set Break
  setBreackInOutStatus({required bool setBreackInOutStatus}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setBreackInOutStatus', setBreackInOutStatus);
  }

  // Get Break
  Future<bool> getBreackInOutStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? breackInOutStatus = prefs.getBool("setBreackInOutStatus");
    return breackInOutStatus ?? false;
  }

  /// Remove Breack
  Future removeBreackInOutStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("setBreackInOutStatus");
  }

  /// Set Check In
  setCheckInResponse({required String setCheckInResponseId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setCheckInResponseId', setCheckInResponseId);
  }

  // Get Check In
  Future<String> getCheckInResponse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? breackInOutStatus = prefs.getString("setCheckInResponseId");
    return breackInOutStatus ?? "";
  }

  //// Set barcode scan data
  setBarcodeResponse({required String setBarcodeResponse}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setCheckInResponseId', setBarcodeResponse);
  }

  // Get Check In
  Future<String> getBarcodeResponse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? breackInOutStatus = prefs.getString("setCheckInResponseId");
    return breackInOutStatus ?? "";
  }

  /// Set Accept n Reject Shift Status
  setAcceptnRejectShiftStatus({required bool shiftAcceptnRejectStatus}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('shiftAcceptnRejectStatus', shiftAcceptnRejectStatus);
  }

  // Get Accept n Reject Shift Status
  Future<bool> getAcceptnRejectShiftStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? breackInOutStatus = prefs.getBool("shiftAcceptnRejectStatus");
    return breackInOutStatus ?? false;
  }

  /// Set Select Roster Shift Locationid
  setSelectRosterShiftLocationid(
      {required String selectRosterShiftLocationid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'setSelectRosterShiftLocationi', selectRosterShiftLocationid);
  }

  // Get Select Roster Shift Locationid
  Future<String> getSelectRosterShiftLocationid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getSelectRosterShiftLocationid =
        prefs.getString("setSelectRosterShiftLocationi");
    return getSelectRosterShiftLocationid ?? "";
  }

  //// IsAccept Roster status
  setAcceptRoster({required bool setAcceptRoster}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setAcceptRoster', setAcceptRoster);
  }

  //// Get Accept Roster
  Future<bool> getAcceptRoster() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? getAcceptRoster = prefs.getBool("setAcceptRoster");
    return getAcceptRoster ?? false;
  }

  //// set Reject Roster status
  setRejectRoster({required bool setRejectRoster}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setRejectRoster', setRejectRoster);
  }

  //// Get Reject Roster
  Future<bool> getRejectRoster() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? getRejectRoster = prefs.getBool("setRejectRoster");
    return getRejectRoster ?? false;
  }

  //// set clock in time
  setClockinTime({required String setClockInTime}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setClockInTime', setClockInTime);
  }

  // Get Clock In Time
  Future<String> getClockInTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getClockInTime = prefs.getString("setClockInTime");
    return getClockInTime ?? "";
  }

  //// set profile pic
  setProfilePic({required String setProfilePic}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setProfilePic', setProfilePic);
  }

  // Get profile pic
  Future<String> getProfilePic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getProfilePic = prefs.getString("setProfilePic");
    return getProfilePic ?? "";
  }

  //// set profile pic
  isClockinByQr({required bool isClockinByQr}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isClockinByQr', isClockinByQr);
  }

  // Get profile pic
  Future<bool> getisClockinByQr() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? getProfilePic = prefs.getBool("isClockinByQr");
    return getProfilePic ?? false;
  }

  //// set profile pic
  isClockinByMap({required bool isClockinByMap}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isClockinByMap', isClockinByMap);
  }

  // Get profile pic
  Future<bool> getisClockinByMap() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? getProfilePic = prefs.getBool("isClockinByMap");
    return getProfilePic ?? false;
  }

  /// Store clock in Id
  setClockInID({required String setClockInId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('setClockinId', setClockInId);
  }

  // Get profile pic
  Future<String> getClockInID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getClockInId = prefs.getString("setClockinId");
    return getClockInId ?? "";
  }
}
