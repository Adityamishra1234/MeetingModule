
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:meeting_module2/models/allMeetingsModels.dart';
// import 'package:meeting_module2/services/apiServices.dart';
// import 'package:meeting_module2/services/endpoints.dart';
// import 'package:meeting_module2/ui/controller/base_controller.dart';
// import 'package:meeting_module2/utils/theme.dart';
// import 'package:meeting_module2/widget/calender/calendar_controller.dart';
// import 'package:meeting_module2/widget/custom_no_data_widget.dart';
// import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
// import 'package:meta/meta.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// part 'dashboard_event.dart';
// part 'dashboard_state.dart';

// class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
//   SharedPreferences sharedPreferences;
//   ApiServices api;
//   late BuildContext context;
//   DashboardBloc({required this.api, required this.sharedPreferences})
//       : super(DashboardInitial()) {
//     on<DashboardEvent>((event, emit) {});

//     on<DashboardIntitalEvent>(dashboardIntialEvent);
//   }

//   dashboardIntialEvent(
//       DashboardIntitalEvent event, Emitter<DashboardState> emit) async {
//     context = event.context;
//     await dashboardInitialLoginForUserDetails();
//     await getMeetingOfThatDate(DateTime.now());
//   }

//   List<Widget> meetingsToShowInDashboardWidgetList = [];
//   List<AllMeetings> allMeetingslist = [];
//   getMeetingOfThatDate(DateTime date) async {
//     // change(null, status: RxStatus.loading());
//     // RxStatus.loading();
//     // print('dddd');

//     // SharedPreferences prefs = await SharedPreferences.getInstance();

//     var id = await sharedPreferences.getInt('id');

//     var endpoint = await meetingsOfCalendarMeetingEndpoint(
//         id!, date.month, date.year, date.day);

//     // var res = await api.getAllMeetings(id!);

//     var res = await api.getMeetingOfDates(endpoint);

//     if (res.length != 0) {
//       meetingsToShowInDashboardWidgetList = [];
//       // var data = await json.decode(res);

//       allMeetingslist =
//           await List<AllMeetings>.from(res.map((x) => AllMeetings.fromJson(x)));

//       // RxList<AllMeetings> userID = <AllMeetings>[].obs;
//       showUpcomingList();
//     } else {
//       meetingsToShowInDashboardWidgetList = [];
//       meetingsToShowInDashboardWidgetList.add(CustomNoDataWidget(
//         text: 'No Meeting',
//       ));
//     }
//   }

//   bool loadingMeetingSection = false;
//   showUpcomingList() async {
//     loadingMeetingSection = true;

//     // await Future.delayed(Duration(seconds: 10));
//     // print('ddd');
//     var bool = await changeInFilter();

//     if (bool != null) {
//       loadingMeetingSection = false;
//     }
//   }

//   List<AllMeetings> listToShow = <AllMeetings>[];

//   changeInFilter() {
//     listToShow = allMeetingslist;
//     singleMeetingDetails(context);
//     // update();
//   }

//   // List<Widget> meetingsToShowInDashboardWidgetList = [];
//   singleMeetingDetails(BuildContext context) {
//     bool menu = false;
//     List<Widget> data = [];
//     for (var i = 0; i < listToShow.length; i++) {
//       data.add(InkWell(
//         onTap: () async {
//           Get.find<BaseController>().selectedMeeting(listToShow[i]);
//           // getNotes('${listToShow[i].id}', i);
//           // context.pushNamed('secondRoute');
//           String? val = await context.push('/MeetingDetails');
//           if (val == 'lol') {
//             getMeetingOfThatDate(
//                 Get.find<CalendarController>().selectedDayGlobal!);
//           }

