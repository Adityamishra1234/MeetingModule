import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});
  TextInputType? keybord;
    this.keybord,

  @override
  Widget build(BuildContext context) {
    return TextField(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keybord ?? TextInputType.text,

      // controller: firstName,
      scrollPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).viewInsets.bottom + 30),
      style: ThemeConstants.montserrattextstyle2,
      // readOnly: saveAndEdit,
      decoration: InputDecoration(
        hintText: "Enter your First Name",
        filled: true,
        fillColor: ThemeConstants.lightblueColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),

      // validator: (value) {
      //   if (value == "") {
      //     return "Please enter First Name";
      //   } else {
      //     return null;
      //   }
      // },
    );
  }
}

enum Validator {
  phone,
  email,
  password,
}
