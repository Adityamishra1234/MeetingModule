import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomErrorPopup extends StatefulWidget {
  CustomErrorPopup({super.key, required this.text, required this.showLoading});
  String text;
  bool showLoading;
  @override
  State<CustomErrorPopup> createState() => _CustomErrorPopupState();
}

class _CustomErrorPopupState extends State<CustomErrorPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          constraints: BoxConstraints(minHeight: 100),
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   alignment: Alignment.topRight,
              //   width: double.infinity,
              //   child: InkWell(
              //     onTap: () {
              //       Get.back();
              //     },
              //     child: CircleAvatar(
              //       radius: 10,
              //       backgroundColor: ThemeConstants.bluecolor,
              //       child: Icon(
              //         Icons.close,
              //         size: 15,
              //       ),
              //     ),
              //   ),
              // ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  widget.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              widget.showLoading == true
                  ? CircularProgressIndicator()
                  : SizedBox.shrink()
            ],
          )),
    );
  }
}
