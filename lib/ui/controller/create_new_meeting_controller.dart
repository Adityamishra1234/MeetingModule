import 'package:get/get.dart';

class CreateNewMeetingController extends GetxController with StateMixin {
  RxBool internalMeetingMode = true.obs;
  RxBool enaleParticipants = false.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
