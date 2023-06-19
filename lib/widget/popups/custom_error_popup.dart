import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/utils/theme.dart';

showPoPUp(String text, Icon icon) {
  return AlertDialog(
    content: Container(
        constraints: BoxConstraints(minHeight: 100),
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topRight,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: ThemeConstants.bluecolor,
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            icon
          ],
        )),
  );
}
