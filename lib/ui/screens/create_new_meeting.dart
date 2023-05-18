import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_time_picker_only.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';
import 'package:meeting_module2/widget/text_underline.dart';

class CreateNewMeeting extends StatelessWidget {
  static const routeNamed = '/CreateNewMeeting';
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CreateNewMeetingController());

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Container(
            padding: EdgeInsets.only(
              top: ScreenUtil().statusBarHeight,
              left: 10,
              right: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Create \nNew Meeting",
                        fontSize: 35,
                        textColor: ThemeConstants.bluecolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: CustomTabWidget(
                          title0: "Internal Meetings",
                          title1: "External Meetings",
                          callback: (val) {
                            if (val == 1) {
                              controller.externalMeeting.value = true;
                              controller.update();
                            } else {
                              controller.externalMeeting.value = false;
                              controller.update();
                            }
                          },
                        ),
                      ),
                      // TextUnderLine(
                      //   text1: "Internal",
                      //   text: "Meetings",
                      //   textColor: ThemeConstants.firstColor,
                      //   underlinceColor: ThemeConstants.firstColor,
                      // ),
                      // const SizedBox(
                      //   width: 20,
                      // ),
                      // TextUnderLine(
                      //   text1: "External",
                      //   text: " Meeting",
                      //   underlinceColor: Colors.transparent,
                      // ),
                    ],
                  ),
                  if (!controller.externalMeeting.value)
                    ...getListInternalmeeting(context, controller),
                  if (controller.externalMeeting.value)
                    ...getExternalMeeting(context, controller)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getListInternalmeeting(
      BuildContext context, CreateNewMeetingController controllers) {
    var controller = Get.find<CreateNewMeetingController>();

    String? selectedValue = 'All Meetings';
    bool showFilterList = true;
    List<String> list = <String>[
      'All Meetings',
      'Launch of New program',
      'Training',
      'Networking',
      'Institute Partner meet'
    ];

    return [
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child:
              // CustomTextField(
              //   hint: 'Creat',
              //   controller: controller.meetingNameController.value,
              // ),
              CustomAutoSizeTextMontserrat(
            text: "Agenda/Purpose of the Meeting",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      Container(
          child: CustomMultiDownSingle(
        model: list,
        initialSelectedValue: list[0],
        enableMultiSelect: false,
        callbackFunctionSingle: (Value) {
          controller.agendaPurposeOfMeeting.value = Value;
          controller.update();
        },
      )

          // DropdownButton2(
          //   underline: Container(),
          //   buttonStyleData: ButtonStyleData(
          //       elevation: 0,
          //       height: 40,
          //       width: MediaQuery.of(context).size.width,
          //       decoration: BoxDecoration(
          //           color: Colors.transparent,
          //           borderRadius: BorderRadius.circular(20),
          //           border:
          //               Border.all(width: 1, color: ThemeConstants.blackcolor))),
          //   dropdownStyleData: DropdownStyleData(elevation: 1),
          //   hint: Text(
          //     '${controller.agendaPurposeOfMeeting.value}',
          //     style: TextStyle(
          //       fontSize: 14,
          //       color: Theme.of(context).hintColor,
          //     ),
          //   ),

          //   items: list
          //       .map((item) => DropdownMenuItem<String>(
          //             value: item,
          //             child: Text(
          //               item,
          //               style: const TextStyle(
          //                 fontSize: 14,
          //               ),
          //             ),
          //           ))
          //       .toList(),
          //   value: controller.agendaPurposeOfMeeting.value == null
          //       ? selectedValue
          //       : controller.agendaPurposeOfMeeting.value,
          //   onChanged: (value) {
          //     // controller.frfr(value);

          //     controller.agendaPurposeOfMeeting.value = value.toString();

          //     // controller.changeInFilter();

          //     controller.update();

          //     // controller.showSpecificMeeting(value);
          //   },
          //   // buttonHeight: 40,
          //   // buttonWidth: 140,
          //   // itemHeight: 40,
          //   // itemWidth: 140,
          // ),
          ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child:
              // CustomTextField(
              //   hint: 'Creat',
              //   controller: controller.meetingNameController.value,
              // ),
              CustomAutoSizeTextMontserrat(
            text: "Meeting Name",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      CustomTextField(
          hint: '', controller: controller.meetingNameController.value),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      SizedBox(
        height: 10,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              CustomAutoSizeTextMontserrat(
                text: "Date",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                    height: 45,
                    width: (MediaQuery.of(context).size.width - 40) / 2,
                    child: CustomTimerWidget(callback: (val) {
                      controller.dateController.value = val;
                      controller.update();
                      print(controller.dateController.value);
                    })),
              ),
            ],
          ),
          Column(
            children: [
              CustomAutoSizeTextMontserrat(
                text: "Time",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    height: 45,
                    width: (MediaQuery.of(context).size.width - 40) / 2,
                    child: CustomTimerWidget2(callback: (val) {
                      // print(val);
                      controller.timeController.value = val;
                      controller.update();
                      print(controller.timeController.value);
                    }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              CustomAutoSizeTextMontserrat(
                text: "Proposed Duration",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 45,
                  width: (MediaQuery.of(context).size.width - 40) / 2,
                  // decoration: BoxDecoration(
                  //     color: ThemeConstants.lightgreycolor,
                  //     borderRadius:
                  //         const BorderRadius.all(Radius.circular(10.0))),
                  child: CustomTextField(
                    hint: '',
                    controller: controller.proposedDuration.value,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomAutoSizeTextMontserrat(
                text: "Meeting Type",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        child: CustomMultiDownSingle(
                            callbackFunctionSingle: (val) {
                              print(val.runtimeType);
                              if (val == 'Offline') {
                                controller.MeetingType.value = false;
                                controller.update();
                              } else {
                                controller.MeetingType.value = true;
                                controller.update();
                              }
                            },
                            enableMultiSelect: false,
                            model: ['Online', 'Offline'],
                            initialSelectedValue: 'Online'))),
              ),
            ],
          ),
        ],
      ),
      if (controller.MeetingType.value == false) ...[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Location",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //
        Container(
          child: CustomMultiDownSingle(
            enableMultiSelect: false,
            model: ['Siec Branch', 'Others'],
            initialSelectedValue: 'Siec Branch',
            callbackFunctionSingle: (val) {
              print(val);
              if (val == 'Others') {
                controller.meetingLocation.value = false;
                controller.update();
              }
              if (val == 'Siec Branch') {
                controller.meetingLocation.value = true;
                controller.update();
              }
            },
          ),
        ),

        if (controller.meetingLocation.value == true) ...[
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Select Branch",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
          Container(
            child: CustomMultiDownSingle(
              enableMultiSelect: false,
              model: ['Siec Branch', 'Others'],
              initialSelectedValue: 'Siec Branch',
              callbackFunctionSingle: (val) {
                controller.selectMeetingBranch.value = val;
                controller.update();
              },
            ),
          ),
        ] else ...[
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Specify Location",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
          Container(
            child: CustomTextField(
                hint: '', controller: controller.specifyMeetingLocation.value),
          ),
        ]
      ],

      if (controller.MeetingType.value == true) ...[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Mode of Meeting",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomMultiDownSingle(
          enableMultiSelect: false,
          model: ['Zoom', 'Meet', 'Teams'],
          initialSelectedValue: 'Zoom',
          callbackFunctionSingle: (val) {
            controller.modeOfMeeting.value = val;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Meeting Link",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width - 40,
          child: CustomTextField(
            hint: '',
            controller: controller.meetingLink.value,
          ),
        ),
      ],

      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "SIEC Persons attending the meeting",
            textColor: ThemeConstants.bluecolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "(Trigger Notification)",
            textColor: ThemeConstants.red,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Select target Audience Type",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      CustomMultiDownSingle(
          callbackFunctionSingle: (val) {
            print(val);
            controller.selectedTargetAudience.value = val;
            controller.update();
            // print(controller.selectedTargetAudience.value);
          },
          enableMultiSelect: false,
          model: controller.selectTargetAudienceType,
          initialSelectedValue: ''),

      if (controller.selectedTargetAudience.value == 'Group Wise') ...[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Group names",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomMultiDownSingle(
            callbackFunctionSingle: (val) {
              controller.groupNames.value = val;
              controller.update();
            },
            enableMultiSelect: false,
            model: controller.groupNamesAudienceType,
            initialSelectedValue: ''),
      ],

      if (controller.selectedTargetAudience.value == 'Branch Based') ...[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Select Branch",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomMultiDownSingle(
            callbackFunctionSingle: (val) {
              controller.selectedBranch.value = val;
              controller.update();
            },
            enableMultiSelect: false,
            model: controller.branchList,
            initialSelectedValue: ''),
      ],

      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Select User",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      CustomMultiDownSingle(
          model: Get.find<DashBoardController>().listBro,
          initialSelectedValue: '',
          callbackFunctionSingle: (val) {
            // controller.selectedBranch.value = val;
            // controller.update();
          },
          callbackFunctionMulti: (val) {
            controller.selectedUsersList.value = val;
          },
          enableMultiSelect: true),

      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   child: CustomTextField(
      //     hint: '',
      //     controller: controller.dateController.value,
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 15),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Group Names",
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   child: CustomTextField(
      //     hint: '',
      //     controller: controller.dateController.value,
      //   ),
      // ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Meeting Cordinator",
            textColor: ThemeConstants.bluecolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      CustomMultiDownSingle(
          enableMultiSelect: true,
          callbackFunctionSingle: (val) {
            controller.update();
          },
          model: controller.groupNamesAudienceType,
          initialSelectedValue: ''),
      const SizedBox(
        height: 25,
      ),

      InkWell(
        onTap: () {
          controller.createNewMeeting();
        },
        child: Container(
          height: 38,
          width: 150,
          decoration: BoxDecoration(
              color: ThemeConstants.bluecolor,
              borderRadius: const BorderRadius.all(Radius.circular(30.0))),
          child: Center(
            child: CustomAutoSizeTextMontserrat(
              text: "Create",
              textColor: ThemeConstants.whitecolor,
              fontSize: 20,
            ),
          ),
        ),
      ),

      SizedBox(
        height: 30,
      )
    ];
  }

  List<Widget> getExternalMeeting(
      BuildContext context, CreateNewMeetingController controller) {
    List<String> list = <String>[
      'All Meetings',
      'Launch of New program',
      'Training',
      'Networking',
      'Institute Partner meet'
    ];
    return [
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Meeting with",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      CustomMultiDownSingle(
          enableMultiSelect: false,
          callbackFunctionSingle: (val) {
            controller.update();
          },
          model: controller.meetingWithList,
          initialSelectedValue: ''),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   child: CustomTextField(
      //     hint: '',
      //     controller: controller.dateController.value,
      //   ),
      // ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Agenda/Purpose of the Meeting",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
          child: CustomMultiDownSingle(
        model: list,
        initialSelectedValue: list[0],
        enableMultiSelect: false,
        callbackFunctionSingle: (Value) {
          controller.agendaPurposeOfMeeting.value = Value;
          controller.update();
        },
      )),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Meeting Name",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      CustomTextField(
          hint: '', controller: controller.meetingNameController.value),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      SizedBox(
        height: 10,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              CustomAutoSizeTextMontserrat(
                text: "Date",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 45,
                  width: (MediaQuery.of(context).size.width - 40) / 2,
                  // child: CustomTextField(
                  //   hint: '',
                  //   controller: controller.dateController.value,
                  // ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomAutoSizeTextMontserrat(
                text: "Time",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    height: 45,
                    width: (MediaQuery.of(context).size.width - 40) / 2,
                    child: Container(
                      height: 45,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      // child: CustomTextField(
                      //   hint: '',
                      //   controller: controller.dateController.value,
                      // )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      SizedBox(
        height: 10,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              CustomAutoSizeTextMontserrat(
                text: "Proposed Duration",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 45,
                  width: (MediaQuery.of(context).size.width - 40) / 2,
                  // decoration: BoxDecoration(
                  //     color: ThemeConstants.lightgreycolor,
                  //     borderRadius:
                  //         const BorderRadius.all(Radius.circular(10.0))),
                  // child: CustomTextField(
                  //   hint: '',
                  //   controller: controller.dateController.value,
                  // ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomAutoSizeTextMontserrat(
                text: "Meeting Type",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                        width: (MediaQuery.of(context).size.width - 40) / 2,
                        child: CustomMultiDownSingle(
                            callbackFunctionSingle: (val) {
                              print(val.runtimeType);
                              if (val == 'Offline') {
                                controller.MeetingType.value = false;
                                controller.update();
                              } else {
                                controller.MeetingType.value = true;
                                controller.update();
                              }
                            },
                            enableMultiSelect: false,
                            model: ['Online', 'Offline'],
                            initialSelectedValue: 'Online'))),
              ),
            ],
          ),
        ],
      ),
      if (controller.MeetingType.value == false) ...[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Location",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //
        Container(
          child: CustomMultiDownSingle(
            enableMultiSelect: false,
            model: ['Siec Branch', 'Others'],
            initialSelectedValue: 'Siec Branch',
            callbackFunctionSingle: (val) {
              print(val);
              if (val == 'Others') {
                controller.meetingLocation.value = false;
                controller.update();
              }
              if (val == 'Siec Branch') {
                controller.meetingLocation.value = true;
                controller.update();
              }
            },
          ),
        ),

        if (controller.meetingLocation.value == true) ...[
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Select Branch",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
          Container(
            child: CustomMultiDownSingle(
              enableMultiSelect: false,
              model: ['Siec Branch', 'Others'],
              initialSelectedValue: 'Siec Branch',
              callbackFunctionSingle: (val) {
                if (val == 'Others') {
                  controller.meetingLocation.value = false;
                  controller.update();
                }
              },
            ),
          ),
        ] else ...[
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Specify Location",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
          Container(
              // child: CustomTextField(
              //   hint: '',
              //   controller: controller.dateController.value,
              // ),
              ),
        ]
      ],
      if (controller.MeetingType.value == true) ...[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Mode of Meeting",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomMultiDownSingle(
          enableMultiSelect: false,
          model: ['Zoom', 'Meet', 'Teams'],
          initialSelectedValue: 'Zoom',
          callbackFunctionSingle: (val) {
            print(val);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Meeting Link",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width - 40,
          // child:
          //  CustomTextField(
          //   hint: '',
          //   controller: controller.dateController.value,
          // ),
        ),
      ],

      // Padding(
      //   padding: const EdgeInsets.only(left: 25),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Mode of Meeting",
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 25),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Meeting Link",
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      // Container(
      //   height: 38,
      //   width: 150,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.bluecolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      //   child: Center(
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Next",
      //       textColor: ThemeConstants.whitecolor,
      //       fontSize: 20,
      //     ),
      //   ),
      // ),
      // // Participants
      // Padding(
      //   padding: const EdgeInsets.only(left: 15),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Participants",
      //       textColor: ThemeConstants.bluecolor,
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 15, top: 10),
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Column(
      //         children: [
      //           CustomAutoSizeTextMontserrat(
      //             text: "Country",
      //             fontSize: 16,
      //             fontWeight: FontWeight.bold,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(left: 10),
      //             child: Align(
      //               alignment: AlignmentDirectional.topStart,
      //               child: Container(
      //                 height: 45,
      //                 width: (MediaQuery.of(context).size.width - 40) / 2,
      //                 decoration: BoxDecoration(
      //                     color: ThemeConstants.lightgreycolor,
      //                     borderRadius:
      //                         const BorderRadius.all(Radius.circular(10.0))),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           CustomAutoSizeTextMontserrat(
      //             text: "University",
      //             fontSize: 16,
      //             fontWeight: FontWeight.bold,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(left: 10),
      //             child: Align(
      //               alignment: AlignmentDirectional.topStart,
      //               child: Container(
      //                 height: 45,
      //                 width: (MediaQuery.of(context).size.width - 40) / 2,
      //                 decoration: BoxDecoration(
      //                     color: ThemeConstants.lightgreycolor,
      //                     borderRadius:
      //                         const BorderRadius.all(Radius.circular(10.0))),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

      // const SizedBox(
      //   height: 10,
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 15, right: 15),
      //   child: Container(
      //     height: 38,
      //     width: MediaQuery.of(context).size.width,
      //     decoration: BoxDecoration(
      //         color: ThemeConstants.bluecolor,
      //         borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      //     child: Center(
      //       child: CustomAutoSizeTextMontserrat(
      //         text: "Add new Representative",
      //         textColor: ThemeConstants.whitecolor,
      //         fontSize: 20,
      //       ),
      //     ),
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 15),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Name of person",
      //       mandatory: true,
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 15),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Designation",
      //       mandatory: true,
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 15),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Email",
      //       mandatory: true,
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 15),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Phone",
      //       mandatory: true,
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      SizedBox(
        height: 10,
      ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      // Row(
      //   children: [
      //     const Spacer(),
      //     Container(
      //       height: 38,
      //       decoration: BoxDecoration(
      //           color: ThemeConstants.whitecolor,
      //           border: Border.all(color: ThemeConstants.firstColor),
      //           borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      //       child: Center(
      //         child: CustomAutoSizeTextMontserrat(
      //           text: "View Participants",
      //           textColor: ThemeConstants.firstColor,
      //           fontSize: 16,
      //         ),
      //       ),
      //     ),
      //     const Spacer(),
      //     Container(
      //       height: 38,
      //       width: 150,
      //       decoration: BoxDecoration(
      //           color: ThemeConstants.bluecolor,
      //           borderRadius: const BorderRadius.all(Radius.circular(30.0))),
      //       child: Center(
      //         child: CustomAutoSizeTextMontserrat(
      //           text: "Next",
      //           textColor: ThemeConstants.whitecolor,
      //           fontSize: 16,
      //         ),
      //       ),
      //     ),
      //     const Spacer(),
      //   ],
      // ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "SIEC Persons attending the meeting",
            textColor: ThemeConstants.bluecolor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "(trigger Notification)",
            textColor: ThemeConstants.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Select Target Audience Type",
            mandatory: true,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      CustomMultiDownSingle(
          callbackFunctionSingle: (val) {
            print(val);
            controller.selectedTargetAudience.value = val;
            controller.update();
            // print(controller.selectedTargetAudience.value);
          },
          enableMultiSelect: false,
          model: controller.selectTargetAudienceType,
          initialSelectedValue: ''),

      if (controller.selectedTargetAudience.value == 'Group Wise') ...[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: CustomAutoSizeTextMontserrat(
              text: "Group names",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomMultiDownSingle(
            enableMultiSelect: false,
            callbackFunctionSingle: (val) {
              controller.update();
            },
            model: controller.groupNamesAudienceType,
            initialSelectedValue: ''),
      ],

      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Select User",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      CustomMultiDownSingle(
          model: Get.find<DashBoardController>().listBro,
          initialSelectedValue: 'Nidhi Vij',
          enableMultiSelect: true),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(left: 15),
      //   child: Align(
      //     alignment: AlignmentDirectional.topStart,
      //     child: CustomAutoSizeTextMontserrat(
      //       text: "Group Names",
      //       mandatory: true,
      //       fontSize: 16,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Meeting Cordinator",
            textColor: ThemeConstants.bluecolor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Select User",
            mandatory: true,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      CustomMultiDownSingle(
          enableMultiSelect: true,
          callbackFunctionSingle: (val) {
            controller.update();
          },
          model: controller.groupNamesAudienceType,
          initialSelectedValue: ''),
      const SizedBox(
        height: 25,
      ),
      // Container(
      //   height: 45,
      //   width: MediaQuery.of(context).size.width - 40,
      //   decoration: BoxDecoration(
      //       color: ThemeConstants.lightgreycolor,
      //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      // ),
      Container(
        height: 38,
        width: 150,
        decoration: BoxDecoration(
            color: ThemeConstants.bluecolor,
            borderRadius: const BorderRadius.all(Radius.circular(30.0))),
        child: Center(
          child: CustomAutoSizeTextMontserrat(
            text: "Create",
            textColor: ThemeConstants.whitecolor,
            fontSize: 16,
          ),
        ),
      ),

      SizedBox(
        height: 30,
      )
    ];
  }
}
