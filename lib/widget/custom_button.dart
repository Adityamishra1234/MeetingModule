import 'package:flutter/material.dart';
import 'package:meeting_module2/utils/theme.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor = const Color.fromARGB(255, 10, 93, 161),
    required this.onPressed,
  }) : super(key: key);

  final String text;
  Color? textColor;
  final Color backgroundColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // alignment: Alignment.center,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(0, 0, 0, 0),
                  blurRadius: 0.1,
                  spreadRadius: 0.2,
                  offset: Offset.fromDirection(0))
            ]),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor == null ? Colors.white : textColor,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
