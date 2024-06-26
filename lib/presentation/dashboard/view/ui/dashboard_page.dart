import 'dart:collection';

import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:meeting_module2/models/allMeetingsModels.dart';

import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/presentation/custom_widgets/custom_app_bar.dart';
import 'package:meeting_module2/presentation/custom_widgets/custom_drawer.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting.dart';
import 'package:meeting_module2/ui/screens/create_new_meeting2.dart';
import 'package:meeting_module2/ui/screens/dashboard_notes.dart';
import 'package:meeting_module2/ui/screens/loginUi.dart';
import 'package:meeting_module2/ui/screens/meeting_details.dart';
import 'package:meeting_module2/ui/screens/signin_view.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/routes/router_config.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/calender/calendar_controller.dart';
import 'package:meeting_module2/widget/calender/src/customization/calendar_builders.dart';
import 'package:meeting_module2/widget/calender/src/customization/calendar_style.dart';
import 'package:meeting_module2/widget/calender/src/customization/days_of_week_style.dart';
import 'package:meeting_module2/widget/calender/src/customization/header_style.dart';
import 'package:meeting_module2/widget/calender/src/shared/utils.dart';
import 'package:meeting_module2/widget/calender/src/table_calendar.dart';
import 'package:meeting_module2/widget/custom_button.dart';
import 'package:meeting_module2/widget/custom_dialogue.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/popups/custom_error_popup.dart';

