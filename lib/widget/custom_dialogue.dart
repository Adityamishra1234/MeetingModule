import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/calender/calendar_controller.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_time_picker_only.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget_pick_hour_minutes.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';
import 'package:meeting_module2/widget/popups/custom_error_non_changeable.dart';
import 'package:meeting_module2/widget/popups/custom_error_popup.dart';

class ResheduleMeetingDialogue extends StatefulWidget {
  ResheduleMeetingDialogue(
      {super.key,
      required this.controller,
      required this.indexz,
      required this.meetingData});

  DashBoardController controller;
  int indexz;
  AllMeetings meetingData;

  @override
  State<ResheduleMeetingDialogue> createState() =>
      _ResheduleMeetingDialogueState();
}

class _ResheduleMeetingDialogueState extends State<ResheduleMeetingDialogue> {
  late String time;
  late String date;
  String proposedDuration = '';
  String meetingType = '';
  String modeOfMeeting = 'Zoom';
  TextEditingController meetingLink = TextEditingController();
  TextEditingController registrationLink = TextEditingController();
  TextEditingController reasonOfReshedule = TextEditingController();
  TextEditingController specifyLocation = TextEditingController();
  String? meetingLocation;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  int selectedBranchForUserList = 0;

  @override
  void initState() {
    date = widget.meetingData.dateOfMeeting!;
    time = widget.meetingData.timeOfTheMeeting!;
    meetingLink.text = widget.meetingData.meetingLink!;
    registrationLink.text = widget.meetingData.registrationLink!;
    proposedDuration =
        widget.controller.listToShow[widget.indexz].durationOfMeeting!;
    meetingType = widget.meetingData.meetingMode!;

    if (widget.meetingData.meetingMode! == '1')
      modeOfMeeting = widget.meetingData.meetingModeType!;

    // TODO: implement initState
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
// rescheduleMeetingDialogue(
//     {required BuildContext context,
//     required int id,
//     required Function timeCallback}) {
//   // barrierDismissible: true,
//   // context: context,
//   // pageBuilder: (ctx, a1, a2) {
//   //   return Container();
//   // },

//   // transitionDuration: const Duration(milliseconds: 0),
//   // transitionBuilder: (ctx, a1, a2, child) {
//   //   print(a2.value);
//   //   print(a1.value);
//   //   return Transform.translate(
//   //       offset: Offset(0, 0),
//   return showAnimatedDialog(
//       animationType: DialogTransitionType.slideFromBottomFade,
//       curve: Curves.easeInOutQuart,
//       // barrierDismissible: false,
//       context: context,
//       builder: (ctx) =>

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Stack(
          fit: StackFit.expand,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FractionallySizedBox(
              heightFactor: 0.1,
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  Container(
                      width: 240,
                      alignment: Alignment.topLeft,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Reschedule Meeting",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textColor: ThemeConstants.bluecolor,
                      )),
                  Spacer(),
                ],
              ),
            ),
            FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.9,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  // Padding(
                  //     padding: EdgeInsets.all(5),
                  //     child: CustomAutoSizeTextMontserrat(
                  //       text: "**touch only the value you want to change",
                  //       fontWeight: FontWeight.bold,
                  //     )),

                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                      padding: EdgeInsets.all(5),
                      child: CustomAutoSizeTextMontserrat(
                        text: "Date",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                  Container(
                    height: 45,
                    child: CustomTimerWidget(
                        startingDate: DateTime.now(),
                        initialTime: widget.meetingData.dateOfMeeting,
                        callback: (val) {
                          date = val;
                          setState(() {});
                        }),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: CustomAutoSizeTextMontserrat(
                        text: "Time",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                  Container(
                    height: 45,
                    child: CustomTimerWidget2(
                        initialTime: widget.meetingData.timeOfTheMeeting,
                        callback: (val) async {
                          // var hours = int.parse(val) / 60;
                          // var minutes = int.parse(val) % 60;

                          print(val);
                          setState(() {
                            time = val;
                          });

                          // var data = val.toString();

                          // var time =
                          //     '${data.substring(0, 2)} hours ${data.substring(3, 5)} minutes';

                          // print(time);

                          // print(val);

                          // controller.update();
                          // print(controller.proposedDurationController.value);
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomAutoSizeTextMontserrat(
                    text: "Proposed Duration",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 45,
                    child: CustomTimerWidgetForHourMinutes(
                        initialTime: widget.meetingData.durationOfMeeting,
                        callback: (val) async {
                          // var hours = int.parse(val) / 60;
                          // var minutes = int.parse(val) % 60;

                          print(val);

                          var data = val.toString();

                          var time =
                              '${data.substring(0, 2)} hours ${data.substring(3, 5)} minutes';

                          print(time);

                          print(val);

                          proposedDuration = time;
                          // widget.controller   proposedDurationController.value = time;
                          // controller.update();
                          // print(controller.proposedDurationController.value);
                        }),
                  ),
                  SizedBox(
                    height: 10,
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
                                      value: '1',
                                      groupValue: meetingType,
                                      onChanged: (value) {
                                        // controller.MeetingType.value = false;
                                        // controller.update();

                                        meetingType = '1';
                                        meetingLocation = "";
                                        setState(() {});

                                        // controller.MeetingType.value = true;
                                        // controller.update();
                                      }),
                                  CustomAutoSizeTextMontserrat(
                                    text: 'Online',
                                    fontSize: 10,
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Radio(
                                      value: '2',
                                      groupValue: meetingType,
                                      onChanged: (value) {
                                        meetingType = '2';

                                        setState(() {});
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CustomAutoSizeTextMontserrat(
                      //   text: "Meeting Type",
                      //   fontSize: 14,
                      //   fontWeight: FontWeight.w500,
                      // ),
                      if (meetingType == '1')
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: CustomAutoSizeTextMontserrat(
                              text: "Mode of Meeting",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //     width: (MediaQuery.of(context).size.width - 40) / 2.8,
                      //     child: CustomMultiDownSingle(
                      //         callbackFunctionSingle: (val) {
                      //           print(val);
                      //           if (val == 'Offline') {
                      //             meetingType = '2';
                      //             // controller.MeetingType.value = false;
                      //             // controller.update();
                      //             setState(() {});
                      //           } else {
                      //             meetingType = '1';
                      //             setState(() {});
                      //             // controller.MeetingType.value = true;
                      //             // controller.update();
                      //           }
                      //         },
                      //         enableMultiSelect: false,
                      //         model: ['Online', 'Offline'],
                      //         initialSelectedValue:
                      //             widget.meetingData.meetingMode == '1'
                      //                 ? 'Online'
                      //                 : 'Offline')),
                      if (meetingType == '1')
                        Container(
                          width: (MediaQuery.of(context).size.width - 40) / 2.7,
                          child: CustomMultiDownSingle(
                            enableMultiSelect: false,
                            model: ['Zoom', 'Meet', 'Teams'],
                            initialSelectedValue: modeOfMeeting,
                            callbackFunctionSingle: (val) {
                              modeOfMeeting = val;
                              // controller.modeOfMeeting.value = val;
                            },
                          ),
                        ),
                    ],
                  ),

                  // Modde of the Meeting Offline
                  if (meetingType == '2')
                    CustomAutoSizeTextMontserrat(
                      text: "Location",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  if (meetingType == '2')
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio(
                            value: true.toString(),
                            groupValue: meetingLocation,
                            onChanged: (value) {
                              meetingLocation = true.toString();
                              setState(() {});
                            }),
                        if (meetingType == '2')
                          CustomAutoSizeTextMontserrat(
                            text: 'Siec Branch',
                            fontSize: 10,
                          ),
                        SizedBox(
                          width: 50,
                        ),
                        Radio(
                            value: false.toString(),
                            groupValue: meetingLocation,
                            onChanged: (value) {
                              meetingLocation = false.toString();
                              setState(() {});
                            }),
                        CustomAutoSizeTextMontserrat(
                          text: 'Others',
                          fontSize: 10,
                        ),
                      ],
                    ),

                  if (meetingLocation == false.toString())
                    Padding(
                      padding: const EdgeInsets.only(left: 0, bottom: 8),
                      child: CustomAutoSizeTextMontserrat(
                        text: "Specify location",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (meetingLocation == false.toString())
                    CustomTextField(hint: "", controller: specifyLocation),

                  if (meetingLocation == true.toString())
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
                  if (meetingLocation == true.toString())
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      height: 110,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.controller.branchListwithFlag.length,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  selectedBranchForUserList = widget
                                      .controller.branchListwithFlag[index].id!;
                                  setState(() {});
                                  // controller.branchSelected(
                                  //     controller.branchListwithFlag[index].id!);
                                  // selectMeetingBranch.value = widget
                                  //     .controller.branchListwithFlag[index].id!;
                                  // controller.update();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: selectedBranchForUserList ==
                                              widget.controller
                                                  .branchListwithFlag[index].id
                                          ? ThemeConstants.lightblueColor2
                                          : ThemeConstants.whitecolor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 1,
                                          color: ThemeConstants.bluecolor)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: CachedNetworkImage(
                                            imageUrl: widget
                                                .controller
                                                .branchListwithFlag[index]
                                                .imageLink!,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${widget.controller.branchListwithFlag[index].name}',
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
                  if (meetingType == '1')
                    Padding(
                      padding: const EdgeInsets.only(left: 0, bottom: 8),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "Meeting Link",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  if (meetingType == '1')
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width - 40,
                      child: CustomTextField(
                        // validator: controller.MeetingType.value == true
                        //     ? Validator.notEmpty
                        //     : null,
                        hint: '',
                        controller: meetingLink,
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),

                  if (meetingType == '1')
                    Padding(
                      padding: const EdgeInsets.only(left: 0, bottom: 8),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text: "registration Link",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  if (meetingType == '1')
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width - 40,
                      child: CustomTextField(
                        // validator: controller.MeetingType.value == true
                        //     ? Validator.notEmpty
                        //     : null,
                        hint: '',
                        controller: registrationLink,
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
                        text: "Reason of Reschedule",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Form(
                      key: key,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            child: CustomTextField(
                              validator: Validator.notEmpty,

                              //  reasonOfReshedule == null
                              //                       ? Validator.notEmpty
                              //                       : null,
                              hint: '',
                              controller: reasonOfReshedule,
                            ),
                          ),
                          CustomButton(
                              backgroundColor: ThemeConstants.bluecolor,
                              text: 'Update',
                              onPressed: () async {
//  AllMeetings data =
//                         widget.controller.listToShow[widget.indexz];

                                if (key.currentState!.validate() == true) {
                                  String link = meetingLink.value.text;

                                  // online => mode of the meeting,meeting link
                                  if (meetingType == '1') {
                                    meetingLocation = "";
                                    selectedBranchForUserList = 0;
                                    specifyLocation.text = "";
                                  } else {
                                    modeOfMeeting = "";
                                    meetingLink.text = "";
                                    registrationLink.text = "";
                                    // Siec Branches
                                    if (meetingLocation == true.toString()) {
                                      specifyLocation.text = "";
                                    } else {
                                      selectedBranchForUserList = 0;
                                    }
                                  }
                                  // ofline => location , Siec branch => selected Branch
                                  print(meetingLocation ?? "" + "   test");
                                  if (meetingType.toString() == "2") {
                                    if (meetingLocation == null) {
                                      getToast(
                                          "Kindly select your location field");
                                    } else {
                                      if (meetingLocation == true.toString()) {
                                        if (selectedBranchForUserList == 0) {
                                          getToast("Kindly select your branch");
                                        } else {
                                          await updateData();
                                        }
                                      } else {
                                        if (specifyLocation.text.isEmpty) {
                                          getToast(
                                              "Kindly enter your specify location");
                                        } else {
                                          await updateData();
                                        }
                                      }
                                    }
                                  } else {
                                    await updateData();
                                  }
                                }
                              }),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ))

                  // InkWell(
                  //   onTap: () {
                  //     _launchURL();
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                  //     width: 300,
                  //     height: 45,
                  //     decoration: BoxDecoration(
                  //         color: ThemeConstants.ultraLightgreyColor,
                  //         borderRadius:
                  //             BorderRadius.all(Radius.circular(25.0))),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //             height: 35,
                  //             width: 35,
                  //             decoration: BoxDecoration(
                  //                 color: ThemeConstants.bluecolor,
                  //                 shape: BoxShape.circle),
                  //             child: Icon(
                  //               Icons.phone,
                  //               color: ThemeConstants.whitecolor,
                  //             )),
                  //         const SizedBox(
                  //           width: 20,
                  //         ),
                  //         CustomRichTextWidget(
                  //           text: '(+91 9779046382)',
                  //           text1: "Call Us ",
                  //           fontWeight: FontWeight.w600,
                  //           textColor: ThemeConstants.bluecolor,
                  //         ),
                  //         // CustomAutoSizeTextMontserrat(
                  //         //     text: "Call Us (+91 9779046382)"),
                  //         Spacer()
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Material(
                  //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //   color: ThemeConstants.ultraLightgreyColor,
                  //   child: InkWell(
                  //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //     splashColor: ThemeConstants.bluecolor,
                  //     onTap: () async {
                  //       await Future.delayed(Duration(milliseconds: 150));
                  //       // Get.toNamed(   );
                  //     },
                  //     child: Container(
                  //       width: 300,
                  //       height: 45,
                  //       padding: EdgeInsets.symmetric(horizontal: 10),
                  //       // decoration: BoxDecoration(
                  //       //     borderRadius:
                  //       //         BorderRadius.all(Radius.circular(25.0))),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Container(
                  //             padding: EdgeInsets.all(7),
                  //             height: 35,
                  //             width: 35,
                  //             decoration: BoxDecoration(
                  //                 color: ThemeConstants.bluecolor,
                  //                 shape: BoxShape.circle),
                  //             child: SvgPicture.asset(
                  //               'assets/icons/raise ticket.svg',
                  //               color: ThemeConstants.whitecolor,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           CustomRichTextWidget(
                  //             text: '',
                  //             text1: "Raise New Ticket",
                  //             fontWeight: FontWeight.w600,
                  //             textColor: ThemeConstants.bluecolor,
                  //           ),
                  //           const Spacer(),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Material(
                  //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //   color: ThemeConstants.ultraLightgreyColor,
                  //   child: InkWell(
                  //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //     splashColor: ThemeConstants.bluecolor,
                  //     onTap: () async {
                  //       await Future.delayed(Duration(milliseconds: 150));
                  //       Get.toNamed(TrackyourTickets.routeNamed);
                  //     },
                  //     child: Container(
                  //       width: 300,
                  //       height: 45,
                  //       padding: EdgeInsets.symmetric(horizontal: 10),
                  //       // decoration: BoxDecoration(
                  //       //     borderRadius:
                  //       //         BorderRadius.all(Radius.circular(25.0))),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Container(
                  //             padding: EdgeInsets.all(7),
                  //             height: 35,
                  //             width: 35,
                  //             decoration: BoxDecoration(
                  //                 color: ThemeConstants.bluecolor,
                  //                 shape: BoxShape.circle),
                  //             child: SvgPicture.asset(
                  //               'assets/icons/Track Issue.svg',
                  //               color: ThemeConstants.whitecolor,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           CustomRichTextWidget(
                  //             text: '',
                  //             text1: "Track issue",
                  //             fontWeight: FontWeight.w600,
                  //             textColor: ThemeConstants.bluecolor,
                  //           ),
                  //           const Spacer(),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // // InkWell(
                  // //   onTap: () {
                  // //     Get.toNamed(ReceiveACallBackView.routeNamed);
                  // //   },
                  // //   child: Container(
                  // //     padding: EdgeInsets.symmetric(horizontal: 10),
                  // //     width: 300,
                  // //     height: 45,
                  // //     decoration: BoxDecoration(
                  // //         color: ThemeConstants.ultraLightgreyColor,
                  // //         borderRadius:
                  // //             BorderRadius.all(Radius.circular(25.0))),
                  // //     child: Row(
                  // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // //       crossAxisAlignment: CrossAxisAlignment.center,
                  // //       children: [
                  // //         Container(
                  // //           padding: EdgeInsets.all(7),
                  // //           height: 35,
                  // //           width: 35,
                  // //           decoration: BoxDecoration(
                  // //               color: ThemeConstants.bluecolor,
                  // //               shape: BoxShape.circle),
                  // //           child: SvgPicture.asset(
                  // //             'assets/icons/call back icon.svg',
                  // //             color: ThemeConstants.whitecolor,
                  // //           ),
                  // //         ),
                  // //         const SizedBox(
                  // //           width: 20,
                  // //         ),
                  // //         CustomAutoSizeTextMontserrat(
                  // //             text: "Receive a call back"),
                  // //         const Spacer(),
                  // //       ],
                  // //     ),
                  // //   ),
                  // // ),
                  // Material(
                  //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //   color: ThemeConstants.ultraLightgreyColor,
                  //   child: InkWell(
                  //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //     splashColor: ThemeConstants.bluecolor,
                  //     onTap: () async {
                  //       await Future.delayed(Duration(milliseconds: 150));
                  //       Get.toNamed(Suggestedimprovisation.routeNamed);
                  //     },
                  //     child: Container(
                  //       width: 300,
                  //       height: 45,
                  //       padding: EdgeInsets.symmetric(horizontal: 10),
                  //       // decoration: BoxDecoration(
                  //       //     borderRadius:
                  //       //         BorderRadius.all(Radius.circular(25.0))),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Container(
                  //             padding: EdgeInsets.all(7),
                  //             height: 35,
                  //             width: 35,
                  //             decoration: BoxDecoration(
                  //                 color: ThemeConstants.bluecolor,
                  //                 shape: BoxShape.circle),
                  //             child: SvgPicture.asset(
                  //               'assets/icons/feed back.svg',
                  //               color: ThemeConstants.whitecolor,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           CustomAutoSizeTextMontserrat(
                  //               text: "Track feedback"),
                  //           const Spacer(),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // // InkWell(
                  // //   onTap: () {
                  // //     Get.toNamed(ScheduleExpertCall.routeNamed);
                  // //   },
                  // //   child: Container(
                  // //     width: 300,
                  // //     height: 45,
                  // //     padding: EdgeInsets.symmetric(horizontal: 10),
                  // //     decoration: BoxDecoration(
                  // //         color: ThemeConstants.ultraLightgreyColor,
                  // //         borderRadius:
                  // //             BorderRadius.all(Radius.circular(25.0))),
                  // //     child: Row(
                  // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // //       crossAxisAlignment: CrossAxisAlignment.center,
                  // //       children: [
                  // //         Container(
                  // //           padding: EdgeInsets.all(7),
                  // //           height: 35,
                  // //           width: 35,
                  // //           decoration: BoxDecoration(
                  // //               color: ThemeConstants.bluecolor,
                  // //               shape: BoxShape.circle),
                  // //           child: SvgPicture.asset(
                  // //             'assets/icons/Calender icon.svg',
                  // //             color: ThemeConstants.whitecolor,
                  // //           ),
                  // //         ),
                  // //         const SizedBox(
                  // //           width: 20,
                  // //         ),
                  // //         CustomAutoSizeTextMontserrat(
                  // //             text: "Schedule an expert call"),
                  // //         const Spacer(),
                  // //       ],
                  // //     ),
                  // //   ),
                  // // ),
                  // Material(
                  //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //   color: ThemeConstants.ultraLightgreyColor,
                  //   child: InkWell(
                  //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //     splashColor: ThemeConstants.bluecolor,
                  //     onTap: () async {
                  //       await Future.delayed(Duration(milliseconds: 150));

                  //       _launchEmailURL();

                  //       // Get.toNamed(ScheduleExpertCall.routeNamed);
                  //     },
                  //     child: Container(
                  //       width: 300,
                  //       height: 50,
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  //       // decoration: BoxDecoration(
                  //       //     borderRadius:
                  //       //         BorderRadius.all(Radius.circular(25.0))),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Container(
                  //             padding: EdgeInsets.all(7),
                  //             height: 35,
                  //             width: 35,
                  //             decoration: BoxDecoration(
                  //                 color: ThemeConstants.bluecolor,
                  //                 shape: BoxShape.circle),
                  //             child: SvgPicture.asset(
                  //               'assets/icons/mail.svg',
                  //               color: ThemeConstants.whitecolor,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           CustomAutoSizeTextMontserrat(
                  //               text: "Gradlynksupport\n@siecindia.com"),
                  //           const Spacer(),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // // InkWell(
                  // //   onTap: () {
                  // //     _launchURL2();
                  // //   },
                  // //   child: Container(
                  // //     padding: EdgeInsets.symmetric(horizontal: 10),
                  // //     width: 300,
                  // //     height: 45,
                  // //     decoration: BoxDecoration(
                  // //         color: ThemeConstants.ultraLightgreyColor,
                  // //         borderRadius:
                  // //             BorderRadius.all(Radius.circular(25.0))),
                  // //     child: Row(
                  // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // //       crossAxisAlignment: CrossAxisAlignment.center,
                  // //       children: [
                  // //         Container(
                  // //           padding: EdgeInsets.all(7),
                  // //           height: 35,
                  // //           width: 35,
                  // //           decoration: BoxDecoration(
                  // //               color: ThemeConstants.bluecolor,
                  // //               shape: BoxShape.circle),
                  // //           child: SvgPicture.asset(
                  // //             'assets/icons/SVO icon.svg',
                  // //             color: ThemeConstants.whitecolor,
                  // //           ),
                  // //         ),
                  // //         const SizedBox(
                  // //           width: 20,
                  // //         ),
                  // //         CustomRichTextWidget(
                  // //           text: 'SVO',
                  // //           text1: "Join via ",
                  // //           fontWeight: FontWeight.w600,
                  // //           textColor: ThemeConstants.bluecolor,
                  // //         ),
                  // //         const Spacer(),
                  // //       ],
                  // //     ),
                  // //   ),
                  // // ),

                  // // Material(
                  // //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  // //   color: ThemeConstants.ultraLightgreyColor,
                  // //   child: InkWell(
                  // //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  // //     splashColor: ThemeConstants.bluecolor,
                  // //     onTap: () async {
                  // //       await Future.delayed(Duration(milliseconds: 150));

                  // //       Get.toNamed(BookAnAppointment.routeNamed);
                  // //     },
                  // //     child: Container(
                  // //       width: 300,
                  // //       height: 45,
                  // //       padding: EdgeInsets.symmetric(horizontal: 10),
                  // //       // decoration: BoxDecoration(
                  // //       //     borderRadius:
                  // //       //         BorderRadius.all(Radius.circular(25.0))),
                  // //       child: Row(
                  // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // //         crossAxisAlignment: CrossAxisAlignment.center,
                  // //         children: [
                  // //           Container(
                  // //             padding: EdgeInsets.all(7),
                  // //             height: 35,
                  // //             width: 35,
                  // //             decoration: BoxDecoration(
                  // //                 color: ThemeConstants.bluecolor,
                  // //                 shape: BoxShape.circle),
                  // //             child: SvgPicture.asset(
                  // //               'assets/icons/Calender icon.svg',
                  // //               color: ThemeConstants.whitecolor,
                  // //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 20,
                  //           ),
                  //           CustomAutoSizeTextMontserrat(
                  //               text: "Book an appointment"),
                  //           const Spacer(),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// _launchURL() async {
//   final call = Uri.parse('tel:+91 9779046382');
//   if (await canLaunchUrl (call)) {
//     launchUrl(call);
//   } else {
//     throw 'Could not launch $call';
//   }
// }

// _launchEmailURL() async {
//   final call = Uri.parse('mailto:gradlynksupport@siecindia.com');
//   if (await canLaunchUrl(call)) {
//     launchUrl(call);
//   } else {
//     throw 'Could not launch $call';
//   }
// }

// _launchURL2() async {
//   print('ddddcd');
//   // final call = Uri.parse('tel:+91 8394049598');
//   // if (await canLaunchUrl(call)) {
//   //   launchUrl(call);
//   // } else {
//   //   throw 'Could not launch $call';
//   // }

//   const url =
//       'https://zoom.us/j/97485138279?pwd=Y1cwcXRHUWZWOFN3aTZOdmhHZm4yQT09';
//   // ignore: deprecated_member_use
//   if (await canLaunch(url)) {
//     // ignore: deprecated_member_use
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

  updateData() async {
    var data = {
      "meetingId": widget.controller.listToShow[widget.indexz].id.toString(),
      "reasonOfReshedule": reasonOfReshedule.value.text,
      "rescheduleDate": date,
      "rescheduleTime": time,
      "rescheduleDuration": proposedDuration,
      "meetingType": meetingType,
      "modeOfMeeting": modeOfMeeting,
      "meetingLink": meetingLink.text,
      "updatedBY": Get.find<BaseController>().id,
      "siec_branch": selectedBranchForUserList,
      "specific_location_of_the_meeting": specifyLocation.text,
      "registration_link_of_the_meeting": registrationLink.text,
      "location_of_the_meeting": getMeetingLocation(meetingLocation ?? "")
    };
    Get.find<CalendarController>().onInit();
    print(data);

    var res = await widget.controller.resheduleMeeting(data);

    if (res) {
      context.pop();
    }
  }

  getMeetingLocation(String meetingLocation) {
    if (meetingLocation.toString() == true) {
      return "1";
    } else if (meetingLocation.toString() == true) {
      return "2";
    } else {
      return "";
    }
  }
}
