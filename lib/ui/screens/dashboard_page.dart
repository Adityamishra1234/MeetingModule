import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/presentation/custom_widgets/custom_filter_selector.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting.dart';
import 'package:meeting_module2/ui/screens/meeting_details.dart';
import 'dart:ui';

import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/text_underline.dart';

class DashBoard extends StatefulWidget {
  static const routeNamed = '/DashBoard';
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int siecParticipantsLength = 0;

  var controller = Get.put(DashBoardController(), permanent: true);

  String? selectedValue = 'All Meetings';
  bool showFilterList = true;
  List<String> list = <String>[
    'All Meetings',
    'University Meeting',
    'Bank Meeting',
    'Vendor Meeting',
    'Internal Meeting'
  ];

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
      // body: controller.obx((state) {
      //   print(state);
      body: SafeArea(
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: ThemeConstants.bluecolor,
                                  radius: 35,
                                ),
                                CircleAvatar(
                                  backgroundColor: ThemeConstants.whitecolor,
                                  radius: 32,
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      ThemeConstants.ultraLightgreyColor,
                                  radius: 30,
                                ),
                              ],
                            )),
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
                  height: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: CustomTabWidget(
                              title0: "Upcoming",
                              title1: "Done",
                              callback: (val) => {
                                controller.indexOfTab.value = val,
                                print(val == 1),
                                if (val == 0)
                                  {
                                    print('dcdfrfvfvf'),
                                    controller.showUpcomingList()
                                  }
                                else if (val == 1)
                                  {
                                    print('$val dcdcd'),
                                    controller.showDoneList()
                                  }
                              },
                            ),
                          ),
                          // DropdownButton<String>(
                          //   // value: dropdownValue,
                          //   icon: const Icon(Icons.arrow_downward),
                          //   elevation: 16,
                          //   style: const TextStyle(color: Colors.deepPurple),
                          //   underline: Container(
                          //     height: 2,
                          //     color: Colors.deepPurpleAccent,
                          //   ),
                          //   onChanged: (String? value) {
                          //     // This is called when the user selects an item.
                          //     setState(() {
                          //       // dropdownValue = value!;
                          //     });
                          //   },
                          //   items: list.map<DropdownMenuItem<String>>(
                          //       (String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          // ),

                          Obx(
                            () => DropdownButton2(
                              underline: Container(),
                              buttonStyleData: ButtonStyleData(
                                  elevation: 0,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 1,
                                          color: ThemeConstants.blackcolor))),
                              dropdownStyleData:
                                  DropdownStyleData(elevation: 1),
                              hint: Text(
                                '${controller.selectedFilter.value}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),

                              items: list
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: controller.selectedFilter.value == null
                                  ? selectedValue
                                  : controller.selectedFilter.value,
                              onChanged: (value) {
                                // controller.frfr(value);

                                controller.selectedFilter.value =
                                    value.toString();

                                controller.changeInFilter();

                                controller.update();

                                // controller.showSpecificMeeting(value);
                              },
                              // buttonHeight: 40,
                              // buttonWidth: 140,
                              // itemHeight: 40,
                              // itemWidth: 140,
                            ),
                          )

                          // CustomFilterSelector(
                          //   callBack: (val) {
                          //     // showDialog(
                          //     //     context: context,
                          //     //     builder: (_) => AlertDialog(
                          //     //           content: Container(
                          //     //             width: 40,
                          //     //             height: 40,
                          //     //             child: Text('dd'),
                          //     //           ),
                          //     //         ));
                          //     print(val);
                          //     setState(() {
                          //       showFilterList = val;
                          //     });
                          //   },
                          // ),
                        ],
                      ),

                      // Positioned(
                      //     right: 0,
                      //     top: 40,
                      //     child: Container(
                      //       width: 200,
                      //       height: 500,
                      //       color: Colors.amber,
                      //       child: Text('data'),
                      //     ))
                    ],
                  ),

                  //  Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       child: CustomTabWidget(
                  //         title0: "Upcoming",
                  //         title1: "Done",
                  //         callback: (val) => val,
                  //       ),
                  //     ),
                  //     CustomFilterSelector(),
                  //     if (showFilterList = true)

                  //   ],
                  // )
                ),
                // GetX<DashBoardController>(
                //   init: DashBoardController(),
                //   builder: (controller) {
                //     if (controller.loading.value == true) {
                //       return CircularProgressIndicator();
                //     } else {
                //       return Container(
                //         child: Text('ddd'),
                //       );
                //
                // }

                Expanded(child: Obx(() {
                  if (controller.loading.value == true) {
                    return getLoading(context);
                  } else {
                    return showFilter();
                  }
                })),

                // Row(
                //   children: [
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     // InkWell(
                //     //   onTap: () {
                //     //     if (controller.upcomingbuttonEnable.value ==
                //     //         false) {
                //     //       controller.upcomingbuttonEnable.value = true;
                //     //       controller.update();
                //     //     }
                //     //   },
                //     //   child: TextUnderLine(
                //     //     text1: "Upco",
                //     //     text: "ming",
                //     //     textColor:
                //     //         controller.upcomingbuttonEnable.value == true
                //     //             ? ThemeConstants.firstColor
                //     //             : ThemeConstants.blackcolor,
                //     //     underlinceColor:
                //     //         controller.upcomingbuttonEnable.value == true
                //     //             ? ThemeConstants.firstColor
                //     //             : Colors.transparent,
                //     //   ),
                //     // ),
                //     // const SizedBox(
                //     //   width: 20,
                //     // ),
                //     // InkWell(
                //     //   onTap: () {
                //     //     if (controller.upcomingbuttonEnable.value == true) {
                //     //       controller.upcomingbuttonEnable.value = false;
                //     //       controller.update();
                //     //     }
                //     //   },
                //     //   child: TextUnderLine(
                //     //     text1: "Do",
                //     //     text: "ne",
                //     //     textColor:
                //     //         controller.upcomingbuttonEnable.value == false
                //     //             ? ThemeConstants.firstColor
                //     //             : ThemeConstants.blackcolor,
                //     //     underlinceColor:
                //     //         controller.upcomingbuttonEnable.value == false
                //     //             ? ThemeConstants.firstColor
                //     //             : Colors.transparent,
                //     //   ),
                //     // ),
                //   ],
                // ),

                // const SizedBox(
                //   height: 5,
                // ),
                // Expanded(
                //   child: ListView(
                //     children: [
                //       ...getMeetingDetails(context, gradient, stops)
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: ThemeConstants.bluecolor,
        onPressed: () {
          // ApiServices().addMeeting();
          Get.toNamed(CreateNewMeeting.routeNamed);

          // Get.to(
          //   () => MeetingDetails(),
          // );
        },
      ),
    );
  }

  List<Widget> getMeetingDetails(
      BuildContext context, List<Color> colors, List<double> stops) {
    return [
      // singleMeetingDetails(context, colors, stops),
      // singleMeetingDetails(context, colors, stops),
      // singleMeetingDetails(context, colors, stops),
      // singleMeetingDetails(context, colors, stops),
    ];
  }

  singleMeetingDetails(BuildContext context, int indexs) {
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
                colors: [
                  Color.fromARGB(255, 255, 225, 150),
                  Color.fromARGB(255, 255, 225, 150),
                  Color.fromARGB(255, 255, 255, 255)
                ],
                stops: [0.00, 0.05, 0.05],
              ),
              border: Border.all(color: const Color(0xff1940b3)),
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 8),
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
                            controller.getNotes(
                                '${controller.listToShow[indexs].id}');
                            Get.to(MeetingDetails(),
                                arguments: controller.listToShow[indexs]);
                            // Get.toNamed(MeetingDetails.routeNamed,
                            //     arguments: controller.listToShow[indexs]);
                          },
                          child: SizedBox(
                            width: 300,
                            child: CustomAutoSizeTextMontserrat(
                              text:
                                  "${controller.listToShow[indexs].meetingAgenda}",
                              fontWeight: FontWeight.w700,
                            ),
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
                      text: "${controller.listToShow[indexs].meetingType}",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "${controller.listToShow[indexs].dateOfMeeting}",
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
                                // Expanded(
                                //     child: ListView.builder(
                                //         itemCount: itemcount(indexs),

                                //         itemBuilder: (context, index) {
                                //           return Positioned(
                                //             left: 25.0,
                                //             child: Container(
                                //               height: 36.0,
                                //               width: 36.0,
                                //               decoration: BoxDecoration(
                                //                 color: Color(0xFFFEF0F0),
                                //                 shape: BoxShape.circle,
                                //                 border: Border.all(
                                //                     color: Color(0xFFFF7171)),
                                //               ),
                                //               child: Center(
                                //                   child: CustomAutoSizeTextMontserrat(
                                //                       text:
                                //                           "${controller.listToShow[indexs].siecParticipants![index].name!.substring(0, 1)}")),
                                //             ),
                                //           );
                                //         })),
                                // Icon(Icons.monetization_on,
                                //     size: 36.0,
                                //     color: Color.fromRGBO(218, 165, 32, 1.0)),

                                ...getlist(indexs),
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: CustomAutoSizeTextMontserrat(
                                    text: "Reschedule Meeting",
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

  itemcount(int indexs) {
    if (controller.listToShow[indexs].siecParticipants == null) {
      return 0;
    } else {
      if (controller.listToShow[indexs].siecParticipants!.length > 3) {
        return 3;
      } else {
        return controller.listToShow[indexs].siecParticipants!.length;
      }
    }
  }

  List<Widget> getlist(int indexs) {
    var x = 25.0;
    List<Widget> list = [];
    var count = 0;
    List<Color> colorData = [
      Color(0xFFFF7171),
      Color(0xFF09C964),
      Color(0xFFFF9900),
      Color.fromARGB(255, 0, 102, 255)
    ];

    List<Color> colorDark = [
      Color(0xFFFEF0F0),
      Color(0xFFECFFF5),
      Color(0xFFFEF6E6),
      Color.fromARGB(255, 0, 102, 255)
    ];

    for (var i = 0;
        i < controller.listToShow[indexs].siecParticipants!.length;
        i++) {
      if (i < 3) {
        Widget uu = Positioned(
          left: 0 + x * i,
          child: Container(
            height: 36.0,
            width: 36.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Color.fromARGB(87, 0, 0, 0))
              ],
              color: colorDark[i],
              shape: BoxShape.circle,
              border: Border.all(
                color: colorData[i],
              ),
            ),
            child: Center(
                child: CustomAutoSizeTextMontserrat(
                    text:
                        "${controller.listToShow[indexs].siecParticipants![i].name!.substring(0, 1)}")),
          ),
        );

        list.add(uu);
      } else {
        Widget uu = Positioned(
          left: 0 + x * i,
          child: Container(
            height: 36.0,
            width: 36.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Color.fromARGB(87, 0, 0, 0))
              ],
              color: Color(0xFFFEF0F0),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFFF7171)),
            ),
            child: Center(
                child: CustomAutoSizeTextMontserrat(
                    text:
                        "+${controller.listToShow[indexs].siecParticipants!.length - 3}")),
          ),
        );

        list.add(uu);
        break;
      }
    }
    return list;

    //  [
    //   Container(
    //     height: 36.0,
    //     width: 36.0,
    //     decoration: BoxDecoration(
    //         color: Color(0xFFF1F0FF),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xFF1940B3))),
    //     child: Center(
    //         child: CustomAutoSizeTextMontserrat(
    //             text:
    //                 "${controller.listToShow[indexs].siecParticipants![0].name!.substring(0, 1)}")),
    //   ),
    //   Positioned(
    //     left: 25.0,
    //     child: Container(
    //       height: 36.0,
    //       width: 36.0,
    //       decoration: BoxDecoration(
    //         color: Color(0xFFFEF0F0),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xFFFF7171)),
    //       ),
    //       child: Center(
    //           child: CustomAutoSizeTextMontserrat(
    //               text:
    //                   "${controller.listToShow[indexs].siecParticipants![1].name!.substring(0, 1)}")),
    //     ),
    //   ),
    //   Positioned(
    //     left: 50.0,
    //     child: Container(
    //       height: 36.0,
    //       width: 36.0,
    //       decoration: BoxDecoration(
    //         color: Color(0xFFECFFF5),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xFF09C964)),
    //       ),
    //       child: Center(
    //           child: CustomAutoSizeTextMontserrat(
    //               text:
    //                   "${controller.listToShow[indexs].siecParticipants![0].name!.substring(0, 1)}")),
    //     ),
    //   ),
    //   Positioned(
    //     left: 75.0,
    //     child: Container(
    //       height: 36.0,
    //       width: 36.0,
    //       decoration: BoxDecoration(
    //         color: Color(0xFFFEF6E6),
    //         shape: BoxShape.circle,
    //         border: Border.all(color: Color(0xFFFF9900)),
    //       ),
    //       child: Center(child: CustomAutoSizeTextMontserrat(text: "+5")),
    //     ),
    //   ),
    // ];
  }

  showFilter() {
    // if (val == "Vendor Meeting") {
    //   return ListView.builder(
    //       itemCount: controller.listToShow
    //           .where((p0) =>
    //               p0.meetingType!.toLowerCase() == val.toString().toLowerCase())
    //           .length,
    //       itemBuilder: (context, index) {
    //         return singleMeetingDetails(context, index);
    //       });
    // }
    return ListView.builder(
        itemCount: controller.listToShow.length,
        itemBuilder: (context, index) {
          return singleMeetingDetails(context, index);
        });
  }
}


//  'All Meetings',
//     'University Meeting',
//     'Bank Meeting',
//     'Vendow Meeting',
//     'Internal Meeting'