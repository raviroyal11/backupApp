import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/local_store/shar_pref.dart';
import 'package:zob/models/get_country_list_response_model.dart';
import 'package:zob/models/update_profile_response_model.dart';
import 'package:zob/services/api_services.dart';
import 'package:zob/widget/snack_bar_widget.dart';

class ProfileDetailsScreenController extends GetxController {
  var isVisiblePassword = false.obs;
  var isGetCountryLoading = false.obs;
  var isUpdateProfileLoading = false.obs;
  var dropdownvalue = ''.obs;
  var selectedDobDate = "".obs;
  var userId = 0.obs;
  var isSelectPersonalDetails = true.obs;
  var isSelectEmployeeDetails = false.obs;
  var selectGenderValue = "Male".obs;
  var selectEmployeeTypeValue = "Full Time".obs;
  var selectEmployeeDocument = "".obs;
  var selectPersonalDocument = "".obs;

  var getCountryList = <CountryData>[].obs;
  var genderDropdown = ["Male", "Female", "Other"].obs;
  var selectEmployeeTypeDropdown = [
    "Full Time",
    "Part Time",
    "Fixed Time",
    "Casual",
    "Apprentice/Trainee",
    "Agency",
    "Contractor/Freelancer",
    "Temporary"
  ].obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void onInit() {
    getCountryListApiCall();
    getUserID();
    super.onInit();
  }

  getUserID() async {
    userId.value = await SharePref().getUserId();
    String email = await SharePref().getUserEmail();
    String name = await SharePref().getUserName();
    selectedDobDate.value = await SharePref().getUserDOB();
    String mobile = await SharePref().getUserMobile();
    emailController = TextEditingController(text: email);
    nameController = TextEditingController(text: name);
    mobileController = TextEditingController(text: mobile);
  }

  /// Get Country List Api Call
  getCountryListApiCall() {
    isGetCountryLoading.value = true;
    return Api.getCountryListApi().then((response) {
      if (response != null) {
        GetCountryListResponseModel countryListResponse =
            GetCountryListResponseModel.fromJson(response);

        if (countryListResponse.success == true) {
          dropdownvalue.value = countryListResponse.data?.first.name ?? "";
          getCountryList.addAll(countryListResponse.data ?? []);
          isGetCountryLoading.value = false;
          debugPrint("Country List api = : ${dropdownvalue.value}");
        } else {
          isGetCountryLoading.value = false;
        }
      }
    });
  }

  /// Select Date Of Birth
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDobDate) {
      selectedDobDate.value = DateFormat("dd-MM-yyyy").format(picked);
      debugPrint("select time : ${selectedDobDate.value}");
    }
  }

  //// document selection
  selectDocument({required bool isEmployeeSelectDocument}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (isEmployeeSelectDocument) {
      if (result != null) {
        selectEmployeeDocument.value = result.files.single.path ?? "";
        debugPrint("Selectd File : ${selectEmployeeDocument.value}");
      }
    } else {
      if (result != null) {
        selectPersonalDocument.value = result.files.single.path ?? "";
        debugPrint("Select File : ${selectPersonalDocument}");
      }
    }
  }
}
