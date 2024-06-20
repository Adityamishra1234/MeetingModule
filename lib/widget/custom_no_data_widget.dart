import 'package:flutter/material.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class CustomNoDataWidget extends StatelessWidget {
  CustomNoDataWidget({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(82, 218, 218, 218)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon(Icons.error_outline_rounded,
          //     color: const Color.fromARGB(255, 136, 136, 136)),
          Center(child: Image.asset("assets/images/noData.gif",scale: 0.6,)),
          // CustomAutoSizeTextMontserrat(
          //     text: '$text',
          //     align: TextAlign.center,
          //     fontSize: 18,
          //     textColor: const Color.fromARGB(255, 136, 136, 136)),
        ],
      ),
    );
  }
}
