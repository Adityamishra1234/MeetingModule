import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class BackgroundAuthView extends StatelessWidget {
  const BackgroundAuthView({super.key});

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
            text: "Let's Sign you in 001",
            textColor: ThemeConstants.paleYellow,
            fontSize: 20,
          ),
          SizedBox(
            height: 0,
          ),
          SizedBox(
              width: 350,
              height: 350,
              child: Image.asset('assets/images/Login-Image.png')),
        ],
      ),
    );
  }
}
