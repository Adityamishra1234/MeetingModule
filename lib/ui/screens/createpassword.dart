import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/createpasswordcontroller.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';

class CreatePasswrord extends StatelessWidget {
  String? email;
  CreatePasswrord({Key? key, required this.email}) : super(key: key);

  var controller = Get.put(CreatePasswordController());

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomTextField(
                obscureText: true,
                hint: "Please enter your password",
                // validator: Validator.email,
                controller: password),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomTextField(
                obscureText: true,
                hint: "Please enter your  confirm password",
                // validator: Validator.email,
                controller: confirmpassword),
          ),
          InkWell(
            onTap: () {
              if (password.text == confirmpassword.text) {
                controller.updatePassword(email!, password.text);
              } else {
                getToast("Please check your password");
              }
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                  color: ThemeConstants.bluecolor,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Center(
                child: CustomAutoSizeTextMontserrat(
                  text: "Submit",
                  textColor: ThemeConstants.whitecolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
