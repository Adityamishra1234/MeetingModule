import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/widget/calender/calendar_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(ApplicationDetail());
    Get.put(
      DashBoardController(),
    );
  }
}
