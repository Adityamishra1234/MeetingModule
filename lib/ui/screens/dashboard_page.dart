import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';

import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting2.dart';
import 'package:meeting_module2/ui/screens/dashboard_notes.dart';
import 'package:meeting_module2/ui/screens/loginUi.dart';
import 'package:meeting_module2/ui/screens/meeting_details.dart';

import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_dialogue.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/popups/custom_error_popup.dart';
import 'package:local_auth/local_auth.dart';

class DashBoard extends StatefulWidget {
  static const routeNamed = '/DashBoard';
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  int siecParticipantsLength = 0;

  GlobalKey<CustomTabWidgetState> _childKey = CustomTabWidget.globalKey;

  // var controller = Get.put(DashBoardController());
  var controllerBase = Get.find<BaseController>();
  var controller = Get.find<DashBoardController>();
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
  void initState() {
    controllerBase.token2();
    controllerBase.getId();
    if (Get.previousRoute == '${LoginView.routeNamed}' ||
        Get.previousRoute == "/signin") {
      _authenticate();
    }

    // controller.getMeetingData();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

//

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
      body: controller.obx(
        (state) => SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 60,
                            height: 60,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: ThemeConstants.bluecolor,
                                  radius: 35,
                                ),
                                CircleAvatar(
                                  backgroundColor: ThemeConstants.whitecolor,
                                  radius: 28,
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      ThemeConstants.ultraLightgreyColor,
                                  radius: 25,
                                  child: Icon(
                                    Icons.person,
                                    size: 35,
                                    color: ThemeConstants.bluecolor,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomAutoSizeTextMontserrat(
                                  text: "Hello,",
                                  fontSize: 18,
                                ),
                                CustomAutoSizeTextMontserrat(
                                  text: "${controller.user.value.name}",
                                  fontSize: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          child: Wrap(
                            spacing: 5,
                            // mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(DashboardNotesView.routenamed);
                                },
                                child: Container(
                                  width: 45,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      border: Border.all(
                                          width: 1.5,
                                          color: ThemeConstants.yellow),
                                      color: ThemeConstants.lightYellow),
                                  height: 45,
                                  child: SvgPicture.asset(
                                      'assets/images/note.svg'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controllerBase.logOut();
                                },
                                child: Container(
                                  width: 45,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      border: Border.all(
                                          width: 1.5,
                                          color: ThemeConstants.bluecolor),
                                      color: ThemeConstants.lightblueColor),
                                  height: 45,
                                  child: Icon(Icons.logout),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  CustomAutoSizeTextMontserrat(
                    text: "Your Meetings",
                    fontSize: 30,
                    textColor: ThemeConstants.bluecolor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: CustomTabWidget(
                          key: _childKey,
                          title0: "Upcoming",
                          title1: "Done",
                          callback: (val) => {
                            controller.indexOfTab = val,
                            print(val == 1),
                            if (val == 0)
                              {
                                print('dcdfrfvfvf'),
                                controller.showUpcomingList(),
                                controller.update()
                              }
                            else if (val == 1)
                              {
                                print('$val dcdcd'),
                                controller.showDoneList(),
                                controller.update()
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
                      SizedBox(
                        width: 30,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Obx(
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
                            dropdownStyleData: DropdownStyleData(elevation: 1),
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
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        print(controller.indexOfTab);
                        print(details);
                        if (controller.indexOfTab == 0) {
                          controller.showUpcomingList();
                          controller.update();
                          controller.indexOfTab = 1;
                          _childKey.currentState?.changeOfIndexFromParent(1);
                        } else if (controller.indexOfTab == 1) {
                          controller.showDoneList();
                          controller.update();
                          controller.indexOfTab = 0;
                          _childKey.currentState?.changeOfIndexFromParent(0);
                        }
                        // if (controller.indexOfTab == 0) {
                        //   controller.indexOfTab == 1;
                        // } else {
                        //   controller.indexOfTab == 0;
                        // }
                        // print(controller.indexOfTab);
                        // controller.update();
                      },
                      child: ListView(children: [
                        ...controller.singleMeetingDetails(context)
                      ]),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  )

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
        onLoading: getLoading(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: ThemeConstants.bluecolor,
        onPressed: () {
          print('object');
          // ApiServices().addMeeting();
          // Get.toNamed(CreateNewMeeting.routeNamed);
          Get.to(CreateNewMeeting2());

          // Get.to(
          //   () => MeetingDetails(),
          // );
        },
      ),
    );
  }

  // List<Widget> getMeetingDetails(
  //     BuildContext context, List<Color> colors, List<double> stops) {
  //   return [
  //     // singleMeetingDetails(context, colors, stops),
  //     // singleMeetingDetails(context, colors, stops),
  //     // singleMeetingDetails(context, colors, stops),
  //     // singleMeetingDetails(context, colors, stops),
  //   ];
  // }

  // singleMeetingDetails(BuildContext context, int indexs) {
  //   bool menu = false;

  //   return StatefulBuilder(builder: (thisLowerContext, innerSetState) {
  //     return Padding(
  //       padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width,
  //         decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               begin: Alignment.centerLeft,
  //               end: Alignment.centerRight,
  //               colors: [
  //                 Color.fromARGB(255, 255, 225, 150),
  //                 Color.fromARGB(255, 255, 225, 150),
  //                 Color.fromARGB(255, 255, 255, 255)
  //               ],
  //               stops: [0.00, 0.05, 0.05],
  //             ),
  //             border: Border.all(color: const Color(0xff1940b3)),
  //             borderRadius: BorderRadius.circular(10.0)),
  //         child: Padding(
  //           padding: const EdgeInsets.only(left: 25, top: 8),
  //           child: Stack(
  //             children: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       InkWell(
  //                         onTap: () {
  //                           controller.getNotes(
  //                               '${controller.listToShow[indexs].id}', indexs);
  //                           Get.to(MeetingDetails());
  //                           // Get.toNamed(MeetingDetails.routeNamed,
  //                           //     arguments: controller.listToShow[indexs]);
  //                         },
  //                         child: SizedBox(
  //                           width: 300,
  //                           child: CustomAutoSizeTextMontserrat(
  //                             text:
  //                                 "${controller.listToShow[indexs].meetingAgenda}",
  //                             fontWeight: FontWeight.w700,
  //                           ),
  //                         ),
  //                       ),
  //                       const Spacer(),

  //                       // InkWell(
  //                       //     onTap: () {
  //                       //       innerSetState(() {
  //                       //         if (menu == false) {
  //                       //           menu = true;
  //                       //         } else {
  //                       //           menu = false;
  //                       //         }
  //                       //       });
  //                       //     },
  //                       //     child: Container(
  //                       //         width: 40,
  //                       //         child: const Icon(Icons.more_vert_rounded)))
  //                     ],
  //                   ),
  //                   CustomAutoSizeTextMontserrat(
  //                     text: "${controller.listToShow[indexs].nameOfTheMeeting}",
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w600,
  //                     textColor: ThemeConstants.TextColor,
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   CustomAutoSizeTextMontserrat(
  //                     text: "${controller.listToShow[indexs].meetingType}",
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w600,
  //                     textColor: ThemeConstants.TextColor,
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   CustomAutoSizeTextMontserrat(
  //                     text: "${controller.listToShow[indexs].dateOfMeeting}",
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.w600,
  //                     textColor: ThemeConstants.TextColor,
  //                   ),
  //                   Row(
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 20),
  //                         child: SizedBox(
  //                           // color: Colors.amber,
  //                           height: 50,
  //                           width: 150,
  //                           child: Stack(
  //                             //alignment:new Alignment(x, y)
  //                             children: [
  //                               // Expanded(
  //                               //     child: ListView.builder(
  //                               //         itemCount: itemcount(indexs),

  //                               //         itemBuilder: (context, index) {
  //                               //           return Positioned(
  //                               //             left: 25.0,
  //                               //             child: Container(
  //                               //               height: 36.0,
  //                               //               width: 36.0,
  //                               //               decoration: BoxDecoration(
  //                               //                 color: Color(0xFFFEF0F0),
  //                               //                 shape: BoxShape.circle,
  //                               //                 border: Border.all(
  //                               //                     color: Color(0xFFFF7171)),
  //                               //               ),
  //                               //               child: Center(
  //                               //                   child: CustomAutoSizeTextMontserrat(
  //                               //                       text:
  //                               //                           "${controller.listToShow[indexs].siecParticipants![index].name!.substring(0, 1)}")),
  //                               //             ),
  //                               //           );
  //                               //         })),
  //                               // Icon(Icons.monetization_on,
  //                               //     size: 36.0,
  //                               //     color: Color.fromRGBO(218, 165, 32, 1.0)),

  //                               ...getlist(indexs),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       Spacer(),
  //                       CustomButton(
  //                           backgroundColor: Color.fromARGB(255, 255, 225, 150),
  //                           text: 'Reshedule',
  //                           textColor: ThemeConstants.blackcolor,
  //                           onPressed: () {
  //                             if (controller
  //                                         .listToShow[indexs].meetingStarted ==
  //                                     false &&
  //                                 controller.listToShow[indexs].meetingEnded ==
  //                                     false) {
  //                               showAnimatedDialog(
  //                                   animationType: DialogTransitionType
  //                                       .slideFromBottomFade,
  //                                   curve: Curves.easeInOutQuart,
  //                                   // barrierDismissible: false,
  //                                   context: context,
  //                                   builder: (ctx) => ResheduleMeetingDialogue(
  //                                         controller: controller,
  //                                         indexz: indexs,
  //                                         meetingData:
  //                                             controller.listToShow[indexs],
  //                                       ));
  //                             } else {
  //                               showAnimatedDialog(
  //                                   animationType: DialogTransitionType
  //                                       .slideFromBottomFade,
  //                                   curve: Curves.easeInOutQuart,
  //                                   // barrierDismissible: false,
  //                                   context: context,
  //                                   builder: (ctx) => AlertDialog(
  //                                         content: Container(
  //                                             width: 400,
  //                                             height: 400,
  //                                             child:
  //                                                 CustomAutoSizeTextMontserrat(
  //                                               text: 'Meeting already started',
  //                                             )),
  //                                       ));
  //                             }
  //                           }),
  //                       // CustomButton(text: 'Delete', onPressed: () {})
  //                     ],
  //                   )
  //                 ],
  //               ),
  //               // if (menu == true)
  //               //   Positioned(
  //               //       right: 25,
  //               //       top: -2,
  //               //       child: SizedBox(
  //               //         height: 70,
  //               //         width: 155,
  //               //         child: Opacity(
  //               //           opacity: 1,
  //               //           child: Card(
  //               //             elevation: 2,
  //               //             color: Colors.white,
  //               //             child: Column(
  //               //               mainAxisAlignment: MainAxisAlignment.start,
  //               //               crossAxisAlignment: CrossAxisAlignment.start,
  //               //               children: [
  //               //                 const Spacer(),
  //               //                 InkWell(
  //               //                   onTap: () async {
  //               //                     // if (controller.listToShow[indexs]
  //               //                     //             .meetingStarted ==
  //               //                     //         false &&
  //               //                     //     controller.listToShow[indexs]
  //               //                     //             .meetingEnded ==
  //               //                     //         false) {
  //               //                     showAnimatedDialog(
  //               //                         animationType: DialogTransitionType
  //               //                             .slideFromBottomFade,
  //               //                         curve: Curves.easeInOutQuart,
  //               //                         // barrierDismissible: false,
  //               //                         context: context,
  //               //                         builder: (ctx) =>
  //               //                             ResheduleMeetingDialogue(
  //               //                               controller: controller,
  //               //                               indexz: indexs,
  //               //                               meetingData:
  //               //                                   controller.listToShow[indexs],
  //               //                             ));
  //               //                     // } else {
  //               //                     // showAnimatedDialog(
  //               //                     //     animationType: DialogTransitionType
  //               //                     //         .slideFromBottomFade,
  //               //                     //     curve: Curves.easeInOutQuart,
  //               //                     //     // barrierDismissible: false,
  //               //                     //     context: context,
  //               //                     //     builder: (ctx) => AlertDialog(
  //               //                     //           content: Container(
  //               //                     //               width: 400,
  //               //                     //               height: 400,
  //               //                     //               child:
  //               //                     //                   CustomAutoSizeTextMontserrat(
  //               //                     //                 text:
  //               //                     //                     'Meeting already started',
  //               //                     //               )),
  //               //                     //         ));
  //               //                     // }

  //               //                     // rescheduleMeetingDialogue(
  //               //                     //     context: context,
  //               //                     //     id: controller.listToShow[indexs].id!,
  //               //                     //     timeCallback: (data2) {
  //               //                     //       AllMeetings data =
  //               //                     //           controller.listToShow[indexs];

  //               //                     //       data.timeOfTheMeeting = data2;
  //               //                     //       data.isReschedule = true;
  //               //                     //       print(data.toJson());
  //               //                     //       /
  //               //                     //     });
  //               //                   },
  //               //                   child: Padding(
  //               //                     padding: const EdgeInsets.only(left: 10),
  //               //                     child: CustomAutoSizeTextMontserrat(
  //               //                       text: "Reschedule Meeting",
  //               //                       fontSize: 10,
  //               //                       fontWeight: FontWeight.w600,
  //               //                       textColor: ThemeConstants.TextColor,
  //               //                     ),
  //               //                   ),
  //               //                 ),
  //               //                 InkWell(
  //               //                   onTap: () async {
  //               //                     showAnimatedDialog(
  //               //                         animationType: DialogTransitionType
  //               //                             .slideFromBottomFade,
  //               //                         curve: Curves.easeInOutQuart,
  //               //                         // barrierDismissible: false,
  //               //                         context: context,
  //               //                         builder: (ctx) => AlertDialog(
  //               //                               content: Container(
  //               //                                 width: 300,
  //               //                                 height: 100,
  //               //                                 child: Column(
  //               //                                     mainAxisAlignment:
  //               //                                         MainAxisAlignment
  //               //                                             .center,
  //               //                                     crossAxisAlignment:
  //               //                                         CrossAxisAlignment
  //               //                                             .center,
  //               //                                     children: [
  //               //                                       CustomAutoSizeTextMontserrat(
  //               //                                         text: 'Please Confirm',
  //               //                                         fontSize: 25,
  //               //                                       ),
  //               //                                       InkWell(
  //               //                                         onTap: () {},
  //               //                                         child: CustomButton(
  //               //                                           backgroundColor:
  //               //                                               ThemeConstants
  //               //                                                   .bluecolor,
  //               //                                           onPressed: () {},
  //               //                                           text: 'Delete',
  //               //                                         ),
  //               //                                       )
  //               //                                     ]),
  //               //                               ),
  //               //                             ));
  //               //                   },
  //               //                   child: Padding(
  //               //                     padding: const EdgeInsets.only(left: 10),
  //               //                     child: CustomAutoSizeTextMontserrat(
  //               //                       text: "Delete Meeting",
  //               //                       fontSize: 10,
  //               //                       fontWeight: FontWeight.w600,
  //               //                       textColor: ThemeConstants.TextColor,
  //               //                     ),
  //               //                   ),
  //               //                 ),
  //               //                 const Spacer(),
  //               //               ],
  //               //             ),
  //               //           ),
  //               //         ),
  //               //       )),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  // itemcount(int indexs) {
  //   if (controller.listToShow[indexs].siecParticipants == null) {
  //     return 0;
  //   } else {
  //     if (controller.listToShow[indexs].siecParticipants!.length > 3) {
  //       return 3;
  //     } else {
  //       return controller.listToShow[indexs].siecParticipants!.length;
  //     }
  //   }
  // }

  // List<Widget> getlist(int indexs) {
  //   var x = 25.0;
  //   List<Widget> list = [];
  //   var count = 0;
  //   List<Color> colorData = [
  //     Color(0xFFFF7171),
  //     Color(0xFF09C964),
  //     Color(0xFFFF9900),
  //     Color.fromARGB(255, 0, 102, 255)
  //   ];

  //   List<Color> colorDark = [
  //     Color(0xFFFEF0F0),
  //     Color(0xFFECFFF5),
  //     Color(0xFFFEF6E6),
  //     Color.fromARGB(255, 0, 102, 255)
  //   ];

  //   for (var i = 0;
  //       i < controller.listToShow[indexs].siecParticipants!.length;
  //       i++) {
  //     if (i < 3) {
  //       Widget uu = Positioned(
  //         left: 0 + x * i,
  //         child: Container(
  //           height: 36.0,
  //           width: 36.0,
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                   blurRadius: 2,
  //                   spreadRadius: 1,
  //                   color: Color.fromARGB(87, 0, 0, 0))
  //             ],
  //             color: colorDark[i],
  //             shape: BoxShape.circle,
  //             border: Border.all(
  //               color: colorData[i],
  //             ),
  //           ),
  //           child: Center(
  //               child: CustomAutoSizeTextMontserrat(
  //                   text:
  //                       "${controller.listToShow[indexs].siecParticipants![i].name!.substring(0, 1)}")),
  //         ),
  //       );

  //       list.add(uu);
  //     } else {
  //       Widget uu = Positioned(
  //         left: 0 + x * i,
  //         child: Container(
  //           height: 36.0,
  //           width: 36.0,
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                   blurRadius: 2,
  //                   spreadRadius: 1,
  //                   color: Color.fromARGB(87, 0, 0, 0))
  //             ],
  //             color: Color(0xFFFEF0F0),
  //             shape: BoxShape.circle,
  //             border: Border.all(color: Color(0xFFFF7171)),
  //           ),
  //           child: Center(
  //               child: CustomAutoSizeTextMontserrat(
  //                   text:
  //                       "+${controller.listToShow[indexs].siecParticipants!.length - 3}")),
  //         ),
  //       );

  //       list.add(uu);
  //       break;
  //     }
  //   }
  //   return list;

  //   //  [
  //   //   Container(
  //   //     height: 36.0,
  //   //     width: 36.0,
  //   //     decoration: BoxDecoration(
  //   //         color: Color(0xFFF1F0FF),
  //   //         shape: BoxShape.circle,
  //   //         border: Border.all(color: Color(0xFF1940B3))),
  //   //     child: Center(
  //   //         child: CustomAutoSizeTextMontserrat(
  //   //             text:
  //   //                 "${controller.listToShow[indexs].siecParticipants![0].name!.substring(0, 1)}")),
  //   //   ),
  //   //   Positioned(
  //   //     left: 25.0,
  //   //     child: Container(
  //   //       height: 36.0,
  //   //       width: 36.0,
  //   //       decoration: BoxDecoration(
  //   //         color: Color(0xFFFEF0F0),
  //   //         shape: BoxShape.circle,
  //   //         border: Border.all(color: Color(0xFFFF7171)),
  //   //       ),
  //   //       child: Center(
  //   //           child: CustomAutoSizeTextMontserrat(
  //   //               text:
  //   //                   "${controller.listToShow[indexs].siecParticipants![1].name!.substring(0, 1)}")),
  //   //     ),
  //   //   ),
  //   //   Positioned(
  //   //     left: 50.0,
  //   //     child: Container(
  //   //       height: 36.0,
  //   //       width: 36.0,
  //   //       decoration: BoxDecoration(
  //   //         color: Color(0xFFECFFF5),
  //   //         shape: BoxShape.circle,
  //   //         border: Border.all(color: Color(0xFF09C964)),
  //   //       ),
  //   //       child: Center(
  //   //           child: CustomAutoSizeTextMontserrat(
  //   //               text:
  //   //                   "${controller.listToShow[indexs].siecParticipants![0].name!.substring(0, 1)}")),
  //   //     ),
  //   //   ),
  //   //   Positioned(
  //   //     left: 75.0,
  //   //     child: Container(
  //   //       height: 36.0,
  //   //       width: 36.0,
  //   //       decoration: BoxDecoration(
  //   //         color: Color(0xFFFEF6E6),
  //   //         shape: BoxShape.circle,
  //   //         border: Border.all(color: Color(0xFFFF9900)),
  //   //       ),
  //   //       child: Center(child: CustomAutoSizeTextMontserrat(text: "+5")),
  //   //     ),
  //   //   ),
  //   // ];
  // }

  // showFilter() {
  //   // if (val == "Vendor Meeting") {
  //   //   return ListView.builder(
  //   //       itemCount: controller.listToShow
  //   //           .where((p0) =>
  //   //               p0.meetingType!.toLowerCase() == val.toString().toLowerCase())
  //   //           .length,
  //   //       itemBuilder: (context, index) {
  //   //         return singleMeetingDetails(context, index);
  //   //       });
  //   // }
  //   return ListView.builder(
  //       itemCount: controller.listToShow.length,
  //       itemBuilder: (context, index) {
  //         return singleMeetingDetails(context, index);
  //       });
  // }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() => _authorized = authenticated ? 'Authorized' : exit(0));
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class DashboardMeetings extends StatelessWidget {
  final AllMeetings data;
  final int i;
  DashboardMeetings({super.key, required this.data, required this.i});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<BaseController>().selectedMeeting(data);
        // getNotes('${data.id}', i);
        Get.to(MeetingDetails());
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 2),
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
            padding: const EdgeInsets.only(left: 30, top: 0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: SizedBox(
                                // width: 300,
                                child: CustomAutoSizeTextMontserrat(
                                  text: "${data.meetingAgenda}",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            data.meetingStarted! && !data.meetingEnded!
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Radio(
                                            activeColor: Colors.green,
                                            value: true,
                                            groupValue: true,
                                            onChanged: (val) {}),
                                      ),
                                      CustomAutoSizeTextMontserrat(
                                        fontSize: 12,
                                        text: '(Started)',
                                        textColor: ThemeConstants.GreenColor,
                                      )
                                    ],
                                  )
                                : SizedBox.shrink(),
                            data.meetingStarted! && data.meetingEnded!
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Radio(
                                            activeColor: Colors.red,
                                            value: true,
                                            groupValue: true,
                                            onChanged: (val) {}),
                                      ),
                                      CustomAutoSizeTextMontserrat(
                                        text: '(Ended)',
                                        fontSize: 12,
                                        textColor: Colors.red,
                                      )
                                    ],
                                  )
                                : SizedBox.shrink(),
                            !data.meetingStarted! && !data.meetingEnded!
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Radio(
                                            activeColor: const Color.fromARGB(
                                                255, 114, 114, 114),
                                            value: true,
                                            groupValue: true,
                                            onChanged: (val) {}),
                                      ),
                                      CustomAutoSizeTextMontserrat(
                                        text: 'Not Started',
                                        fontSize: 14,
                                        textColor: const Color.fromARGB(
                                            255, 114, 114, 114),
                                      )
                                    ],
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                        const Spacer(),

                        // InkWell(
                        //     onTap: () {
                        //       innerSetState(() {
                        //         if (menu == false) {
                        //           menu = true;
                        //         } else {
                        //           menu = false;
                        //         }
                        //       });
                        //     },
                        //     child: Container(
                        //         width: 40,
                        //         child: const Icon(Icons.more_vert_rounded)))
                      ],
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "${data.nameOfTheMeeting}",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      textColor: ThemeConstants.TextColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "${data.meetingType}",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      textColor: ThemeConstants.TextColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomAutoSizeTextMontserrat(
                      text: "${data.dateOfMeeting}",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      textColor: ThemeConstants.TextColor,
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

                                // ...getlist(i),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        CustomButton(
                            backgroundColor: Color.fromARGB(255, 255, 225, 150),
                            text: 'Reschedule',
                            textColor: ThemeConstants.blackcolor,
                            onPressed: () async {
                              late bool showTheStartEndOptions;
                              data.meetingCoordinator!.forEach((element) {
                                if (element.id ==
                                        Get.find<BaseController>().id ||
                                    data.createdBy ==
                                        Get.find<BaseController>().id) {
                                  showTheStartEndOptions = true;
                                } else {
                                  print('${element.id}dddddddd');
                                  showTheStartEndOptions = false;
                                }
                              });
                              if (showTheStartEndOptions == true) {
                                if (data.meetingStarted == false &&
                                    data.meetingEnded == false) {
                                  showAnimatedDialog(
                                      animationType: DialogTransitionType
                                          .slideFromBottomFade,
                                      curve: Curves.easeInOutQuart,
                                      // barrierDismissible: false,
                                      context: context,
                                      builder: (ctx) => StatefulBuilder(
                                          builder: (context, setState) =>
                                              ResheduleMeetingDialogue(
                                                controller: Get.find<
                                                    DashBoardController>(),
                                                indexz: i,
                                                meetingData: data,
                                              )));
                                } else {
                                  showAnimatedDialog(
                                      barrierDismissible: true,
                                      animationType: DialogTransitionType
                                          .slideFromBottomFade,
                                      curve: Curves.easeInOutQuart,
                                      // barrierDismissible: false,
                                      context: context,
                                      builder: (ctx) => showPoPUp(
                                          'Meeting already started',
                                          Icon(
                                            Icons.error,
                                            size: 40,
                                            color: ThemeConstants.bluecolor,
                                          )));
                                }
                              } else {
                                showAnimatedDialog(
                                    barrierDismissible: true,
                                    animationType: DialogTransitionType
                                        .slideFromBottomFade,
                                    curve: Curves.easeInOutQuart,
                                    // barrierDismissible: false,
                                    context: context,
                                    builder: (ctx) => showPoPUp(
                                        "Only Co-ordinator's and creator can reshedule the meeting",
                                        Icon(
                                          Icons.error,
                                          size: 40,
                                          color: ThemeConstants.bluecolor,
                                        )));
                              }
                            }),
                        // CustomButton(text: 'Delete', onPressed: () {})
                      ],
                    )
                  ],
                ),
                // if (menu == true)
                //   Positioned(
                //       right: 25,
                //       top: -2,
                //       child: SizedBox(
                //         height: 70,
                //         width: 155,
                //         child: Opacity(
                //           opacity: 1,
                //           child: Card(
                //             elevation: 2,
                //             color: Colors.white,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 const Spacer(),
                //                 InkWell(
                //                   onTap: () async {
                //                     // if (controller.listToShow[indexs]
                //                     //             .meetingStarted ==
                //                     //         false &&
                //                     //     controller.listToShow[indexs]
                //                     //             .meetingEnded ==
                //                     //         false) {
                //                     showAnimatedDialog(
                //                         animationType: DialogTransitionType
                //                             .slideFromBottomFade,
                //                         curve: Curves.easeInOutQuart,
                //                         // barrierDismissible: false,
                //                         context: context,
                //                         builder: (ctx) =>
                //                             ResheduleMeetingDialogue(
                //                               controller: controller,
                //                               indexz: indexs,
                //                               meetingData:
                //                                   controller.listToShow[indexs],
                //                             ));
                //                     // } else {
                //                     // showAnimatedDialog(
                //                     //     animationType: DialogTransitionType
                //                     //         .slideFromBottomFade,
                //                     //     curve: Curves.easeInOutQuart,
                //                     //     // barrierDismissible: false,
                //                     //     context: context,
                //                     //     builder: (ctx) => AlertDialog(
                //                     //           content: Container(
                //                     //               width: 400,
                //                     //               height: 400,
                //                     //               child:
                //                     //                   CustomAutoSizeTextMontserrat(
                //                     //                 text:
                //                     //                     'Meeting already started',
                //                     //               )),
                //                     //         ));
                //                     // }

                //                     // rescheduleMeetingDialogue(
                //                     //     context: context,
                //                     //     id: controller.listToShow[indexs].id!,
                //                     //     timeCallback: (data2) {
                //                     //       AllMeetings data =
                //                     //           controller.listToShow[indexs];

                //                     //       data.timeOfTheMeeting = data2;
                //                     //       data.isReschedule = true;
                //                     //       print(data.toJson());
                //                     //       /
                //                     //     });
                //                   },
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(left: 10),
                //                     child: CustomAutoSizeTextMontserrat(
                //                       text: "Reschedule Meeting",
                //                       fontSize: 10,
                //                       fontWeight: FontWeight.w600,
                //                       textColor: ThemeConstants.TextColor,
                //                     ),
                //                   ),
                //                 ),
                //                 InkWell(
                //                   onTap: () async {
                //                     showAnimatedDialog(
                //                         animationType: DialogTransitionType
                //                             .slideFromBottomFade,
                //                         curve: Curves.easeInOutQuart,
                //                         // barrierDismissible: false,
                //                         context: context,
                //                         builder: (ctx) => AlertDialog(
                //                               content: Container(
                //                                 width: 300,
                //                                 height: 100,
                //                                 child: Column(
                //                                     mainAxisAlignment:
                //                                         MainAxisAlignment
                //                                             .center,
                //                                     crossAxisAlignment:
                //                                         CrossAxisAlignment
                //                                             .center,
                //                                     children: [
                //                                       CustomAutoSizeTextMontserrat(
                //                                         text: 'Please Confirm',
                //                                         fontSize: 25,
                //                                       ),
                //                                       InkWell(
                //                                         onTap: () {},
                //                                         child: CustomButton(
                //                                           backgroundColor:
                //                                               ThemeConstants
                //                                                   .bluecolor,
                //                                           onPressed: () {},
                //                                           text: 'Delete',
                //                                         ),
                //                                       )
                //                                     ]),
                //                               ),
                //                             ));
                //                   },
                //                   child: Padding(
                //                     padding: const EdgeInsets.only(left: 10),
                //                     child: CustomAutoSizeTextMontserrat(
                //                       text: "Delete Meeting",
                //                       fontSize: 10,
                //                       fontWeight: FontWeight.w600,
                //                       textColor: ThemeConstants.TextColor,
                //                     ),
                //                   ),
                //                 ),
                //                 const Spacer(),
                //               ],
                //             ),
                //           ),
                //         ),
                //       )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  'All Meetings',
//     'University Meeting',
//     'Bank Meeting',
//     'Vendow Meeting',
//     'Internal Meeting'
