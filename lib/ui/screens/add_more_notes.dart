import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/idConstant.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';

import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';

class AddMoreNotesView extends StatelessWidget {
  static String routeName = '/addmorenotes';
  AddMoreNotesView({super.key});
  // TextEditingController fff = TextEditingController();

  var controller = Get.put(AddMoreNotesController());

  @override
  Widget build(BuildContext context) {
    int meetingID = Get.arguments;

    return Scaffold(
        body: controller.obx(
            (state) => SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: CustomAutoSizeTextMontserrat(
                                text: "Add more \nnotes",
                                fontSize: 40,
                                textColor: ThemeConstants.bluecolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: CustomAutoSizeTextMontserrat(
                                text: "Add notes for:",
                                fontSize: 15,
                                textColor: ThemeConstants.blackcolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomMultiDownSingle(
                              callbackFunctionSingle: (value) {
                                controller.noteTypeSelectedID.value =
                                    getNoteTypeId(value);
                                controller.noteTypeSelected.value = value;
                              },
                              model: const [
                                "Meeting Notes",
                                "Marketing Notes",
                                "Observation",
                                "Propose Changes",
                                "Process",
                                "Training Notes",
                                "Requirements",
                                "University Notes",
                                "Offline Marketing Notes"
                              ],
                              initialSelectedValue: "Select Add notes for",
                              enableMultiSelect: false,
                            ),
                            // CustomTextField(
                            //   hint: "",
                            //   controller: fff,
                            // ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: CustomAutoSizeTextMontserrat(
                                text: "Notes accessibility to",
                                fontSize: 15,
                                textColor: ThemeConstants.blackcolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomMultiDownSingleAllUser(
                                ////finx alll user model
                                model: Get.find<BaseController>()
                                    .allSiecMembersList,
                                initialSelectedValue: "Select Add notes for",
                                enableMultiSelect: true,
                                callbackFunctionMulti: (value) {
                                  controller.accessibileUserSelected.value =
                                      value;
                                }),

                            // CustomTextField(
                            //   hint: "",
                            //   controller: fff,
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                height: 185,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xff1940b3)),
                                  ),
                                  child: SizedBox(
                                    height: 200,
                                    child: TextField(
                                      controller: controller.noteText.value,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10)),
                                      keyboardType: TextInputType.multiline,
                                      expands: true,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.noteTypeSelected.isEmpty) {
                                  getToast(SnackBarConstants.notestype!);
                                } else if (controller
                                    .noteText.value.text.isEmpty) {
                                  getToast(SnackBarConstants.noteTextField!);
                                } else {
                                  controller.saveAndNext(meetingID);
                                }
                              },
                              child: Container(
                                // color: ThemeConstants.bluecolor,
                                decoration: BoxDecoration(
                                    color: ThemeConstants.bluecolor,
                                    borderRadius: BorderRadius.circular(500)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                child: Text(
                                  'Save & Next',
                                  style: TextStyle(
                                      color: ThemeConstants.whitecolor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: CustomAutoSizeTextMontserrat(
                                text: "Notes",
                                fontSize: 30,
                                textColor: ThemeConstants.bluecolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...listOfNotes(controller.model)
                            // Expanded(
                            //     child:
                            //
                            // ListView(
                            //   children: [
                            //     Container(
                            //       width: 500,
                            //       height: 1000,
                            //       color: Colors.amber,
                            //     ),
                            //     SizedBox(
                            //       height: 20,
                            //     ),
                            //     Container(
                            //       width: 500,
                            //       height: 1000,
                            //       color: Colors.amber,
                            //     )
                            //   ],
                            // ))
                          ],
                        )),
                  ),
                ),
            onLoading: getLoading(context)));
  }

  List<Widget> listOfNotes(RxList<FindNotesModel> models) {
    List<Widget> data = [];
    for (var i = 0; i < models.value.length; i++) {
      data.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 185,
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff1940b3)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAutoSizeTextMontserrat(
                      text: models[i].note,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 120,
                          // color: ThemeConstants.bluecolor,
                          decoration: BoxDecoration(
                              color: ThemeConstants.bluecolor,
                              borderRadius: BorderRadius.circular(500)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Text(
                            'Assign to',
                            style: TextStyle(color: ThemeConstants.whitecolor),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      );
    }
    return data;
  }
}
