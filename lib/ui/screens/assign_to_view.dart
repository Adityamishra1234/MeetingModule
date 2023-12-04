import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/ui/controller/assignToController.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';

class AssignToView extends StatelessWidget {
  FindNotesModel notesModel;

  AssignToView({super.key, required this.notesModel});

  TextEditingController controller = TextEditingController();

  var getController = Get.put(AssignToController());

  @override
  Widget build(BuildContext context) {
    FindNotesModel argu = notesModel;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15),
          child: ListView(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: CustomAutoSizeTextMontserrat(
                  text: "Assign Task",
                  fontSize: 35,
                  textColor: ThemeConstants.bluecolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomAutoSizeTextMontserrat(
                  text: "Type Of Task",
                  mandatory: true,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CustomTextField(
                    hint: "type of task", controller: controller),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomAutoSizeTextMontserrat(
                  text: "Task Owner",
                  mandatory: true,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomMultiDownSingleAllUser(

                  // model: ['d', 'd'],
                  model: Get.find<BaseController>().allSiecMembersList,
                  // callbackFunction: callback,
                  // callbackFunctionMulti: (val) {
                  //   print(val);
                  // },
                  callbackFunctionSingle: (val) {
                    getController.taskOwner = val;
                  },
                  enableMultiSelect: false,
                  choosefieldtype: false,
                  initialSelectedValue: "1"),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomAutoSizeTextMontserrat(
                  text: "Select a deadline for a task",
                  mandatory: true,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: Container(
                  height: 45,
                  child: CustomTimerWidget(
                    callback: (value) {
                      getController.deadLine = value;
                    },
                  ),
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
                      text: "Add Task",
                      onPressed: () {
                        getController.assign(argu, controller.text, context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
