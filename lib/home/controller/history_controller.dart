import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/models/roster_history_response_model.dart';
import 'package:zob/services/api_services.dart';

class HistoryScreenController extends GetxController {
  var userName = "".obs;
  var userID = 0.obs;
  var rosterHistoryList = <HistoryDate>[].obs;
  var historyLoader = false.obs;
  @override
  void onInit() {
    getUserId();
    super.onInit();
  }

  getUserId() async {
    userName.value = await SharePref().getUserName();
    userID.value = await SharePref().getUserId();
  }

  getRosterHistory() async {
    var userId = await SharePref().getUserId();
    var getSelectRosterShiftLocationid =
        await SharePref().getSelectRosterShiftLocationid();
    debugPrint("user id : $userId");
    historyLoader.value = true;
    return Api.getRosterHistoryListApi(
            userId: userId.toString(),
            locationID: getSelectRosterShiftLocationid)
        .then((response) {
      try {
        if (response != null) {
          log("Check history response : $response");
          debugPrint("Check Hostory data : $response");
          historyLoader.value = false;
          RosterHistoryResponseModel historyResponseModel =
              RosterHistoryResponseModel.fromJson(response);
          if (historyResponseModel.success == true) {
            rosterHistoryList.value = historyResponseModel.data?.data ?? [];
            debugPrint("History data : ${historyResponseModel.data?.data}");
          }
        } else {
          historyLoader.value = false;
        }
      } catch (e) {
        historyLoader.value = false;
        debugPrint("Roster history response error : $e");
      }
    });
  }
}
