import 'package:flutter/material.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

showPoPUp(String text, Icon icon) {
  return AlertDialog(
    content: Container(
        constraints: BoxConstraints(minHeight: 100),
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
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
