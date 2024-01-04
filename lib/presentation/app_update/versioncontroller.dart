import 'package:get/get.dart';
import 'package:meeting_module2/presentation/app_update/new_version_check.dart';

class VersionController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    // await getUpdateNotitifcation();
  }

  getUpdateNotitifcation() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      NewVersionCheck.newVersionCheck(
          Get.context,
          "com.downtownengineers.meeting_module2",
          "com.downtownengineers.meeting_module2");
    });
  }
}
