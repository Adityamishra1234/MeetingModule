import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller2.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/presentation/dashboard/view/ui/dashboard_page.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/addRepresentative_widget.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_time_picker_only.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget_pick_hour_minutes.dart';
import 'package:meeting_module2/widget/custom_dialog_box.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';
import 'package:meeting_module2/widget/custom_tab_widget_2.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';
import 'package:meeting_module2/widget/view_particpant_dialog.dart';

class CreateNewMeeting2 extends StatelessWidget {
  static const routeNamed = 'CreateNewMeeting';
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CreateNewMeetingController2());

    return Scaffold(
        body: controller.obx(
            (state) => WillPopScope(
                  onWillPop: () async {
                    context.pop('true');
                    return true;
                  },
                  child: SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: ThemeConstants.backgroundGradient),
                      padding: EdgeInsets.only(top: 10, left: 0, right: 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: CustomAutoSizeTextMontserrat(
                                text: "Create New Meeting",
                                fontSize: 28,
                                textColor: ThemeConstants.paleYellow,
                                fontWeight: ThemeConstants.fontWeightHeavyBold,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                CustomTabWidget2(
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
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          // if (controller.externalMeeting.value)
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: ThemeConstants.whitecolor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35))),
                            padding: const EdgeInsets.only(
                                top: 30, left: 25, right: 25),
                            child: ListView(
                              children: [
                                ...getListInternalmeeting(context, controller),
                              ],
                            ),
                          ))
                          // if (controller.externalMeeting.value)
                          //   ...getExternalMeeting(context, controller)
                        ],
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

              Row(
                children: [
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
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: ThemeConstants.bluecolor,
                    child: IconButton(
                      iconSize: 15,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  contentPadding: EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomAutoSizeTextMontserrat(
                                            text: 'Add new Agenda'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          // height: 45,

                                          child: CustomTextField(
                                              validator: Validator.notEmpty,
                                              hint: '',
                                              controller: controller
                                                  .addNewAgendaController
                                                  .value),
                                        ),
                                        CustomButton(
                                            backgroundColor:
                                                ThemeConstants.bluecolor,
                                            text: 'Add',
                                            onPressed: () async {
                                              if (controller
                                                      .addNewAgendaController
                                                      .value
                                                      .text ==
                                                  '') {
                                                getToast('Please Fill');
                                              } else {
                                                var data = await controller
                                                    .addNewAgenda(
                                                        agenda: controller
                                                            .addNewAgendaController
                                                            .value
                                                            .text,
                                                        userId: Get.find<
                                                                BaseController>()
                                                            .id);

                                                if (data) {
                                                  context.pop();
                                                }
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      icon: Icon(
                        Icons.add,
                        color: ThemeConstants.whitecolor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              if (controller.agendaList.length == 0) ...[
                Container(),
              ] else ...[
                Container(
                    child: CustomMultiDownSingle(
                  model: controller.agendaList,
                  initialSelectedValue: controller.agendaList[0],
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
              ],

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
                      Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width - 55,
                          child: CustomTimerWidget(
                              field: Container(
                                height: 25,
                                child: CustomTextField(
                                  forDropDown: false,
                                  backgroundCOlour: Colors.transparent,
                                  hint: '',
                                  readOrEdit: true,
                                  controller: TextEditingController(),
                                  validator:
                                      controller.dateController.value == ''
                                          ? Validator.plzSelectOne
                                          : null,
                                ),
                              ),
                              startingDate: DateTime.now(),
                              isBlank: true,
                              callback: (val) {
                                controller.dateController.value = val;

                                print(controller.dateController.value);
                              })),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            height: 65,
                            width: (MediaQuery.of(context).size.width - 60) / 2,
                            child: CustomTimerWidget2(
                              field: Container(
                                height: 22,
                                child: CustomTextField(
                                  forDropDown: false,
                                  backgroundCOlour: Colors.transparent,
                                  hint: '',
                                  readOrEdit: true,
                                  controller: TextEditingController(),
                                  validator:
                                      controller.timeController.value == ''
                                          ? Validator.plzSelectOne
                                          : null,
                                ),
                              ),
                              callback: (val) {
                                // print(val);
                                controller.timeController.value = val;

                                print(controller.timeController.value);
                              },
                              isBlank: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                          bottom: 8,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            height: 65,
                            width: (MediaQuery.of(context).size.width - 60) / 2,
                            child: CustomTimerWidgetForHourMinutes(
                                field: Container(
                                  height: 22,
                                  child: CustomTextField(
                                    forDropDown: false,
                                    backgroundCOlour: Colors.transparent,
                                    hint: '',
                                    readOrEdit: true,
                                    controller: TextEditingController(),
                                    validator: controller
                                                .proposedDurationController
                                                .value ==
                                            '0 hours 0 minutes'
                                        ? Validator.plzSelectOne
                                        : null,
                                  ),
                                ),
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
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    spacing: 20,
                    runSpacing: 5,
                    children: [
                      Column(
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                  value: true,
                                  groupValue: controller.MeetingType.value,
                                  onChanged: (value) {
                                    controller.MeetingType.value = true;
                                    controller.meetingLocation = null;
                                    print(controller.meetingLocation);
                                    controller.update();
                                  }),
                              CustomAutoSizeTextMontserrat(
                                text: 'Online',
                                fontSize: 10,
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Radio(
                                  value: false,
                                  groupValue: controller.MeetingType.value,
                                  onChanged: (value) {
                                    controller.MeetingType.value = false;
                                    controller.fetchParticipantData();
                                    // controller.selectedOption = 1;
                                    controller.update();
                                  }),
                              CustomAutoSizeTextMontserrat(
                                text: 'Offline',
                                fontSize: 10,
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(),
                          //   child: Align(
                          //       alignment: AlignmentDirectional.topStart,
                          //       child: Container(
                          //           width:
                          //               (MediaQuery.of(context).size.width - 60) / 2,
                          //           child: CustomMultiDownSingle(
                          //               callbackFunctionSingle: (val) {
                          //                 print(val);
                          //                 if (val == 'Offline') {
                          //                   controller.MeetingType.value = false;
                          //                   controller.meetingLocation =
                          //                       true.toString();
                          //                   controller.update();
                          //                 } else {
                          //                   controller.MeetingType.value = true;
                          //                   controller.update();
                          //                 }
                          //               },
                          //               enableMultiSelect: false,
                          //               model: ['Online', 'Offline'],
                          //               initialSelectedValue: 'Online'))),
                          // ),
                        ],
                      ),
                      // Spacer(),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 8),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(bottom: 8),
                  //         child: CustomAutoSizeTextMontserrat(
                  //           text: "Meeting Type",
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(),
                  //         child: Align(
                  //             alignment: AlignmentDirectional.topStart,
                  //             child: Container(
                  //                 width:
                  //                     (MediaQuery.of(context).size.width - 60) /
                  //                         2,
                  //                 child: CustomMultiDownSingle(
                  //                     callbackFunctionSingle: (val) {
                  //                       print(val);
                  //                       if (val == 'Offline') {
                  //                         controller.MeetingType.value = false;
                  //                         controller.meetingLocation =
                  //                             true.toString();
                  //                         controller.update();
                  //                       } else {
                  //                         controller.MeetingType.value = true;
                  //                         controller.update();
                  //                       }
                  //                     },
                  //                     enableMultiSelect: false,
                  //                     model: ['Online', 'Offline'],
                  //                     initialSelectedValue: 'Online'))),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              if (controller.MeetingType.value == false) ...[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceBetween,
                      spacing: 20,
                      runSpacing: 5,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: CustomAutoSizeTextMontserrat(
                                text: "Location",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio(
                                    value: true.toString(),
                                    groupValue: controller.meetingLocation,
                                    onChanged: (value) {
                                      controller.meetingLocation =
                                          true.toString();
                                      controller.update();
                                    }),
                                CustomAutoSizeTextMontserrat(
                                  text: 'Siec Branch',
                                  fontSize: 10,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Radio(
                                    value: false.toString(),
                                    groupValue: controller.meetingLocation,
                                    onChanged: (value) {
                                      controller.meetingLocation =
                                          false.toString();
                                      controller.update();
                                    }),
                                CustomAutoSizeTextMontserrat(
                                  text: 'Others',
                                  fontSize: 10,
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(),
                            //   child: Align(
                            //       alignment: AlignmentDirectional.topStart,
                            //       child: Container(
                            //           width:
                            //               (MediaQuery.of(context).size.width - 60) / 2,
                            //           child: CustomMultiDownSingle(
                            //               callbackFunctionSingle: (val) {
                            //                 print(val);
                            //                 if (val == 'Offline') {
                            //                   controller.MeetingType.value = false;
                            //                   controller.meetingLocation =
                            //                       true.toString();
                            //                   controller.update();
                            //                 } else {
                            //                   controller.MeetingType.value = true;
                            //                   controller.update();
                            //                 }
                            //               },
                            //               enableMultiSelect: false,
                            //               model: ['Online', 'Offline'],
                            //               initialSelectedValue: 'Online'))),
                            // ),
                          ],
                        ),
                        // Spacer(),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8),
                //   child: Align(
                //     alignment: AlignmentDirectional.topStart,
                //     child: CustomAutoSizeTextMontserrat(
                //       text: "Location",
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
                // //

                // Container(
                //   child: CustomMultiDownSingle(
                //     enableMultiSelect: false,
                //     model: ['Siec Branch', 'Others'],
                //     initialSelectedValue: 'Siec Branch',
                //     callbackFunctionSingle: (val) {
                //       print(val);
                //       if (val == 'Others') {
                //         controller.meetingLocation = false.toString();
                //         controller.update();
                //       }
                //       if (val == 'Siec Branch') {
                //         controller.meetingLocation = true.toString();
                //         controller.update();
                //       }
                //     },
                //   ),
                // ),

                // SizedBox(
                //   height: 10,
                // ),
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    height: 110,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.branchListwithFlag.length,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                controller.selectMeetingBranch.value =
                                    controller.branchListwithFlag[index].id!;
                                controller.update();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: 140,
                                decoration: BoxDecoration(
                                    color:
                                        controller.selectMeetingBranch.value ==
                                                controller
                                                    .branchListwithFlag[index]
                                                    .id
                                            ? ThemeConstants.lightblueColor2
                                            : ThemeConstants.whitecolor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 1,
                                        color: ThemeConstants.bluecolor)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: CachedNetworkImage(
                                          imageUrl: controller
                                              .branchListwithFlag[index]
                                              .imageLink!,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${controller.branchListwithFlag[index].name}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ]),
                              ),
                            )),
                  ),

                  //
                  // Container(
                  //   child: CustomMultiDownSingleAllUser(
                  //     enableMultiSelect: false,
                  //     model: controller.branchList,
                  //     initialSelectedValue: 'Siec Branch',
                  //     callbackFunctionSingle: (AllUserModel val) {
                  //       print('$val ddd');
                  //       controller.selectMeetingBranch.value = val;
                  //       controller.update();
                  //     },
                  //   ),
                  // ),

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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  height: 110,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              controller.modeOfMeeting.value =
                                  controller.modeOfMeetingList[index];

                              print(controller.modeOfMeeting.value);
                              // controller.selectMeetingBranch.value =
                              //     controller.branchListwithFlag[index].id!;
                              controller.update();
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 140,
                              decoration: BoxDecoration(
                                  color: controller.modeOfMeeting.value ==
                                          controller.modeOfMeetingList[index]
                                      ? ThemeConstants.lightblueColor2
                                      : ThemeConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 1,
                                      color: ThemeConstants.bluecolor)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: Image.asset(
                                          controller.modeOfMeetingIcon[index]),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${controller.modeOfMeetingList[index]}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ]),
                            ),
                          )),
                ),
                // CustomMultiDownSingle(
                //   enableMultiSelect: false,
                //   model: ['Zoom', 'Meet', 'Teams'],
                //   initialSelectedValue: 'Zoom',
                //   callbackFunctionSingle: (val) {
                //     controller.modeOfMeeting.value = val;
                //   },
                // ),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      mandatory: true,
                      text: "Registration Link",
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
                    controller: controller.registrationLink.value,
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
                      fontSize: 22,
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
                        await controller.fetchParticipantData();
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
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: CustomAutoSizeTextMontserrat(
                              text: "Choose Representative",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
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
                            // height: 38,
                            width: MediaQuery.of(context).size.width * 0.55,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                                color: ThemeConstants.bluecolor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 14,
                                    color: ThemeConstants.whitecolor,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "Add New Representative",
                                    textColor: ThemeConstants.whitecolor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // child: CustomAutoSizeTextMontserrat(
                          //   text: "ADD",
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ],
                    ),
                  ),

                  CustomMultiDownSingleAllUser(
                      model: controller.listOfParticipantData,
                      initialSelectedValue: '',
                      // inititalSelectedList: ,
                      callbackFunctionSingle: (val) async {
                        controller.participantID.value = val;
                        await controller.fetchParticipantData();
                        var contains = false;

                        for (var i = 0;
                            i < controller.listOfParticipants.length;
                            i++) {
                          contains = false;
                          if (controller.listOfParticipants[i].id ==
                              controller.participantData.id) {
                            contains = true;
                          }
                        }

                        if (contains) {
                          getToast('Already added');
                          // showDialog(
                          //     context: context,
                          //     builder: (_) => AlertDialog(
                          //           content: Container(
                          //               child: Text('Already added')),
                          //         ));
                        } else if (controllers.participantData.id == 0) {
                          // showDialog(
                          //     context: context,
                          //     builder: (_) => AlertDialog(
                          //           content: Container(
                          //               child: Text(
                          //                   'Please add a representative')),
                          //         ));

                          getToast('Please add a representative');
                        } else {
                          controller.listOfParticipants
                              .add(controllers.participantData);
                          controller.update();
                          getToast('Participant Added Successfully');
                          // showDialog(
                          //     context: context,
                          //     builder: (_) => AlertDialog(
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(20)),
                          //           content: Container(
                          //             child: Column(
                          //                 mainAxisSize: MainAxisSize.min,
                          //                 children: [
                          //                   Text(
                          //                       'Participant Added Successfully'),
                          //                   Icon(Icons.check_circle,
                          //                       size: 30,
                          //                       color: ThemeConstants
                          //                           .GreenColor)
                          //                 ]),
                          //           ),
                          //         ));
                        }

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

                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: CustomAutoSizeTextMontserrat(
                      text: "Participants attending meeting",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
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
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
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
                            // height: 38,
                            // width: MediaQuery.of(context).size.width * 0.45,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                                color: ThemeConstants.bluecolor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 14,
                                    color: ThemeConstants.whitecolor,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "Add New Vendor",
                                    textColor: ThemeConstants.whitecolor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // child: CustomAutoSizeTextMontserrat(
                          //   text: "ADD",
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ],
                    ),
                  ),

                  if (controller.meetingWith.value == 'Vendor Meeting') ...[
                    CustomMultiDownSingleAllUser(
                        model: controller.listOfParticipantData,
                        initialSelectedValue: '',
                        // inititalSelectedList: ,
                        callbackFunctionSingle: (val) async {
                          controller.participantID.value = val;
                          await controller.fetchParticipantData();

                          var contains = false;
                          for (var i = 0;
                              i < controller.listOfParticipants.length;
                              i++) {
                            contains = false;
                            if (controller.listOfParticipants[i].id ==
                                controller.participantData.id) {
                              contains = true;
                            }
                          }

                          if (contains) {
                            getToast('Already added');
                            // showDialog(
                            //     context: context,
                            //     builder: (_) => AlertDialog(
                            //           content: Container(
                            //               child: Text('Already added')),
                            //         ));
                          } else if (controllers.participantData.id == 0) {
                            // showDialog(
                            //     context: context,
                            //     builder: (_) => AlertDialog(
                            //           content: Container(
                            //               child: Text(
                            //                   'Please add a representative')),
                            //         ));

                            getToast('Please add a representative');
                          } else {
                            controller.listOfParticipants
                                .add(controllers.participantData);
                            controller.update();
                            getToast('Participant Added Successfully');
                            // showDialog(
                            //     context: context,
                            //     builder: (_) => AlertDialog(
                            //           shape: RoundedRectangleBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(20)),
                            //           content: Container(
                            //             child: Column(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 children: [
                            //                   Text(
                            //                       'Participant Added Successfully'),
                            //                   Icon(Icons.check_circle,
                            //                       size: 30,
                            //                       color: ThemeConstants
                            //                           .GreenColor)
                            //                 ]),
                            //           ),
                            //         ));
                          }
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
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
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
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
                            // height: 38,
                            // width: MediaQuery.of(context).size.width * 0.45,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                                color: ThemeConstants.bluecolor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 14,
                                    color: ThemeConstants.whitecolor,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "Add New Bank",
                                    textColor: ThemeConstants.whitecolor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // child: CustomAutoSizeTextMontserrat(
                          //   text: "ADD",
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ],
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
                          var contains = false;
                          for (var i = 0;
                              i < controller.listOfParticipants.length;
                              i++) {
                            contains = false;
                            if (controller.listOfParticipants[i].id ==
                                controller.participantData.id) {
                              contains = true;
                            }
                          }

                          if (contains) {
                            getToast('Already added');
                            // showDialog(
                            //     context: context,
                            //     builder: (_) => AlertDialog(
                            //           content: Container(
                            //               child: Text('Already added')),
                            //         ));
                          } else if (controllers.participantData.id == 0) {
                            // showDialog(
                            //     context: context,
                            //     builder: (_) => AlertDialog(
                            //           content: Container(
                            //               child: Text(
                            //                   'Please add a representative')),
                            //         ));

                            getToast('Please add a representative');
                          } else {
                            controller.listOfParticipants
                                .add(controllers.participantData);
                            controller.update();
                            getToast('Participant Added Successfully');
                            // showDialog(
                            //     context: context,
                            //     builder: (_) => AlertDialog(
                            //           shape: RoundedRectangleBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(20)),
                            //           content: Container(
                            //             child: Column(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 children: [
                            //                   Text(
                            //                       'Participant Added Successfully'),
                            //                   Icon(Icons.check_circle,
                            //                       size: 30,
                            //                       color: ThemeConstants
                            //                           .GreenColor)
                            //                 ]),
                            //           ),
                            //         ));
                          }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     controller.showRepresentativeData =
                    //         !controller.showRepresentativeData;

                    //     // showDialog(
                    //     //     context: context,
                    //     //     builder: (_) => DialogHora(controller: controller));
                    //     // controller.listOfParticipants
                    //     //     .add(controllers.participantData.value);
                    //     controller.update();
                    //   },
                    //   child: Container(
                    //     height: 38,
                    //     width: MediaQuery.of(context).size.width * 0.35,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(
                    //             width: 1, color: ThemeConstants.orangeColor),
                    //         color: Colors.transparent,
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(30.0))),
                    //     child: Center(
                    //       child: CustomAutoSizeTextMontserrat(
                    //           text: "View Representative Data",
                    //           align: TextAlign.center,
                    //           textColor: ThemeConstants.orangeColor,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //   ),
                    // ),

                    // GestureDetector(
                    //   onTap: () {
                    //     showAnimatedDialog(
                    //       context: context,
                    //       builder: (ctx) => ExistingRepresentativeModal(
                    //         controller2: controller,
                    //       ),
                    //     );
                    //     // addRepresentative(context, controllers);
                    //     // showDialog(
                    //     //     context: context,
                    //     //     builder: (_) => CustomProfileDialogue(
                    //     //         child: Container(
                    //     //           child: Column(children: [
                    //     //             Row(
                    //     //               children: [
                    //     //                 CustomButton(text: 'Unive', onPressed: () {}),
                    //     //                 CustomButton(
                    //     //                     text: 'Vendor', onPressed: () {}),
                    //     //                 CustomButton(text: 'Bank', onPressed: () {}),
                    //     //               ],
                    //     //             ),
                    //     //             Padding(
                    //     //               padding: const EdgeInsets.only(left: 15),
                    //     //               child: Align(
                    //     //                 alignment: AlignmentDirectional.topStart,
                    //     //                 child: CustomAutoSizeTextMontserrat(
                    //     //                   text: "University",
                    //     //                   fontSize: 16,
                    //     //                   fontWeight: FontWeight.bold,
                    //     //                 ),
                    //     //               ),
                    //     //             ),
                    //     //           ]),
                    //     //         ),
                    //     //         title: 'Add Representative'));
                    //   },
                    //   child: Container(
                    //     // padding: EdgeInsets.symmetric(horizontal: 10),
                    //     height: 38,
                    //     width: MediaQuery.of(context).size.width * 0.45,
                    //     decoration: BoxDecoration(
                    //         color: ThemeConstants.bluecolor,
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(30.0))),
                    //     child: Center(
                    //       child: CustomAutoSizeTextMontserrat(
                    //         text: "Existing Representative",
                    //         textColor: ThemeConstants.whitecolor,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    //   // child: CustomAutoSizeTextMontserrat(
                    //   //   text: "ADD",
                    //   //   fontSize: 16,
                    //   //   fontWeight: FontWeight.bold,
                    //   // ),
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     addRepresentative(context, controllers);
                    //     // showDialog(
                    //     //     context: context,
                    //     //     builder: (_) => CustomProfileDialogue(
                    //     //         child: Container(
                    //     //           child: Column(children: [
                    //     //             Row(
                    //     //               children: [
                    //     //                 CustomButton(text: 'Unive', onPressed: () {}),
                    //     //                 CustomButton(
                    //     //                     text: 'Vendor', onPressed: () {}),
                    //     //                 CustomButton(text: 'Bank', onPressed: () {}),
                    //     //               ],
                    //     //             ),
                    //     //             Padding(
                    //     //               padding: const EdgeInsets.only(left: 15),
                    //     //               child: Align(
                    //     //                 alignment: AlignmentDirectional.topStart,
                    //     //                 child: CustomAutoSizeTextMontserrat(
                    //     //                   text: "University",
                    //     //                   fontSize: 16,
                    //     //                   fontWeight: FontWeight.bold,
                    //     //                 ),
                    //     //               ),
                    //     //             ),
                    //     //           ]),
                    //     //         ),
                    //     //         title: 'Add Representative'));
                    //   },
                    //   child: Container(
                    //     height: 38,
                    //     width: MediaQuery.of(context).size.width * 0.45,
                    //     decoration: BoxDecoration(
                    //         color: ThemeConstants.bluecolor,
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(30.0))),
                    //     child: Center(
                    //       child: CustomAutoSizeTextMontserrat(
                    //         text: "Add New Representative",
                    //         textColor: ThemeConstants.whitecolor,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    //   // child: CustomAutoSizeTextMontserrat(
                    //   //   text: "ADD",
                    //   //   fontSize: 16,
                    //   //   fontWeight: FontWeight.bold,
                    //   // ),
                    // ),
                  ],
                ),

                if (true) ...[
                  if (controller.meetingWith.value !=
                      'University Meetings') ...[
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ThemeConstants.bluecolor, width: 1),
                          color: ThemeConstants.lightVioletColor,
                          borderRadius: BorderRadius.circular(500)),
                      width: double.infinity,
                      height: 40,
                      child: CustomAutoSizeTextMontserrat(
                        text: '${controller.participantData.personName}',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 8, top: 8),
                  //   child: Align(
                  //     alignment: AlignmentDirectional.topStart,
                  //     child: CustomAutoSizeTextMontserrat(
                  //       text: "Designation",
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),

                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //           color: ThemeConstants.bluecolor, width: 1),
                  //       color: ThemeConstants.lightVioletColor,
                  //       borderRadius: BorderRadius.circular(500)),
                  //   width: double.infinity,
                  //   height: 40,
                  //   child: CustomAutoSizeTextMontserrat(
                  //     text: '${controller.participantData.designation}',
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: 10,
                  // ),
                  // // CustomTextField(
                  // //   hint: '',
                  // //   controller: controller.designation.value,
                  // // ),

                  // // Padding(
                  // //   padding: const EdgeInsets.only(left: 15),
                  // //   child: Align(
                  // //     alignment: AlignmentDirectional.topStart,
                  // //     child: CustomAutoSizeTextMontserrat(
                  // //       text: "Add Representative",
                  // //       fontSize: 16,
                  // //       fontWeight: FontWeight.bold,
                  // //     ),
                  // //   ),
                  // // ),

                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 8),
                  //   child: Align(
                  //     alignment: AlignmentDirectional.topStart,
                  //     child: CustomAutoSizeTextMontserrat(
                  //       text: "Email id",
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 0),
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //             color: ThemeConstants.bluecolor, width: 1),
                  //         color: ThemeConstants.lightVioletColor,
                  //         borderRadius: BorderRadius.circular(500)),
                  //     width: double.infinity,
                  //     height: 40,
                  //     child: CustomAutoSizeTextMontserrat(
                  //       text: '${controller.participantData.email}',
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: 10,
                  // ),
                  // // CustomTextField(
                  // //   hint: '',
                  // //   controller: controller.designation.value,
                  // // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 8),
                  //   child: Align(
                  //     alignment: AlignmentDirectional.topStart,
                  //     child: CustomAutoSizeTextMontserrat(
                  //       text: "Phone Number",
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 0),
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //             color: ThemeConstants.bluecolor, width: 1),
                  //         color: ThemeConstants.lightVioletColor,
                  //         borderRadius: BorderRadius.circular(500)),
                  //     width: double.infinity,
                  //     height: 40,
                  //     child: CustomAutoSizeTextMontserrat(
                  //       text: controller.participantData.phone == null
                  //           ? ''
                  //           : '${controller.participantData.phone}',
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                ],

                SizedBox(
                  height: 5,
                ),

                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [...allParticipantsListFnc(controller)],
                  ),
                ),

                // CustomTextField(
                //   hint: '',
                //   controller: controller.designation.value,
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 0),
                //   child: Align(
                //     alignment: Alignment.topLeft,
                //     child: Wrap(
                //       spacing: 10,
                //       runSpacing: 10,
                //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         GestureDetector(
                //           onTap: () {
                //             showDialog(
                //                 context: context,
                //                 builder: (_) =>
                //                     DialogHora(controller: controller));
                //             // controller.listOfParticipants
                //             //     .add(controllers.participantData.value);
                //             controller.update();
                //           },
                //           child: Container(
                //             height: 38,
                //             width: 170,
                //             decoration: BoxDecoration(
                //                 border: Border.all(
                //                     width: 1,
                //                     color: ThemeConstants.orangeColor),
                //                 color: Colors.transparent,
                //                 borderRadius: const BorderRadius.all(
                //                     Radius.circular(30.0))),
                //             child: Center(
                //               child: CustomAutoSizeTextMontserrat(
                //                   text: "View Participants",
                //                   textColor: ThemeConstants.orangeColor,
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 15,
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             if (controller.listOfParticipants
                //                 .contains(controller.participantData)) {
                //               getToast('Already added');
                //               // showDialog(
                //               //     context: context,
                //               //     builder: (_) => AlertDialog(
                //               //           content: Container(
                //               //               child: Text('Already added')),
                //               //         ));
                //             } else if (controllers.participantData.id == 0) {
                //               // showDialog(
                //               //     context: context,
                //               //     builder: (_) => AlertDialog(
                //               //           content: Container(
                //               //               child: Text(
                //               //                   'Please add a representative')),
                //               //         ));

                //               getToast('Please add a representative');
                //             } else {
                //               controller.listOfParticipants
                //                   .add(controllers.participantData);
                //               controller.update();
                //               getToast('Participant Added Successfully');
                //               // showDialog(
                //               //     context: context,
                //               //     builder: (_) => AlertDialog(
                //               //           shape: RoundedRectangleBorder(
                //               //               borderRadius:
                //               //                   BorderRadius.circular(20)),
                //               //           content: Container(
                //               //             child: Column(
                //               //                 mainAxisSize: MainAxisSize.min,
                //               //                 children: [
                //               //                   Text(
                //               //                       'Participant Added Successfully'),
                //               //                   Icon(Icons.check_circle,
                //               //                       size: 30,
                //               //                       color: ThemeConstants
                //               //                           .GreenColor)
                //               //                 ]),
                //               //           ),
                //               //         ));
                //             }
                //           },
                //           child: Container(
                //             height: 38,
                //             width: MediaQuery.of(context).size.width * 0.55,
                //             decoration: BoxDecoration(
                //                 color: ThemeConstants.bluecolor,
                //                 borderRadius: const BorderRadius.all(
                //                     Radius.circular(30.0))),
                //             child: Center(
                //               child: CustomAutoSizeTextMontserrat(
                //                   text: "Add Participants",
                //                   textColor: ThemeConstants.whitecolor,
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
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
                padding: const EdgeInsets.only(left: 0, top: 10),
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
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "Select target Audience Type",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 5),
                height: 110,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.selectTargetAudienceType.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            controller.selectedTargetAudience.value =
                                controller.selectTargetAudienceType[index];

                            // controller.preFilledUsers.clear();
                            // if (val.toString().toLowerCase() == 'branch based') {
                            //   await controller.getBranchData();
                            //   controller.update();
                            // }
                            controller.groupNames.value = '';
                            controller.preFilledUsers = [];
                            if (controller.selectedTargetAudience.value ==
                                'Branch Based') {
                              controller.selectedBranchForUserList =
                                  controller.branchListwithFlag[0].id!;
                              controller.branchSelected(
                                  controller.branchListwithFlag[0].id!);
                              // controller
                              //     .branchSelected(controller.branchList[0]);
                            }
                            if (controller.selectedTargetAudience.value ==
                                'All User') {
                              controller.preFilledUsers =
                                  Get.find<BaseController>().allSiecMembersList;
                            }
                            controller.update();
                            // controller.selectMeetingBranch.value =
                            //     controller.branchListwithFlag[index].id!;
                            // controller.update();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 140,
                            decoration: BoxDecoration(
                                color: controller.selectedTargetAudience ==
                                        controller
                                            .selectTargetAudienceType[index]
                                    ? ThemeConstants.lightblueColor2
                                    : ThemeConstants.whitecolor,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 1, color: ThemeConstants.bluecolor)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.group,
                                        size: 45,
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${controller.selectTargetAudienceType[index]}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ]),
                          ),
                        )),
              ),
              SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 0, bottom: 8),
              //   child: Align(
              //     alignment: AlignmentDirectional.topStart,
              //     child: CustomAutoSizeTextMontserrat(
              //       text: "Select target Audience Type",
              //       fontSize: 14,
              //       fontWeight: FontWeight.w500,
              //       mandatory: true,
              //     ),
              //   ),
              // ),

              // CustomMultiDownSingle(
              //     field: Container(
              //       height: 22,
              //       child: CustomTextField(
              //         forDropDown: false,
              //         backgroundCOlour: Colors.transparent,
              //         hint: '',
              //         readOrEdit: true,
              //         controller: TextEditingController(),
              //         validator: controller.selectedTargetAudience.value == ''
              //             ? Validator.plzSelectOne
              //             : null,
              //       ),
              //     ),
              //     callbackFunctionSingle: (val) async {
              //       print(val);
              //       controller.selectedTargetAudience.value = val;

              //       // controller.preFilledUsers.clear();
              //       // if (val.toString().toLowerCase() == 'branch based') {
              //       //   await controller.getBranchData();
              //       //   controller.update();
              //       // }
              //       controller.groupNames.value = '';
              //       controller.preFilledUsers = [];
              //       if (controller.selectedTargetAudience.value ==
              //           'Branch Based') {
              //         controller.branchSelected(controller.branchList[0]);
              //       }
              //       if (controller.selectedTargetAudience.value == 'All User') {
              //         controller.preFilledUsers =
              //             Get.find<BaseController>().allSiecMembersList;
              //       }
              //       controller.update();

              //       // print(controller.selectedTargetAudience.value);
              //     },
              //     enableMultiSelect: false,
              //     model: controller.selectTargetAudienceType,
              //     initialSelectedValue:
              //         '${controller.selectedTargetAudience.value}'),

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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  height: 110,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.branchListwithFlag.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              controller.branchSelected(
                                  controller.branchListwithFlag[index].id!);
                              // controller.selectMeetingBranch.value =
                              //     controller.branchListwithFlag[index].id!;
                              // controller.update();
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 140,
                              decoration: BoxDecoration(
                                  color: controller.selectedBranchForUserList ==
                                          controller
                                              .branchListwithFlag[index].id
                                      ? ThemeConstants.lightblueColor2
                                      : ThemeConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 1,
                                      color: ThemeConstants.bluecolor)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: CachedNetworkImage(
                                        imageUrl: controller
                                            .branchListwithFlag[index]
                                            .imageLink!,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${controller.branchListwithFlag[index].name}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ]),
                            ),
                          )),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 0),
                //   child: Align(
                //     alignment: AlignmentDirectional.topStart,
                //     child: CustomAutoSizeTextMontserrat(
                //       text: "Select Branch",
                //       fontSize: 14,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
                // CustomMultiDownSingleAllUser(
                //   field: Container(
                //     height: 22,
                //     child: CustomTextField(
                //       forDropDown: false,
                //       backgroundCOlour: Colors.transparent,
                //       hint: '',
                //       controller: TextEditingController(),
                //       validator: controller.selectedBranch.value == ''
                //           ? Validator.plzSelectOne
                //           : null,
                //     ),
                //   ),
                //   enableMultiSelect: false,
                //   model: controller.branchList,

                //   initialSelectedValue: 'Siec Branch',
                //   callbackFunctionSingle: (AllUserModel val) async {
                //     await controller.branchSelected(val);
                //   },
                //   // callbackFunctionSingle: (AllUserModel val) {
                //   //   print('$val ddd');
                //   //   controller.selectMeetingBranch.value = val;
                //   // },
                // ),

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
                    text: "Meeting Coordinator",
                    mandatory: true,
                    fontSize: 14,
                    textColor: ThemeConstants.bluecolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              CustomMultiDownSingleAllUser(
                  field: Container(
                    height: 22,
                    child: CustomTextField(
                      forDropDown: false,
                      backgroundCOlour: Colors.transparent,
                      readOrEdit: true,
                      hint: '',
                      controller: TextEditingController(),
                      validator: controller.selectedCoordinatorList.length == 0
                          ? Validator.plzSelectOne
                          : null,
                    ),
                  ),
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
                      controller.createNewMeeting(context);
                    } else {
                      controller.createExternalNewMeeting(context);
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
    return showAnimatedDialog(
        duration: Duration(milliseconds: 350),
        animationType: DialogTransitionType.slideFromBottomFade,
        context: context,
        builder: (_) {
          print(controller.addRepresentaitveType.value);
          return SafeArea(
              child: Stack(
            children: [
              Center(child: AddRepresentativeWidget(controller: controller)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                      // Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: ThemeConstants.bluecolor,
                          borderRadius: BorderRadius.circular(200)),
                      child: Icon(
                        Icons.close_rounded,
                        color: ThemeConstants.whitecolor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ));
        });
  }

  List<Widget> allParticipantsListFnc(CreateNewMeetingController2 controller) {
    List<Widget> data = [];
    for (var i = 0; i < controller.listOfParticipants.length; i++) {
      data.add(Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: ThemeConstants.VioletColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAutoSizeTextMontserrat(
                    text: '${controller.listOfParticipants[i].personName}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Suitcase.svg',
                        width: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].designation}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].email}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].phone}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ]),
            Container(
              height: 60,
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    controller.listOfParticipants.removeAt(i);
                    controller.update();
                    // setState(() {});
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ThemeConstants.lightRed),
                    child: Icon(
                      Icons.delete,
                      color: ThemeConstants.red,
                      size: 25,
                    ),
                  )),
            )
          ],
        ),
      ));
    }

    return data;
  }
}

