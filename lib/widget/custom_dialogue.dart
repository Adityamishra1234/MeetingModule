import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/reschedule_meeting.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_time_picker_only.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget.dart';
import 'package:meeting_module2/widget/custom_date_picker/custom_timer_widget_pick_hour_minutes.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';

class ResheduleMeetingDialogue extends StatefulWidget {
  ResheduleMeetingDialogue(
      {super.key, required this.controller, required this.indexz});

  DashBoardController controller;
  int indexz;

  @override
  State<ResheduleMeetingDialogue> createState() =>
      _ResheduleMeetingDialogueState();
}

class _ResheduleMeetingDialogueState extends State<ResheduleMeetingDialogue> {
  String time = '';
  String date = '';
  String proposedDuration = '';
  bool meetingType = true;
  String modeOfMeeting = 'Zoom';
  TextEditingController meetingLink = TextEditingController();
  TextEditingController reasonOfReshedule = TextEditingController();

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
                      alignment: Alignment.centerLeft,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Reschedule the Meeting",
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        textColor: ThemeConstants.bluecolor,
                      )),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: ThemeConstants.ultraLightgreyColor,
                        child: Icon(
                          Icons.close,
                          color: ThemeConstants.bluecolor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.9,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: CustomAutoSizeTextMontserrat(
                        text: "**touch only the value you want to change",
                        fontWeight: FontWeight.bold,
                      )),

                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                      padding: EdgeInsets.all(5),
                      child: CustomAutoSizeTextMontserrat(
                        text: "Date",
                        fontWeight: FontWeight.bold,
                      )),
                  CustomTimerWidget(callback: (val) {
                    date = val;
                    setState(() {});
                  }),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: CustomAutoSizeTextMontserrat(
                        text: "Time",
                        fontWeight: FontWeight.bold,
                      )),
                  CustomTimerWidget2(callback: (val) async {
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
                  SizedBox(
                    height: 10,
                  ),
                  CustomAutoSizeTextMontserrat(
                    text: "Proposed Duration",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:
                        CustomTimerWidgetForHourMinutes(callback: (val) async {
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAutoSizeTextMontserrat(
                        text: "Meeting Type",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                          width: (MediaQuery.of(context).size.width - 40) / 2.5,
                          child: CustomMultiDownSingle(
                              callbackFunctionSingle: (val) {
                                print(val);
                                if (val == 'Offline') {
                                  meetingType = false;
                                  // controller.MeetingType.value = false;
                                  // controller.update();
                                } else {
                                  meetingType = true;
                                  // controller.MeetingType.value = true;
                                  // controller.update();
                                }
                              },
                              enableMultiSelect: false,
                              model: ['Online', 'Offline'],
                              initialSelectedValue: 'Online')),
                      Container(
                        width: (MediaQuery.of(context).size.width - 40) / 2.7,
                        child: CustomMultiDownSingle(
                          enableMultiSelect: false,
                          model: ['Zoom', 'Meet', 'Teams'],
                          initialSelectedValue: 'Zoom',
                          callbackFunctionSingle: (val) {
                            modeOfMeeting = val;
                            // controller.modeOfMeeting.value = val;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: CustomAutoSizeTextMontserrat(
                        text: "Reason of Reshedule",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width - 40,
                    child: CustomTextField(
                      // validator: controller.MeetingType.value == true
                      //     ? Validator.notEmpty
                      //     : null,
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

                        String link = meetingLink.value.text;
                        var data = {
                          "meetingId": widget
                              .controller.listToShow[widget.indexz].id
                              .toString(),
                          "reasonOfReshedule": reasonOfReshedule.value.text,
                          "rescheduleDate": date == ''
                              ? widget.controller.listToShow[widget.indexz]
                                  .dateOfMeeting
                              : date,
                          "rescheduleTime": time == ''
                              ? widget.controller.listToShow[widget.indexz]
                                  .timeOfTheMeeting
                              : time,
                          "rescheduleDuration": proposedDuration == ''
                              ? widget.controller.listToShow[widget.indexz]
                                  .durationOfMeeting
                              : proposedDuration,
                          "meetingType":
                              modeOfMeeting == '' ? 'Zoom' : modeOfMeeting,
                          "modeOfMeeting": meetingType ? '1' : '0',
                          "meetingLink": link,
                          "updatedBY": 44
                        };

                        // var data2 = json.encode(data);

                        // data.timeOfTheMeeting = time;
                        // data.isReschedule = true;
                        // data.dateOfMeeting = date;
                        // data.durationOfMeeting = proposedDuration;
                        // data.meetingType =
                        //     meetingType == true ? 'Online' : 'Offline';
                        // data.meetingMode = modeOfMeeting;
                        // data.meetingLink = meetingLink.value.text;
                        //todo

                        // print(data.toJson());
                        widget.controller.resheduleMeeting(data);
                      })
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
}