//           // Get.to(MeetingDetails());
//         },
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 12),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                   colors: [
//                     Color.fromARGB(255, 255, 225, 150),
//                     Color.fromARGB(255, 255, 225, 150),
//                     Color.fromARGB(255, 255, 255, 255)
//                   ],
//                   stops: [0.00, 0.05, 0.05],
//                 ),
//                 border: Border.all(color: const Color(0xff1940b3)),
//                 borderRadius: BorderRadius.circular(15.0)),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 30, top: 0),
//               child: Stack(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width - 20,
//                         child: Wrap(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 12),
//                               child: SizedBox(
//                                 // width: 300,
//                                 child: CustomAutoSizeTextMontserrat(
//                                   text: "${listToShow[i].meetingAgenda}",
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 listToShow[i].meetingStarted! &&
//                                         !listToShow[i].meetingEnded!
//                                     ? Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Transform.scale(
//                                             scale: 0.8,
//                                             child: Radio(
//                                                 activeColor: Colors.green,
//                                                 value: true,
//                                                 groupValue: true,
//                                                 onChanged: (val) {}),
//                                           ),
//                                           CustomAutoSizeTextMontserrat(
//                                             fontSize: 12,
//                                             text: '(Started)',
//                                             textColor:
//                                                 ThemeConstants.GreenColor,
//                                           )
//                                         ],
//                                       )
//                                     : SizedBox.shrink(),
//                                 listToShow[i].meetingStarted! &&
//                                         listToShow[i].meetingEnded!
//                                     ? Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Transform.scale(
//                                             scale: 0.8,
//                                             child: Radio(
//                                                 activeColor: Colors.red,
//                                                 value: true,
//                                                 groupValue: true,
//                                                 onChanged: (val) {}),
//                                           ),
//                                           CustomAutoSizeTextMontserrat(
//                                             text: '(Ended)',
//                                             fontSize: 12,
//                                             textColor: Colors.red,
//                                           )
//                                         ],
//                                       )
//                                     : SizedBox.shrink(),
//                                 !listToShow[i].meetingStarted! &&
//                                         !listToShow[i].meetingEnded!
//                                     ? Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Transform.scale(
//                                             scale: 0.8,
//                                             child: Radio(
//                                                 activeColor:
//                                                     const Color.fromARGB(
//                                                         255, 114, 114, 114),
//                                                 value: true,
//                                                 groupValue: true,
//                                                 onChanged: (val) {}),
//                                           ),
//                                           CustomAutoSizeTextMontserrat(
//                                             text: 'Not Started',
//                                             fontSize: 14,
//                                             textColor: const Color.fromARGB(
//                                                 255, 114, 114, 114),
//                                           )
//                                         ],
//                                       )
//                                     : SizedBox.shrink()
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       CustomAutoSizeTextMontserrat(
//                         text: "${listToShow[i].nameOfTheMeeting}",
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         textColor: ThemeConstants.TextColor,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       CustomAutoSizeTextMontserrat(
//                         text: "${listToShow[i].meetingType}",
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         textColor: ThemeConstants.TextColor,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       CustomAutoSizeTextMontserrat(
//                         text: "${listToShow[i].dateOfMeeting}",
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         textColor: ThemeConstants.TextColor,
//                       ),
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 20),
//                             child: SizedBox(
//                               // color: Colors.amber,
//                               height: 50,
//                               width: 150,
//                               child: Stack(
//                                 //alignment:new Alignment(x, y)
//                                 children: [
//                                   // Expanded(
//                                   //     child: ListView.builder(
//                                   //         itemCount: itemcount(indexs),

//                                   //         itemBuilder: (context, index) {
//                                   //           return Positioned(
//                                   //             left: 25.0,
//                                   //             child: Container(
//                                   //               height: 36.0,
//                                   //               width: 36.0,
//                                   //               decoration: BoxDecoration(
//                                   //                 color: Color(0xFFFEF0F0),
//                                   //                 shape: BoxShape.circle,
//                                   //                 border: Border.all(
//                                   //                     color: Color(0xFFFF7171)),
//                                   //               ),
//                                   //               child: Center(
//                                   //                   child: CustomAutoSizeTextMontserrat(
//                                   //                       text:
//                                   //                           "${controller.listToShow[indexs].siecParticipants![index].name!.substring(0, 1)}")),
//                                   //             ),
//                                   //           );
//                                   //         })),
//                                   // Icon(Icons.monetization_on,
//                                   //     size: 36.0,
//                                   //     color: Color.fromRGBO(218, 165, 32, 1.0)),

//                                   ...getlist(i),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Spacer(),
//                           CustomButton(
//                               backgroundColor:
//                                   Color.fromARGB(255, 255, 225, 150),
//                               text: 'Reschedule',
//                               textColor: ThemeConstants.blackcolor,
//                               onPressed: () async {
//                                 late bool showTheStartEndOptions;
//                                 listToShow[i]
//                                     .meetingCoordinator!
//                                     .forEach((element) {
//                                   if (element.id ==
//                                           Get.find<BaseController>().id ||
//                                       listToShow[i].createdBy ==
//                                           Get.find<BaseController>().id) {
//                                     showTheStartEndOptions = true;
//                                   } else {
//                                     print('${element.id}dddddddd');
//                                     showTheStartEndOptions = false;
//                                   }
//                                 });
//                                 if (showTheStartEndOptions == true) {
//                                   if (listToShow[i].meetingStarted == false &&
//                                       listToShow[i].meetingEnded == false) {
//                                     showAnimatedDialog(
//                                         animationType: DialogTransitionType
//                                             .slideFromBottomFade,
//                                         curve: Curves.easeInOutQuart,
//                                         // barrierDismissible: false,
//                                         context: context,
//                                         builder: (ctx) =>
//                                             ResheduleMeetingDialogue(
//                                               controller: Get.find<
//                                                   DashBoardController>(),
//                                               indexz: i,
//                                               meetingData: listToShow[i],
//                                             ));
//                                   } else {
//                                     showAnimatedDialog(
//                                         barrierDismissible: true,
//                                         animationType: DialogTransitionType
//                                             .slideFromBottomFade,
//                                         curve: Curves.easeInOutQuart,
//                                         // barrierDismissible: false,
//                                         context: context,
//                                         builder: (ctx) => showPoPUp(
//                                             'Meeting already started',
//                                             Icon(
//                                               Icons.error,
//                                               size: 40,
//                                               color: ThemeConstants.bluecolor,
//                                             )));
//                                   }
//                                 } else {
//                                   showAnimatedDialog(
//                                       barrierDismissible: true,
//                                       animationType: DialogTransitionType
//                                           .slideFromBottomFade,
//                                       curve: Curves.easeInOutQuart,
//                                       // barrierDismissible: false,
//                                       context: context,
//                                       builder: (ctx) => showPoPUp(
//                                           "Only Co-ordinator's and creator can reshedule the meeting",
//                                           Icon(
//                                             Icons.error,
//                                             size: 40,
//                                             color: ThemeConstants.bluecolor,
//                                           )));
//                                 }
//                               }),
//                           // CustomButton(text: 'Delete', onPressed: () {})
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ));
//     }
//     meetingsToShowInDashboardWidgetList = data;
//     update();
//     change(null, status: RxStatus.success());
//     return data;
//   }

//   dashboardInitialLoginForUserDetails() async {
//     var email = await sharedPreferences.getString('email');
//     var password = await sharedPreferences.getString('password');

//     // var logout = await api.login(email: email, password: password!);

//     var login = await api.login(email: email!, password: password!);

//     // var data = json.decode(login);

//     user.value = UserModel.fromJson(login);

//     update();
//   }
// }
