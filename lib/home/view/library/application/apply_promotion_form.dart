import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zob/login/intro_screen.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_size.dart';
import 'package:zob/utils/app_style.dart';
import 'package:zob/widget/text_form_field_widget.dart';

class PromotionForm extends StatefulWidget {
  @override
  _PromotionFormState createState() => _PromotionFormState();
}

class _PromotionFormState extends State<PromotionForm> {
  // Controllers for text fields
  TextEditingController employeeController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController currentPositionController = TextEditingController();

  DateTime startDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply Promotion"),
        titleTextStyle: AppStyle()
            .workSansSemiBold(context)
            .copyWith(fontSize: 20, color: AppColor.color4551),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppColor.colorB5BA,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Employee",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: employeeController,
              labelText: "",
              hintText: 'Employee',
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Current Position",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormFieldWidget(
              height: height,
              width: width,
              controller: currentPositionController,
              labelText: "",
              hintText: 'Current Position',
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Date",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            InkWell(
              onTap: () {
                _selectStartDate(context);
              },
              child: Container(
                height: height * 0.055,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(DateFormat('dd/MM/yyyy').format(startDate),
                        style: AppStyle()
                            .workSansMedium(context)
                            .copyWith(color: AppColor.color4551, fontSize: 17)),
                  ),
                ),
              ),
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            Text(
              "Message",
              style: AppStyle().workSansMedium(context).copyWith(
                    fontSize: 18,
                    color: const Color(0xFF83878E),
                  ),
            ),
            AppHelper().verticalSpace(size: 5),
            TextFormField(
              cursorColor: AppColor.color8EE9,
              controller: messageController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 2, left: 10),
                labelStyle: AppStyle()
                    .workSansMedium(context)
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
                  borderSide:
                      const BorderSide(color: AppColor.borderColor, width: 1.0),
                ),
              ),
              maxLines: 4,
            ),
            AppHelper().verticalSpace(size: AppFontSize.paddingSize18),
            ButtonWidget(
              width: width,
              height: height * 0.062,
              onTap: () {},
              btnColor: AppColor.color95ED,
              btnName: "Submit",
              btnTextColor: AppColor.white,
              isLoading: false.obs,
            ),
          ],
        ),
      ),
    );
  }
}
