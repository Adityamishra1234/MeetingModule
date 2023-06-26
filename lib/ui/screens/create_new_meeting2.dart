import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller2.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/addRepresentative_widget.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_time_picker_only.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget_pick_hour_minutes.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';
import 'package:meeting_module2/widget/view_particpant_dialog.dart';

class CreateNewMeeting2 extends StatelessWidget {
  static const routeNamed = '/CreateNewMeeting';
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CreateNewMeetingController2());

    return Scaffold(
        body: controller.obx(
            (state) => WillPopScope(
                  onWillPop: () async {
                    Get.offAllNamed(DashBoard.routeNamed);

                    return Future.value(true);
                  },
                  child: SafeArea(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().statusBarHeight,
                          left: 10,
                          right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: CustomAutoSizeTextMontserrat(
                                text: "Create \nNew Meeting",
                                fontSize: 35,
                                textColor: ThemeConstants.bluecolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                CustomTabWidget(
                                  title0: "Internal Meeting",
                                  title1: "External Meeting",
                                  callback: (val) {
                                    if (val == 1) {
                                      controller.externalMeeting = true;
                                      controller.update();
                                    } else {
                                      controller.externalMeeting = false;
                                      controller.update();
                                    }
                                  },
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
                            // if (controller.externalMeeting.value)
                            ...getListInternalmeeting(context, controller),
                            // if (controller.externalMeeting.value)
                            //   ...getExternalMeeting(context, controller)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            onLoading: getLoading(context)));
  }

  List<Widget> getListInternalmeeting(
      BuildContext context, CreateNewMeetingController2 controllers) {
    var controller = Get.find<CreateNewMeetingController2>();

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
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Form(
            key: controller.key,
            child: Column(children: [
              if (controller.externalMeeting == true) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Meeting with",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomMultiDownSingle(
                    enableMultiSelect: false,
                    callbackFunctionSingle: (val) {
                      controller.meetingWith.value = val;

                      controller.getRepresentativeDropDownData();
                      // controller.inItGetRepresentative();
                    },
                    model: controller.meetingWithList,
                    initialSelectedValue: '${controllers.meetingWith}'),
                SizedBox(
                  height: 10,
                )
              ],

              Align(
                alignment: AlignmentDirectional.topStart,
                child:
                    // CustomTextField(
                    //   hint: 'Creat',
                    //   controller: controller.meetingNameController.value,
                    // ),
                    CustomAutoSizeTextMontserrat(
                  text: "Agenda/Purpose of the Meeting",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  child: CustomMultiDownSingle(
                model: list,
                initialSelectedValue: list[0],
                enableMultiSelect: false,
                callbackFunctionSingle: (Value) {
                  controller.agendaPurposeOfMeeting.value = Value;
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

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 5),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child:
                      // CustomTextField(
                      //   hint: 'Creat',
                      //   controller: controller.meetingNameController.value,
                      // ),
                      CustomAutoSizeTextMontserrat(
                    text: "Meeting Name",
                    mandatory: true,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Add TextFormFields and ElevatedButton here.

              Container(
                // height: 45,

                child: CustomTextField(
                    validator: Validator.notEmpty,
                    hint: '',
                    controller: controller.meetingNameController.value),
              ),
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
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: CustomAutoSizeTextMontserrat(
                          text: "Date",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                            height: 45,
                            width: (MediaQuery.of(context).size.width - 60) / 2,
                            child: CustomTimerWidget(callback: (val) {
                              controller.dateController.value = val;

                              print(controller.dateController.value);
                            })),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: CustomAutoSizeTextMontserrat(
                          text: "Time",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            height: 45,
                            width: (MediaQuery.of(context).size.width - 60) / 2,
                            child: CustomTimerWidget2(callback: (val) {
                              // print(val);
                              controller.timeController.value = val;

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
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: CustomAutoSizeTextMontserrat(
                          text: "Proposed Duration",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 0,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            height: 45,
                            width: (MediaQuery.of(context).size.width - 60) / 2,
                            child: CustomTimerWidgetForHourMinutes(
                                callback: (val) async {
                              // var hours = int.parse(val) / 60;
                              // var minutes = int.parse(val) % 60;

                              print(val);

                              var data = val.toString();

                              var time =
                                  '${data.substring(0, 2)} hours ${data.substring(3, 5)} minutes';

                              print(time);

                              // print(val);
                              controller.proposedDurationController.value =
                                  time;
                              // controller.update();
                              // print(controller.proposedDurationController.value);
                            }),
                          ),
                        ),
                      ),

                      // Align(
                      //   alignment: AlignmentDirectional.topStart,
                      //   child: Container(
                      //       height: 45,
                      //       width: (MediaQuery.of(context).size.width - 40) / 2,
                      //       // decoration: BoxDecoration(
                      //       //     color: ThemeConstants.lightgreycolor,
                      //       //     borderRadius:
                      //       //         const BorderRadius.all(Radius.circular(10.0))),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //             decoration: BoxDecoration(
                      //                 color: ThemeConstants.lightVioletColor,
                      //                 borderRadius: BorderRadius.circular(15)),
                      //             width:
                      //                 (MediaQuery.of(context).size.width - 40) /
                      //                     4.5,
                      //             child: TextFormField(
                      //               keyboardType: TextInputType.number,
                      //               decoration: InputDecoration(
                      //                 contentPadding: EdgeInsets.symmetric(
                      //                     vertical: 10, horizontal: 15),
                      //                 hintText: 'Hours',
                      //                 filled: true,
                      //                 fillColor: ThemeConstants.lightblueColor,
                      //                 border: OutlineInputBorder(
                      //                   borderSide: BorderSide.none,
                      //                   borderRadius: BorderRadius.circular(15.0),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 5,
                      //           ),
                      //           Container(
                      //             decoration: BoxDecoration(
                      //                 color: ThemeConstants.lightVioletColor,
                      //                 borderRadius: BorderRadius.circular(15)),
                      //             width:
                      //                 (MediaQuery.of(context).size.width - 40) /
                      //                     4.5,
                      //             child: TextFormField(
                      //               keyboardType: TextInputType.number,
                      //               decoration: InputDecoration(
                      //                 contentPadding: EdgeInsets.symmetric(
                      //                     vertical: 10, horizontal: 15),
                      //                 hintText: 'Minutes',
                      //                 filled: true,
                      //                 fillColor: ThemeConstants.lightblueColor,
                      //                 border: OutlineInputBorder(
                      //                   borderSide: BorderSide.none,
                      //                   borderRadius: BorderRadius.circular(15.0),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       )),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CustomAutoSizeTextMontserrat(
                            text: "Meeting Type",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 60) /
                                          2,
                                  child: CustomMultiDownSingle(
                                      callbackFunctionSingle: (val) {
                                        print(val);
                                        if (val == 'Offline') {
                                          controller.MeetingType.value = false;
                                          controller.meetingLocation =
                                              true.toString();
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
                  ),
                ],
              ),
              if (controller.MeetingType.value == false) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Location",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
                        controller.meetingLocation = false.toString();
                        controller.update();
                      }
                      if (val == 'Siec Branch') {
                        controller.meetingLocation = true.toString();
                        controller.update();
                      }
                    },
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                if (controller.meetingLocation == true.toString()) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Select Branch",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  //
                  Container(
                    child: CustomMultiDownSingleAllUser(
                      enableMultiSelect: false,
                      model: controller.branchList,
                      initialSelectedValue: 'Siec Branch',
                      callbackFunctionSingle: (AllUserModel val) {
                        print('$val ddd');
                        controller.selectMeetingBranch.value = val;
                        controller.update();
                      },
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Specify Location",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  //
                  Container(
                    padding: EdgeInsets.only(left: 0),
                    child: CustomTextField(
                        validator: Validator.notEmpty,
                        hint: '',
                        controller: controller.specifyMeetingLocation.value),
                  ),
                ]
              ],

              if (controller.MeetingType.value == true) ...[
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Mode of Meeting",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      mandatory: true,
                      text: "Meeting Link",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  // height: 45,

                  child: CustomTextField(
                    validator: controller.MeetingType.value == true
                        ? Validator.notEmpty
                        : null,
                    hint: '',
                    controller: controller.meetingLink.value,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],

              if (controller.externalMeeting == true) ...[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Participants",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // GetX<CreateNewMeetingController>(
                //     init: CreateNewMeetingController(),
                //     builder: (controller) {
                //       if (controller.meetingWith.value == 'University Meetings')
                //         return Column(
                //
                //       children: [

                SizedBox(
                  height: 10,
                ),
                if (controller.meetingWith.value == 'University Meetings') ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Country",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CustomMultiDownSingleAllUser(
                      model: controller.allCountriesList,
                      initialSelectedValue: '',
                      // inititalSelectedList: controller.preFilledUsers.value,
                      callbackFunctionSingle: (AllUserModel val) async {
                        print(val);
                        controller.selectedCountry = val;

                        await controller.getUniversities(val.id!);

                        controller.selectedUniversity =
                            controller.allUniversityList[0];
                        await controller.getRepresentativesByUniversity();
                      },
                      callbackFunctionMulti: (AllUserModel val) {
                        print(val);
                      },
                      enableMultiSelect: false),
                  // CustomMultiDownSingleAllUser(
                  //     model: controller.allCountriesList,
                  //     initialSelectedValue: '',
                  //     // inititalSelectedList: controller.preFilledUsers.value,
                  //     callbackFunctionSingle: (val) async {
                  //       controller.selectedCountry.value = val;
                  //       controller.update();
                  //       await controller.getUniversities(
                  //           controller.selectedCountry.value.id!);
                  //       controller.update();
                  //     },
                  //     callbackFunctionMulti: (AllUserModel val) {
                  //       print(val);
                  //     },
                  //     enableMultiSelect: false),

                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "University Name",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  CustomMultiDownSingleAllUser(
                      model: controller.allUniversityList,
                      initialSelectedValue: '',
                      // inititalSelectedList: controller.preFilledUsers.value,
                      callbackFunctionSingle: (val) async {
                        controller.selectedUniversity = val;
                        await controller.getRepresentativesByUniversity();
                        controller.update();
                        print(val);
                      },
                      callbackFunctionMulti: (AllUserModel val) {
                        print(val);
                      },
                      enableMultiSelect: false),

                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Name of the Person",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  CustomMultiDownSingleAllUser(
                      model: controller.listOfParticipantData,
                      initialSelectedValue: '',
                      // inititalSelectedList: ,
                      callbackFunctionSingle: (val) {
                        controller.participantID.value = val;
                        controller.fetchParticipantData();

                        // controller.selectedBranch.value = val;
                        // controller.update();
                      },
                      callbackFunctionMulti: (List<AllUserModel> val) {
                        print(val);
                        // controller.selectedUsersList.value = val;
                        // controller.update();
                      },
                      enableMultiSelect: false),

                  SizedBox(
                    height: 15,
                  ),
                ],

                // Padding(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: Align(
                //     alignment: AlignmentDirectional.topStart,
                //     child: CustomAutoSizeTextMontserrat(
                //       text: "Country",
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // CustomMultiDownSingleAllUser(
                //     model: controller.allCountriesList,
                //     initialSelectedValue: '',
                //     // inititalSelectedList: ,
                //     callbackFunctionSingle: (val) async {
                //       // controller.selectedBranch.value = val;
                //       // controller.update();
                //       print(val);
                //       controller.selectedCountry.value = val;
                //       await controller
                //           .getUniversities(controllers.selectedCountry.value.id!);
                //       controller.update();
                //     },
                //     callbackFunctionMulti: (List<AllUserModel> val) {
                //       print(val);
                //       // controller.selectedUsersList.value = val;
                //       // controller.update();
                //     },
                //     enableMultiSelect: false),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: Align(
                //     alignment: AlignmentDirectional.topStart,
                //     child: CustomAutoSizeTextMontserrat(
                //       text: "University",
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // CustomMultiDownSingleAllUser(
                //     model: controller.allUniversityList,
                //     initialSelectedValue: '',
                //     // inititalSelectedList: ,
                //     callbackFunctionSingle: (val) {
                //       // controller.selectedBranch.value = val;
                //       // controller.update();
                //     },
                //     callbackFunctionMulti: (List<AllUserModel> val) {
                //       print(val);
                //       // controller.selectedUsersList.value = val;
                //       // controller.update();
                //     },
                //     enableMultiSelect: false),
                //       ],
                //     );
                //   return Container();
                // }),

                if (controller.meetingWith.value == 'Vendor Meeting') ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Name of Vendor",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  if (controller.meetingWith.value == 'Vendor Meeting') ...[
                    CustomMultiDownSingleAllUser(
                        model: controller.listOfParticipantData,
                        initialSelectedValue: '',
                        // inititalSelectedList: ,
                        callbackFunctionSingle: (val) {
                          controller.participantID.value = val;
                          controller.fetchParticipantData();
                          controller.update();
                          // controller.selectedBranch.value = val;
                          // controller.update();
                        },
                        callbackFunctionMulti: (List<AllUserModel> val) {
                          print(val);
                          // controller.selectedUsersList.value = val;
                          // controller.update();
                        },
                        enableMultiSelect: false)
                  ],

                  SizedBox(
                    height: 15,
                  ),

                  // CustomMultiDownSingleAllUser(
                  //     model: controller.allUniversityList,
                  //     initialSelectedValue: '',
                  //     // inititalSelectedList: ,
                  //     callbackFunctionSingle: (val) {
                  //       // controller.selectedBranch.value = val;
                  //       // controller.update();
                  //     },
                  //     callbackFunctionMulti: (List<AllUserModel> val) {
                  //       print(val);
                  //       // controller.selectedUsersList.value = val;
                  //       // controller.update();
                  //     },
                  //     enableMultiSelect: false),
                ],

                if (controller.meetingWith.value == 'Bank Meeting') ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Name of Bank",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (controller.meetingWith.value == 'Bank Meeting') ...[
                    CustomMultiDownSingleAllUser(
                        model: controller.listOfParticipantData,
                        initialSelectedValue: '',
                        // inititalSelectedList: ,
                        callbackFunctionSingle: (val) {
                          controller.participantID.value = val;
                          controller.fetchParticipantData();
                          controller.update();
                        },
                        callbackFunctionMulti: (List<AllUserModel> val) {
                          print(val);
                          // controller.selectedUsersList.value = val;
                          // controller.update();
                        },
                        enableMultiSelect: false),
                    SizedBox(
                      height: 10,
                    ),
                  ]
                ],
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: GestureDetector(
                    onTap: () {
                      addRepresentative(context, controllers);
                      // showDialog(
                      //     context: context,
                      //     builder: (_) => CustomProfileDialogue(
                      //         child: Container(
                      //           child: Column(children: [
                      //             Row(
                      //               children: [
                      //                 CustomButton(text: 'Unive', onPressed: () {}),
                      //                 CustomButton(
                      //                     text: 'Vendor', onPressed: () {}),
                      //                 CustomButton(text: 'Bank', onPressed: () {}),
                      //               ],
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 15),
                      //               child: Align(
                      //                 alignment: AlignmentDirectional.topStart,
                      //                 child: CustomAutoSizeTextMontserrat(
                      //                   text: "University",
                      //                   fontSize: 16,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //             ),
                      //           ]),
                      //         ),
                      //         title: 'Add Representative'));
                    },
                    child: Container(
                      height: 38,
                      width: MediaQuery.of(context).size.width * 0.55,
                      decoration: BoxDecoration(
                          color: ThemeConstants.bluecolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0))),
                      child: Center(
                        child: CustomAutoSizeTextMontserrat(
                          text: "Add New Representative",
                          textColor: ThemeConstants.whitecolor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // child: CustomAutoSizeTextMontserrat(
                    //   text: "ADD",
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                ),
                if (controller.meetingWith.value != 'University Meetings') ...[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Name of the Person",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeConstants.bluecolor, width: 1),
                          color: ThemeConstants.lightVioletColor,
                          borderRadius: BorderRadius.circular(500)),
                      width: double.infinity,
                      height: 40,
                      child: CustomAutoSizeTextMontserrat(
                          text:
                              '${controller.participantData.value.personName}'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Designation",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ThemeConstants.bluecolor, width: 1),
                      color: ThemeConstants.lightVioletColor,
                      borderRadius: BorderRadius.circular(500)),
                  width: double.infinity,
                  height: 40,
                  child: CustomAutoSizeTextMontserrat(
                    text: '${controller.participantData.value.designation}',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // CustomTextField(
                //   hint: '',
                //   controller: controller.designation.value,
                // ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 15),
                //   child: Align(
                //     alignment: AlignmentDirectional.topStart,
                //     child: CustomAutoSizeTextMontserrat(
                //       text: "Add Representative",
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Email id",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ThemeConstants.bluecolor, width: 1),
                        color: ThemeConstants.lightVioletColor,
                        borderRadius: BorderRadius.circular(500)),
                    width: double.infinity,
                    height: 40,
                    child: CustomAutoSizeTextMontserrat(
                      text: '${controller.participantData.value.email}',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // CustomTextField(
                //   hint: '',
                //   controller: controller.designation.value,
                // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Phone Number",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ThemeConstants.bluecolor, width: 1),
                        color: ThemeConstants.lightVioletColor,
                        borderRadius: BorderRadius.circular(500)),
                    width: double.infinity,
                    height: 40,
                    child: CustomAutoSizeTextMontserrat(
                      text: '${controller.participantData.value.phone}',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                // CustomTextField(
                //   hint: '',
                //   controller: controller.designation.value,
                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    DialogHora(controller: controller));
                            // controller.listOfParticipants
                            //     .add(controllers.participantData.value);
                            controller.update();
                          },
                          child: Container(
                            height: 38,
                            width: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: ThemeConstants.orangeColor),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            child: Center(
                              child: CustomAutoSizeTextMontserrat(
                                  text: "View Participants",
                                  textColor: ThemeConstants.orangeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.listOfParticipants
                                .add(controllers.participantData.value);
                            controller.update();
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      content: Container(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  'Participant Added Successfully'),
                                              Icon(Icons.check_circle,
                                                  size: 30,
                                                  color:
                                                      ThemeConstants.GreenColor)
                                            ]),
                                      ),
                                    ));
                          },
                          child: Container(
                            height: 38,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                                color: ThemeConstants.bluecolor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            child: Center(
                              child: CustomAutoSizeTextMontserrat(
                                  text: "Add Participants",
                                  textColor: ThemeConstants.whitecolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //
                // Container(
                //   alignment: Alignment.center,
                //   height: 200,
                //   decoration: BoxDecoration(
                //       color: ThemeConstants.whitecolor,
                //       borderRadius: BorderRadius.circular(5),
                //       border: Border.all(
                //           width: 1, color: ThemeConstants.VioletColor)),
                //   width: double.infinity,
                //   child: ListView(
                //     children: [
                //       Wrap(
                //           alignment: WrapAlignment.center,
                //           spacing: 10,
                //           children: [...controller.allParticipants(controllers)]),
                //     ],
                //   ),
                // ),
                // CustomMultiDownSingle(
                //     enableMultiSelect: false,
                //     callbackFunctionSingle: (val) {
                //       controller.meetingWith.value = val;
                //       controller.update();
                //     },
                //     model: controller.meetingWithList,
                //     initialSelectedValue: '${controllers.meetingWith}'),

                SizedBox(
                  height: 10,
                )
              ],

              Padding(
                padding: const EdgeInsets.only(left: 0),
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
                padding: const EdgeInsets.only(left: 0),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "(Trigger Notification)",
                    textColor: ThemeConstants.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 8),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "Select target Audience Type",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              CustomMultiDownSingle(
                  field: Container(
                    height: 22,
                    child: CustomTextField(
                      forDropDown: false,
                      backgroundCOlour: Colors.transparent,
                      hint: '',
                      readOrEdit: true,
                      controller: TextEditingController(),
                      validator: controller.selectedTargetAudience.value == ''
                          ? Validator.plzSelectOne
                          : null,
                    ),
                  ),
                  callbackFunctionSingle: (val) async {
                    print(val);
                    controller.selectedTargetAudience.value = val;

                    // controller.preFilledUsers.clear();
                    // if (val.toString().toLowerCase() == 'branch based') {
                    //   await controller.getBranchData();
                    //   controller.update();
                    // }
                    controller.groupNames.value = '';
                    controller.preFilledUsers = [];
                    if (controller.selectedTargetAudience.value ==
                        'Branch Based') {
                      controller.branchSelected(controller.branchList[0]);
                    }
                    if (controller.selectedTargetAudience.value == 'All User') {
                      controller.preFilledUsers =
                          Get.find<BaseController>().allSiecMembersList;
                    }
                    controller.update();

                    // print(controller.selectedTargetAudience.value);
                  },
                  enableMultiSelect: false,
                  model: controller.selectTargetAudienceType,
                  initialSelectedValue:
                      '${controller.selectedTargetAudience.value}'),

              if (controller.selectedTargetAudience.value == 'Group Wise') ...[
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Select Group",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomMultiDownSingle(
                    field: Container(
                      height: 22,
                      child: CustomTextField(
                        readOrEdit: true,
                        forDropDown: false,
                        backgroundCOlour: Colors.transparent,
                        hint: '',
                        controller: TextEditingController(),
                        validator: controller.groupNames.value == ''
                            ? Validator.plzSelectOne
                            : null,
                      ),
                    ),
                    callbackFunctionSingle: (val) async {
                      // print(val + "sdddd");
                      controller.groupNames.value = val;
                      await controller.showList(val);
                      controller.update();
                    },
                    enableMultiSelect: false,
                    model: controller.groupNamesAudienceType.value,
                    initialSelectedValue: ''),
              ],

              if (controller.selectedTargetAudience.value ==
                  'Branch Based') ...[
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Select Branch",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomMultiDownSingleAllUser(
                  field: Container(
                    height: 22,
                    child: CustomTextField(
                      forDropDown: false,
                      backgroundCOlour: Colors.transparent,
                      hint: '',
                      controller: TextEditingController(),
                      validator: controller.groupNames.value == ''
                          ? Validator.plzSelectOne
                          : null,
                    ),
                  ),
                  enableMultiSelect: false,
                  model: controller.branchList,

                  initialSelectedValue: 'Siec Branch',
                  callbackFunctionSingle: (AllUserModel val) async {
                    await controller.branchSelected(val);
                  },
                  // callbackFunctionSingle: (AllUserModel val) {
                  //   print('$val ddd');
                  //   controller.selectMeetingBranch.value = val;
                  // },
                ),

                // CustomMultiDownSingle(
                //     callbackFunctionSingle: (val) async {
                //       await controller.branchSelected(val);
                //       controller.update();
                //     },
                //     enableMultiSelect: false,
                //     model: controller.branchList.value,
                //     initialSelectedValue: ''),
              ],

              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "Select User",
                    mandatory: true,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              CustomMultiDownSingleAllUser(
                  model: Get.find<BaseController>().allSiecMembersList,
                  initialSelectedValue: '',
                  inititalSelectedList: controller.preFilledUsers,

                  // callbackFunctionSingle: (val) {
                  //   // controller.selectedBranch.value = val;
                  //   // controller.update();
                  // },
                  callbackFunctionMulti: (List<AllUserModel> val) {
                    print(val);
                    controller.selectedUsersList = val;
                    controller.update();
                  },
                  enableMultiSelect: true),

              // CustomMultiDownSingle(
              //     model: Get.find<DashBoardController>().listBro,
              //     initialSelectedValue: '',
              //     inititalSelectedList: ['Nancy Gupta', 'Admin', 'Sharmila'],
              //     // callbackFunctionSingle: (val) {
              //     //   // controller.selectedBranch.value = val;
              //     //   // controller.update();
              //     // },
              //     callbackFunctionMulti: (val) {
              //       print(val);
              //       controller.selectedUsersList.value = val;
              //       // controller.update();
              //     },
              //     enableMultiSelect: true),

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

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "Meeting Cordinator",
                    mandatory: true,
                    textColor: ThemeConstants.bluecolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              CustomMultiDownSingleAllUser(
                  model: Get.find<BaseController>().allSiecMembersList,
                  initialSelectedValue: '',

                  // callbackFunctionSingle: (val) {
                  //   // controller.selectedBranch.value = val;
                  //   // controller.update();
                  // },
                  callbackFunctionMulti: (List<AllUserModel> val) {
                    print(val);
                    controller.selectedCoordinatorList.value = val;
                    controller.update();
                  },
                  enableMultiSelect: true),
              // CustomMultiDownSingle(
              //     model: controller.groupNamesAudienceType,
              //     initialSelectedValue: '',
              //     // inititalSelectedList: ['Nancy Gupta', 'Admin', 'Sharmila'],
              //     // callbackFunctionSingle: (val) {
              //     //   // controller.selectedBranch.value = val;
              //     //   // controller.update();
              //     // },
              //     callbackFunctionMulti: (val) {
              //       print(val);
              //       controller.selectedCoordinatorList.value = val;
              //       // controller.update();
              //     },
              //     enableMultiSelect: true),

              // CustomMultiDownSingle(
              //     enableMultiSelect: true,
              //     callbackFunctionSingle: (val) {
              //       controller.update();
              //     },
              //     model: controller.groupNamesAudienceType,
              //     initialSelectedValue: ''),
              // const SizedBox(
              //   height: 25,
              // ),

              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  if (controller.key.currentState!.validate()) {
                    print(controller.externalMeeting);
                    if (controller.externalMeeting == false) {
                      print('ff');
                      controller.createNewMeeting();
                    } else {
                      controller.createExternalNewMeeting();
                    }
                    controller.key.currentState!.save();
                  } else {
                    getToast('${SnackBarConstants.requiredFields}');
                  }
                },
                child: Container(
                  height: 38,
                  width: 150,
                  decoration: BoxDecoration(
                      color: ThemeConstants.bluecolor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0))),
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
            ])),
      )
    ];
  }

  // List<Widget> getExternalMeeting(
  //     BuildContext context, CreateNewMeetingController controller) {
  //   List<String> list = <String>[
  //     'All Meetings',
  //     'Launch of New program',
  //     'Training',
  //     'Networking',
  //     'Institute Partner meet'
  //   ];
  //   return [
  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "Meeting with",
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     CustomMultiDownSingle(
  //         enableMultiSelect: false,
  //         callbackFunctionSingle: (val) {
  //           controller.update();
  //         },
  //         model: controller.meetingWithList,
  //         initialSelectedValue: ''),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   child: CustomTextField(
  //     //     hint: '',
  //     //     controller: controller.dateController.value,
  //     //   ),
  //     // ),
  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "Agenda/Purpose of the Meeting",
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     Container(
  //         child: CustomMultiDownSingle(
  //       model: list,
  //       initialSelectedValue: list[0],
  //       enableMultiSelect: false,
  //       callbackFunctionSingle: (Value) {
  //         controller.agendaPurposeOfMeeting.value = Value;
  //         controller.update();
  //       },
  //     )),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "Meeting Name",
  //           mandatory: true,
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     CustomTextField(
  //         hint: '', controller: controller.meetingNameController.value),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     SizedBox(
  //       height: 10,
  //     ),
  //     Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Column(
  //           children: [
  //             CustomAutoSizeTextMontserrat(
  //               text: "Date",
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //             Align(
  //               alignment: AlignmentDirectional.topStart,
  //               child: Container(
  //                 height: 45,
  //                 width: (MediaQuery.of(context).size.width - 40) / 2,
  //                 // child: CustomTextField(
  //                 //   hint: '',
  //                 //   controller: controller.dateController.value,
  //                 // ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Column(
  //           children: [
  //             CustomAutoSizeTextMontserrat(
  //               text: "Time",
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 10),
  //               child: Align(
  //                 alignment: AlignmentDirectional.topStart,
  //                 child: Container(
  //                   height: 45,
  //                   width: (MediaQuery.of(context).size.width - 40) / 2,
  //                   child: Container(
  //                     height: 45,
  //                     width: (MediaQuery.of(context).size.width - 40) / 2,
  //                     // child: CustomTextField(
  //                     //   hint: '',
  //                     //   controller: controller.dateController.value,
  //                     // )
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),

  //     SizedBox(
  //       height: 10,
  //     ),
  //     Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Column(
  //           children: [
  //             CustomAutoSizeTextMontserrat(
  //               text: "Proposed Duration",
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //             Align(
  //               alignment: AlignmentDirectional.topStart,
  //               child: Container(
  //                 height: 45,
  //                 width: (MediaQuery.of(context).size.width - 40) / 2,
  //                 // decoration: BoxDecoration(
  //                 //     color: ThemeConstants.lightgreycolor,
  //                 //     borderRadius:
  //                 //         const BorderRadius.all(Radius.circular(10.0))),
  //                 // child: CustomTextField(
  //                 //   hint: '',
  //                 //   controller: controller.dateController.value,
  //                 // ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Column(
  //           children: [
  //             CustomAutoSizeTextMontserrat(
  //               text: "Meeting Type",
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 10),
  //               child: Align(
  //                   alignment: AlignmentDirectional.topStart,
  //                   child: Container(
  //                       width: (MediaQuery.of(context).size.width - 40) / 2,
  //                       child: CustomMultiDownSingle(
  //                           callbackFunctionSingle: (val) {
  //                             print(val.runtimeType);
  //                             if (val == 'Offline') {
  //                               controller.MeetingType.value = false;
  //                               controller.update();
  //                             } else {
  //                               controller.MeetingType.value = true;
  //                               controller.update();
  //                             }
  //                           },
  //                           enableMultiSelect: false,
  //                           model: ['Online', 'Offline'],
  //                           initialSelectedValue: 'Online'))),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //     if (controller.MeetingType.value == false) ...[
  //       Padding(
  //         padding: const EdgeInsets.only(left: 15),
  //         child: Align(
  //           alignment: AlignmentDirectional.topStart,
  //           child: CustomAutoSizeTextMontserrat(
  //             text: "Location",
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       //
  //       Container(
  //         child: CustomMultiDownSingle(
  //           enableMultiSelect: false,
  //           model: ['Siec Branch', 'Others'],
  //           initialSelectedValue: 'Siec Branch',
  //           callbackFunctionSingle: (val) {
  //             print(val);
  //             if (val == 'Others') {
  //               controller.meetingLocation.value = false;
  //               controller.update();
  //             }
  //             if (val == 'Siec Branch') {
  //               controller.meetingLocation.value = true;
  //               controller.update();
  //             }
  //           },
  //         ),
  //       ),

  //       if (controller.meetingLocation.value == true) ...[
  //         Padding(
  //           padding: const EdgeInsets.only(left: 15),
  //           child: Align(
  //             alignment: AlignmentDirectional.topStart,
  //             child: CustomAutoSizeTextMontserrat(
  //               text: "Select Branch",
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         //
  //         Container(
  //           child: CustomMultiDownSingle(
  //             enableMultiSelect: false,
  //             model: ['Siec Branch', 'Others'],
  //             initialSelectedValue: 'Siec Branch',
  //             callbackFunctionSingle: (val) {
  //               if (val == 'Others') {
  //                 controller.meetingLocation.value = false;
  //                 controller.update();
  //               }
  //             },
  //           ),
  //         ),
  //       ] else ...[
  //         Padding(
  //           padding: const EdgeInsets.only(left: 15),
  //           child: Align(
  //             alignment: AlignmentDirectional.topStart,
  //             child: CustomAutoSizeTextMontserrat(
  //               text: "Specify Location",
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         //
  //         Container(
  //             // child: CustomTextField(
  //             //   hint: '',
  //             //   controller: controller.dateController.value,
  //             // ),
  //             ),
  //       ]
  //     ],
  //     if (controller.MeetingType.value == true) ...[
  //       Padding(
  //         padding: const EdgeInsets.only(left: 15),
  //         child: Align(
  //           alignment: AlignmentDirectional.topStart,
  //           child: CustomAutoSizeTextMontserrat(
  //             text: "Mode of Meeting",
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       CustomMultiDownSingle(
  //         enableMultiSelect: false,
  //         model: ['Zoom', 'Meet', 'Teams'],
  //         initialSelectedValue: 'Zoom',
  //         callbackFunctionSingle: (val) {
  //           print(val);
  //         },
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 15),
  //         child: Align(
  //           alignment: AlignmentDirectional.topStart,
  //           child: CustomAutoSizeTextMontserrat(
  //             text: "Meeting Link",
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         height: 45,
  //         width: MediaQuery.of(context).size.width - 40,
  //         // child:
  //         //  CustomTextField(
  //         //   hint: '',
  //         //   controller: controller.dateController.value,
  //         // ),
  //       ),
  //     ],

  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 25),
  //     //   child: Align(
  //     //     alignment: AlignmentDirectional.topStart,
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Mode of Meeting",
  //     //       fontSize: 16,
  //     //       fontWeight: FontWeight.bold,
  //     //     ),
  //     //   ),
  //     // ),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 25),
  //     //   child: Align(
  //     //     alignment: AlignmentDirectional.topStart,
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Meeting Link",
  //     //       fontSize: 16,
  //     //       fontWeight: FontWeight.bold,
  //     //     ),
  //     //   ),
  //     // ),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     // Container(
  //     //   height: 38,
  //     //   width: 150,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.bluecolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(30.0))),
  //     //   child: Center(
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Next",
  //     //       textColor: ThemeConstants.whitecolor,
  //     //       fontSize: 20,
  //     //     ),
  //     //   ),
  //     // ),
  //     // // Participants
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 15),
  //     //   child: Align(
  //     //     alignment: AlignmentDirectional.topStart,
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Participants",
  //     //       textColor: ThemeConstants.bluecolor,
  //     //       fontSize: 18,
  //     //       fontWeight: FontWeight.bold,
  //     //     ),
  //     //   ),
  //     // ),
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 15, top: 10),
  //     //   child: Row(
  //     //     crossAxisAlignment: CrossAxisAlignment.start,
  //     //     mainAxisAlignment: MainAxisAlignment.start,
  //     //     children: [
  //     //       Column(
  //     //         children: [
  //     //           CustomAutoSizeTextMontserrat(
  //     //             text: "Country",
  //     //             fontSize: 16,
  //     //             fontWeight: FontWeight.bold,
  //     //           ),
  //     //           Padding(
  //     //             padding: const EdgeInsets.only(left: 10),
  //     //             child: Align(
  //     //               alignment: AlignmentDirectional.topStart,
  //     //               child: Container(
  //     //                 height: 45,
  //     //                 width: (MediaQuery.of(context).size.width - 40) / 2,
  //     //                 decoration: BoxDecoration(
  //     //                     color: ThemeConstants.lightgreycolor,
  //     //                     borderRadius:
  //     //                         const BorderRadius.all(Radius.circular(10.0))),
  //     //               ),
  //     //             ),
  //     //           ),
  //     //         ],
  //     //       ),
  //     //       Column(
  //     //         children: [
  //     //           CustomAutoSizeTextMontserrat(
  //     //             text: "University",
  //     //             fontSize: 16,
  //     //             fontWeight: FontWeight.bold,
  //     //           ),
  //     //           Padding(
  //     //             padding: const EdgeInsets.only(left: 10),
  //     //             child: Align(
  //     //               alignment: AlignmentDirectional.topStart,
  //     //               child: Container(
  //     //                 height: 45,
  //     //                 width: (MediaQuery.of(context).size.width - 40) / 2,
  //     //                 decoration: BoxDecoration(
  //     //                     color: ThemeConstants.lightgreycolor,
  //     //                     borderRadius:
  //     //                         const BorderRadius.all(Radius.circular(10.0))),
  //     //               ),
  //     //             ),
  //     //           ),
  //     //         ],
  //     //       ),
  //     //     ],
  //     //   ),
  //     // ),

  //     // const SizedBox(
  //     //   height: 10,
  //     // ),
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 15, right: 15),
  //     //   child: Container(
  //     //     height: 38,
  //     //     width: MediaQuery.of(context).size.width,
  //     //     decoration: BoxDecoration(
  //     //         color: ThemeConstants.bluecolor,
  //     //         borderRadius: const BorderRadius.all(Radius.circular(30.0))),
  //     //     child: Center(
  //     //       child: CustomAutoSizeTextMontserrat(
  //     //         text: "Add new Representative",
  //     //         textColor: ThemeConstants.whitecolor,
  //     //         fontSize: 20,
  //     //       ),
  //     //     ),
  //     //   ),
  //     // ),
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 15),
  //     //   child: Align(
  //     //     alignment: AlignmentDirectional.topStart,
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Name of person",
  //     //       mandatory: true,
  //     //       fontSize: 16,
  //     //       fontWeight: FontWeight.bold,
  //     //     ),
  //     //   ),
  //     // ),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 15),
  //     //   child: Align(
  //     //     alignment: AlignmentDirectional.topStart,
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Designation",
  //     //       mandatory: true,
  //     //       fontSize: 16,
  //     //       fontWeight: FontWeight.bold,
  //     //     ),
  //     //   ),
  //     // ),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 15),
  //     //   child: Align(
  //     //     alignment: AlignmentDirectional.topStart,
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Email",
  //     //       mandatory: true,
  //     //       fontSize: 16,
  //     //       fontWeight: FontWeight.bold,
  //     //     ),
  //     //   ),
  //     // ),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 15),
  //     //   child: Align(
  //     //     alignment: AlignmentDirectional.topStart,
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Phone",
  //     //       mandatory: true,
  //     //       fontSize: 16,
  //     //       fontWeight: FontWeight.bold,
  //     //     ),
  //     //   ),
  //     // ),
  //     SizedBox(
  //       height: 10,
  //     ),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     // Row(
  //     //   children: [
  //     //     const Spacer(),
  //     //     Container(
  //     //       height: 38,
  //     //       decoration: BoxDecoration(
  //     //           color: ThemeConstants.whitecolor,
  //     //           border: Border.all(color: ThemeConstants.firstColor),
  //     //           borderRadius: const BorderRadius.all(Radius.circular(30.0))),
  //     //       child: Center(
  //     //         child: CustomAutoSizeTextMontserrat(
  //     //           text: "View Participants",
  //     //           textColor: ThemeConstants.firstColor,
  //     //           fontSize: 16,
  //     //         ),
  //     //       ),
  //     //     ),
  //     //     const Spacer(),
  //     //     Container(
  //     //       height: 38,
  //     //       width: 150,
  //     //       decoration: BoxDecoration(
  //     //           color: ThemeConstants.bluecolor,
  //     //           borderRadius: const BorderRadius.all(Radius.circular(30.0))),
  //     //       child: Center(
  //     //         child: CustomAutoSizeTextMontserrat(
  //     //           text: "Next",
  //     //           textColor: ThemeConstants.whitecolor,
  //     //           fontSize: 16,
  //     //         ),
  //     //       ),
  //     //     ),
  //     //     const Spacer(),
  //     //   ],
  //     // ),
  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "SIEC Persons attending the meeting",
  //           textColor: ThemeConstants.bluecolor,
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "(trigger Notification)",
  //           textColor: ThemeConstants.red,
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),

  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "Select Target Audience Type",
  //           mandatory: true,
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     CustomMultiDownSingle(
  //         callbackFunctionSingle: (val) {
  //           print(val);
  //           // controller.selectedTargetAudience.value = val;
  //           // controller.update();
  //           // print(controller.selectedTargetAudience.value);
  //         },
  //         enableMultiSelect: false,
  //         model: controller.selectTargetAudienceType,
  //         initialSelectedValue: '${controller.selectedTargetAudience.value}'),

  //     if (controller.selectedTargetAudience.value == 'Group Wise') ...[
  //       Padding(
  //         padding: const EdgeInsets.only(left: 15),
  //         child: Align(
  //           alignment: AlignmentDirectional.topStart,
  //           child: CustomAutoSizeTextMontserrat(
  //             text: "Group names",
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //       CustomMultiDownSingle(
  //           enableMultiSelect: false,
  //           callbackFunctionSingle: (val) {
  //             controller.update();
  //           },
  //           model: controller.groupNamesAudienceType,
  //           initialSelectedValue: ''),
  //     ],

  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "Select User",
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),

  //     // CustomMultiDownSingleAllUser(
  //     //     model: Get.find<DashBoardController>().listBro,
  //     //     initialSelectedValue: 'Nidhi Vij',
  //     //     enableMultiSelect: true),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     // Padding(
  //     //   padding: const EdgeInsets.only(left: 15),
  //     //   child: Align(
  //     //     alignment: AlignmentDirectional.topStart,
  //     //     child: CustomAutoSizeTextMontserrat(
  //     //       text: "Group Names",
  //     //       mandatory: true,
  //     //       fontSize: 16,
  //     //       fontWeight: FontWeight.bold,
  //     //     ),
  //     //   ),
  //     // ),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "Meeting Cordinator",
  //           textColor: ThemeConstants.bluecolor,
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     Padding(
  //       padding: const EdgeInsets.only(left: 15),
  //       child: Align(
  //         alignment: AlignmentDirectional.topStart,
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "Select User",
  //           mandatory: true,
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     CustomMultiDownSingle(
  //         enableMultiSelect: true,
  //         callbackFunctionSingle: (val) {
  //           controller.update();
  //         },
  //         model: controller.groupNamesAudienceType,
  //         initialSelectedValue: ''),
  //     const SizedBox(
  //       height: 25,
  //     ),
  //     // Container(
  //     //   height: 45,
  //     //   width: MediaQuery.of(context).size.width - 40,
  //     //   decoration: BoxDecoration(
  //     //       color: ThemeConstants.lightgreycolor,
  //     //       borderRadius: const BorderRadius.all(Radius.circular(10.0))),
  //     // ),
  //     Container(
  //       height: 38,
  //       width: 150,
  //       decoration: BoxDecoration(
  //           color: ThemeConstants.bluecolor,
  //           borderRadius: const BorderRadius.all(Radius.circular(30.0))),
  //       child: Center(
  //         child: CustomAutoSizeTextMontserrat(
  //           text: "Create",
  //           textColor: ThemeConstants.whitecolor,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),

  //     SizedBox(
  //       height: 30,
  //     )
  //   ];
  // }

  addRepresentative(
      BuildContext context, CreateNewMeetingController2 controller) {
    return showDialog(
        context: context,
        builder: (_) {
          print(controller.addRepresentaitveType.value);
          return AddRepresentativeWidget(controller: controller);
        });
  }
}
