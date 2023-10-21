import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/utils/theme.dart';

showPoPUp(String text, Icon icon, BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    content: Container(
        constraints: BoxConstraints(minHeight: 100),
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.topRight,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  context.pop();
                  // Get.back();
                },
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: ThemeConstants.bluecolor,
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: ThemeConstants.whitecolor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
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
