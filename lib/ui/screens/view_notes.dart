import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';

class ViewNotesDetails extends StatelessWidget {
  final String id;

  var controller = Get.find<AddMoreNotesController>();

  static const routeNamed = 'ViewNotesDetails';

  ViewNotesDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    print(id);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        print('objectdeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        controller.viewNotesSection = 0;
        context.pop();
      },
      child: Scaffold(
          body: controller.obx(
        (state) => SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: CustomTabWidget(
                        title0: "All notes",
                        defaultIndex: 0,
                        title1: "Reason of not attending",
                        callback: (val) {
                          controller.viewNotesSection = val;
                          controller.update();
                        },
                      ),
                    ),
                    // TextUnderLine(
                    //   text1: "View",
                    //   text: "Notes",
                    //   textColor: ThemeConstants.firstColor,
                    //   underlinceColor: ThemeConstants.firstColor,
                    // ),
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    // TextUnderLine(
                    //   text1: "Reason",
                    //   text: " of Attending",
                    //   underlinceColor: Colors.transparent,
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // CustomMultiDownSingle(
                //     enableMultiSelect: false,
                //     callbackFunctionSingle: (val) {
                //       controller.meetingWith.value = val;

                //       controller.getRepresentativeDropDownData();
                //       // controller.inItGetRepresentative();
                //     },
                //     model: controller.meetingWithList,
                //     initialSelectedValue: '${controllers.meetingWith}'),
                // const SizedBox(
                //   height: 10,
                // ),
                if (controller.viewNotesSection == 0 &&
                    controller.notesList.length > 0) ...[
                  if (controller.selectedDropDown != "")
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      child: DropdownButton2(
                        underline: Container(),
                        buttonStyleData: ButtonStyleData(
                            elevation: 0,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 1,
                                    color: ThemeConstants.blackcolor))),
                        dropdownStyleData: DropdownStyleData(elevation: 1),
                        hint: Text(
                          '${controller.selectedDropDown}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),

                        items: controller.notesTypeToShowInDropDown
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        // value: controller.selectedDropDown == null
                        //     ?
                        //     : controller.selectedFilter.value,
                        onChanged: (value) {
                          // controller.frfr(value);

                          controller.selectedDropDown = value.toString();

                          controller.showThisNote(context);

                          controller.update();

                          // controller.showSpecificMeeting(value);
                        },
                        // buttonHeight: 40,
                        // buttonWidth: 140,
                        // itemHeight: 40,
                        // itemWidth: 140,
                      ),
                    ),
                ],
                Expanded(
                  child: ListView(
                    children: [
                      if (controller.viewNotesSection == 0) ...[
                        ...controller.documentlist,
                      ] else ...[
                        ...controller.reasonofNotAtteding
                      ]
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Meeting Notes',
                      //   dataList: controller.meetingNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Observation Notes',
                      //   dataList: controller.observationNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Propose Changes Notes',
                      //   dataList: controller.processNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Process Notes Notes',
                      //   dataList: controller.processNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Training Notes',
                      //   dataList: controller.traningNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Requirement Notes',
                      //   dataList: controller.requirementsNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'University Notes',
                      //   dataList: controller.universityNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Offline Marketing Notes',
                      //   dataList: controller.offlineMarketingNotesList,
                      // ),
                    ],
                  ),
                ),

                // Expanded(
                //   child: ListView.separated(
                //       separatorBuilder: (context, index) => SizedBox(
                //             height: 20,
                //           ),
                //       itemCount: controller.notesList.length,
                //       itemBuilder: (context, index) {
                //         return Container(
                //           width: MediaQuery.of(context).size.width - 30,
                //           decoration: BoxDecoration(
                //               border: Border.all(),
                //               borderRadius: BorderRadius.circular(20.0)),
                //           child: Padding(
                //             padding: const EdgeInsets.all(12.0),
                //             child: Column(
                //               children: [
                //                 Align(
                //                   alignment: AlignmentDirectional.topStart,
                //                   child: CustomAutoSizeTextMontserrat(
                //                       text:
                //                           "${controller.notesList[index].note}"),
                //                 ),
                //                 Align(
                //                   alignment: AlignmentDirectional.topStart,
                //                   child: CustomAutoSizeTextMontserrat(
                //                     text:
                //                         "${controller.notesList[index].createdBy}",
                //                     textColor: ThemeConstants.TextColor,
                //                     fontSize: 12,
                //                   ),
                //                 ),
                //                 InkWell(
                //                   onTap: () {
                //                     Get.to(AssignToView());
                //                   },
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(top: 10),
                //                     child: Align(
                //                       alignment: AlignmentDirectional.topEnd,
                //                       child: Container(
                //                         height: 30,
                //                         width: 120,
                //                         decoration: BoxDecoration(
                //                             color: ThemeConstants.bluecolor,
                //                             borderRadius: const BorderRadius.all(
                //                                 Radius.circular(30.0))),
                //                         child: Center(
                //                           child: CustomAutoSizeTextMontserrat(
                //                             text: "Assign to",
                //                             textColor: ThemeConstants.whitecolor,
                //                             fontSize: 14,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         );
                //       }),
                // )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
