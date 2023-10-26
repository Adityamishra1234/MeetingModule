import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class BackgroundAuthView extends StatelessWidget {
  String text;
  BackgroundAuthView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          CustomAutoSizeTextMontserrat(
            text: 'Welcome!',
            textColor: ThemeConstants.paleYellow,
            fontSize: 30,
          ),
          CustomAutoSizeTextMontserrat(
            text: "$text",
            textColor: ThemeConstants.paleYellow,
            fontSize: 20,
          ),
          SizedBox(
            height: 0,
          ),
          SizedBox(
              width: 300,
              height: 300,
              child: Image.asset('assets/images/Login-Image.png')),
        ],
      ),
    );
  }
}
