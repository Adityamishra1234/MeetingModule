import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  Validator? validator;

  CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,

      controller: controller,
      scrollPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).viewInsets.bottom + 30),
      style: ThemeConstants.montserrattextstyle2,
      // readOnly: saveAndEdit,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: ThemeConstants.lightgreycolor,
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
        }
      },
    );
  }
}
