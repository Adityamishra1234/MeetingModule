import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/add_more_notes.dart';
import 'package:meeting_module2/ui/screens/view_notes.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customdropdownsingle.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';
import 'package:meeting_module2/extensions/textLengthExtension.dart';
// test

class MeetingDetails extends StatefulWidget {
  // MeetingDetails();
  static const routeNamed = '/MeetingDetails';

  @override
  State<MeetingDetails> createState() => _MeetingDetailsState();
}

class _MeetingDetailsState extends State<MeetingDetails> {
  var controller = Get.put(AddMoreNotesController());

  var controllerbase = Get.find<BaseController>();

  var controllerDashboard = Get.find<DashBoardController>();

  @override
  void dispose() {
    controller.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  // AllMeetings meetingData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    AllMeetings meetingData = controllerDashboard.selectedMeetingdata.value;
    return Scaffold(
      backgroundColor: ThemeConstants.lightVioletColor,
      body: controller.obx(
          (state) => SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, bottom: 10),
                            child: CustomAutoSizeTextMontserrat(
                              text: "${meetingData.meetingAgenda}",
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              textColor: ThemeConstants.bluecolor,
                            ),
                          ),
                          meetingData.meetingStarted! &&
                                  !meetingData.meetingEnded!
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio(
                                        activeColor: Colors.green,
                                        value: true,
                                        groupValue: true,
                                        onChanged: (val) {}),
                                    CustomAutoSizeTextMontserrat(
                                      text: '(Started)',
                                      textColor: ThemeConstants.GreenColor,
                                    )
                                  ],
                                )
                              : SizedBox.shrink(),
                          meetingData.meetingStarted! &&
                                  meetingData.meetingEnded!
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio(
                                        activeColor: Colors.red,
                                        value: true,
                                        groupValue: true,
                                        onChanged: (val) {}),
                                    CustomAutoSizeTextMontserrat(
                                      text: '(Ended)',
                                      textColor: Colors.red,
                                    )
                                  ],
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: SizedBox(
                          height: 72,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 72,
                                width: MediaQuery.of(context).size.width / 2.2,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    const BoxShadow(
                                        blurRadius: 0.5,
                                        spreadRadius: 0.1,
                                        color: Color.fromARGB(40, 0, 0, 0))
                                  ],
                                  color: ThemeConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(13),
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
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Column(
                                          children: [
                                            CustomAutoSizeTextMontserrat(
                                              text: "Meeting Type",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            CustomAutoSizeTextMontserrat(
                                              text:
                                                  "${meetingData.meetingType}",
                                              fontSize: 12,
                                              maxLines: 12,
                                              fontWeight: FontWeight.w500,
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
                              const Spacer(),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                height: 72,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 0.5,
                                        spreadRadius: 0.1,
                                        color: Color.fromARGB(40, 0, 0, 0)),
                                  ],
                                  color: ThemeConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(13),
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
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Column(
                                          children: [
                                            CustomAutoSizeTextMontserrat(
                                              text: "Agenda",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            CustomAutoSizeTextMontserrat(
                                              text: "Networking",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
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
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 5, left: 5, bottom: 5, right: 20),
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                                blurRadius: 0.5,
                                spreadRadius: 0.1,
                                color: Color.fromARGB(40, 0, 0, 0))
                          ],
                          color: ThemeConstants.whitecolor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Column(
                          children: [
                            meetingData.meetingType == 'External Meeting'
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(left: 15, top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomAutoSizeTextMontserrat(
                                          text: 'Meeting with:',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          textColor: ThemeConstants.TextColor,
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
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CustomAutoSizeTextMontserrat(
                                          text: "${meetingData.meetingWith}",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          textColor: ThemeConstants.TextColor,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: "Date:",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    textColor: ThemeConstants.TextColor,
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "${meetingData.dateOfMeeting}",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    textColor: ThemeConstants.TextColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: "Time:",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    textColor: ThemeConstants.TextColor,
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "${meetingData.timeOfTheMeeting}",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    textColor: ThemeConstants.TextColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: "Mode: ",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    textColor: ThemeConstants.TextColor,
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text:
                                        "${meetingData.meetingMode == false ? "offline" : "online"}",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    textColor: ThemeConstants.TextColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomAutoSizeTextMontserrat(
                                      text: "Duration: ",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      textColor: ThemeConstants.TextColor,
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
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomAutoSizeTextMontserrat(
                                      text: "${meetingData.durationOfMeeting}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      textColor: ThemeConstants.TextColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: "Platform:",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    textColor: ThemeConstants.TextColor,
                                  ),
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
                                    textColor: ThemeConstants.TextColor,
                                    text: "${meetingData.meetingModeType}",
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: "Link: ",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    textColor: ThemeConstants.TextColor,
                                  ),
                                  // Container(
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
                                    textColor: ThemeConstants.TextColor,
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
                        height: 8,
                      ),

                      meetingData.meetingType == 'External Meeting'
                          ? Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // guardianesJ (211:620)
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      'assets/page-1/images/guardian-T8t.png',
                                      fit: BoxFit.contain,
                                      color: ThemeConstants.blackcolor,
                                    ),
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "Participants attending meeting",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )
                                ],
                              ),
                            )
                          : SizedBox.shrink(),

                      meetingData.meetingType == 'External Meeting'
                          ? Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  top: 5, left: 5, bottom: 5, right: 20),
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  const BoxShadow(
                                      blurRadius: 0.5,
                                      spreadRadius: 0.1,
                                      color: Color.fromARGB(40, 0, 0, 0))
                                ],
                                color: ThemeConstants.whitecolor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child:
                                  meetingData.meetingType == 'External Meeting'
                                      ? Wrap(
                                          children: [
                                            ...controller.participantDataList
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

                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // guardianesJ (211:620)
                              margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                'assets/page-1/images/guardian-T8t.png',
                                fit: BoxFit.contain,
                                color: ThemeConstants.blackcolor,
                              ),
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: "SIEC Persons attending the meeting",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              top: 5, left: 10, bottom: 5, right: 20),
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Wrap(children: [
                            ...siecParticipantsList(meetingData)
                          ])),

                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // guardianesJ (211:620)
                              margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                'assets/page-1/images/guardian-T8t.png',
                                fit: BoxFit.contain,
                                color: ThemeConstants.blackcolor,
                              ),
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: "Meeting Coordinators",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              top: 0, left: 10, bottom: 5, right: 20),
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Wrap(
                              children: [...siecCordinatorList(meetingData)])),
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

                      controller.showTheStartEndOptions
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: CustomAutoSizeTextMontserrat(
                                          text: "Meeting Started",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Radio(
                                          value: true,
                                          groupValue: true,
                                          onChanged: (val) {})
                                      // Switch(
                                      //   value: meetingData.meetingStarted!,
                                      //   onChanged: (val) {
                                      //     controller.meetingStarted(
                                      //         meetingData.id!, val);
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: CustomAutoSizeTextMontserrat(
                                          text: "Meeting Ended",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Switch(
                                          value: meetingData.meetingEnded!,
                                          onChanged: (val) {
                                            controller.meetingEnded(
                                                meetingData.id!, val);
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          content: Container(
                                            child: Text('ddd'),
                                          ),
                                        ));
                              },
                              child: IgnorePointer(
                                ignoring: true,
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child:
                                                  CustomAutoSizeTextMontserrat(
                                                text: "Meeting Started",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Switch(
                                              value:
                                                  meetingData.meetingStarted!,
                                              onChanged: (val) {
                                                controller.meetingStarted(
                                                    meetingData.id!, val);
                                              },
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child:
                                                  CustomAutoSizeTextMontserrat(
                                                text: "Meeting Ended",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Switch(
                                                value:
                                                    meetingData.meetingEnded!,
                                                onChanged: (val) {
                                                  controller.meetingEnded(
                                                      meetingData.id!, val);
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                      // CustomAutoText using for mandatory *
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 15),
                        child: CustomAutoSizeTextMontserrat(
                          text: 'Add Meeting Notes ',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          textColor: ThemeConstants.bluecolor,
                          mandatory: true,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: CustomAutoSizeTextMontserrat(
                              text: 'Notes accessibility to',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.to(ViewNotesDetails(),
                                  arguments: meetingData.id);
                            },
                            child: SizedBox(
                              width: 86,
                              height: 24,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: const Color(0xffff9900)),
                                ),
                                child: Center(
                                  child: CustomAutoSizeTextMontserrat(
                                    text: "View Notes",
                                    fontSize: 12,
                                    textColor: const Color(0xffff9900),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),

                      // DropDown

                      Padding(
                        padding:
                            const EdgeInsets.only(left: 0, right: 10, top: 10),
                        child: CustomMultiDownSingleAllUser(
                          // model: ['d', 'd'],
                          model: Get.find<BaseController>().allSiecMembersList,
                          // callbackFunction: callback,
                          callbackFunctionMulti: (val) {
                            controller.accessibileUserSelected_meetingDetail
                                .value = val;

                            print(controller
                                .accessibileUserSelected_meetingDetail);
                            controller.update();
                          },
                          enableMultiSelect: true,
                          // inititalSelectedList:
                          //     controller.accessibileUserSelected_meetingDetail,

                          initialSelectedValue: '',
                        ),
                        // TextField(
                        //   // controller: firstName,
                        //   scrollPadding: EdgeInsets.symmetric(
                        //       vertical: MediaQuery.of(context).viewInsets.bottom + 30),
                        //   style: ThemeConstants.montserrattextstyle2,
                        //   // readOnly: saveAndEdit,
                        //   decoration: textFieldDecoration("Demo Text Field"),
                        // ),
                      ),

                      Container(
                        width: double.infinity,
                        height: 90,
                        padding: EdgeInsets.only(
                            top: 5, left: 5, bottom: 5, right: 20),
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                                blurRadius: 0.5,
                                spreadRadius: 0.1,
                                color: Color.fromARGB(40, 0, 0, 0))
                          ],
                          color: ThemeConstants.whitecolor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 100,
                                alignment: Alignment.center,
                                child: Icon(Icons.add, size: 50)),
                            Container(
                                width: 100,
                                alignment: Alignment.center,
                                child: Icon(Icons.document_scanner, size: 50)),
                            Container(
                                width: 100,
                                alignment: Alignment.center,
                                child: Icon(Icons.document_scanner, size: 50)),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          content: Container(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.mark_email_read)
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: Container(
                                  width: (MediaQuery.of(context).size.width -
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
                                          color: Color.fromARGB(40, 0, 0, 0))
                                    ],
                                    color: ThemeConstants.whitecolor,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Icon(Icons.add, size: 50)),
                            ),
                            Container(
                                width:
                                    (MediaQuery.of(context).size.width - 100) /
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
                                        color: Color.fromARGB(40, 0, 0, 0))
                                  ],
                                  color: ThemeConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.document_scanner, size: 50)),
                            Container(
                                width:
                                    (MediaQuery.of(context).size.width - 100) /
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
                                        color: Color.fromARGB(40, 0, 0, 0))
                                  ],
                                  color: ThemeConstants.whitecolor,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                alignment: Alignment.center,
                                child: Icon(Icons.document_scanner, size: 50)),
                          ],
                        ),
                      ),

                      //Text filed
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: SizedBox(
                          height: 185,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xff1940b3)),
                            ),
                            child: SizedBox(
                              height: 200,
                              child: Form(
                                key: controller.globalKey,
                                child: TextField(
                                  controller:
                                      controller.noteText_meetingdetails.value,
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
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Container(
                                width: 152,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffff9900)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AddMoreNotesView.routeName,
                                        arguments: meetingData.id);
                                  },
                                  child: CustomAutoSizeTextMontserrat(
                                    text: "Add more Notes",
                                    textColor: ThemeConstants.firstColor,
                                  ),
                                )),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  controller.saveNotes(meetingData.id!);
                                },
                                child: Container(
                                  width: 152,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1940b3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: CustomAutoSizeTextMontserrat(
                                      text: "Add",
                                      textColor: ThemeConstants.whitecolor,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
          onLoading: getLoading(context)),
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
          padding: EdgeInsets.only(top: 5, left: 8, bottom: 5, right: 20),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  blurRadius: 0.5,
                  spreadRadius: 0.1,
                  color: Color.fromARGB(40, 0, 0, 0))
            ],
            color: ThemeConstants.whitecolor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: CustomAutoSizeTextMontserrat(
            text: "${meetingData.siecParticipants![i].name}",
            textColor: ThemeConstants.TextColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
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
          padding: EdgeInsets.only(top: 5, left: 8, bottom: 5, right: 20),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  blurRadius: 0.5,
                  spreadRadius: 0.1,
                  color: Color.fromARGB(40, 0, 0, 0))
            ],
            color: ThemeConstants.whitecolor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: CustomAutoSizeTextMontserrat(
            text: "${meetingData.meetingCoordinator![i].name}",
            textColor: ThemeConstants.TextColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return data;
  }
}
