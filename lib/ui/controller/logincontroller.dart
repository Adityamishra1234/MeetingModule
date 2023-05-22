import 'package:get/get.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/screens/createpassword.dart';
import 'package:meeting_module2/utils/constants.dart';

class LoginController extends GetxController with StateMixin {
  ApiServices api = ApiServices();
  bool forOtp = false;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  emailVerification(String email) async {
    change(null, status: RxStatus.loading());
    var res = await api.getEmailverification(email);
    if (res != null) {
      if (res == false) {
        var res2 = await api.getOTP(email);
        if (res2 != null) {
          if (res2 == true) {
            getToast("Please check otp on your office email address");
            forOtp = true;
          } else {
            getToast("Some thing went wrong");
          }
        }
      } else if (res == true) {
        print(true);
      }
    }
    change(null, status: RxStatus.success());
  }

  otpcheck(String email, String otp) async {
    change(null, status: RxStatus.loading());
    var res = await api.otpMatch(email, otp);
    if (res != null) {
      if (res == true) {
        Get.to(CreatePasswrord(email: email));
      }
    }
    change(null, status: RxStatus.success());
  }
}
