import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/add_more_notes.dart';
// import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/ui/screens/view_docs.dart';
import 'package:meeting_module2/ui/screens/view_notes.dart';
import 'package:meeting_module2/utils/routes/router_config.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/popups/custom_error_non_changeable.dart';
import 'package:meeting_module2/widget/popups/custom_error_popup.dart';
import 'package:quickalert/quickalert.dart';
// test

class MeetingDetails extends StatefulWidget {
  // MeetingDetails();
  static const routeNamed = 'MeetingDetails';

  @override
  State<MeetingDetails> createState() => _MeetingDetailsState();
}

class _MeetingDetailsState extends State<MeetingDetails> {
  var controller = Get.put(AddMoreNotesController());

  var controllerbase = Get.find<BaseController>();

  // var controllerDashboard = Get.find<DashBoardController>();

  GlobalKey<FormState> _keyForReasonOfNotAttending = GlobalKey<FormState>();

  TextEditingController reasonOfNotAttending = TextEditingController();
  late bool meetingStarted;
  late bool meetingEnded;
  late AllMeetings meetingData;
  int daata = 1;

  // @override
  // void initState() {
  //   controller.getMeetingParticipantsList();
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  void initState() {
    meetingData = controllerbase.selectedMeetingData;

    meetingStarted = meetingData.meetingStarted!;
    meetingEnded = meetingData.meetingEnded!;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // AllMeetings meetingData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop('true');
        return true;
      },
      child: Scaffold(
        backgroundColor: ThemeConstants.lightVioletColor,
        body: controller.obx(
            (state) => SafeArea(
                    child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      gradient: ThemeConstants.backgroundGradient),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView(
                            children: [
                              Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 20, bottom: 5),
                                    child: CustomAutoSizeTextMontserrat(
                                      text: "${meetingData.meetingAgenda}",
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      textColor: ThemeConstants.whitecolor,
                                    ),
                                  ),
                                  // meetingData.meetingStarted! &&
                                  //         !meetingData.meetingEnded!
                                  //     ? Row(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           Radio(
                                  //               activeColor: Colors.green,
                                  //               value: true,
                                  //               groupValue: true,
                                  //               onChanged: (val) {}),
                                  //           CustomAutoSizeTextMontserrat(
                                  //             text: '(Started)',
                                  //             textColor: ThemeConstants.GreenColor,
                                  //           )
                                  //         ],
                                  //       )
                                  //     : SizedBox.shrink(),
                                  // meetingData.meetingStarted! &&
                                  //         meetingData.meetingEnded!
                                  //     ? Row(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           Radio(
                                  //               activeColor: Colors.red,
                                  //               value: true,
                                  //               groupValue: true,
                                  //               onChanged: (val) {}),
                                  //           CustomAutoSizeTextMontserrat(
                                  //             text: '(Ended)',
                                  //             textColor: Colors.red,
                                  //           )
                                  //         ],
                                  //       )
                                  //     : SizedBox.shrink(),
                                  // !meetingData.meetingStarted! &&
                                  //         !meetingData.meetingEnded!
                                  //     ? Row(
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           Radio(
                                  //               activeColor: const Color.fromARGB(
                                  //                   255, 114, 114, 114),
                                  //               value: true,
                                  //               groupValue: true,
                                  //               onChanged: (val) {}),
                                  //           CustomAutoSizeTextMontserrat(
                                  //             text: 'Not Started',
                                  //             textColor: const Color.fromARGB(
                                  //                 255, 114, 114, 114),
                                  //           )
                                  //         ],
                                  //       )
                                  //     : SizedBox.shrink()
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 0, bottom: 10),
                                child: CustomAutoSizeTextMontserrat(
                                  text: "${meetingData.nameOfTheMeeting}",
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  textColor: ThemeConstants.paleYellow,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(17, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 1.5,
                                          color: ThemeConstants.whitecolor)),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 0,
                                          // top: 10,/
                                          // bottom: 10,
                                          // right: 10,
                                        ),
                                        height: 72,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          // boxShadow: [
                                          //   const BoxShadow(
                                          //       blurRadius: 0.5,
                                          //       spreadRadius: 0.1,
                                          //       color: Color.fromARGB(40, 0, 0, 0))
                                          // ],
                                          // color: ThemeConstants.whitecolor,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: SizedBox(
                                          height: 50,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              SizedBox(
                                                width: 33,
                                                height: 33,
                                                child: Image.asset(
                                                  'assets/page-1/images/image-2-7kL.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 18),
                                                child: Column(
                                                  children: [
                                                    CustomAutoSizeTextMontserrat(
                                                      text: "Meeting Type",
                                                      fontSize: 14,
                                                      textColor: ThemeConstants
                                                          .whitecolor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    CustomAutoSizeTextMontserrat(
                                                      textColor: ThemeConstants
                                                          .whitecolor,
                                                      text:
                                                          "${meetingData.meetingType}",
                                                      fontSize: 12,
                                                      maxLines: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // const Spacer(),
                                      SizedBox(
                                        width: 5,
                                        height: 5,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 0,
                                          // top: 10,
                                          // bottom: 20,
                                          // right: 10,
                                        ),
                                        width: 180,
                                        height: 72,
                                        decoration: BoxDecoration(
                                          // boxShadow: const [
                                          //   BoxShadow(
                                          //       blurRadius: 0.5,
                                          //       spreadRadius: 0.1,
                                          //       color: Color.fromARGB(40, 0, 0, 0)),
                                          // ],
                                          // color: ThemeConstants.whitecolor,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: SizedBox(
                                          height: 50,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              SizedBox(
                                                width: 33,
                                                height: 33,
                                                child: Image.asset(
                                                  'assets/page-1/images/image-3-gBS.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 18),
                                                child: Column(
                                                  children: [
                                                    CustomAutoSizeTextMontserrat(
                                                      textColor: ThemeConstants
                                                          .whitecolor,
                                                      text: "Agenda",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    CustomAutoSizeTextMontserrat(
                                                      textColor: ThemeConstants
                                                          .whitecolor,
                                                      text: "Networking",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              )
                                            ],
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                child: Row(
                                  children: [
                                    CustomAutoSizeTextMontserrat(
                                      textColor: ThemeConstants.paleYellow,
                                      text: "Meeting Details",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    // Spacer(),
                                    // Container(
                                    //   padding: EdgeInsets.only(
                                    //       top: 5, left: 8, bottom: 5, right: 20),
                                    //   margin: EdgeInsets.symmetric(
                                    //       vertical: 6, horizontal: 4),
                                    //   decoration: BoxDecoration(
                                    //     boxShadow: [
                                    //       const BoxShadow(
                                    //           blurRadius: 0.5,
                                    //           spreadRadius: 0.1,
                                    //           color: Color.fromARGB(40, 0, 0, 0))
                                    //     ],
                                    //     color: ThemeConstants.whitecolor,
                                    //     borderRadius: BorderRadius.circular(13),
                                    //   ),
                                    //   child: CustomAutoSizeTextMontserrat(
                                    //     text: "Mark Attendance",
                                    //     textColor: ThemeConstants.TextColor,
                                    //     fontSize: 13,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 0, left: 0, bottom: 5, right: 20),
                                margin: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 12),
                                decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   const BoxShadow(
                                  //       blurRadius: 0.5,
                                  //       spreadRadius: 0.1,
                                  //       color: Color.fromARGB(40, 0, 0, 0))
                                  // ],
                                  // color: ThemeConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Column(
                                  children: [
                                    meetingData.meetingType ==
                                            'External Meeting'
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 5),
                                            child: Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  color:
                                                      ThemeConstants.whitecolor,
                                                  weight: 20,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CustomAutoSizeTextMontserrat(
                                                  text: 'Meeting with:',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  textColor:
                                                      ThemeConstants.whitecolor,
                                                ),
                                                Spacer(),
                                                // SizedBox(
                                                //   width: 24,
                                                //   height: 24,
                                                //   child: Image.asset(
                                                //     'assets/page-1/images/group-9-CJc.png',
                                                //     width: 24,
                                                //     height: 24,
                                                //   ),
                                                // ),

                                                CustomAutoSizeTextMontserrat(
                                                  text:
                                                      "${meetingData.meetingWith}",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  textColor:
                                                      ThemeConstants.whitecolor,
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: ThemeConstants.whitecolor,
                                            weight: 20,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CustomAutoSizeTextMontserrat(
                                            text: "Date:",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                          // SizedBox(
                                          //   width: 24,
                                          //   height: 24,
                                          //   child: Image.asset(
                                          //     'assets/page-1/images/group-9-CJc.png',
                                          //     width: 24,
                                          //     height: 24,
                                          //   ),
                                          // ),
                                          Spacer(),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomAutoSizeTextMontserrat(
                                            text:
                                                "${meetingData.dateOfMeeting}",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 15),
                                    //   child: Row(
                                    //     // mainAxisAlignment:
                                    //     //     MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Icon(
                                    //         Icons.calendar_month,
                                    //         color: ThemeConstants.whitecolor,
                                    //       ),
                                    //       SizedBox(
                                    //         width: 5,
                                    //       ),
                                    //       CustomAutoSizeTextMontserrat(
                                    //         text: "Time:",
                                    //         fontWeight: FontWeight.w500,
                                    //         fontSize: 14,
                                    //         textColor: ThemeConstants.whitecolor,
                                    //       ),
                                    //       // CustomAutoSizeTextMontserrat(
                                    //       //   text: "Time:",
                                    //       //   fontWeight: FontWeight.w500,
                                    //       //   fontSize: 14,
                                    //       //   textColor: ThemeConstants.TextColor,
                                    //       // ),
                                    //       // SizedBox(
                                    //       //   width: 24,
                                    //       //   height: 24,
                                    //       //   child: Image.asset(
                                    //       //     'assets/page-1/images/group-9-CJc.png',
                                    //       //     width: 24,
                                    //       //     height: 24,
                                    //       //   ),
                                    //       // ),
                                    //       Spacer(),
                                    //       SizedBox(
                                    //         width: 10,
                                    //       ),
                                    //       CustomAutoSizeTextMontserrat(
                                    //         text: "${meetingData.timeOfTheMeeting}",
                                    //         fontWeight: FontWeight.w500,
                                    //         fontSize: 14,
                                    //         textColor: ThemeConstants.TextColor,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.computer_outlined,
                                            weight: 20,
                                            size: 20,
                                            color: ThemeConstants.whitecolor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CustomAutoSizeTextMontserrat(
                                            text: "Mode:",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                          // CustomAutoSizeTextMontserrat(
                                          //   text: "Time:",
                                          //   fontWeight: FontWeight.w500,
                                          //   fontSize: 14,
                                          //   textColor: ThemeConstants.TextColor,
                                          // ),
                                          // SizedBox(
                                          //   width: 24,
                                          //   height: 24,
                                          //   child: Image.asset(
                                          //     'assets/page-1/images/group-9-CJc.png',
                                          //     width: 24,
                                          //     height: 24,
                                          //   ),
                                          // ),
                                          Spacer(),
                                          // CustomAutoSizeTextMontserrat(
                                          //   text: "Mode: ",
                                          //   fontWeight: FontWeight.w500,
                                          //   fontSize: 14,
                                          //   textColor: ThemeConstants.TextColor,
                                          // ),
                                          // Spacer(),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          CustomAutoSizeTextMontserrat(
                                            text:
                                                "${meetingData.meetingMode == false ? "offline" : "online"}",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 15),
                                    //   child: SizedBox(
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Icon(
                                    //           Icons.calendar_month,
                                    //           color: ThemeConstants.whitecolor,
                                    //         ),
                                    //         SizedBox(
                                    //           width: 5,
                                    //         ),
                                    //         CustomAutoSizeTextMontserrat(
                                    //           text: "Duration: ",
                                    //           fontWeight: FontWeight.w500,
                                    //           fontSize: 14,
                                    //           textColor: ThemeConstants.whitecolor,
                                    //         ),
                                    //         // CustomAutoSizeTextMontserrat(
                                    //         //   text: "Time:",
                                    //         //   fontWeight: FontWeight.w500,
                                    //         //   fontSize: 14,
                                    //         //   textColor: ThemeConstants.TextColor,
                                    //         // ),
                                    //         // SizedBox(
                                    //         //   width: 24,
                                    //         //   height: 24,
                                    //         //   child: Image.asset(
                                    //         //     'assets/page-1/images/group-9-CJc.png',
                                    //         //     width: 24,
                                    //         //     height: 24,
                                    //         //   ),
                                    //         // ),
                                    //         Spacer(),
                                    //         // CustomAutoSizeTextMontserrat(
                                    //         //   text: "Duration: ",
                                    //         //   fontWeight: FontWeight.w500,
                                    //         //   fontSize: 14,
                                    //         //   textColor: ThemeConstants.TextColor,
                                    //         // ),
                                    //         // SizedBox(
                                    //         //   width: 24,
                                    //         //   height: 24,
                                    //         //   child: Image.asset(
                                    //         //     'assets/page-1/images/group-9-CJc.png',
                                    //         //     width: 24,
                                    //         //     height: 24,
                                    //         //   ),
                                    //         // ),
                                    //         const SizedBox(
                                    //           width: 10,
                                    //         ),
                                    //         CustomAutoSizeTextMontserrat(
                                    //           text:
                                    //               "${meetingData.durationOfMeeting}",
                                    //           fontSize: 14,
                                    //           fontWeight: FontWeight.w500,
                                    //           textColor: ThemeConstants.TextColor,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            weight: 20,
                                            size: 20,
                                            Icons.video_call,
                                            color: ThemeConstants.whitecolor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CustomAutoSizeTextMontserrat(
                                            text: "Platform:",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                          // CustomAutoSizeTextMontserrat(
                                          //   text: "Time:",
                                          //   fontWeight: FontWeight.w500,
                                          //   fontSize: 14,
                                          //   textColor: ThemeConstants.TextColor,
                                          // ),
                                          // SizedBox(
                                          //   width: 24,
                                          //   height: 24,
                                          //   child: Image.asset(
                                          //     'assets/page-1/images/group-9-CJc.png',
                                          //     width: 24,
                                          //     height: 24,
                                          //   ),
                                          // ),
                                          Spacer(),
                                          // CustomAutoSizeTextMontserrat(
                                          //   text: "Platform:",
                                          //   fontWeight: FontWeight.w500,
                                          //   fontSize: 14,
                                          //   textColor: ThemeConstants.TextColor,
                                          // ),
                                          // SizedBox(
                                          //   // zoomi96 (211:612)

                                          //   width: 24,
                                          //   height: 24,
                                          //   child: Image.asset(
                                          //     'assets/page-1/images/zoom.png',
                                          //     fit: BoxFit.contain,
                                          //   ),
                                          // ),
                                          CustomAutoSizeTextMontserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            textColor:
                                                ThemeConstants.whitecolor,
                                            text:
                                                "${meetingData.meetingModeType}",
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.link,
                                            weight: 20,
                                            size: 20,
                                            color: ThemeConstants.whitecolor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CustomAutoSizeTextMontserrat(
                                            text: "Meeting Link:",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                          // CustomAutoSizeTextMontserrat(
                                          //   text: "Time:",
                                          //   fontWeight: FontWeight.w500,
                                          //   fontSize: 14,
                                          //   textColor: ThemeConstants.TextColor,
                                          // ),
                                          // SizedBox(
                                          //   width: 24,
                                          //   height: 24,
                                          //   child: Image.asset(
                                          //     'assets/page-1/images/group-9-CJc.png',
                                          //     width: 24,
                                          //     height: 24,
                                          //   ),
                                          // ),
                                          Spacer(),
                                          // CustomAutoSizeTextMontserrat(
                                          //   text: "Link: ",
                                          //   fontWeight: FontWeight.w500,
                                          //   fontSize: 14,
                                          //   textColor: ThemeConstants.TextColor,
                                          // ),
                                          // // Container(
                                          //   // linknYG (211:616)
                                          //   margin: const EdgeInsets.fromLTRB(
                                          //       0, 0, 7.14, 0),
                                          //   width: 24,
                                          //   height: 24,
                                          //   child: Image.asset(
                                          //     'assets/page-1/images/link.png',
                                          //     fit: BoxFit.contain,
                                          //   ),
                                          // ),

                                          CustomAutoSizeTextMontserrat(
                                            text: "${meetingData.meetingLink}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            textColor:
                                                ThemeConstants.whitecolor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              meetingData.meetingType == 'External Meeting' &&
                                      controller.participantDataList.length != 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Container(
                                          //   // guardianesJ (211:620)
                                          //   margin: const EdgeInsets.fromLTRB(
                                          //       0, 0, 9, 0),
                                          //   width: 20,
                                          //   height: 20,
                                          //   child: Image.asset(
                                          //     'assets/page-1/images/guardian-T8t.png',
                                          //     fit: BoxFit.contain,
                                          //     color: ThemeConstants.blackcolor,
                                          //   ),
                                          // ),
                                          CustomAutoSizeTextMontserrat(
                                            textColor:
                                                ThemeConstants.paleYellow,
                                            text:
                                                "Participants attending meeting",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          // CustomAutoSizeTextMontserrat(
                                          //   text:
                                          //       "Participants attending meeting",
                                          //   fontSize: 14,
                                          //   fontWeight: FontWeight.w600,
                                          // )
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink(),

                              meetingData.meetingType == 'External Meeting' &&
                                      controller.participantDataList.length != 0
                                  ? Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                          top: 5,
                                          left: 5,
                                          bottom: 5,
                                          right: 20),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   const BoxShadow(
                                        //       blurRadius: 0.5,
                                        //       spreadRadius: 0.1,
                                        //       color: Color.fromARGB(40, 0, 0, 0))
                                        // ],
                                        // color: ThemeConstants.whitecolor,
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: meetingData.meetingType ==
                                              'External Meeting'
                                          ? Wrap(
                                              children: [
                                                ...controller
                                                    .participantDataList
                                              ],
                                            )
                                          : SizedBox.shrink(),
                                    )
                                  : SizedBox.shrink(),

                              //
                              // Padding(
                              //     padding: const EdgeInsets.only(left: 50),
                              //     child: CustomAutoSizeTextMontserrat(
                              //       text:
                              //           "${meetingData.siecParticipants!.map((e) => e.name).toList().toString().substring(1, meetingData.siecParticipants!.map((e) => e.name).toList().toString().length - 1)}",
                              //       textColor: ThemeConstants.TextColor,
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //   )

                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                height: 8,
                              ),

                              ParticipantListWidget(nameList: [
                                ...siecParticipantsList(meetingData)
                              ], title: 'SIEC Attendees'),

                              // ParticipantListWidget(
                              //     nameList: [...siecParticipantsList(meetingData)],
                              //     title: 'SIEC Attendees'),
                              // ParticipantListWidget(
                              //     nameList: [...siecParticipantsList(meetingData)],
                              //     title: 'SIEC Attendees'),
                              // ParticipantListWidget(
                              //     nameList: [...siecParticipantsList(meetingData)],
                              //     title: 'SIEC Attendees'),
                              // ParticipantListWidget(
                              //     nameList: [...siecParticipantsList(meetingData)],
                              //     title: 'SIEC Attendees'),
                              // ParticipantListWidget(
                              //     nameList: [...siecParticipantsList(meetingData)],
                              //     title: 'SIEC Attendees'),
                              // ParticipantListWidget(
                              //     nameList: [...siecParticipantsList(meetingData)],
                              //     title: 'SIEC Attendees'),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 20),
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       // Container(
                              //       //   // guardianesJ (211:620)
                              //       //   margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                              //       //   width: 20,
                              //       //   height: 20,
                              //       //   child: Image.asset(
                              //       //     'assets/page-1/images/guardian-T8t.png',
                              //       //     fit: BoxFit.contain,
                              //       //     color: ThemeConstants.blackcolor,
                              //       //   ),
                              //       // ),
                              //       CustomAutoSizeTextMontserrat(
                              //         textColor: ThemeConstants.paleYellow,
                              //         text: "SIEC Attendees",
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //       // CustomAutoSizeTextMontserrat(
                              //       //   text: "SIEC Attendees",
                              //       //   fontSize: 14,
                              //       //   fontWeight: FontWeight.w600,
                              //       // )
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //     width: double.infinity,
                              //     padding: EdgeInsets.only(
                              //         top: 0, left: 15, bottom: 5, right: 20),
                              //     margin:
                              //         EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              //     decoration: BoxDecoration(
                              //       color: Colors.transparent,
                              //       borderRadius: BorderRadius.circular(13),
                              //     ),
                              //     child: Wrap(
                              //         children: [...siecParticipantsList(meetingData)])),

                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 20),
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Container(
                              //         // guardianesJ (211:620)
                              //         margin:
                              //             const EdgeInsets.fromLTRB(0, 0, 9, 0),
                              //         width: 20,
                              //         height: 20,
                              //         child: Image.asset(
                              //           'assets/page-1/images/guardian-T8t.png',
                              //           fit: BoxFit.contain,
                              //           color: ThemeConstants.blackcolor,
                              //         ),
                              //       ),
                              //       CustomAutoSizeTextMontserrat(
                              //         text: "Meeting Coordinators",
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w600,
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //     width: double.infinity,
                              //     padding: EdgeInsets.only(
                              //         top: 0, left: 10, bottom: 5, right: 20),
                              //     margin: EdgeInsets.symmetric(
                              //         vertical: 8, horizontal: 12),
                              //     decoration: BoxDecoration(
                              //       color: Colors.transparent,
                              //       borderRadius: BorderRadius.circular(13),
                              //     ),
                              //     child: Wrap(children: [
                              //       ...siecCordinatorList(meetingData)
                              //     ])),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 52),
                              //   child: CustomAutoSizeTextMontserrat(
                              //     text:
                              //         '${meetingData.meetingCoordinator!.map((e) => e.name).toString().substring(1, meetingData.meetingCoordinator!.map((e) => e.name).toString().length - 1)}',
                              //     fontSize: 13,
                              //     fontWeight: FontWeight.w500,
                              //     textColor: ThemeConstants.TextColor,
                              //   ),
                              // ),
                              ParticipantListWidget(
                                title: "Meeting Coordinators",
                                nameList: [...siecCordinatorList(meetingData)],
                              ),

                              // controller.showTheStartEndOptions
                              //     ? Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Row(
                              //           children: [
                              //             Column(
                              //               children: [
                              //                 Padding(
                              //                   padding: const EdgeInsets.symmetric(
                              //                       horizontal: 10, vertical: 5),
                              //                   child: CustomAutoSizeTextMontserrat(
                              //                     text: "Meeting Started",
                              //                     fontSize: 14,
                              //                     fontWeight: FontWeight.w500,
                              //                   ),
                              //                 ),
                              //                 Radio(
                              //                     value: true,
                              //                     groupValue: true,
                              //                     onChanged: (val) {})
                              //                 // Switch(
                              //                 //   value: meetingData.meetingStarted!,
                              //                 //   onChanged: (val) {
                              //                 //     controller.meetingStarted(
                              //                 //         meetingData.id!, val);
                              //                 //   },
                              //                 // ),
                              //               ],
                              //             ),
                              //             Column(
                              //               children: [
                              //                 Padding(
                              //                   padding: const EdgeInsets.symmetric(
                              //                       horizontal: 10, vertical: 5),
                              //                   child: CustomAutoSizeTextMontserrat(
                              //                     text: "Meeting Ended",
                              //                     fontSize: 14,
                              //                     fontWeight: FontWeight.w500,
                              //                   ),
                              //                 ),
                              //                 Switch(
                              //                     value: meetingData.meetingEnded!,
                              //                     onChanged: (val) {
                              //                       controller.meetingEnded(
                              //                           meetingData.id!, val);
                              //                     }),
                              //               ],
                              //             )
                              //           ],
                              //         ),
                              //       )
                              //     : InkWell(
                              //         onTap: () {
                              //           showDialog(
                              //               context: context,
                              //               builder: (_) => AlertDialog(
                              //                     content: Container(
                              //                       child: Text('ddd'),
                              //                     ),
                              //                   ));
                              //         },
                              //         child: IgnorePointer(
                              //           ignoring: true,
                              //           child: Opacity(
                              //             opacity: 0.5,
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(8.0),
                              //               child: Row(
                              //                 children: [
                              //                   Column(
                              //                     children: [
                              //                       Padding(
                              //                         padding:
                              //                             const EdgeInsets.symmetric(
                              //                                 horizontal: 10,
                              //                                 vertical: 5),
                              //                         child:
                              //                             CustomAutoSizeTextMontserrat(
                              //                           text: "Meeting Started",
                              //                           fontSize: 16,
                              //                           fontWeight: FontWeight.w800,
                              //                         ),
                              //                       ),
                              //                       Switch(
                              //                         value:
                              //                             meetingData.meetingStarted!,
                              //                         onChanged: (val) {
                              //                           controller.meetingStarted(
                              //                               meetingData.id!, val);
                              //                         },
                              //                       ),
                              //                     ],
                              //                   ),
                              //                   Column(
                              //                     children: [
                              //                       Padding(
                              //                         padding:
                              //                             const EdgeInsets.symmetric(
                              //                                 horizontal: 10,
                              //                                 vertical: 5),
                              //                         child:
                              //                             CustomAutoSizeTextMontserrat(
                              //                           text: "Meeting Ended",
                              //                           fontSize: 16,
                              //                           fontWeight: FontWeight.w800,
                              //                         ),
                              //                       ),
                              //                       Switch(
                              //                           value:
                              //                               meetingData.meetingEnded!,
                              //                           onChanged: (val) {
                              //                             controller.meetingEnded(
                              //                                 meetingData.id!, val);
                              //                           }),
                              //                     ],
                              //                   )
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),

                              // CustomAutoText using for mandatory *
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 20, top: 15),
                              //   child: CustomAutoSizeTextMontserrat(
                              //     text: 'Add Meeting Notes ',
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w600,
                              //     textColor: ThemeConstants.bluecolor,
                              //     mandatory: true,
                              //   ),
                              // ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.only(left: 20),
                              //       child: CustomAutoSizeTextMontserrat(
                              //         text: 'Notes accessibility to',
                              //         fontSize: 10,
                              //         fontWeight: FontWeight.w600,
                              //         textColor: ThemeConstants.TextColor,
                              //       ),
                              //     ),
                              //     const Spacer(),
                              //     // InkWell(
                              //     //   onTap: () {
                              //     //     Get.to(ViewNotesDetails(),
                              //     //         arguments: meetingData.id);
                              //     //   },
                              //     //   child: SizedBox(
                              //     //     width: 86,
                              //     //     height: 24,
                              //     //     child: Container(
                              //     //       decoration: BoxDecoration(
                              //     //         borderRadius: BorderRadius.circular(20),
                              //     //         border: Border.all(
                              //     //             color: const Color(0xffff9900)),
                              //     //       ),
                              //     //       child: Center(
                              //     //         child: CustomAutoSizeTextMontserrat(
                              //     //           text: "View Notes",
                              //     //           fontSize: 12,
                              //     //           textColor: const Color(0xffff9900),
                              //     //         ),
                              //     //       ),
                              //     //     ),
                              //     //   ),
                              //     // ),
                              //     const SizedBox(
                              //       width: 25,
                              //     ),
                              //   ],
                              // ),

                              // DropDown

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 0, right: 10, top: 5),
                              //   child: CustomMultiDownSingleAllUser(
                              //     // model: ['d', 'd'],
                              //     model: Get.find<BaseController>().allSiecMembersList,
                              //     // callbackFunction: callback,
                              //     callbackFunctionMulti: (val) {
                              //       controller.accessibileUserSelected_meetingDetail
                              //           .value = val;

                              //       print(controller
                              //           .accessibileUserSelected_meetingDetail);
                              //       controller.update();
                              //     },
                              //     enableMultiSelect: true,
                              //     // inititalSelectedList:
                              //     //     controller.accessibileUserSelected_meetingDetail,

                              //     initialSelectedValue: '',
                              //   ),
                              //   // TextField(
                              //   //   // controller: firstName,
                              //   //   scrollPadding: EdgeInsets.symmetric(
                              //   //       vertical: MediaQuery.of(context).viewInsets.bottom + 30),
                              //   //   style: ThemeConstants.montserrattextstyle2,
                              //   //   // readOnly: saveAndEdit,
                              //   //   decoration: textFieldDecoration("Demo Text Field"),
                              //   // ),
                              // ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: ThemeConstants.whitecolor),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45))),
                        padding:
                            const EdgeInsets.only(top: 30, left: 25, right: 25),
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            height: 90,
                            padding: EdgeInsets.only(
                                top: 0, left: 0, bottom: 5, right: 0),
                            margin: EdgeInsets.only(
                                left: 0, right: 0, top: 0, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: ThemeConstants.whitecolor),
                              // boxShadow: [
                              //   const BoxShadow(
                              //       blurRadius: 0.5,
                              //       spreadRadius: 0.1,
                              //       color: Color.fromARGB(40, 0, 0, 0))
                              // ],
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (controller.meetingStartedValue ==
                                        true) {
                                      context.push(
                                          '${Routes.dashboard}/${Routes.meetingDetails}/${Routes.addMoreNotesView}/${meetingData.id}/0');
                                      // Get.toNamed(AddMoreNotesView.routeName,
                                      //     arguments: [meetingData.id, 0]);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => showPoPUp(
                                              'Meeting not started yet',
                                              Icon(
                                                Icons.error,
                                                size: 40,
                                                color: ThemeConstants.bluecolor,
                                              ),
                                              context));
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 100,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                            color: ThemeConstants.blackcolor,
                                          )),
                                      CustomAutoSizeTextMontserrat(
                                        text: 'Add Note',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        textColor: ThemeConstants.blackcolor,
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.push(
                                      '${Routes.dashboard}/${Routes.meetingDetails}/${ViewNotesDetails.routeNamed}/:${meetingData.id}',
                                    );
                                    // Get.to(ViewNotesDetails(),
                                    //     arguments: meetingData.id);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 100,
                                          alignment: Alignment.center,
                                          child: Icon(Icons.document_scanner,
                                              size: 30)),
                                      CustomAutoSizeTextMontserrat(
                                        text: 'View Note',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        textColor: ThemeConstants.blackcolor,
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.push(
                                        '${Routes.dashboard}/${Routes.meetingDetails}/${Routes.addMoreNotesView}/${meetingData.id}/1');
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 100,
                                          alignment: Alignment.center,
                                          child: Icon(Icons.upload, size: 30)),
                                      CustomAutoSizeTextMontserrat(
                                        text: 'Upload File',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        textColor: ThemeConstants.blackcolor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.showTheStartEndOptions
                                    ? InkWell(
                                        onTap: () async {
                                          if (controller.meetingStartedValue ==
                                                  false &&
                                              controller.meetingEndedValue ==
                                                  false) {
                                            print('ddddd');

                                            controller.showLoading = true;
                                            controller.update();
                                            //  Future.delayed(
                                            //         Duration(seconds: 5));

                                            await controller.meetingStarted(
                                                meetingData.id!, true);
                                            controller.meetingStartedValue =
                                                true;
                                            controller.showLoading = false;
                                            controller.update();
                                            // showDialog(
                                            //     context: context,
                                            //     builder: (_) => CustomErrorPopup(
                                            //         text: 'sss',
                                            //         showLoading: false));

                                            controller.update();
                                          } else if (controller
                                                      .meetingStartedValue ==
                                                  true &&
                                              controller.meetingEndedValue ==
                                                  false) {
                                            print('ddddd');
                                            // showLoading = true;
                                            // setState(() {});
                                            controller.showLoading = true;
                                            // Future.delayed(Duration(seconds: 5));
                                            controller.update();
                                            await controller.meetingEnded(
                                                meetingData.id!, true);
                                            // controller.showLoading = false;
                                            controller.meetingEndedValue = true;
                                            controller.showLoading = false;
                                            // showDialog(
                                            //     context: context,
                                            //     builder: (_) => CustomErrorPopup(
                                            //         text: 'sss',
                                            //         showLoading: false));
                                            controller.update();
                                            setState(() {});
                                          } else if (controller
                                                      .meetingStartedValue ==
                                                  true &&
                                              controller.meetingEndedValue ==
                                                  true) {
                                            showDialog(
                                                barrierDismissible: true,
                                                context: context,
                                                builder: (_) => showPoPUp(
                                                    'Meeting Already Ended',
                                                    Icon(
                                                      Icons.error,
                                                      size: 40,
                                                      color: ThemeConstants
                                                          .bluecolor,
                                                    ),
                                                    context));
                                          }
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (_) => AlertDialog(
                                          //           content: Container(
                                          //             child: Column(
                                          //               mainAxisAlignment:
                                          //                   MainAxisAlignment
                                          //                       .center,
                                          //               mainAxisSize:
                                          //                   MainAxisSize.min,
                                          //               children: [
                                          //                 Icon(
                                          //                     Icons.mark_email_read)
                                          //               ],
                                          //             ),
                                          //           ),
                                          //         ));
                                        },
                                        child: Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    100) /
                                                3,
                                            height: 90,
                                            // padding: EdgeInsets.only(
                                            //     top: 5, left: 5, bottom: 5, right: 20),
                                            // margin: EdgeInsets.symmetric(
                                            //     vertical: 15, horizontal: 12),
                                            decoration: BoxDecoration(
                                              // boxShadow: [
                                              //   const BoxShadow(
                                              //       blurRadius: 0.5,
                                              //       spreadRadius: 0.1,
                                              //       color: Color.fromARGB(
                                              //           40, 0, 0, 0))
                                              // ],
                                              color: ThemeConstants.whitecolor,
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                            ),
                                            child: controller
                                                            .meetingStartedValue ==
                                                        false &&
                                                    controller
                                                            .meetingEndedValue ==
                                                        false
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (controller
                                                              .showLoading ==
                                                          false) ...[
                                                        Icon(Icons.meeting_room,
                                                            size: 30),
                                                        CustomAutoSizeTextMontserrat(
                                                          align:
                                                              TextAlign.center,
                                                          text: 'Start Meeting',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          textColor:
                                                              ThemeConstants
                                                                  .blackcolor,
                                                        )
                                                      ] else if (controller
                                                              .showLoading ==
                                                          true) ...[
                                                        CircularProgressIndicator()
                                                      ]
                                                    ],
                                                  )
                                                : controller.meetingStartedValue ==
                                                            true &&
                                                        controller
                                                                .meetingEndedValue ==
                                                            false
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          if (controller
                                                                  .showLoading ==
                                                              false) ...[
                                                            Icon(
                                                                Icons
                                                                    .meeting_room,
                                                                size: 30),
                                                            CustomAutoSizeTextMontserrat(
                                                              align: TextAlign
                                                                  .center,
                                                              text:
                                                                  'End Meeting',
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              textColor:
                                                                  ThemeConstants
                                                                      .blackcolor,
                                                            )
                                                          ] else ...[
                                                            CircularProgressIndicator()
                                                          ]
                                                        ],
                                                      )
                                                    : controller.meetingStartedValue ==
                                                                true &&
                                                            controller
                                                                    .meetingEndedValue ==
                                                                true
                                                        ? Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .meeting_room,
                                                                  size: 30),
                                                              CustomAutoSizeTextMontserrat(
                                                                align: TextAlign
                                                                    .center,
                                                                text:
                                                                    'Meeting Ended',
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                textColor:
                                                                    ThemeConstants
                                                                        .blackcolor,
                                                              )
                                                            ],
                                                          )
                                                        : SizedBox.shrink()),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          showDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (_) => showPoPUp(
                                                  'Only Co-ordinator or meeting creator can start and end the meeting',
                                                  Icon(
                                                    Icons.error,
                                                    size: 40,
                                                    color: ThemeConstants
                                                        .bluecolor,
                                                  ),
                                                  context));
                                        },
                                        child: IgnorePointer(
                                          ignoring: true,
                                          child: Opacity(
                                            opacity: 0.5,
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => AlertDialog(
                                                          content: Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(Icons
                                                                    .mark_email_read)
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                              },
                                              child: Container(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          100) /
                                                      3,
                                                  height: 90,
                                                  // padding: EdgeInsets.only(
                                                  //     top: 5, left: 5, bottom: 5, right: 20),
                                                  // margin: EdgeInsets.symmetric(
                                                  //     vertical: 15, horizontal: 12),
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      const BoxShadow(
                                                          blurRadius: 0.5,
                                                          spreadRadius: 0.1,
                                                          color: Color.fromARGB(
                                                              40, 0, 0, 0))
                                                    ],
                                                    color: ThemeConstants
                                                        .whitecolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.meeting_room,
                                                          size: 30),
                                                      CustomAutoSizeTextMontserrat(
                                                        align: TextAlign.center,
                                                        text:
                                                            'Meeting Started Ended',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textColor:
                                                            ThemeConstants
                                                                .blackcolor,
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                // InkWell(
                                //   onTap: () {
                                //     showDialog(
                                //         context: context,
                                //         builder: (_) => AlertDialog(
                                //               content: Container(
                                //                 child: Column(
                                //                   mainAxisSize: MainAxisSize.min,
                                //                   children: [
                                //                     Icon(Icons.mark_email_read)
                                //                   ],
                                //                 ),
                                //               ),
                                //             ));
                                //   },
                                //   child: Container(
                                //       width: (MediaQuery.of(context).size.width -
                                //               100) /
                                //           3,
                                //       height: 90,
                                //       // padding: EdgeInsets.only(
                                //       //     top: 5, left: 5, bottom: 5, right: 20),
                                //       // margin: EdgeInsets.symmetric(
                                //       //     vertical: 15, horizontal: 12),
                                //       decoration: BoxDecoration(
                                //         boxShadow: [
                                //           const BoxShadow(
                                //               blurRadius: 0.5,
                                //               spreadRadius: 0.1,
                                //               color: Color.fromARGB(40, 0, 0, 0))
                                //         ],
                                //         color: ThemeConstants.whitecolor,
                                //         borderRadius: BorderRadius.circular(13),
                                //       ),
                                //       child: Column(
                                //         children: [
                                //           Icon(Icons.meeting_room, size: 50),
                                //           CustomAutoSizeTextMontserrat(
                                //             text: 'Meeting Started Ended',
                                //             fontSize: 10,
                                //             fontWeight: FontWeight.w500,
                                //             textColor: ThemeConstants.TextColor,
                                //           )
                                //         ],
                                //       )),
                                // ),
                                // Container(
                                //     width:
                                //         (MediaQuery.of(context).size.width - 100) /
                                //             3,
                                //     height: 90,
                                //     // padding: EdgeInsets.only(
                                //     //     top: 5, left: 5, bottom: 5, right: 20),
                                //     // margin: EdgeInsets.symmetric(
                                //     //     vertical: 15, horizontal: 12),
                                //     decoration: BoxDecoration(
                                //       boxShadow: [
                                //         const BoxShadow(
                                //             blurRadius: 0.5,
                                //             spreadRadius: 0.1,
                                //             color: Color.fromARGB(40, 0, 0, 0))
                                //       ],
                                //       color: ThemeConstants.whitecolor,
                                //       borderRadius: BorderRadius.circular(13),
                                //     ),
                                //     alignment: Alignment.center,
                                //     child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.center,
                                //       children: [
                                //         Icon(Icons.not_accessible, size: 30),
                                //         CustomAutoSizeTextMontserrat(
                                //           text: 'Reason of not attending',
                                //           fontSize: 9,
                                //           fontWeight: FontWeight.w500,
                                //           textColor: ThemeConstants.TextColor,
                                //         )
                                //       ],
                                //     )),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => StatefulBuilder(
                                            builder: (context,
                                                    StateSetter setState) =>
                                                AlertDialog(
                                                  content: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100)),
                                                      width: 350,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              CustomAutoSizeTextMontserrat(
                                                                  textColor:
                                                                      ThemeConstants
                                                                          .bluecolor,
                                                                  text:
                                                                      "Mark Attendance"),
                                                              InkWell(
                                                                onTap: () {
                                                                  context.pop();
                                                                  // Get.back();
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      ThemeConstants
                                                                          .bluecolor,
                                                                  radius: 10,
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                daata = 1;
                                                              });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Radio(
                                                                    value: 1,
                                                                    groupValue:
                                                                        daata,
                                                                    onChanged:
                                                                        (val) async {
                                                                      setState(
                                                                          () {
                                                                        daata =
                                                                            val!;
                                                                      });
                                                                    }),
                                                                CustomAutoSizeTextMontserrat(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    text:
                                                                        "Present")
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                daata = 2;
                                                              });
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Radio(
                                                                    value: 2,
                                                                    groupValue:
                                                                        daata,
                                                                    onChanged:
                                                                        (val) {
                                                                      print(
                                                                          daata);
                                                                      print(
                                                                          val);
                                                                      setState(
                                                                          () {
                                                                        daata =
                                                                            val!;
                                                                      });

                                                                      print(
                                                                          daata);
                                                                      ;
                                                                    }),
                                                                CustomAutoSizeTextMontserrat(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    text:
                                                                        "Absent")
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          if (daata == 2) ...[
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: CustomAutoSizeTextMontserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  text:
                                                                      'Please Specify reason of absent'),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Form(
                                                              key:
                                                                  _keyForReasonOfNotAttending,
                                                              child: CustomTextField(
                                                                  validator:
                                                                      Validator
                                                                          .notEmpty,
                                                                  hint: 'Enter',
                                                                  controller:
                                                                      reasonOfNotAttending),
                                                            )
                                                          ],
                                                          CustomButton(
                                                              backgroundColor:
                                                                  ThemeConstants
                                                                      .bluecolor,
                                                              text: 'Submit',
                                                              onPressed: () {
                                                                if (daata ==
                                                                    1) {
                                                                  controller.markAttendance(
                                                                      meetingData
                                                                          .id!);
                                                                } else {
                                                                  if (_keyForReasonOfNotAttending
                                                                      .currentState!
                                                                      .validate()) {
                                                                    controller.reasonOfNotAttendance(
                                                                        meetingData
                                                                            .id!,
                                                                        reasonOfNotAttending
                                                                            .text);
                                                                    print(
                                                                        'object');
                                                                  }
                                                                }
                                                              })
                                                        ],
                                                      )),
                                                )));
                                  },
                                  child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  100) /
                                              3,
                                      height: 90,
                                      margin: EdgeInsets.only(left: 20),
                                      // padding: EdgeInsets.only(
                                      //     top: 5, left: 5, bottom: 5, right: 20),
                                      // margin: EdgeInsets.symmetric(
                                      //     vertical: 15, horizontal: 12),
                                      decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   const BoxShadow(
                                        //       blurRadius: 0.5,
                                        //       spreadRadius: 0.1,
                                        //       color: Color.fromARGB(40, 0, 0, 0))
                                        // ],
                                        color: ThemeConstants.whitecolor,
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.calendar_month_rounded,
                                              size: 30),
                                          Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: CustomAutoSizeTextMontserrat(
                                              text: 'Mark Attendance',
                                              align: TextAlign.center,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              textColor:
                                                  ThemeConstants.blackcolor,
                                            ),
                                          )
                                        ],
                                      )),
                                ),

                                InkWell(
                                  onTap: () {
                                    context.push(
                                        '${Routes.dashboard}/${Routes.meetingDetails}/${Routes.viewDocs}');
                                    Get.to(ViewDocs());
                                  },
                                  child: Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  100) /
                                              3,
                                      height: 90,
                                      margin: EdgeInsets.only(left: 20),
                                      // padding: EdgeInsets.only(
                                      //     top: 5, left: 5, bottom: 5, right: 20),
                                      // margin: EdgeInsets.symmetric(
                                      //     vertical: 15, horizontal: 12),
                                      decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   const BoxShadow(
                                        //       blurRadius: 0.5,
                                        //       spreadRadius: 0.1,
                                        //       color: Color.fromARGB(40, 0, 0, 0))
                                        // ],
                                        color: ThemeConstants.whitecolor,
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.document_scanner_outlined,
                                              size: 30),
                                          Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: CustomAutoSizeTextMontserrat(
                                              text: 'View Docs',
                                              align: TextAlign.center,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              textColor:
                                                  ThemeConstants.blackcolor,
                                            ),
                                          )
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 40,
                          ) // // ...controller.singleMeetingDetails(context),
                        ]),
                      ),

                      // SizedBox(
                      //   height: 40,
                      // )
                      //Text filed
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(top: 10, left: 10, right: 10),
                      //   child: SizedBox(
                      //     height: 185,
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border:
                      //             Border.all(color: const Color(0xff1940b3)),
                      //       ),
                      //       child: SizedBox(
                      //         height: 200,
                      //         child: Form(
                      //           key: controller.globalKey,
                      //           child: TextField(
                      //             controller:
                      //                 controller.noteText_meetingdetails.value,
                      //             decoration: const InputDecoration(
                      //                 border: InputBorder.none,
                      //                 contentPadding: EdgeInsets.all(10)),
                      //             keyboardType: TextInputType.multiline,
                      //             expands: true,
                      //             maxLines: null,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     top: 10,
                      //   ),
                      //   child: SizedBox(
                      //     height: 40,
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         const Spacer(),
                      //         Container(
                      //           width: 152,
                      //           height: double.infinity,
                      //           decoration: BoxDecoration(
                      //             border: Border.all(
                      //                 color: const Color(0xffff9900)),
                      //             borderRadius: BorderRadius.circular(20),
                      //           ),
                      //           child: Center(
                      //               child: GestureDetector(
                      //             onTap: () {
                      //               Get.toNamed(AddMoreNotesView.routeName,
                      //                   arguments: meetingData.id);
                      //             },
                      //             child: CustomAutoSizeTextMontserrat(
                      //               text: "Add more Notes",
                      //               textColor: ThemeConstants.firstColor,
                      //             ),
                      //           )),
                      //         ),
                      //         const Spacer(),
                      //         InkWell(
                      //           onTap: () {
                      //             controller.saveNotes(meetingData.id!);
                      //           },
                      //           child: Container(
                      //             width: 152,
                      //             height: double.infinity,
                      //             decoration: BoxDecoration(
                      //               color: const Color(0xff1940b3),
                      //               borderRadius: BorderRadius.circular(20),
                      //             ),
                      //             child: Center(
                      //               child: CustomAutoSizeTextMontserrat(
                      //                 text: "Add",
                      //                 textColor: ThemeConstants.whitecolor,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         const Spacer(),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                )),
            onLoading: getLoading(context)),
      ),
    );
  }

  //Callback funcation
  callback(data) {
    print(data);
  }

  siecParticipantsList(AllMeetings meetingData) {
    List<Widget> data = [];
    for (var i = 0; i < meetingData.siecParticipants!.length; i++) {
      data.add(
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
          // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
              // boxShadow: [
              //   const BoxShadow(
              //       blurRadius: 0.5,
              //       spreadRadius: 0.1,
              //       color: Color.fromARGB(40, 0, 0, 0))
              // ],
              // color: ThemeConstants.whitecolor,
              // borderRadius: BorderRadius.circular(13),
              ),
          child: CustomAutoSizeTextMontserrat(
            text: "${meetingData.siecParticipants![i].name}",
            textColor: ThemeConstants.whitecolor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return data;
  }

  siecCordinatorList(AllMeetings meetingData) {
    List<Widget> data = [];
    for (var i = 0; i < meetingData.meetingCoordinator!.length; i++) {
      data.add(
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
          // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
              // boxShadow: [
              //   const BoxShadow(
              //       blurRadius: 0.5,
              //       spreadRadius: 0.1,
              //       color: Color.fromARGB(40, 0, 0, 0))
              // ],
              // color: ThemeConstants.whitecolor,
              // borderRadius: BorderRadius.circular(13),
              ),
          child: CustomAutoSizeTextMontserrat(
            text: "${meetingData.meetingCoordinator![i].name}",
            textColor: ThemeConstants.whitecolor,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return data;
  }
}

class ParticipantListWidget extends StatelessWidget {
  List<Widget> nameList;
  String title;
  ParticipantListWidget(
      {super.key, required this.nameList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   // guardianesJ (211:620)
              //   margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
              //   width: 20,
              //   height: 20,
              //   child: Image.asset(
              //     'assets/page-1/images/guardian-T8t.png',
              //     fit: BoxFit.contain,
              //     color: ThemeConstants.blackcolor,
              //   ),
              // ),
              CustomAutoSizeTextMontserrat(
                textColor: ThemeConstants.paleYellow,
                text: "$title",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              // CustomAutoSizeTextMontserrat(
              //   text: "SIEC Attendees",
              //   fontSize: 14,
              //   fontWeight: FontWeight.w600,
              // )
            ],
          ),
        ),
        Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 0, left: 15, bottom: 5, right: 20),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Wrap(children: [...nameList])),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
