import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/screens/dashboard_page.dart';
import 'package:meeting_module2/ui/screens/login_page.dart';

class CreatePasswordController extends GetxController {
  ApiServices api = ApiServices();

  updatePassword(String email, String password) async {
    var res = await api.password(email, password);
    if (res != null) {
      if (res == true) {
        Get.toNamed(LoginPage.routeNamed);
      }
    }

    Get.toNamed(DashBoard.routeNamed);
  }
}