class ExistingRepresentativeModal extends StatefulWidget {
  CreateNewMeetingController2 controller2;
  ExistingRepresentativeModal({super.key, required this.controller2});

  @override
  State<ExistingRepresentativeModal> createState() =>
      _ExistingRepresentativeModalState();
}

class _ExistingRepresentativeModalState
    extends State<ExistingRepresentativeModal> {
  @override
  Widget build(BuildContext context) {
    return CustomProfileDialogue(
        title: 'd',
        tap: (val) async {
          // if (key2.currentState!.validate()) {
          //   print(val);

          //   await controller.addANewRepresentative();
          //   context.pop();
          //   // Get.back();
          //   Get.defaultDialog(
          //       content: Container(
          //     child: Text('Representative Added'),
          //   ));
          // }
        },
        child: Container(
            alignment: Alignment.center,
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Container(
                //       width: 180,
                //       child: Padding(
                //         padding: const EdgeInsets.only(left: 0),
                //         child: Align(
                //           alignment: AlignmentDirectional.topStart,
                //           child: CustomAutoSizeTextMontserrat(
                //             text: "Participants Details",
                //             fontSize: 20,
                //             textColor: ThemeConstants.bluecolor,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         context.pop();
                //         // Get.back();
                //       },
                //       child: Container(
                //         margin: EdgeInsets.only(top: 10),
                //         width: 25,
                //         height: 25,
                //         alignment: Alignment.centerRight,
                //         child: CircleAvatar(
                //           radius: 25,
                //           backgroundColor: ThemeConstants.bluecolor,
                //           child: Icon(
                //             Icons.close,
                //             color: ThemeConstants.whitecolor,
                //             size: 20,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Container(
                  height: 412,
                  child: ListView(
                    children: [
                      Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          children: [
                            ...allParticipants(widget.controller2, setState)
                          ]),
                    ],
                  ),
                ),
              ],
            )));
  }

  List<Widget> allParticipants(
      CreateNewMeetingController2 controller, StateSetter setstate) {
    List<Widget> data = [];
    for (var i = 0; i < controller.listOfParticipantData.length; i++) {
      data.add(Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: ThemeConstants.VioletColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAutoSizeTextMontserrat(
                    text: '${controller.listOfParticipantData[i].name}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Suitcase.svg',
                        width: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // CustomAutoSizeTextMontserrat(
                      //   text: '${controller.listOfParticipants[i].designation}',
                      //   fontSize: 8,
                      //   fontWeight: FontWeight.w500,
                      //   textColor: ThemeConstants.TextColor,
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // CustomAutoSizeTextMontserrat(
                      //   text: '${controller.listOfParticipants[i].email}',
                      //   fontSize: 8,
                      //   fontWeight: FontWeight.w500,
                      //   textColor: ThemeConstants.TextColor,
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // CustomAutoSizeTextMontserrat(
                      //   text: '${controller.listOfParticipants[i].phone}',
                      //   fontSize: 8,
                      //   fontWeight: FontWeight.w500,
                      //   textColor: ThemeConstants.TextColor,
                      // ),
                    ],
                  ),
                ]),
            Container(
              height: 60,
              alignment: Alignment.center,
              child: Radio(
                onChanged: (val) {
                  print(val);
                  controller.participantID.value = val!;
                  setState(() {});
                  // controller.fetchParticipantData();
                  // controller.listOfParticipants.removeAt(i);
                  controller.update();
                },
                groupValue: controller.participantID.value,
                value: controller.listOfParticipantData[i],
              ),
            )
          ],
        ),
      ));
    }
    return data;
  }
}
