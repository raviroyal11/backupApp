import 'dart:developer';

import 'package:get/get.dart';
import 'package:zob/models/JobApplyListApiResponse.dart';
import 'package:zob/models/find_job_list_response.dart';
import 'package:zob/services/api_services.dart';

class JobScreenController extends GetxController {
  var jobList = <JobData>[].obs;
  var jobApplyList = <ApplyJob>[].obs;
  var isLoading = true.obs;

  //// Get Save Job List
  getSaveJobList(){
    return Api.getSaveJobListApi().then((response) {
      log("Check My Job Details api response : 1 $response");
       if (response != null) {
        JobListApiResponseModel responseModel =
            JobListApiResponseModel.fromJson(response);
        if (responseModel.success == true) {
          jobList.value = responseModel.data ?? [];
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    });
  }

  //// Get Apply Job List
  getApplyList(){
    isLoading.value = true;
    return Api.getApplyJobListApi().then((response) {
      log("Check My Job Details api response : 1 $response");
       if (response != null) {
        JobApplyListApiResponseModel responseModel =
            JobApplyListApiResponseModel.fromJson(response);
        if (responseModel.success == true) {
          jobApplyList.value = responseModel.data ?? [];
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    });
  }
  
}