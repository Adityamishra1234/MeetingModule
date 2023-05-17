import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';

late StreamSubscription subscription;
bool isDeviceConnected = false;
bool isAlertSet = false;
bool ActiveConnection = false;
String T = "";

Future checkUserConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // var controller1 = Get.put(BaseController());
      // controller1.refresh();
      // // Get.find<BaseController>().refresh();
      // Get.back();
      if (ActiveConnection == false) {
        Get.deleteAll();
        // Get.find<BaseController>().profiledetail();
        // Get.find<BaseController>().upcomingEvents();
        // Get.toNamed(DashBoard.routeNamed);
        ActiveConnection = true;
        T = "Turn off the data and repress again";
      }
    }
  } on SocketException catch (_) {
    ActiveConnection = false;
    // Get.toNamed(InternetConnectionStatusScreen.routeNamed);
    // T = "Turn On the data and repress again";
  }
}
