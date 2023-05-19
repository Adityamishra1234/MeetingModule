import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(ApplicationDetail());

    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }
}