import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/add_more_notes.dart';
import 'package:meeting_module2/ui/screens/view_notes.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customdropdownsingle.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';
// test

class MeetingDetails extends StatelessWidget {
  // MeetingDetails();
  static const routeNamed = '/MeetingDetails';

  @override
  Widget build(BuildContext context) {
    AllMeetings meetingData = Get.arguments;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: CustomAutoSizeTextMontserrat(
                  text: "${meetingData.meetingAgenda}",
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  textColor: ThemeConstants.bluecolor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: SizedBox(
                  height: 72,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 72,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 0.5,
                                color: Color.fromARGB(40, 0, 0, 0))
                          ],
                          color: const Color(0xfffff9ee),
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
                                      text: "Internal Meeting",
                                      fontSize: 12,
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
                        height: 72,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 0.7,
                                color: Color.fromARGB(40, 0, 0, 0)),
                          ],
                          color: const Color(0xfffff9ee),
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

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: CustomAutoSizeTextMontserrat(
                  text: "${meetingData.timeOfTheMeeting}",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textColor: ThemeConstants.TextColor,
                ),
              ),

              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAutoSizeTextMontserrat(
                      text: "Meeting Mode:  ",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textColor: ThemeConstants.TextColor,
                    ),
                    CustomAutoSizeTextMontserrat(
                      text:
                          "${meetingData.meetingMode == false ? "offline" : "online"}",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          'assets/page-1/images/group-9-CJc.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "${meetingData.durationOfMeeting}",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                  children: [
                    SizedBox(
                      // zoomi96 (211:612)

                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/page-1/images/zoom.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                        child: CustomAutoSizeTextMontserrat(
                      text: "${meetingData.meetingModeType}",
                    )),
                    Container(
                        // zoomxZE (211:610)

                        child: CustomAutoSizeTextMontserrat(
                      text: 'Zoom: ',
                    )),
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
                  children: [
                    Container(
                      // linknYG (211:616)
                      margin: const EdgeInsets.fromLTRB(0, 0, 7.14, 0),
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/page-1/images/link.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "${meetingData.meetingLink}",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // guardianesJ (211:620)
                      margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/page-1/images/guardian-T8t.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "SIEC Persons attending the meeting",
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: CustomAutoSizeTextMontserrat(
                  text:
                      "${meetingData.siecParticipants!.map((e) => e.name).toList().toString().substring(1, meetingData.siecParticipants!.map((e) => e.name).toList().toString().length - 1)}",
                  textColor: ThemeConstants.TextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // guardian2sr (211:624)

                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/page-1/images/guardian-uaQ.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "Meeting Cordinator",
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 52),
                child: CustomAutoSizeTextMontserrat(
                  text:
                      '${meetingData.meetingCoordinator!.map((e) => e.name).toString().substring(1, meetingData.meetingCoordinator!.map((e) => e.name).toString().length - 1)}',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textColor: ThemeConstants.TextColor,
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
                      Get.toNamed(ViewNotesDetails.routeNamed);
                    },
                    child: SizedBox(
                      width: 86,
                      height: 24,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xffff9900)),
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
                  padding: const EdgeInsets.only(left: 0, right: 10, top: 10),
                  child: CustomMultiDownSingle(
                      // model: ['d', 'd'],
                      model: Get.find<DashBoardController>().listBro,
                      // callbackFunction: callback,
                      callbackFunctionMulti: () {},
                      enableMultiSelect: true,
                      choosefieldtype: false,
                      initialSelectedValue: "1")
                  // TextField(
                  //   // controller: firstName,
                  //   scrollPadding: EdgeInsets.symmetric(
                  //       vertical: MediaQuery.of(context).viewInsets.bottom + 30),
                  //   style: ThemeConstants.montserrattextstyle2,
                  //   // readOnly: saveAndEdit,
                  //   decoration: textFieldDecoration("Demo Text Field"),
                  // ),

                  ),
              //Text filed
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                child: SizedBox(
                  height: 185,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xff1940b3)),
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
                          border: Border.all(color: const Color(0xffff9900)),
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
                      Container(
                        // autogroup5qyfrBz (HAFFbk5L5gZQcUFmpj5qYF)
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
    );
  }

  //Callback funcation

  callback(data) {
    print(data);
  }
}
