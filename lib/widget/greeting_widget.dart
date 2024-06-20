import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../ui/controller/dashboardController.dart';
import '../utils/theme.dart';
import 'customautosizetextmontserrat.dart'; // Import the intl package for date formatting

class GreetingWidget extends StatelessWidget {
  var controller = Get.put(DashBoardController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          // height: 70,
          child: Row(
            children: [
              CustomAutoSizeTextMontserrat(
                text: getGreeting(),
                textColor: ThemeConstants.whitecolor,
                fontSize: 14,
              ),
              SizedBox(
                width: 5,
              ),
              CustomAutoSizeTextMontserrat(
                text: "${controller.user.value.name}",
                textColor: ThemeConstants.paleYellow,
                fontSize: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getGreeting() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }
}
