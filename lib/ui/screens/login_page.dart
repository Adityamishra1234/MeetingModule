import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/logincontroller.dart';
import 'package:meeting_module2/ui/screens/createpassword.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const routeNamed = '/LoginPage';

  TextEditingController texfield = TextEditingController();
  TextEditingController otpfield = TextEditingController();

  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
          (state) => Container(
                color: ThemeConstants.whitecolor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.forOtp == false)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextField(
                            hint: "Enter your office email",
                            validator: Validator.email,
                            controller: texfield),
                      ),
                    if (controller.forOtp == true)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomTextField(
                            hint: "enter your OTP",
                            validator: Validator.otp,
                            controller: otpfield),
                      ),
                    if (controller.forOtp == false)
                      InkWell(
                        onTap: () {
                          // Get.to(CreatePasswrord(
                          //   email: texfield.text,
                          // ));
                          controller.emailVerification(texfield.text);
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
                              text: "Get OTP",
                              textColor: ThemeConstants.whitecolor,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (controller.forOtp == true)
                      InkWell(
                        onTap: () {
                          controller.otpcheck(texfield.text, otpfield.text);
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
                      )
                  ],
                ),
              ),
          onLoading: getLoading(context)),
    );
  }
}
