import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller.dart';
import 'package:meeting_module2/ui/controller/create_new_meeting_controller2.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';

class DialogHora extends StatefulWidget {
  DialogHora({super.key, required this.controller});
  CreateNewMeetingController2 controller;
  @override
  State<DialogHora> createState() => _DialogHoraState();
}

class _DialogHoraState extends State<DialogHora> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
            alignment: Alignment.center,
            height: 500,
            width: 400,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
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
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 25,
                        height: 25,
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: ThemeConstants.bluecolor,
                          child: Icon(
                            Icons.close,
                            color: ThemeConstants.whitecolor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 412,
                  child: ListView(
                    children: [
                      Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          children: [...allParticipants(widget.controller)]),
                    ],
                  ),
                ),
              ],
            )));
  }

  List<Widget> allParticipants(CreateNewMeetingController2 controller) {
    List<Widget> data = [];
    for (var i = 0; i < controller.listOfParticipants.length; i++) {
      data.add(Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: ThemeConstants.VioletColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAutoSizeTextMontserrat(
                    text: '${controller.listOfParticipants[i].personName}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black54,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Suitcase.svg',
                        width: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].designation}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].email}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 12,
                        color: ThemeConstants.TextColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomAutoSizeTextMontserrat(
                        text: '${controller.listOfParticipants[i].phone}',
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: ThemeConstants.TextColor,
                      ),
                    ],
                  ),
                ]),
            Container(
              height: 60,
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () {
                    controller.listOfParticipants.removeAt(i);
                    controller.update();
                    setState(() {});
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ThemeConstants.lightRed),
                    child: Icon(
                      Icons.delete,
                      color: ThemeConstants.red,
                      size: 25,
                    ),
                  )),
            )
          ],
        ),
      ));
    }

    return data;
  }
}
