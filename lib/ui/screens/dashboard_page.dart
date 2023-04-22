import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting.dart';
import 'package:meeting_module2/ui/screens/meeting_details.dart';
import 'package:meeting_module2/ui/screens/reschedule_meeting.dart';
import 'package:meeting_module2/ui/screens/test/test.dart';
import 'dart:ui';

import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/text_underline.dart';

class DashBoard extends StatelessWidget {
  static const routeNamed = '/DashBoard';
  var controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    Color background = Color(0xFFFFEDBE);
    Color fill = ThemeConstants.whitecolor;
    List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    final double fillPercent = 95;
    final double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    return Scaffold(
      body: controller.obx((state) {
        return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              'assets/page-1/images/group-2-WX2.png',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: "Hello,",
                                    fontSize: 18,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "Manasvi",
                                    fontSize: 35,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: CustomAutoSizeTextMontserrat(
                      text: "Your Meetings",
                      fontSize: 44,
                      textColor: ThemeConstants.bluecolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 10),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.upcomingbuttonEnable.value ==
                                false) {
                              controller.upcomingbuttonEnable.value = true;
                              controller.update();
                            }
                          },
                          child: TextUnderLine(
                            text1: "Upco",
                            text: "ming",
                            textColor:
                                controller.upcomingbuttonEnable.value == true
                                    ? ThemeConstants.firstColor
                                    : ThemeConstants.blackcolor,
                            underlinceColor:
                                controller.upcomingbuttonEnable.value == true
                                    ? ThemeConstants.firstColor
                                    : Colors.transparent,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.upcomingbuttonEnable.value == true) {
                              controller.upcomingbuttonEnable.value = false;
                              controller.update();
                            }
                          },
                          child: TextUnderLine(
                            text1: "Do",
                            text: "ne",
                            textColor:
                                controller.upcomingbuttonEnable.value == false
                                    ? ThemeConstants.firstColor
                                    : ThemeConstants.blackcolor,
                            underlinceColor:
                                controller.upcomingbuttonEnable.value == false
                                    ? ThemeConstants.firstColor
                                    : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ...getMeetingDetails(context, gradient, stops)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: ThemeConstants.bluecolor,
        onPressed: () {
          Get.toNamed(CreateNewMeeting.routeNamed);
        },
      ),
    );
  }

  List<Widget> getMeetingDetails(
      BuildContext context, List<Color> colors, List<double> stops) {
    return [
      singleMeetingDetails(context, colors, stops),
      singleMeetingDetails(context, colors, stops),
      singleMeetingDetails(context, colors, stops),
      singleMeetingDetails(context, colors, stops),
    ];
  }

  singleMeetingDetails(
      BuildContext context, List<Color> colors, List<double> stops) {
    bool menu = false;

    return StatefulBuilder(builder: (thisLowerContext, innerSetState) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: colors,
                stops: stops,
              ),
              border: Border.all(color: const Color(0xff1940b3)),
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(MeetingDetails.routeNamed);
                          },
                          child: CustomAutoSizeTextMontserrat(
                            text: "Meeting with Vendor",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              innerSetState(() {
                                if (menu == false) {
                                  menu = true;
                                } else {
                                  menu = false;
                                }
                              });
                            },
                            child: Container(
                                width: 40,
                                child: const Icon(Icons.more_vert_rounded)))
                      ],
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "Launch of New Program",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "30-03-2023 06:09 PM",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            // color: Colors.amber,
                            height: 50,
                            width: 150,
                            child: Stack(
                              //alignment:new Alignment(x, y)
                              children: [
                                // Icon(Icons.monetization_on,
                                //     size: 36.0,
                                //     color: Color.fromRGBO(218, 165, 32, 1.0)),
                                Container(
                                  height: 36.0,
                                  width: 36.0,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF1F0FF),
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Color(0xFF1940B3))),
                                  child: Center(
                                      child: CustomAutoSizeTextMontserrat(
                                          text: "A")),
                                ),
                                Positioned(
                                  left: 25.0,
                                  child: Container(
                                    height: 36.0,
                                    width: 36.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFEF0F0),
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Color(0xFFFF7171)),
                                    ),
                                    child: Center(
                                        child: CustomAutoSizeTextMontserrat(
                                            text: "A")),
                                  ),
                                ),
                                Positioned(
                                  left: 50.0,
                                  child: Container(
                                    height: 36.0,
                                    width: 36.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFECFFF5),
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Color(0xFF09C964)),
                                    ),
                                    child: Center(
                                        child: CustomAutoSizeTextMontserrat(
                                            text: "A")),
                                  ),
                                ),
                                Positioned(
                                  left: 75.0,
                                  child: Container(
                                    height: 36.0,
                                    width: 36.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFEF6E6),
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Color(0xFFFF9900)),
                                    ),
                                    child: Center(
                                        child: CustomAutoSizeTextMontserrat(
                                            text: "+5")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                if (menu == true)
                  Positioned(
                      right: 30,
                      top: 0,
                      child: SizedBox(
                        height: 70,
                        width: 200,
                        child: Opacity(
                          opacity: 1,
                          child: Card(
                            elevation: 6,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Get.to(Test(
                                      tablist: ["test1", "test2"],
                                      listWidget: [
                                        Text("text1"),
                                        Text("test2")
                                      ],
                                    ));
                                    // Get.toNamed(RescheduleMeeting.routeNamed);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomAutoSizeTextMontserrat(
                                      text: "Reschedule Meeting",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CustomAutoSizeTextMontserrat(
                                    text: "Delete Meeting",
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
