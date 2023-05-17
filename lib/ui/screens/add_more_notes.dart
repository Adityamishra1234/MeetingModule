import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10),
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
                  SizedBox(
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
                  SizedBox(
                    height: 10,
                  ),
                  CustomMultiDownSingle(
                    model: [
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
                  SizedBox(
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
                  SizedBox(
                    height: 10,
                  ),
                  CustomMultiDownSingle(
                    model: Get.find<DashBoardController>().listBro,
                    initialSelectedValue: "Select Add notes for",
                    enableMultiSelect: true,
                  ),
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
                          border: Border.all(color: const Color(0xff1940b3)),
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
                      controller.addNote(meetingID);
                    },
                    child: Container(
                      // color: ThemeConstants.bluecolor,
                      decoration: BoxDecoration(
                          color: ThemeConstants.bluecolor,
                          borderRadius: BorderRadius.circular(500)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text(
                        'Save & Next',
                        style: TextStyle(color: ThemeConstants.whitecolor),
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

                  ...listOfNotes()
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
    );
  }

  List<Widget> listOfNotes() {
    List<Widget> data = [];
    for (var i = 0; i < 3; i++) {
      data.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 185,
            child: Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff1940b3)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('dddd'),
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
                          padding: EdgeInsets.symmetric(
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
