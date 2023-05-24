import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_time_picker_only.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';

class AssignToView extends StatelessWidget {
  AssignToView({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CustomAutoSizeTextMontserrat(
                text: "Type Of Task",
                mandatory: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child:
                  CustomTextField(hint: "type of task", controller: controller),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomAutoSizeTextMontserrat(
                text: "Type Owner",
                mandatory: true,
              ),
            ),
            CustomMultiDownSingleAllUser(

                // model: ['d', 'd'],
                model: Get.find<BaseController>().allSiecMembersList,
                // callbackFunction: callback,
                callbackFunctionMulti: (val) {
                  print(val);
                },
                enableMultiSelect: true,
                choosefieldtype: false,
                initialSelectedValue: "1"),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomAutoSizeTextMontserrat(
                text: "Select a deadline for a task",
                mandatory: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomTimerWidget(
                callback: (value) {
                  print(value);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: CustomButton(
                    backgroundColor: ThemeConstants.bluecolor,
                    text: "add Task",
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