import 'package:meeting_module2/widget/calender/src/shared/utils.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  static const routeNamed = '/DashBoard';
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  int siecParticipantsLength = 0;

  GlobalKey<CustomTabWidgetState> _childKey = CustomTabWidget.globalKey;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  // Map<DateTime, List<Event>> map1 = {
  //   DateTime(2023, 8, 15): [Event('ddd'), Event('ddd')],
  //   DateTime(2023, 8, 30): [Event('ddd'), Event('ddd')],
  //   DateTime(2023, 8, 12): [Event('ddd'), Event('ddd')],
  //   DateTime(2023, 9, 20): [Event('ddd'), Event('ddd')],
  //   DateTime(2023, 9, 21): [Event('ddd'), Event('ddd')],
  //   DateTime.now(): [Event('ddd'), Event('ddd')]
  // };
  // var controller = Get.put(DashBoardController());
  var controllerBase = Get.find<BaseController>();

  var controller = Get.put(DashBoardController(), permanent: true);

  //  var    Get.put(CalendarController());

  late CalendarController caleCon;

  String? selectedValue = 'All Meetings';
  bool showFilterList = true;
  List<String> list = <String>[
    'All Meetings',
    'University Meeting',
    'Bank Meeting',
    'Vendor Meeting',
    'Internal Meeting'
  ];

  // late DashboardBloc dashboardBloc;

  @override
  void initState() {
    controllerBase.getId;

    print(context);

    caleCon = Get.put(CalendarController());

    caleCon.getMonthMeetingDates(Get.find<BaseController>().id,
        DateTime.now().month, DateTime.now().year);

    // dashboardBloc = locator.get<DashboardBloc>();
    // dashboardBloc.add(DashboardIntitalEvent(context));

    // Get.find<BaseController>().getBuildContextOfThePage(context);
    // controller.getBuildContextOfThePage(context);
    // controllerBase.token2();

    controllerBase.getId();
    controllerBase.token2();
    controller.dashboardInitialLoginForUserDetails(context);

    // controller.user.value = controllerBase.user.value;

    // if (Get.previousRoute == '${LoginView.routeNamed}' ||
    //     Get.previousRoute == "/") {
    //   _authenticate();
    // }

    // controller.getMeetingData();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
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
      // appBar: CustomAppBar('title'),
      // drawer: CustomDrawer(),
      // body: controller.obx((state) {
      //   print(state);
      body: controller.obx(
        (state) =>
            // BlocConsumer<DashboardBloc, DashboardState>(
            // listener: (context, state) {
            // TODO: implement listener
            // }, builder: (context, state) {
            SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(gradient: ThemeConstants.backgroundGradient),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 25, right: 25),
                      child: SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: "Hello,",
                                    textColor: ThemeConstants.whitecolor,
                                    fontSize: 16,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  CustomAutoSizeTextMontserrat(
                                    text: "${controller.user.value.name}",
                                    textColor: ThemeConstants.paleYellow,
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    backgroundColor: ThemeConstants.whitecolor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(40),
                                    )),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        decoration: BoxDecoration(),
                                        height: 300,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  width: double.infinity,
                                                  padding: EdgeInsets.only(
                                                      top: 0,
                                                      left: 0,
                                                      bottom: 5,
                                                      right: 0),
                                                  margin: EdgeInsets.only(
                                                      left: 0,
                                                      right: 0,
                                                      top: 0,
                                                      bottom: 0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: ThemeConstants
                                                            .whitecolor),
                                                    // boxShadow: [
                                                    //   const BoxShadow(
                                                    //       blurRadius: 0.5,
                                                    //       spreadRadius: 0.1,
                                                    //       color: Color.fromARGB(40, 0, 0, 0))
                                                    // ],
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              context.push(
                                                                  '${Routes.dashboard}/${Routes.viewDashboardNotes}');
                                                              // Get.deleteAll();

                                                              // if (controller
                                                              //         .meetingStartedValue ==
                                                              //     true) {
                                                              //   context.push(
                                                              //       '${Routes.dashboard}/${Routes.meetingDetails}/${Routes.addMoreNotesView}/${meetingData.id}/0');
                                                              //   // Get.toNamed(AddMoreNotesView.routeName,
                                                              //   //     arguments: [meetingData.id, 0]);
                                                              // } else {
                                                              //   getToast(
                                                              //       'Meeting not started yet');
                                                              //   // showDialog(
                                                              //   //     context: context,
                                                              //   //     builder: (_) => showPoPUp(
                                                              //   //         'Meeting not started yet',
                                                              //   //         Icon(
                                                              //   //           Icons.error,
                                                              //   //           size: 40,
                                                              //   //           color: ThemeConstants.bluecolor,
                                                              //   //         ),
                                                              //   //         context));
                                                              // }
                                                            },
                                                            child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  color: ThemeConstants
                                                                      .lightblueColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    // decoration: BoxDecoration(
                                                                    //     color: ThemeConstants
                                                                    //         .GreenColor),
                                                                    width: 150,
                                                                    color: Colors
                                                                        .transparent,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/images/View Note.svg',
                                                                      color: ThemeConstants
                                                                          .bluecolor,
                                                                      // color: index == 5
                                                                      //     ? ThemeConstants.bluecolor
                                                                      //     : const Color.fromARGB(
                                                                      //         255, 31, 31, 31),
                                                                      width: 30,
                                                                    ),
                                                                    // child: Icon(
                                                                    //   Icons.add,
                                                                    //   size: 30,
                                                                    //   color: ThemeConstants.blackcolor,
                                                                    // )
                                                                  ),
                                                                  CustomAutoSizeTextMontserrat(
                                                                    text:
                                                                        'My Notes',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    textColor:
                                                                        ThemeConstants
                                                                            .bluecolor,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                color: ThemeConstants
                                                                    .lightblueColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: InkWell(
                                                              onTap: () {
                                                                context.push(
                                                                    '${Routes.dashboard}/${Routes.usesNotesTask}/${controller.user.value.id}');
                                                                // Get.deleteAll();

                                                                // if (controller
                                                                //         .meetingStartedValue ==
                                                                //     true) {
                                                                //   context.push(
                                                                //       '${Routes.dashboard}/${Routes.meetingDetails}/${Routes.addMoreNotesView}/${meetingData.id}/0');
                                                                //   // Get.toNamed(AddMoreNotesView.routeName,
                                                                //   //     arguments: [meetingData.id, 0]);
                                                                // } else {
                                                                //   getToast(
                                                                //       'Meeting not started yet');
                                                                //   // showDialog(
                                                                //   //     context: context,
                                                                //   //     builder: (_) => showPoPUp(
                                                                //   //         'Meeting not started yet',
                                                                //   //         Icon(
                                                                //   //           Icons.error,
                                                                //   //           size: 40,
                                                                //   //           color: ThemeConstants.bluecolor,
                                                                //   //         ),
                                                                //   //         context));
                                                                // }
                                                              },
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    width: 150,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/images/View Note.svg',
                                                                      color: ThemeConstants
                                                                          .bluecolor,
                                                                      // color: index == 5
                                                                      //     ? ThemeConstants.bluecolor
                                                                      //     : const Color.fromARGB(
                                                                      //         255, 31, 31, 31),
                                                                      width: 30,
                                                                    ),
                                                                    // child: Icon(
                                                                    //   Icons.add,
                                                                    //   size: 30,
                                                                    //   color: ThemeConstants.blackcolor,
                                                                    // )
                                                                  ),
                                                                  CustomAutoSizeTextMontserrat(
                                                                    text:
                                                                        'My Tasks',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    textColor:
                                                                        ThemeConstants
                                                                            .bluecolor,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              // context.push(
                                                              //     '${Routes.dashboard}/${Routes.viewDashboardNotes}');

                                                              await controllerBase
                                                                  .logOut();

                                                              context.go('/');

                                                              // Get.deleteAll();

                                                              // if (controller
                                                              //         .meetingStartedValue ==
                                                              //     true) {
                                                              //   context.push(
                                                              //       '${Routes.dashboard}/${Routes.meetingDetails}/${Routes.addMoreNotesView}/${meetingData.id}/0');
                                                              //   // Get.toNamed(AddMoreNotesView.routeName,
                                                              //   //     arguments: [meetingData.id, 0]);
                                                              // } else {
                                                              //   getToast(
                                                              //       'Meeting not started yet');
                                                              //   // showDialog(
                                                              //   //     context: context,
                                                              //   //     builder: (_) => showPoPUp(
                                                              //   //         'Meeting not started yet',
                                                              //   //         Icon(
                                                              //   //           Icons.error,
                                                              //   //           size: 40,
                                                              //   //           color: ThemeConstants.bluecolor,
                                                              //   //         ),
                                                              //   //         context));
                                                              // }
                                                            },
                                                            child: Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                  color: ThemeConstants
                                                                      .lightblueColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                      width:
                                                                          150,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .logout,
                                                                        size:
                                                                            30,
                                                                        color: ThemeConstants
                                                                            .bluecolor,
                                                                      )),
                                                                  CustomAutoSizeTextMontserrat(
                                                                    text:
                                                                        'Logout',
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    textColor:
                                                                        ThemeConstants
                                                                            .bluecolor,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      controller.showDeleteOption ==
                                                              true
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    // context.push(
                                                                    //     '${Routes.dashboard}/${Routes.viewDashboardNotes}');
                                                                    var res =
                                                                        await controller
                                                                            .deleteAccount();

                                                                    if (res ==
                                                                        true) {
                                                                      context.go(
                                                                          '/');
                                                                    }

                                                                    // Get.deleteAll();

                                                                    // if (controller
                                                                    //         .meetingStartedValue ==
                                                                    //     true) {
                                                                    //   context.push(
                                                                    //       '${Routes.dashboard}/${Routes.meetingDetails}/${Routes.addMoreNotesView}/${meetingData.id}/0');
                                                                    //   // Get.toNamed(AddMoreNotesView.routeName,
                                                                    //   //     arguments: [meetingData.id, 0]);
                                                                    // } else {
                                                                    //   getToast(
                                                                    //       'Meeting not started yet');
                                                                    //   // showDialog(
                                                                    //   //     context: context,
                                                                    //   //     builder: (_) => showPoPUp(
                                                                    //   //         'Meeting not started yet',
                                                                    //   //         Icon(
                                                                    //   //           Icons.error,
                                                                    //   //           size: 40,
                                                                    //   //           color: ThemeConstants.bluecolor,
                                                                    //   //         ),
                                                                    //   //         context));
                                                                    // }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 100,
                                                                    height: 100,
                                                                    decoration: BoxDecoration(
                                                                        color: ThemeConstants
                                                                            .lightblueColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                            padding: EdgeInsets.all(
                                                                                2),
                                                                            width:
                                                                                150,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: Icon(
                                                                              Icons.delete,
                                                                              size: 30,
                                                                              color: ThemeConstants.bluecolor,
                                                                            )),
                                                                        SizedBox(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              CustomAutoSizeTextMontserrat(
                                                                            align:
                                                                                TextAlign.center,
                                                                            text:
                                                                                'Delete\nProfile',
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            textColor:
                                                                                ThemeConstants.bluecolor,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : SizedBox.shrink(),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  // Scaffold.of(ctx).openDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  color: ThemeConstants.whitecolor,
                                  size: 30,
                                )),

                            // SizedBox(
                            //     width: 60,
                            //     height: 60,
                            //     child: Stack(
                            //       alignment: Alignment.center,
                            //       children: [
                            //         CircleAvatar(
                            //           backgroundColor: ThemeConstants.whitecolor,
                            //           radius: 35,
                            //         ),
                            //         CircleAvatar(
                            //           backgroundColor: ThemeConstants.bluecolor,
                            //           radius: 28.5,
                            //         ),
                            //         CircleAvatar(
                            //           backgroundColor: ThemeConstants.whitecolor,
                            //           radius: 25,
                            //           child: Icon(
                            //             Icons.person,
                            //             size: 35,
                            //             color: ThemeConstants.bluecolor,
                            //           ),
                            //         ),
                            //       ],
                            //     )),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            // InkWell(
                            //   onTap: () async {
                            //     controller.change(null,
                            //         status: RxStatus.loading());
                            //     var res = await controllerBase.logOut();

                            //     if (res) {
                            //       context.go('/');
                            //     }
                            //     controller.change(null,
                            //         status: RxStatus.success());
                            //   },
                            //   child: SizedBox(
                            //       width: 60,
                            //       height: 60,
                            //       child: Stack(
                            //         alignment: Alignment.center,
                            //         children: [
                            //           CircleAvatar(
                            //             backgroundColor:
                            //                 ThemeConstants.whitecolor,
                            //             radius: 35,
                            //           ),
                            //           CircleAvatar(
                            //             backgroundColor: ThemeConstants.bluecolor,
                            //             radius: 28.5,
                            //           ),
                            //           CircleAvatar(
                            //             backgroundColor:
                            //                 ThemeConstants.whitecolor,
                            //             radius: 25,
                            //             child: Icon(
                            //               Icons.logout,
                            //               size: 30,
                            //               color: ThemeConstants.bluecolor,
                            //             ),
                            //           ),
                            //         ],
                            //       )),
                            // ),
                            // SizedBox(
                            //   width: 5,
                            // ),

                            // InkWell(
                            //   onTap: () {
                            //     context.push(
                            //         '${Routes.dashboard}/${Routes.viewDashboardNotes}');
                            //     // Get.toNamed(DashboardNotesView.routenamed);
                            //   },
                            //   child: SizedBox(
                            //       width: 60,
                            //       height: 60,
                            //       child: Stack(
                            //         alignment: Alignment.center,
                            //         children: [
                            //           CircleAvatar(
                            //             backgroundColor:
                            //                 ThemeConstants.whitecolor,
                            //             radius: 35,
                            //           ),
                            //           CircleAvatar(
                            //             backgroundColor: ThemeConstants.bluecolor,
                            //             radius: 28.5,
                            //           ),
                            //           CircleAvatar(
                            //             backgroundColor:
                            //                 ThemeConstants.whitecolor,
                            //             radius: 25,
                            //             child: SvgPicture.asset(
                            //               'assets/images/note.svg',
                            //               width: 30,
                            //               color: ThemeConstants.bluecolor,
                            //               height: 30,
                            //             ),
                            //           ),
                            //         ],
                            //       )),
                            //   // Container(
                            //   //   width: 45,
                            //   //   padding: EdgeInsets.all(10),
                            //   //   decoration: BoxDecoration(
                            //   //       borderRadius: BorderRadius.circular(200),
                            //   //       border: Border.all(
                            //   //           width: 1.5, color: ThemeConstants.yellow),
                            //   //       color: ThemeConstants.lightYellow),
                            //   //   height: 45,
                            //   //   child: SvgPicture.asset('assets/images/note.svg'),
                            //   // ),
                            // ),
                            // InkWell(
                            //   onTap: () {
                            //     controllerBase.logOut();
                            //   },
                            //   child: Container(
                            //     width: 45,
                            //     padding: EdgeInsets.all(10),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(200),
                            //         border: Border.all(
                            //             width: 1.5,
                            //             color: ThemeConstants.bluecolor),
                            //         color: ThemeConstants.lightblueColor),
                            //     height: 45,
                            //     child: Icon(Icons.logout),
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 25, right: 25),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 5, left: 25, right: 25),
                    //   child: CustomAutoSizeTextMontserrat(
                    //     text: "Your Meetings",
                    //     fontSize: 30,
                    //     textColor: ThemeConstants.bluecolor,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // ChangeNotifierProvider<CalendarController>(
                    //   create: (_) => CalendarController(),
                    //   builder: (context, child) {
                    //     return
                    GetBuilder<CalendarController>(
                        init: Get.put(CalendarController()),
                        builder: (calendarController) {
                          if (calendarController.loading == true) {
                            return getLoading(context);
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 25, right: 25),
                              child: TableCalendar<Event>(
                                  selectedDayPredicate: (day) => isSameDay(
                                      calendarController.selectedDayGlobal,
                                      day),
                                  eventLoader:
                                      calendarController.getEventsForDay,
                                  daysOfWeekStyle: DaysOfWeekStyle(
                                    weekendStyle: TextStyle(
                                        color: ThemeConstants.whitecolor),
                                    weekdayStyle: TextStyle(
                                        color: ThemeConstants.whitecolor),
                                  ),
                                  calendarStyle: CalendarStyle(
                                      isTodayHighlighted: true,
                                      selectedDecoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        border: Border.all(
                                            width: 1,
                                            color: ThemeConstants.yellow),
                                      ),
                                      defaultDecoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                      weekendDecoration: BoxDecoration(
                                          color: ThemeConstants.whitecolor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      outsideDecoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      disabledDecoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      outsideDaysVisible: true,
                                      selectedTextStyle: TextStyle(
                                          color: ThemeConstants.whitecolor),
                                      outsideTextStyle:
                                          TextStyle(color: Colors.yellow),
                                      defaultTextStyle: TextStyle(
                                          color: ThemeConstants.whitecolor),
                                      weekendTextStyle: TextStyle(
                                          color: ThemeConstants.blackcolor),
                                      todayTextStyle: TextStyle(
                                          color: ThemeConstants.blackcolor),
                                      todayDecoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: ThemeConstants.yellow)),
                                  onTapHeaderCustomButton: () async {
                                    var result = await context.push(
                                        '/DashBoard/${Routes.createMeeting}');
                                    // print(
                                    //     '$result efdddeeeeeeeeeeeeee\f\e\ffefefeef');

                                    Get.find<DashBoardController>().onInit();
                                    calendarController.onInit();

                                    calendarController.selectedDayGlobal =
                                        DateTime.now();

                                    calendarController.update();
                                    setState(() {});

                                    // Get.to(CreateNewMeeting2());
                                    print('ddd');
                                  },
                                  headerStyle: HeaderStyle(
                                      headerPadding: EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 20),
                                      titleTextStyle: TextStyle(
                                          fontSize: 14,
                                          color: ThemeConstants.whitecolor),
                                      formatButtonVisible: false,
                                      leftChevronVisible: false,
                                      rightChevronVisible: false),
                                  calendarFormat: controller.calendarFormat,
                                  onDaySelected:
                                      calendarController.onDaySelected,
                                  onFormatChanged: (format) {
                                    if (controller.calendarFormat != format) {
                                      // Call `setState()` when updating calendar format

                                      controller.calendarFormat = format;
                                    }
                                    controller.update();
                                  },
                                  // calendarStyle: CalendarStyle(
                                  //   // Use `CalendarStyle` to customize the UI
                                  //   outsideDaysVisible: false,
                                  // ),
                                  onPageChanged:
                                      calendarController.onPageChanged,
                                  focusedDay:
                                      calendarController.focusedDayGlobal!,
                                  firstDay: DateTime(2017, 9, 10),
                                  lastDay: DateTime(2027, 9, 10)),
                            );
                          }
                        }),

                    // },
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Wrap(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       child: CustomTabWidget(
                    //         key: _childKey,
                    //         title0: "Upcoming",
                    //         title1: "Done",
                    //         callback: (val) => {
                    //           controller.indexOfTab = val,
                    //           print(val == 1),
                    //           if (val == 0)
                    //             {
                    //               print('dcdfrfvfvf'),
                    //               controller.showUpcomingList(),
                    //               controller.update()
                    //             }
                    //           else if (val == 1)
                    //             {
                    //               print('$val dcdcd'),
                    //               controller.showDoneList(),
                    //               controller.update()
                    //             }
                    //         },
                    //       ),
                    //     ),
                    //     // DropdownButton<String>(
                    //     //   // value: dropdownValue,
                    //     //   icon: const Icon(Icons.arrow_downward),
                    //     //   elevation: 16,
                    //     //   style: const TextStyle(color: Colors.deepPurple),
                    //     //   underline: Container(
                    //     //     height: 2,
                    //     //     color: Colors.deepPurpleAccent,
                    //     //   ),
                    //     //   onChanged: (String? value) {
                    //     //     // This is called when the user selects an item.
                    //     //     setState(() {
                    //     //       // dropdownValue = value!;
                    //     //     });
                    //     //   },
                    //     //   items: list.map<DropdownMenuItem<String>>(
                    //     //       (String value) {
                    //     //     return DropdownMenuItem<String>(
                    //     //       value: value,
                    //     //       child: Text(value),
                    //     //     );
                    //     //   }).toList(),
                    //     // ),
                    //     SizedBox(
                    //       width: 30,
                    //     ),

                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 8),
                    //       child: Obx(
                    //         () => DropdownButton2(
                    //           underline: Container(),
                    //           buttonStyleData: ButtonStyleData(
                    //               elevation: 0,
                    //               height: 40,
                    //               decoration: BoxDecoration(
                    //                   color: Colors.transparent,
                    //                   borderRadius: BorderRadius.circular(20),
                    //                   border: Border.all(
                    //                       width: 1,
                    //                       color: ThemeConstants.blackcolor))),
                    //           dropdownStyleData: DropdownStyleData(elevation: 1),
                    //           hint: Text(
                    //             '${controller.selectedFilter.value}',
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               color: Theme.of(context).hintColor,
                    //             ),
                    //           ),

                    //           items: list
                    //               .map((item) => DropdownMenuItem<String>(
                    //                     value: item,
                    //                     child: Text(
                    //                       item,
                    //                       style: const TextStyle(
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                   ))
                    //               .toList(),
                    //           value: controller.selectedFilter.value == null
                    //               ? selectedValue
                    //               : controller.selectedFilter.value,
                    //           onChanged: (value) {
                    //             // controller.frfr(value);

                    //             controller.selectedFilter.value =
                    //                 value.toString();

                    //             controller.changeInFilter();

                    //             controller.update();

                    //             // controller.showSpecificMeeting(value);
                    //           },
                    //           // buttonHeight: 40,
                    //           // buttonWidth: 140,
                    //           // itemHeight: 40,
                    //           // itemWidth: 140,
                    //         ),
                    //       ),
                    //     )

                    //     // CustomFilterSelector(
                    //     //   callBack: (val) {
                    //     //     // showDialog(
                    //     //     //     context: context,
                    //     //     //     builder: (_) => AlertDialog(
                    //     //     //           content: Container(
                    //     //     //             width: 40,
                    //     //     //             height: 40,
                    //     //     //             child: Text('dd'),
                    //     //     //           ),
                    //     //     //         ));
                    //     //     print(val);
                    //     //     setState(() {
                    //     //       showFilterList = val;
                    //     //     });
                    //     //   },
                    //     // ),
                    //   ],
                    // ),
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
                      // padding: EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeConstants.whitecolor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35))),
                        padding: const EdgeInsets.only(
                            top: 30, left: 25, right: 25, bottom: 30),
                        child: ListView(children: [
                          if (controller.loadingMeetingSection == false) ...[
                            ...controller.meetingsToShowInDashboardWidgetList
                          ] else ...[
                            CircularProgressIndicator(
                              color: ThemeConstants.bluecolor,
                            )
                          ]
                          // ...controller.singleMeetingDetails(context),
                        ]),
                      ),
                    ),

                    // SizedBox(
                    //   height: 10,
                    // )

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
        ),
        onLoading: getLoading(context),
      ),

      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   // isExtended: true,
      //   child: Icon(Icons.add),
      //   backgroundColor: ThemeConstants.bluecolor,
      //   onPressed: () {
      //     print('object');
      //     // ApiServices().addMeeting();
      //     // Get.toNamed(CreateNewMeeting.routeNamed);
      //     Get.to(CreateNewMeeting2());

      //     // Get.to(
      //     //   () => MeetingDetails(),
      //     // );
      //   },
      // ),
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

  // Future<void> _authenticate() async {
  //   bool authenticated = false;
  //   try {
  //     setState(() {
  //       _isAuthenticating = true;
  //       _authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticate(
  //       localizedReason: 'Let OS determine authentication method',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //       ),
  //     );
  //     setState(() {
  //       _isAuthenticating = false;
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = 'Error - ${e.message}';
  //     });
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   setState(() => _authorized = authenticated ? 'Authorized' : exit(0));
  // }
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
        context.push('MeetingDetails');
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
                                          ),
                                          ctx));
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
                                        ),
                                        ctx));
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
