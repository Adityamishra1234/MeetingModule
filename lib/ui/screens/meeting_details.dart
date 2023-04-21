import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/screens/addMoreNotes.dart';
import 'package:meeting_module2/ui/screens/view_notes.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/Custom%20Dropdown/custom_dropdown.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customdropdownsingle.dart';
// test

class MeetingDetails extends StatelessWidget {
  static const routeNamed = '/MeetingDetails';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: CustomAutoSizeTextMontserrat(
                  text: "Meeting With Vendor",
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  textColor: ThemeConstants.bluecolor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 0),
                child: SizedBox(
                  height: 72,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        height: 72,
                        decoration: BoxDecoration(
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
                  text: "30-03-2023 06:09 PM",
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
                      text: "online",
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
                        text: "3 hours 1 minutes",
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
                      text: 'Meeting Mode Type: ',
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
                      text: "Meeting link",
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
                  text: 'Chitra IT, Lakshay Singh IT, Taniya IT',
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
                      text: "Meeting Coordinators",
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 52),
                child: CustomAutoSizeTextMontserrat(
                  text: 'Chitra IT, Lakshay Singh IT, Taniya IT',
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
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomDropDown(
                        model: ["1", "2", "3"],
                        callbackFunction: callback,
                        editEnable: true,
                        initialSelectedValue: "1")),
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
                      InkWell(
                        onTap: () {
                          Get.toNamed(AddMoreNotes.routeNamed);
                        },
                        child: Container(
                          width: 152,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffff9900)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: CustomAutoSizeTextMontserrat(
                            text: "Add more Notes",
                            textColor: ThemeConstants.firstColor,
                          )),
                        ),
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
