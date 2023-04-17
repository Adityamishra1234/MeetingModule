import 'package:get/get.dart';

class ViewDetailsController extends GetxController with StateMixin {
  RxBool viewNotes = true.obs;

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }
}
