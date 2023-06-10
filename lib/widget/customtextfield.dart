import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Validator? validator;
  TextInputType? keybord;
  bool? obscureText = false;
  bool readOrEdit = false;
  Color? backgroundCOlour;
  CustomTextField({
    Key? key,
    this.backgroundCOlour,
    required this.hint,
    required this.controller,
    this.obscureText,
    this.validator,
    this.keybord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText ?? false,
        keyboardType: keybord ?? TextInputType.text,
        controller: controller,
        scrollPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).viewInsets.bottom + 30),
        style: ThemeConstants.montserrattextstyle2,
        readOnly: readOrEdit,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          hintText: hint,
          filled: true,
          fillColor: backgroundCOlour ?? ThemeConstants.ultraLightgreyColor,
          border: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: ThemeConstants.lightgreycolor),
            borderRadius: BorderRadius.circular(200),
          ),
        ),
        validator: (value) {
          if (Validator.phone == validator) {
            return getPhoneNumbervalidation(value);
          } else if (Validator.email == validator) {
            return getEmailvaliation(value);
          } else if (Validator.password == validator) {
            print("password");
          } else if (Validator.notEmpty == validator) {
            return getEmptyValidation(value);
          } else if (Validator.otp == validator) {
            return getOtpvalidation(value);
          }
        });
  }
}

enum Validator { phone, email, password, notEmpty, otp }
