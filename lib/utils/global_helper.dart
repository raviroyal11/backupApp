import 'package:flutter/material.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/services/api_services.dart';

class MySingleton {
  MySingleton._privateConstructor();

  static final MySingleton _instance = MySingleton._privateConstructor();

  factory MySingleton() {
    return _instance;
  }

  Future<int> checkMyLoginStatus() async {
    /* int? loginStatus;
    var userId = await SharePref().getUserId();
    debugPrint("check my response : $userId");
    await Api.getLoginStatusCheckApi(userId: userId.toString())
        .then((response) {
      debugPrint("check my response : $response");
      if (response != null) {
        if (response['success'] == true) {
          loginStatus = response['data']['login_status'];
          debugPrint("check my login status : $loginStatus");
        }
      }
    }); 
    return loginStatus ?? 0;*/
    return 0;
  }
}
