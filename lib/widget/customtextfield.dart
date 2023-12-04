import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Validator? validator;
  TextInputType? keybord;
  bool? obscureText = false;
  bool? readOrEdit = false;
  Color? backgroundCOlour;
  bool? forDropDown;
  bool? isPassword = false;
  VoidCallback? callbackForPasswordShow;
  int? fontSize;
  String? originalPasswordToMatch;

  CustomTextField({
    Key? key,
    this.originalPasswordToMatch,
    this.callbackForPasswordShow,
    this.fontSize,
    this.forDropDown = true,
    this.backgroundCOlour,
    required this.hint,
    required this.controller,
    this.isPassword,
    this.obscureText,
    this.readOrEdit,
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
        style: ThemeConstants.montserratTextStyleSmall,
        readOnly: readOrEdit == null ? false : readOrEdit!,
        decoration: InputDecoration(
          errorMaxLines: 20,
          suffixIcon: isPassword == true
              ? IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: callbackForPasswordShow!,
                )
              : SizedBox.shrink(),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          hintText: hint,
          hintStyle: ThemeConstants.montserratTextStyleSmall,
          filled: true,
          fillColor: backgroundCOlour ?? Colors.transparent,
          errorBorder: OutlineInputBorder(
            borderRadius: forDropDown!
                ? BorderRadius.circular(200)
                : BorderRadius.circular(0),
            borderSide: BorderSide(
                color: forDropDown! ? Colors.red : Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: forDropDown! ? 1 : 0,
                color: forDropDown!
                    ? ThemeConstants.blackcolor
                    : Colors.transparent),
            borderRadius: forDropDown!
                ? BorderRadius.circular(200)
                : BorderRadius.circular(0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: forDropDown! ? 1 : 0,
                color: forDropDown!
                    ? ThemeConstants.blackcolor
                    : Colors.transparent),
            borderRadius: forDropDown!
                ? BorderRadius.circular(200)
                : BorderRadius.circular(0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: forDropDown! ? 1 : 0,
                color: forDropDown!
                    ? ThemeConstants.blackcolor
                    : Colors.transparent),
            borderRadius: forDropDown!
                ? BorderRadius.circular(200)
                : BorderRadius.circular(0),
          ),
        ),
        validator: (value) {
          if (Validator.phone == validator) {
            return getPhoneNumbervalidation(value);
          } else if (Validator.email == validator) {
            return getEmailvaliation(value);
          } else if (Validator.password == validator) {
            return getPasswordValidator(value);
          } else if (Validator.notEmpty == validator) {
            return getEmptyValidation(value);
          } else if (Validator.otp == validator) {
            return getOtpvalidation(value);
          } else if (Validator.plzSelectOne == validator) {
            return getEmptyDropDownValidation(value);
          } else if (Validator.passwordWithSpecial == validator) {
            return getPasswordWithSpecialCharacterValidator(value);
          } else if (Validator.passwordMatchValidation == validator) {
            return validatePasswordMatchedOrNot(
                value, originalPasswordToMatch!);
          }
          return null;
        });
  }
}

enum Validator {
  phone,
  email,
  password,
  passwordWithSpecial,
  notEmpty,
  otp,
  plzSelectOne,

  passwordMatchValidation
}
