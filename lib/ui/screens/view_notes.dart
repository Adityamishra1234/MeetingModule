import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';

class ViewNotesDetails extends StatelessWidget {
  var controller = Get.find<AddMoreNotesController>();

  static const routeNamed = '/ViewNotesDetails';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.viewNotesSection = 0;
        return Future.value(true);
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
                        title1: "Reason of attending",
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
