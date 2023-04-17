import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class RescheduleMeeting extends StatelessWidget {
  static const routeNamed = '/RescheduleMeeting';
  const RescheduleMeeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: " Add New \n Representative",
                    fontSize: 35,
                    textColor: ThemeConstants.bluecolor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CustomAutoSizeTextMontserrat(
                            text: "Rescheduled Date",
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
                              width:
                                  (MediaQuery.of(context).size.width - 40) / 2,
                              decoration: BoxDecoration(
                                  color: ThemeConstants.lightgreycolor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CustomAutoSizeTextMontserrat(
                            text: "Rescheduled Time",
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
                              width:
                                  (MediaQuery.of(context).size.width - 40) / 2,
                              decoration: BoxDecoration(
                                  color: ThemeConstants.lightgreycolor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: CustomAutoSizeTextMontserrat(
                            text: "Rescheduled Dur.",
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
                              width:
                                  (MediaQuery.of(context).size.width - 40) / 2,
                              decoration: BoxDecoration(
                                  color: ThemeConstants.lightgreycolor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
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
                              width:
                                  (MediaQuery.of(context).size.width - 40) / 2,
                              decoration: BoxDecoration(
                                  color: ThemeConstants.lightgreycolor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
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
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
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
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "Reason Of Reschedule",
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
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 38,
                  width: 250,
                  decoration: BoxDecoration(
                      color: ThemeConstants.bluecolor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0))),
                  child: Center(
                    child: CustomAutoSizeTextMontserrat(
                      text: "Reschedule Meeting",
                      textColor: ThemeConstants.whitecolor,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
