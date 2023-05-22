import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> emailText = TextEditingController().obs;
  Rx<TextEditingController> passwordText = TextEditingController().obs;
}
