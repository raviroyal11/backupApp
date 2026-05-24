import 'package:flutter/material.dart';
import 'package:zob/utils/app_color.dart';
import 'package:zob/utils/app_style.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.labelText,
      required this.hintText,
      this.controller,
      this.keyboardType = TextInputType.name,
      this.validator,
      this.obscureText = false,
      this.suffixIcon});

  final double height;
  final double width;
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.color8EE9,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill details.';
            }
            return null;
          },
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 2, left: 10),
        labelText: labelText,
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
          borderSide: const BorderSide(color: AppColor.borderColor, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        hintText: hintText,
        hintStyle: AppStyle().workSansMedium(context).copyWith(
              fontSize: 18,
              color: const Color(0xFF83878E),
            ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
