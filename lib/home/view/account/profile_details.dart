import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zob/home/controller/account_screen_controller.dart';
import 'package:zob/home/controller/profile_details_screen_controller.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_images.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';

class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({super.key});

  final profileDetailsController = Get.put(ProfileDetailsScreenController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.white,
          title: Text(
            "Profile Details",
            style: AppStyle()
                .workSansSemiBold(context)
                .copyWith(fontSize: 20, color: AppColor.color4551),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              color: AppColor.color969D,
              height: 1.0,
            ),
          )),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          profileDetailsController
                              .isSelectPersonalDetails.value = true;
                          profileDetailsController
                              .isSelectEmployeeDetails.value = false;
                        },
                        child: Container(
                          height: height * 0.065,
                          width: width / 2.3,
                          decoration: BoxDecoration(
                            color: !profileDetailsController
                                    .isSelectPersonalDetails.value
                                ? const Color(0x66E7E8E9)
                                : AppColor.colorB3FF,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                width: profileDetailsController
                                        .isSelectPersonalDetails.value
                                    ? 0
                                    : 1.3,
                                color: AppColor.colorB5BA),
                          ),
                          child: Center(
                            child: Text(
                              "Personal Detail",
                              style: AppStyle()
                                  .workSansMedium(context)
                                  .copyWith(
                                      fontSize: 15,
                                      color: profileDetailsController
                                              .isSelectPersonalDetails.value
                                          ? Colors.white
                                          : AppColor.color969D),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          profileDetailsController
                              .isSelectPersonalDetails.value = false;
                          profileDetailsController
                              .isSelectEmployeeDetails.value = true;
                        },
                        child: Container(
                          height: height * 0.065,
                          width: width / 2.3,
                          decoration: BoxDecoration(
                            color: !profileDetailsController
                                    .isSelectEmployeeDetails.value
                                ? const Color(0x66E7E8E9)
                                : AppColor.colorB3FF,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                width: profileDetailsController
                                        .isSelectEmployeeDetails.value
                                    ? 0
                                    : 1.3,
                                color: AppColor.colorB5BA),
                          ),
                          child: Center(
                            child: Text(
                              "Employee Detail",
                              style: AppStyle()
                                  .workSansMedium(context)
                                  .copyWith(
                                      fontSize: 15,
                                      color: profileDetailsController
                                              .isSelectEmployeeDetails.value
                                          ? Colors.white
                                          : AppColor.color969D),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              profileDetailsController.isSelectPersonalDetails.value
                  ? PersonalDetailsScreenWidget(
                      height: height,
                      width: width,
                      profileDetailsController: profileDetailsController,
                    )
                  : EmployeeScreenWidget(
                      height: height,
                      width: width,
                      profileDetailsController: profileDetailsController,
                    )
            ],
          ),
        ),
      ),
    );
  }
}

