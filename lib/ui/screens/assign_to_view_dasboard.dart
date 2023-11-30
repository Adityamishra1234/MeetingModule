import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:meeting_module2/models/dashboardNotesModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/assignToController.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';

class AssignToView2 extends StatefulWidget {
  FindNotesModel argu;
  AssignToView2({super.key, required this.argu});

  @override
  State<AssignToView2> createState() => _AssignToView2State();
}

class _AssignToView2State extends State<AssignToView2> {
  TextEditingController controller = TextEditingController();

  var getController = Get.put(AssignToController());
  late FindNotesModel data;
  @override
  void initState() {
    // FindNotesModel argu = Get.arguments;
    data = widget.argu;
    getController.taskOwner = Get.find<BaseController>().allSiecMembersList[0];
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AssignToController>();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getController.obx(
          (state) => SafeArea(
                child: Form(
                  key: getController.key,
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
                              validator: Validator.notEmpty,
                              hint: "type of task",
                              controller: controller),
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
                            model:
                                Get.find<BaseController>().allSiecMembersList,
                            // callbackFunction: callback,
                            // callbackFunctionMulti: (val) {
                            //   print(val);
                            // },
                            callbackFunctionSingle: (val) {
                              getController.taskOwner =
                                  Get.find<BaseController>()
                                      .allSiecMembersList[0];
                              getController.update();
                            },
                            field: Container(
                              height: 22,
                              child: CustomTextField(
                                forDropDown: false,
                                backgroundCOlour: Colors.transparent,
                                hint: '',
                                readOrEdit: true,
                                controller: TextEditingController(),
                                validator: getController.taskOwner.name == null
                                    ? Validator.plzSelectOne
                                    : null,
                              ),
                            ),
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
                                print(value);
                                getController.deadLine = value;
                                getController.update();
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
                                  if (getController.key.currentState!
                                      .validate()) {
                                    // print(getController.taskOwner.name);
                                    getController.assign(
                                        data, controller.text, context);
                                  }
                                  // getController.key.currentState!.save();
                                  // print(getController.taskOwner.name);
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
              ),
          onLoading: getLoading(context)),
    );
  }
}
