import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/logincontroller.dart';

import 'package:meeting_module2/ui/controller/signin_controller.dart';
import 'package:meeting_module2/ui/screens/createpassword.dart';
import 'package:meeting_module2/ui/screens/loginUi.dart';
import 'package:meeting_module2/ui/screens/login_page.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  var controller = Get.put(SigninController());

  TextEditingController texfield = TextEditingController();
  TextEditingController otpfield = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  var emailController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
          (state) => Container(
                color: ThemeConstants.whitecolor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomAutoSizeTextMontserrat(
                        text: 'Sign In',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          hint: "Enter your office email",
                          validator: Validator.email,
                          controller: emailController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          hint: "Enter your password",
                          validator: Validator.otp,
                          controller: otpfield),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                            () => CreatePasswrord(email: texfield.value.text));
                        // controller.otpcheck(texfield.text, otpfield.text);
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            color: ThemeConstants.bluecolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Center(
                          child: CustomAutoSizeTextMontserrat(
                            text: "Submit",
                            textColor: ThemeConstants.whitecolor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            "Already registered? Click here",
                            style: TextStyle(color: ThemeConstants.bluecolor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          onLoading: getLoading(context)),
    );
  }
}
