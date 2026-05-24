import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/view/job_applied_dialog.dart';
import 'package:zob/models/job_apply_api_response_model.dart';
import 'package:zob/models/job_detail_api_response_model.dart';

import 'package:zob/services/api_services.dart';
import 'package:zob/utils/common_snackbar.dart';

class JobDetailScreenController extends GetxController {
  var isLoading = false.obs;
  var jobDetailsData = JobDetailsData().obs;
  var isJobApplyLoading = false.obs;

  //// Get job list api call
  getjobList({required String jobSlug}) async {
    isLoading.value = true;

    Api.getJobDetaislApi(jobSlug: jobSlug).then((response) {
      log("Check My Job Details api response : 1 $response");
      if (response != null) {
        JobDetailApiResponseModel responseModel =
            JobDetailApiResponseModel.fromJson(response);
        if (responseModel.success == true) {
          if (responseModel.data != null) {
            jobDetailsData.value = responseModel.data!;
            isLoading.value = false;
          }
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
      }
    });
  }

  //// Job Apply Api Call
  jobApply({required String jobId}) {
    log("Check My Job Apply api response : 1 $jobId");
    isJobApplyLoading.value = true;
    return Api.jobApplyApi(jobId: jobId).then((response) {
      if (response != null) {
        JobApplyApiResponseModel responseModel =
            JobApplyApiResponseModel.fromJson(response);
        isJobApplyLoading.value = false;
        if (responseModel.questionRequired == true) {
          if (responseModel.questions != null &&
              responseModel.questions!.isNotEmpty) {
            showDialog(
              context: Get.context!,
              builder: (_) => JobQuestionDialog(
                questions: responseModel.questions!,
                jobId: jobId,
              ),
            );
          } else {
            CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: "Error!",
              message: "Failed to apply for job",
              snackBarType: ContentType.failure,
            );
          }
        } else {
          if (response['success'] == true) {
            CommonSnackBarWidget().snackBarWidget(
              context: Get.context!,
              title: "Success!",
              message: response['message'] ?? "Applied for job successfully",
              snackBarType: ContentType.success,
            );
          } else {
            CommonSnackBarWidget().snackBarWidget(
                context: Get.context!,
                title: "Error!",
                message: "Failed to apply for job",
                snackBarType: ContentType.failure);
          }
          isJobApplyLoading.value = false;
        }
      } else {
        isJobApplyLoading.value = false;
      }
    });
  }
}
