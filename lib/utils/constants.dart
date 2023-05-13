import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class Constants {
  String? id;
  static const String enterEmail = "Enter Email";

  // Color
  static const LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF),
      Color.fromARGB(255, 228, 230, 255),
    ],
  );

  static const BoxDecoration boxDecorationfield = BoxDecoration(
    gradient: Constants.linearGradient,
  );
  static const textstyle = TextStyle(fontSize: 16, color: Colors.black);

  static const lightgrey = Color(0xFFD3D3D3);
  static const textstyle2 =
      TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500);
  static const textstyle3 =
      TextStyle(fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold);
}

//Null check
bool getNUllChecker(var data) {
  if (data == null) {
    return true;
  } else if (data == "null") {
    return true;
  } else if (data == "") {
    return true;
  } else if (data == "0") {
    return true;
  } else {
    return false;
  }
}

String getRemoveSquarebracket(String data) {
  var temp = data.split('[');
  var temp2 = temp[1].split(']')[0];
  return temp2;
}

getToast(String data) {
  return Fluttertoast.showToast(
      // webBgColor: "linear-gradient(to right, #F1F4FB, #F1F4FB)",
      // webPosition: "Top",
      webPosition: "center",
      msg: data,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ThemeConstants.lightblueColor,
      textColor: ThemeConstants.blackcolor,
      fontSize: 16.0);
}

getDailog(BuildContext context, String data) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            icon: svgImage("warning", ThemeConstants.yellow, 90, 90),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Divider(
                    thickness: 0.5,
                    color: ThemeConstants.lightgreycolor,
                  ),
                  SizedBox(
                      width: 200.0,
                      height: 80.0,
                      child: Center(
                          child: CustomAutoSizeTextMontserrat(text: data))),
                ],
              ),
            ),
          ));
}

getEmailvaliation(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  if (value != null) {
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  } else if (value == null) {
    return "Please enter email address";
  }
}

getPhoneNumbervalidation(String? value) {
  if (value != null) {
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else
      return null;
  } else {
    return "Mobile Number must be of 10 digit";
  }
}

getsnakbar(String title, String data) {
  return Get.snackbar(
    title,
    duration: const Duration(seconds: 2),
    data,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white.withOpacity(0.0),
    margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
  );
}

svgImage(String endpoint, Color color, double height, double width) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: CachedNetworkSVGImage(
      'https://sieceducation.in/assets/assets/icons/$endpoint.svg',
      // placeholder: const CircularProgressIndicator(color: Colors.blue),
      errorWidget: const Icon(Icons.error, color: Colors.red),
      height: height,
      width: width,
      color: color,
      fadeDuration: const Duration(milliseconds: 500),
    ),
  );
}

textFieldDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: ThemeConstants.lightgreycolor,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(15.0),
    ),
  );
}
