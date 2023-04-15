import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/text_underline.dart';

class ViewNotesDetails extends StatelessWidget {
  static const routeNamed = '/ViewNotesDetails';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  TextUnderLine(
                    text1: "View",
                    text: "Notes",
                    textColor: ThemeConstants.firstColor,
                    underlinceColor: ThemeConstants.firstColor,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextUnderLine(
                    text1: "Reason",
                    text: " of Attending",
                    underlinceColor: Colors.transparent,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                            text:
                                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud."),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: CustomAutoSizeTextMontserrat(
                          text:
                              "Created By Aman verma on March 29, 2023 4:09 PM",
                          textColor: ThemeConstants.TextColor,
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                color: ThemeConstants.bluecolor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0))),
                            child: Center(
                              child: CustomAutoSizeTextMontserrat(
                                text: "Assign to",
                                textColor: ThemeConstants.whitecolor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
