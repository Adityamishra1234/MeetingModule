import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class ParticipantsDetails extends StatelessWidget {
  static const routeNamed = '/ParticipantsDetails';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: CustomAutoSizeTextMontserrat(
                text: "Participants Details",
                fontSize: 35,
                textColor: ThemeConstants.bluecolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...getparticipantsDetails(context)
        ],
      ),
    ));
  }

  //List of participants details
  List<Widget> getparticipantsDetails(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(color: ThemeConstants.bluecolor),
              borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAutoSizeTextMontserrat(
                        text: "Aman verma",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "App developer",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "amanverma@gmail.com",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "1234567890",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDEDE),
                        border: Border.all(color: ThemeConstants.red),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        size: 40,
                        Icons.delete,
                        color: ThemeConstants.red,
                      ),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "Remove",
                      textColor: ThemeConstants.red,
                      fontSize: 14,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(color: ThemeConstants.bluecolor),
              borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAutoSizeTextMontserrat(
                        text: "Aman verma",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "App developer",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "amanverma@gmail.com",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "1234567890",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDEDE),
                        border: Border.all(color: ThemeConstants.red),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        size: 40,
                        Icons.delete,
                        color: ThemeConstants.red,
                      ),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "Remove",
                      textColor: ThemeConstants.red,
                      fontSize: 14,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(color: ThemeConstants.bluecolor),
              borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAutoSizeTextMontserrat(
                        text: "Aman verma",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "App developer",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "amanverma@gmail.com",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "1234567890",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDEDE),
                        border: Border.all(color: ThemeConstants.red),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        size: 40,
                        Icons.delete,
                        color: ThemeConstants.red,
                      ),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "Remove",
                      textColor: ThemeConstants.red,
                      fontSize: 14,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(color: ThemeConstants.bluecolor),
              borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAutoSizeTextMontserrat(
                        text: "Aman verma",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "App developer",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "amanverma@gmail.com",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "1234567890",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDEDE),
                        border: Border.all(color: ThemeConstants.red),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        size: 40,
                        Icons.delete,
                        color: ThemeConstants.red,
                      ),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "Remove",
                      textColor: ThemeConstants.red,
                      fontSize: 14,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(color: ThemeConstants.bluecolor),
              borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAutoSizeTextMontserrat(
                        text: "Aman verma",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "App developer",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "amanverma@gmail.com",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "1234567890",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDEDE),
                        border: Border.all(color: ThemeConstants.red),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        size: 40,
                        Icons.delete,
                        color: ThemeConstants.red,
                      ),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "Remove",
                      textColor: ThemeConstants.red,
                      fontSize: 14,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(color: ThemeConstants.bluecolor),
              borderRadius: const BorderRadius.all(Radius.circular(20.0))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAutoSizeTextMontserrat(
                        text: "Aman verma",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "App developer",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "amanverma@gmail.com",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: "1234567890",
                        fontSize: 14,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDEDE),
                        border: Border.all(color: ThemeConstants.red),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        size: 40,
                        Icons.delete,
                        color: ThemeConstants.red,
                      ),
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "Remove",
                      textColor: ThemeConstants.red,
                      fontSize: 14,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ];
  }
}
