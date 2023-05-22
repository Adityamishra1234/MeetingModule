import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/login_controller.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';

class LoginView extends StatelessWidget {
  static const routeNamed = '/login';
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    var controller2 = Get.put(BaseController(), permanent: true);

    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomAutoSizeTextMontserrat(
              text: "Proposed Duration",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            CustomTextField(hint: '', controller: controller.emailText.value),
            CustomAutoSizeTextMontserrat(
              text: "Proposed Duration",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            CustomTextField(hint: '', controller: controller.emailText.value),
            Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.toNamed(DashBoard.routeNamed);
                },
                child: CustomAutoSizeTextMontserrat(
                  text: "Forget passowrd",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomButton(
                text: 'Login',
                onPressed: () {
                  Get.toNamed(DashBoard.routeNamed);
                })
          ]),
        ),
      )),
    );
  }
}
