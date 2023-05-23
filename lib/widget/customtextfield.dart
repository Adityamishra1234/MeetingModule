import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Validator? validator;
  TextInputType? keybord;
  bool readOrEdit = false;
  CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.validator,
    this.keybord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keybord ?? TextInputType.text,
        controller: controller,
        scrollPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).viewInsets.bottom + 30),
        style: ThemeConstants.montserrattextstyle2,
        readOnly: readOrEdit,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: ThemeConstants.lightblueColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.0),
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
          }
        });
  }
}

enum Validator { phone, email, password, notEmpty }
