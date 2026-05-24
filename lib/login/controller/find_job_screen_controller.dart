import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/models/find_job_list_response.dart';
import 'package:zob/models/jobSaveApiResponseModel.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/utils/common_snackbar.dart';

class FindJobScreenController extends GetxController {
  var selectJobTypeValue = "Current Jobs".obs;
  var jobList = <JobData>[].obs;
  var isLoading = false.obs;
  var isSaveJobLoading = false.obs;
  var selectIndex = 0.obs;

  var selectJobTypeList =
      ["Current Jobs", "Upcoming Jobs", "Completed Jobs"].obs;

  @override
  void onReady() {
    super.onReady();
    getjobList();
  }

  //// Get job list api call
  getjobList() async {
    isLoading.value = true;
    var userId = await SharePref().getUserId();
    log("My user Id L: $userId");
    Api.getJobListApi(userId: userId.toString()).then((response) {
      log("Check My api response : 1 $response");
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


  //// Save job api call
  saveJob({required String jobId}) async {
    isSaveJobLoading .value = true;
    var userId = await SharePref().getUserId();
    log("My user Id L: $userId");
    return Api.jobSaveApi(jobId: jobId).then((response) {
      log("Check My api response : 1 $response");
     if (response != null) {
        JobSaveApiResponseModel responseModel =
            JobSaveApiResponseModel.fromJson(response);
        if (responseModel.success == true) {
          CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: "Job Applied!",
              message: responseModel.message ?? "",
              snackBarType: ContentType.success);
          isSaveJobLoading.value = false;
        } else {
          CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: "Error!",
              message: responseModel.message ?? "",
              snackBarType: ContentType.failure);
          isSaveJobLoading.value = false;
        }
      } else {
        isSaveJobLoading.value = false;
      }
    });
  }
}
