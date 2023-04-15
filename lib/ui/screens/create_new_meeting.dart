import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/text_underline.dart';

class CreateNewMeeting extends StatelessWidget {
  static const routeNamed = '/CreateNewMeeting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                TextUnderLine(
                  text1: "Internal",
                  text: "Meetings",
                  textColor: ThemeConstants.firstColor,
                  underlinceColor: ThemeConstants.firstColor,
                ),
                const SizedBox(
                  width: 20,
                ),
                TextUnderLine(
                  text1: "External",
                  text: " Meeting",
                  underlinceColor: Colors.transparent,
                ),
              ],
            ),
            if (false) ...getListInternalmeeting(context),
            if (true) ...getExternalMeeting(context)
          ],
        ),
      ),
    );
  }

  List<Widget> getListInternalmeeting(BuildContext context) {
    return [
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
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Row(
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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      height: 45,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomAutoSizeTextMontserrat(
                  text: "Date",
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
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Row(
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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      height: 45,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
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
                      height: 45,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
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
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
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
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Group Names",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
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
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      const SizedBox(
        height: 25,
      ),
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
            fontSize: 20,
          ),
        ),
      )
    ];
  }

  List<Widget> getExternalMeeting(BuildContext context) {
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
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
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
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
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
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomAutoSizeTextMontserrat(
                      text: "Date",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      height: 45,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomAutoSizeTextMontserrat(
                    text: "Time",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      height: 45,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomAutoSizeTextMontserrat(
                    text: "Proposed Duration",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      height: 45,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomAutoSizeTextMontserrat(
                    text: "Meeting Type",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                      height: 45,
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Mode of Meeting",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25),
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
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Container(
        height: 38,
        width: 150,
        decoration: BoxDecoration(
            color: ThemeConstants.bluecolor,
            borderRadius: const BorderRadius.all(Radius.circular(30.0))),
        child: Center(
          child: CustomAutoSizeTextMontserrat(
            text: "Next",
            textColor: ThemeConstants.whitecolor,
            fontSize: 20,
          ),
        ),
      ),
      // Participants
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Participants",
            textColor: ThemeConstants.bluecolor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                CustomAutoSizeTextMontserrat(
                  text: "Country",
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
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomAutoSizeTextMontserrat(
                  text: "University",
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
                      decoration: BoxDecoration(
                          color: ThemeConstants.lightgreycolor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          height: 38,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: ThemeConstants.bluecolor,
              borderRadius: const BorderRadius.all(Radius.circular(30.0))),
          child: Center(
            child: CustomAutoSizeTextMontserrat(
              text: "Add new Representative",
              textColor: ThemeConstants.whitecolor,
              fontSize: 20,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Name of person",
            mandatory: true,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Designation",
            mandatory: true,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Email",
            mandatory: true,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Phone",
            mandatory: true,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Row(
        children: [
          const Spacer(),
          Container(
            height: 38,
            decoration: BoxDecoration(
                color: ThemeConstants.whitecolor,
                border: Border.all(color: ThemeConstants.firstColor),
                borderRadius: const BorderRadius.all(Radius.circular(30.0))),
            child: Center(
              child: CustomAutoSizeTextMontserrat(
                text: "View Participants",
                textColor: ThemeConstants.firstColor,
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 38,
            width: 150,
            decoration: BoxDecoration(
                color: ThemeConstants.bluecolor,
                borderRadius: const BorderRadius.all(Radius.circular(30.0))),
            child: Center(
              child: CustomAutoSizeTextMontserrat(
                text: "Next",
                textColor: ThemeConstants.whitecolor,
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
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
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Align(
          alignment: AlignmentDirectional.topStart,
          child: CustomAutoSizeTextMontserrat(
            text: "Group Names",
            mandatory: true,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
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
            text: "Group Names",
            mandatory: true,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: ThemeConstants.lightgreycolor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      ),
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
    ];
  }
}
