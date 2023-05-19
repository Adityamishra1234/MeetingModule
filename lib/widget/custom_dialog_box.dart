import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
// import 'package:studentpanel/ui/screen/Profile_Module/contactinformation.dart';
// import 'package:studentpanel/ui/screen/Profile_module_2/contact_information_in_popup.dart';
// import 'package:studentpanel/ui/screen/Profile_module_2/controllers.dart/contact_information_in_popup_controller.dart';
// import 'package:studentpanel/utils/constants.dart';
// import 'package:studentpanel/utils/theme.dart';
// import 'package:studentpanel/widgets/customautosizetextmontserrat.dart';
// import 'package:studentpanel/widgets/custombutton.dart';

class CustomProfileDialogue extends StatelessWidget {
  Widget child;
  String title;
  CustomProfileDialogue({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(15),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: Container(
          height: MediaQuery.of(context).size.height * 0.65,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FractionallySizedBox(
                heightFactor: 0.05,
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAutoSizeTextMontserrat(
                      text: title,
                    ),
                    // CustomAutoSizeTextMontserrat(
                    //   textColor: ThemeConstants.bluecolor,
                    //   text: 'Edit',
                    // )
                  ],
                ),
              ),
              FractionallySizedBox(
                heightFactor: 0.85,
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 10), child: child),
                ),
              ),
              FractionallySizedBox(
                heightFactor: 0.1,
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAutoSizeTextMontserrat(
                        textColor: ThemeConstants.bluecolor,
                        text: 'Cancel',
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          // color: ThemeConstants.bluecolor,
                          decoration: BoxDecoration(
                              color: ThemeConstants.bluecolor,
                              borderRadius: BorderRadius.circular(10)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Text(
                            'Save & Next',
                            style: TextStyle(color: ThemeConstants.whitecolor),
                          ),
                        ),
                      )

                      // CustomButton(text: "Cancel", onPressed: () {})
                    ],
                  ),
                ),
              ),

              // Row(
              //   children: [
              //     CustomAutoSizeTextMontserrat(
              //       text: title,
              //     )
              //   ],
              // ),

              // SingleChildScrollView(
              //   child: child,
              // )
            ],
          )),
    );
  }
}
