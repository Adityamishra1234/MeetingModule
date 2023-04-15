import 'package:get/get.dart';

class DashBoardController extends GetxController with StateMixin {
  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  RxBool upcomingbuttonEnable = true.obs;
}