//// Personal Detail Screen
class PersonalDetailsScreenWidget extends StatelessWidget {
  final double height;
  final double width;
  final ProfileDetailsScreenController profileDetailsController;
  const PersonalDetailsScreenWidget({
    super.key,
    required this.height,
    required this.width,
    required this.profileDetailsController,
  });

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountScreenController());
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Container(
                    height: height * 0.1,
                    width: height * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.color77DC, width: 1.5),
                      image: accountController.selectProfilePics.value != ""
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(accountController.selectProfilePics.value),
                              ),
                            )
                          : accountController.selectProfilePicsApi.value != ""
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(accountController
                                      .selectProfilePicsApi.value))
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(AppImg.manImg),
                                ),
                    ),
                  ),
                ),
                AppHelper().horizontalSpace(size: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile Picture",
                      style: AppStyle().workSansSemiBold(context).copyWith(
                            fontSize: 20,
                            color: AppColor.color4551,
                          ),
                    ),
                    SizedBox(
                      width: width * 0.6,
                      child: Text(
                        "Tap to change your profile images",
                        style: AppStyle().workSansMedium(context).copyWith(
                              fontSize: 15,
                              color: AppColor.color969D,
                            ),
                      ),
                    )
                  ],
                )
              ],
            ),
            AppHelper().verticalSpace(size: 16),
            //// Your Personal Data
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Basic",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            personalDataWidget(context: context),
            AppHelper().verticalSpace(size: 10),
            ///// Emargancy Contact Section
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Emergency Contact",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            emergencyContactWidget(context),
            /* Text(
              "Country :",
              style: AppStyle.workSansMedium.copyWith(
                fontSize: 18,
                color: const Color(0xFF83878E),
              ),
            ),
            AppHelper().verticalSpace(size: 09),
            Obx(
              () => profileDetailsController.isGetCountryLoading.value
                  ? Container(
                      height: height * 0.06,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColor.borderColor, width: 1.0)),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.color95ED,
                        ),
                      ),
                    )
                  : DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 2, left: 10, right: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColor.borderColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: profileDetailsController.dropdownvalue.value,
                      onChanged: (newValue) {
                        profileDetailsController.dropdownvalue.value =
                            newValue.toString();
                      },
                      items:
                          profileDetailsController.getCountryList.map((items) {
                        return DropdownMenuItem(
                          value: items.name,
                          child: Text(items.name),
                        );
                      }).toList(),
                    ),
            ),
            AppHelper().verticalSpace(size: 20),
            Text(
              "Email :",
              style: AppStyle.workSansMedium.copyWith(
                fontSize: 18,
                color: const Color(0xFF83878E),
              ),
            ),
            AppHelper().verticalSpace(size: 09),
            TextFormFieldWidget(
              height: height,
              width: width,
              controllerl: profileDetailsController.emailController,
              labelText: "Enter Your Email",
              hintText: 'Enter Your Email',
            ),
            AppHelper().verticalSpace(size: 20),
            Text(
              "Passwpord :",
              style: AppStyle.workSansMedium.copyWith(
                fontSize: 18,
                color: const Color(0xFF83878E),
              ),
            ),
            AppHelper().verticalSpace(size: 09),
            Obx(
              () => TextFormField(
                cursorColor: AppColor.color8EE9,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill details.';
                  }
                  return null;
                },
                controller: profileDetailsController.passwordController,
                obscureText: profileDetailsController.isVisiblePassword.value,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 2, left: 10),
                  labelText: "Password",
                  labelStyle: AppStyle.workSansMedium
                      .copyWith(color: AppColor.color4551, fontSize: 17),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColor.color77DC,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: AppColor.borderColor, width: 1.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      profileDetailsController.isVisiblePassword.value =
                          !profileDetailsController.isVisiblePassword.value;
                    },
                    icon: Icon(!profileDetailsController.isVisiblePassword.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  hintText: "Enter Your Password",
                  hintStyle: AppStyle.workSansMedium.copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
                ),
              ),
            ), */
            AppHelper().verticalSpace(size: 10),
            ///// Contact Details Section
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Contact Details",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            contactDetailsWidget(context),
            AppHelper().verticalSpace(size: 10),
            //// Work experiance 1
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Work Experience",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            workExperianceWidget(context),
            AppHelper().verticalSpace(size: 10),
            //// Upload Document
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Upload Documents",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            uploadDocumentsWidget(context),
            AppHelper().verticalSpace(size: 10),

            //// Education Details
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Education Details",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            educationWidget(context),
            AppHelper().verticalSpace(size: 10),

            //// Bank Details
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Bank Details",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            bankDetailsWidget(context),
            AppHelper().verticalSpace(size: 10),

            //// Bank Details
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Refernces",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            referncesWidget(context),
            AppHelper().verticalSpace(size: 10),

            //// Password Changes Widget
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Password",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            passwordChangeWidget(context),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Personal data widget
  Widget personalDataWidget({required BuildContext context}) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 09),
            Text(
              "First Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              hintText: "Enter Your First Name",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Middle Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              // controllerl: profileDetailsController.nameController,
              hintText: 'Enter Your Middle Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Last Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              // controllerl: profileDetailsController.nameController,

              hintText: 'Enter Your Last Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "DOB",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            Obx(
              () => InkWell(
                onTap: () {
                  profileDetailsController.selectDate(context);
                },
                child: Container(
                  height: height * 0.06,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(color: AppColor.borderColor, width: 1.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Text(
                      profileDetailsController.selectedDobDate.value,
                      style: AppStyle()
                          .workSansMedium(context)
                          .copyWith(color: AppColor.color4551, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Gender",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 2, left: 10, right: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: profileDetailsController.selectGenderValue.value,
              onChanged: (newValue) {
                profileDetailsController.selectGenderValue.value =
                    newValue.toString();
              },
              items: profileDetailsController.genderDropdown.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Emaergancy Contact widget
  Widget emergencyContactWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Emergency Contact Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              // controllerl: profileDetailsController.mobileController,

              hintText: 'Emergency Contact Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Emergency Contact Phone Number",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              hintText: 'Emergency Contact Phone Number',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Relationship to Employee",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              hintText: 'Relationship to Employee',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Contact Details Widget
  Widget contactDetailsWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Address",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Address',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "City",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'City',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Country",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Country',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Postal Code",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Postal Code',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Email",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Email',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Mobile No.",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Mobile No.',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Work Experiance Widget
  Widget workExperianceWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Company Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Company Name (Where you work before?)',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Contact Person",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Contact Person',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Position",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Position',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Email",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Email',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Phone/Mobile Number",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Phone/Mobile Number',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Address",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Address',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Your duties",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Your duties',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Upload Document Widget
  Widget uploadDocumentsWidget(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            AppHelper().verticalSpace(size: 10),
            InkWell(
              onTap: () {
                profileDetailsController.selectDocument(
                    isEmployeeSelectDocument: false);
              },
              child: Container(
                height: height * 0.22,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.borderColor, width: 2),
                ),
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.borderColor, width: 1),
                    ),
                    child:
                        profileDetailsController.selectEmployeeDocument.value !=
                                ""
                            ? Image.file(
                                File(profileDetailsController
                                    .selectPersonalDocument.value),
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Choose File",
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(
                                            color: AppColor.color4551,
                                            fontSize: 20),
                                  ),
                                ),
                              ),
                  ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Education Widget
  Widget educationWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Company Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Company Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Company owner",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Company owner',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Company Telephone Number",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Company Telephone Number',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Postcode",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Postcode',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Address",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Address",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "City",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'City',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Country",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Country',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Bank Details
  Widget bankDetailsWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Bank Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Bank Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Bank Address",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Bank Address",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Account Nos",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Account Nos',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "IFSC Code",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'IFSC Code',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Refernces
  Widget referncesWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Email",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Email",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Mobile Number",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Mobile Number',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "How do you know him/her?",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'How do you know him/her?',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Password Change Widget
  Widget passwordChangeWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Current Password",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Current Password',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "New Password",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "New Password",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Re-type New Password",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Re-type New Password",
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }
}

///// Employee Screen
class EmployeeScreenWidget extends StatelessWidget {
  final double height;
  final double width;
  final ProfileDetailsScreenController profileDetailsController;
  const EmployeeScreenWidget({
    super.key,
    required this.height,
    required this.width,
    required this.profileDetailsController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            //// Employee Basic Info
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Basic",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            employeeBasicDataWidget(context),
            AppHelper().verticalSpace(size: 10),
            //// Employee Work Experience
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Work Experience",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            employeeWorkExperianceWidget(context),
            AppHelper().verticalSpace(size: 10),
            //// Employee Upload Document
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Upload Document",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            employeeUploadDocumentsWidget(context),
            AppHelper().verticalSpace(size: 10),
            //// Employee Education
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Eduction",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            employeeEducationWidget(context),
            AppHelper().verticalSpace(size: 10),
            //// Employee Bank Detail
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Bank Details",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            employeeBankDetailsWidget(context),
            AppHelper().verticalSpace(size: 10),
            //// Employee Referance Widget
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Refernces",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            employeeReferncesWidget(context),
            AppHelper().verticalSpace(size: 10),
            //// Employee Password Change
            Row(
              children: [
                Container(
                  height: height * 0.03,
                  width: width * 0.01,
                  decoration: BoxDecoration(
                    color: AppColor.color77DC,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                AppHelper().horizontalSpace(size: 5),
                Text(
                  "Password",
                  style: AppStyle().workSansSemiBold(context).copyWith(
                        fontSize: 16,
                        color: AppColor.color95ED,
                      ),
                ),
              ],
            ),
            AppHelper().verticalSpace(size: 10),
            employeePasswordChangeWidget(context),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Employee Basic Widget
  Widget employeeBasicDataWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Weekly Hours",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Weekly Hours",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Annual Holiday Allowance",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: '${0} Day',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Start Date",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Start Date',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Final Working Date",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Final Working Date',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Employment Type",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            DropdownButtonFormField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(top: 2, left: 10, right: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              value: profileDetailsController.selectEmployeeTypeValue.value,
              onChanged: (newValue) {
                profileDetailsController.selectEmployeeTypeValue.value =
                    newValue.toString();
              },
              items: profileDetailsController.selectEmployeeTypeDropdown
                  .map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Employee Work Experiance
  Widget employeeWorkExperianceWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Company Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Company Name (Where you work before?)',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Contact Person",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Contact Person',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Position",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Position',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Email",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Email',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Phone/Mobile Number",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Phone/Mobile Number',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Address",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Address',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Your duties",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Your duties',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Employee Upload Document Widget
  Widget employeeUploadDocumentsWidget(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            AppHelper().verticalSpace(size: 10),
            InkWell(
              onTap: () {
                profileDetailsController.selectDocument(
                    isEmployeeSelectDocument: true);
              },
              child: Container(
                height: height * 0.22,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.borderColor, width: 2),
                ),
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.borderColor, width: 1),
                    ),
                    child:
                        profileDetailsController.selectEmployeeDocument.value !=
                                ""
                            ? Image.file(
                                File(profileDetailsController
                                    .selectEmployeeDocument.value),
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Choose File",
                                    style: AppStyle()
                                        .workSansSemiBold(context)
                                        .copyWith(
                                            color: AppColor.color4551,
                                            fontSize: 20),
                                  ),
                                ),
                              ),
                  ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Employee Education Widget
  Widget employeeEducationWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Company Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Company Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Company owner",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Company owner',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Company Telephone Number",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Company Telephone Number',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Postcode",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Postcode',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Address",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Address",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "City",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'City',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Country",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Country',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Employee Bank Details
  Widget employeeBankDetailsWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Bank Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Bank Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Bank Address",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Bank Address",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Account Nos",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Account Nos',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "IFSC Code",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'IFSC Code',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Employee Refernces
  Widget employeeReferncesWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Name",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Name',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Email",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Email",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Mobile Number",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Mobile Number',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "How do you know him/her?",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'How do you know him/her?',
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }

  //// Employee Password Change Widget
  Widget employeePasswordChangeWidget(BuildContext context) {
    return Card(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelper().verticalSpace(size: 10),
            Text(
              "Current Password",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: 'Current Password',
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "New Password",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "New Password",
            ),
            AppHelper().verticalSpace(size: 10),
            Text(
              "Re-type New Password",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 05),
            TextFormFieldWidget(
              height: height,
              hintText: "Re-type New Password",
            ),
            AppHelper().verticalSpace(size: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: SaveBtnWidget(height: height, width: width),
            ),
            AppHelper().verticalSpace(size: 10),
          ],
        ),
      ),
    );
  }
}

class SaveBtnWidget extends StatelessWidget {
  const SaveBtnWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      width: width * 0.38,
      decoration: BoxDecoration(
        color: AppColor.color95ED,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "Save",
          style: AppStyle()
              .workSansSemiBold(context)
              .copyWith(fontSize: AppFontSize.fontSize20, color: Colors.white),
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.height,
      required this.hintText,
      this.surfixIcon,
      this.prefixIcon});

  final double height;
  final String hintText;
  final Widget? surfixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill details.';
            }
            return null;
          },
          style:
              AppStyle().workSansMedium(context).copyWith(color: Colors.black),
          // controller: loginController.passwordController,
          cursorColor: AppColor.color8EE9,

          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: surfixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: AppStyle()
                .workSansMedium(context)
                .copyWith(color: AppColor.color4551),
          ),
        ),
      ),
    );
  }
}
