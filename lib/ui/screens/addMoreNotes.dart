import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class AddMoreNotes extends StatelessWidget {
  static const routeNamed = '/AddMoreNotes';
  const AddMoreNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: CustomAutoSizeTextMontserrat(
                  text: "Add more Notes",
                  fontSize: 35,
                  textColor: ThemeConstants.bluecolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: CustomAutoSizeTextMontserrat(
                  text: "Add notes for:",
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
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: CustomAutoSizeTextMontserrat(
                  text: "Notes accessibility to",
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
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 15),
                child: Container(
                  height: 38,
                  width: 150,
                  decoration: BoxDecoration(
                      color: ThemeConstants.bluecolor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0))),
                  child: Center(
                    child: CustomAutoSizeTextMontserrat(
                      text: "Add",
                      textColor: ThemeConstants.whitecolor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: CustomAutoSizeTextMontserrat(
                  text: "Notes",
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  textColor: ThemeConstants.bluecolor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    border: Border.all(color: ThemeConstants.bluecolor),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
