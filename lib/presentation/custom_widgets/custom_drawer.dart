import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/utils/routes/router_config.dart';

import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:nice_loading_button/nice_loading_button.dart';

class CustomDrawer extends StatelessWidget {
  int? index;
  CustomDrawer({Key? key, this.index}) : super(key: key);
  // var controller = Get.put(DrawerGetXController());
  var controller = Get.find<BaseController>();
  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width > 600;
    return Drawer(
      // elevation: 10,
      backgroundColor: Colors.white,
      // shadowColor: Color.fromARGB(255, 0, 0, 0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35))),

      width: 240,
      child: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.symmetric(
        //     vertical: MediaQuery.of(context).size.height * 0.005),
        // decoration: BoxDecoration(
        //     color: ThemeConstants.blackcolor,
        //     borderRadius: BorderRadius.only(
        //         topRight: Radius.circular(200),
        //         bottomRight: Radius.circular(200))),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     color: ThemeConstants.lightblueColor,
                //     borderRadius: BorderRadius.circular(20),
                //     border:
                //         Border.all(width: 0.5, color: ThemeConstants.bluecolor),
                //   ),
                //   width: double.infinity,
                //   margin:
                //       const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                //   padding: const EdgeInsets.all(10),
                //   height: 80,
                //   child: Row(children: [
                //     // CircleAvatar(
                //     //   onBackgroundImageError: (exception, stackTrace) {
                //     //     print(exception);
                //     //     print(stackTrace.toString());
                //     //   },
                //     //   // onForegroundImageError: (exception, stackTrace) {
                //     //   //   print(exception);
                //     //   //   print(stackTrace.toString());
                //     //   // },
                //     //   radius: 25.0,
                //     //   backgroundImage: const NetworkImage(
                //     //       "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                //     //   backgroundColor: Colors.transparent,
                //     // ),
                //     // const SizedBox(
                //     //   width: 15,
                //     // ),
                //     // if (controller.loadinValidatorDataForDashboard ==
                //     //     false) ...[
                //     //   SizedBox(
                //     //     height: 200,
                //     //     child: Column(
                //     //         mainAxisAlignment: MainAxisAlignment.center,
                //     //         crossAxisAlignment:
                //     //             CrossAxisAlignment.start,
                //     //         children: [
                //     //           CustomAutoSizeTextMontserrat(
                //     //             text:
                //     //                 "${firstLetterChaptial(Get.find<BaseController>().model1.enquiryName)}",
                //     //             fontSize: 14,
                //     //             fontWeight: FontWeight.w500,
                //     //           ),
                //     //           const SizedBox(
                //     //             height: 2.5,
                //     //           ),
                //     //           const SizedBox(
                //     //             height: 2.5,
                //     //           ),
                //     //           Stack(
                //     //             children: [
                //     //               Container(
                //     //                 decoration: BoxDecoration(
                //     //                     color: ThemeConstants
                //     //                         .lightgreycolor,
                //     //                     borderRadius:
                //     //                         BorderRadius.circular(20)),
                //     //                 width: 120,
                //     //                 height: 5,
                //     //               ),
                //     //               Container(
                //     //                 decoration: BoxDecoration(
                //     //                     color: const Color.fromARGB(
                //     //                         255, 16, 32, 255),
                //     //                     borderRadius:
                //     //                         BorderRadius.circular(20)),
                //     //                 width: controller.data.value
                //     //                         .totalPercentageComplete!
                //     //                         .toDouble() *
                //     //                     1.2,
                //     //                 height: 5,
                //     //               )
                //     //             ],
                //     //           ),
                //     //           const SizedBox(
                //     //             height: 5,
                //     //           ),
                //     //           Text(
                //     //             "${controller.data.value.totalPercentageComplete}% completed",
                //     //             style: TextStyle(
                //     //                 fontSize: 10,
                //     //                 fontWeight: FontWeight.w500,
                //     //                 color: ThemeConstants.TextColor),
                //     //           )
                //     //         ]),
                //     //   )
                //     // ] else ...[
                //     //   Spacer(),
                //     //   SizedBox(
                //     //     width: 30,
                //     //     height: 30,
                //     //     child: CircularProgressIndicator(
                //     //       color: ThemeConstants.bluecolor,
                //     //     ),
                //     //   ),
                //     //   Spacer(),
                //     // ]
                //   ]),
                // ),

                // Container(
                //   margin: EdgeInsets.all(10),
                //   padding: EdgeInsets.all(10),
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: ThemeConstants.lightblueColor,
                //     borderRadius: BorderRadius.circular(10.0),
                //     border: Border.all(
                //         color: ThemeConstants.bluecolor, width: 1),
                //   ),
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         onBackgroundImageError: (exception, stackTrace) {
                //           print(exception);
                //           print(stackTrace.toString());
                //         },
                //         // onForegroundImageError: (exception, stackTrace) {
                //         //   print(exception);
                //         //   print(stackTrace.toString());
                //         // },
                //         radius: 30.0,
                //         backgroundImage: const NetworkImage(
                //             "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250"),
                //         backgroundColor: Colors.transparent,
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Center(
                //   child: CustomAutoSizeTextMontserrat(
                //     text: firstLetterChaptial(
                //         Get.find<BaseController>().model1.enquiryName),
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   child: Stack(
                //     children: [
                //       Container(
                //         decoration: BoxDecoration(
                //             color: ThemeConstants.lightgreycolor,
                //             borderRadius: BorderRadius.circular(20)),
                //         width: 150,
                //         height: 6,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: ThemeConstants.GreenColor,
                //             borderRadius: BorderRadius.circular(20)),
                //         width: controller
                //                 .data.value.totalPercentageComplete!
                //                 .toDouble() *
                //             1.5,
                //         height: 4,
                //       ),
                //       Container(
                //         decoration: BoxDecoration(
                //             color: ThemeConstants.GreenColor,
                //             borderRadius: BorderRadius.circular(20)),
                //         width: controller
                //                 .data.value.totalPercentageComplete!
                //                 .toDouble() *
                //             1.5,
                //         height: 4,
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // Center(
                //   child: CustomAutoSizeTextMontserrat(
                //     text:
                //         "${controller.data.value.totalPercentageComplete}% Profile Completed",
                //     fontSize: 5,
                //   ),
                // ),
                // Center(
                //     child: Container(
                //   margin: const EdgeInsets.symmetric(vertical: 5),
                //   width: 200,
                //   height: 8,
                //   child: ClipRRect(
                //     borderRadius:
                //         const BorderRadius.all(Radius.circular(10)),
                //     child: LinearProgressIndicator(
                //       value: 0.7,
                //       valueColor:
                //           AlwaysStoppedAnimation(ThemeConstants.GreenColor),
                //       backgroundColor: const Color(0xffD6D6D6),
                //     ),
                //   ),
                // )),

                // Center(
                //   child: CustomAutoSizeTextMontserrat(
                //     text: "Profile: 70% complete",
                //     fontSize: 14,
                //     textColor: ThemeConstants.TextColor,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),

                SizedBox(
                  height: MediaQuery.sizeOf(context).height - 400,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: InkWell(
                                highlightColor: ThemeConstants.whitecolor,
                                onTap: () {
                                  context.push(
                                      '${Routes.dashboard}/${Routes.viewDashboardNotes}');
                                  // Get.deleteAll();
                                  // Get.toNamed(DashBoard.routeNamed);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: [
                                      // svgImage(
                                      //     "Dashboard",
                                      //     index == 0
                                      //         ? ThemeConstants.bluecolor
                                      //         : ThemeConstants.blackcolor,
                                      //     20,
                                      //     20),
                                      // SvgPicture.asset(
                                      //   'assets/icons/.svg',
                                      //   color:
                                      //   width: 20,
                                      // ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: CustomAutoSizeTextMontserrat(
                                            text: "My Notes",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            textColor: index == 0
                                                ? ThemeConstants.bluecolor
                                                : ThemeConstants.blackcolor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: InkWell(
                                highlightColor: ThemeConstants.whitecolor,
                                onTap: () {
                                  context.push(
                                      '${Routes.dashboard}/${Routes.viewDashboardNotes}');
                                  // Get.deleteAll();
                                  // Get.toNamed(DashBoard.routeNamed);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: [
                                      // svgImage(
                                      //     "Dashboard",
                                      //     index == 0
                                      //         ? ThemeConstants.bluecolor
                                      //         : ThemeConstants.blackcolor,
                                      //     20,
                                      //     20),
                                      // SvgPicture.asset(
                                      //   'assets/icons/.svg',
                                      //   color:
                                      //   width: 20,
                                      // ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 5),
                                          child: CustomAutoSizeTextMontserrat(
                                            text: "Task Section",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            textColor: index == 0
                                                ? ThemeConstants.bluecolor
                                                : ThemeConstants.blackcolor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 40),
                          child: Center(
                            child: LoadingButton(
                              height: 35,
                              borderRadius: 8,
                              animate: true,
                              color: ThemeConstants.bluecolor,
                              width: 120,
                              loader: Container(
                                padding: const EdgeInsets.all(10),
                                width: 30,
                                height: 30,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                              child: CustomAutoSizeTextMontserrat(
                                text: "Logout",
                                textColor: ThemeConstants.whitecolor,
                              ),
                              onTap: (startLoading, stopLoading,
                                  buttonState) async {
                                if (buttonState == ButtonState.idle) {
                                  startLoading();
                                  // Do something here
                                  var res =
                                      await Get.find<BaseController>().logOut();

                                  if (res) {
                                    context.go('/');
                                  }
                                  // await Get.find<BaseController>().logout();
                                  stopLoading();
                                }
                              },
                            ),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20),
                        //   child: Align(
                        //       alignment: AlignmentDirectional.topStart,
                        //       child: InkWell(
                        //         highlightColor: ThemeConstants.whitecolor,
                        //         onTap: () async {
                        //           // controller.change(null,
                        //           //     status: RxStatus.loading());
                        //           var res =
                        //               await Get.find<BaseController>().logOut();

                        //           if (res) {
                        //             context.go('/');
                        //           }
                        //           // controller.change(null,
                        //           //     status: RxStatus.success());
                        //           // context.
                        //           // Get.toNamed(DashBoard.routeNamed);
                        //         },
                        //         child: Padding(
                        //           padding: const EdgeInsets.only(right: 10),
                        //           child: Row(
                        //             children: [
                        //               // svgImage(
                        //               //     "Dashboard",
                        //               //     index == 0
                        //               //         ? ThemeConstants.bluecolor
                        //               //         : ThemeConstants.blackcolor,
                        //               //     20,
                        //               //     20),
                        //               // SvgPicture.asset(
                        //               //   'assets/icons/.svg',
                        //               //   color:
                        //               //   width: 20,
                        //               // ),
                        //               Container(
                        //                 height: 30,
                        //                 decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(10.0)),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.only(
                        //                       left: 10, top: 5),
                        //                   child: CustomAutoSizeTextMontserrat(
                        //                     text: "My Notes",
                        //                     fontSize: 15,
                        //                     fontWeight: FontWeight.w500,
                        //                     textColor: index == 0
                        //                         ? ThemeConstants.bluecolor
                        //                         : ThemeConstants.blackcolor,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       )),
                        // ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Align(
//                               alignment: AlignmentDirectional.topStart,
//                               child: InkWell(
//                                 highlightColor: ThemeConstants.whitecolor,
//                                 onTap: () {
//                                   Get.deleteAll();
//                                   // Get.toNamed(ProfileView.routeNamed);
//                                 },
//                                 child: Row(
//                                   children: [
//                                     // svgImage('track', ThemeConstants.IconColor, 20, 20),
//                                     svgImage(
//                                         "Profile",
//                                         index == 1
//                                             ? ThemeConstants.bluecolor
//                                             : const Color.fromARGB(
//                                                 255, 31, 31, 31),
//                                         20,
//                                         20),

// // SvgPicture.asset(
// //                                               'assets/icons/Profile.svg',
// //                                               color: index == 1
// //                                                   ? ThemeConstants.bluecolor
// //                                                   : const Color.fromARGB(
// //                                                       255, 31, 31, 31),
// //                                               width: 20,
// //                                             ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: Container(
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 10, top: 5),
//                                           child: CustomAutoSizeTextMontserrat(
//                                             text: "Profile",
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                             textColor: index == 1
//                                                 ? ThemeConstants.bluecolor
//                                                 : Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                         // if (Get.find<BaseController>()
//                         //         .meetingZoneStatus
//                         //         .trackApplication ==
//                         //     true)
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Align(
//                               alignment: AlignmentDirectional.topStart,
//                               child: InkWell(
//                                 highlightColor: ThemeConstants.whitecolor,
//                                 onTap: () {
//                                   Get.deleteAll();
//                                   // Get.toNamed(
//                                   //     ApplicationSummary.routeNamed);
//                                 },
//                                 child: Row(
//                                   children: [
//                                     svgImage(
//                                         "Track appli",
//                                         index == 2
//                                             ? ThemeConstants.bluecolor
//                                             : const Color.fromARGB(
//                                                 255, 31, 31, 31),
//                                         20,
//                                         20),
//                                     // SvgPicture.asset(
//                                     //   'assets/icons/Track appli.svg',
//                                     //   color: index == 2
//                                     //       ? ThemeConstants.bluecolor
//                                     //       : const Color.fromARGB(
//                                     //           255, 31, 31, 31),
//                                     //   width: 20,
//                                     // ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: Container(
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                             // color: index == 2
//                                             //     ? ThemeConstants.lightblueColor
//                                             //     : ThemeConstants.whitecolor,
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 10, top: 5),
//                                           child: CustomAutoSizeTextMontserrat(
//                                             text: "Track Application",
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                             textColor: index == 2
//                                                 ? ThemeConstants.bluecolor
//                                                 : ThemeConstants.blackcolor,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                         // if (Get.find<BaseController>()
//                         //         .meetingZoneStatus
//                         //         .searchCourse ==
//                         //     true)
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Align(
//                               alignment: AlignmentDirectional.topStart,
//                               child: InkWell(
//                                 highlightColor: ThemeConstants.whitecolor,
//                                 onTap: () {
//                                   Get.deleteAll();
//                                   // Get.toNamed(CourseSearch2.routeNamed);
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(right: 10),
//                                   child: Row(
//                                     children: [
//                                       svgImage(
//                                           "Course search",
//                                           index == 3
//                                               ? ThemeConstants.bluecolor
//                                               : const Color.fromARGB(
//                                                   255, 31, 31, 31),
//                                           20,
//                                           20),
//                                       // SvgPicture.asset(
//                                       //   'assets/icons/Course search.svg',
//                                       //   color: index == 3
//                                       //       ? ThemeConstants.bluecolor
//                                       //       : const Color.fromARGB(
//                                       //           255, 31, 31, 31),
//                                       //   width: 20,
//                                       // ),
//                                       Container(
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                             // color: index == 3
//                                             //     ? ThemeConstants.lightblueColor
//                                             //     : ThemeConstants.whitecolor,
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 10, top: 5),
//                                           child: CustomAutoSizeTextMontserrat(
//                                             text: "Search Course",
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 15,
//                                             textColor: index == 3
//                                                 ? ThemeConstants.bluecolor
//                                                 : ThemeConstants.blackcolor,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )),
//                         ),
//                         // if (Get.find<BaseController>()
//                         //         .meetingZoneStatus
//                         //         .searchCourse ==
//                         //     true)
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Align(
//                               alignment: AlignmentDirectional.topStart,
//                               child: InkWell(
//                                 highlightColor: ThemeConstants.whitecolor,
//                                 onTap: () {
//                                   Get.deleteAll();
//                                   // Get.toNamed(
//                                   //     ReviewShortList.routeNamed);
//                                 },
//                                 child: Row(
//                                   children: [
//                                     svgImage(
//                                         "Review Course",
//                                         index == 4
//                                             ? ThemeConstants.bluecolor
//                                             : const Color.fromARGB(
//                                                 255, 31, 31, 31),
//                                         20,
//                                         20),
//                                     // SvgPicture.asset(
//                                     //   'assets/icons/Review Course.svg',
//                                     //   color: index == 4
//                                     //       ? ThemeConstants.bluecolor
//                                     //       : const Color.fromARGB(
//                                     //           255, 31, 31, 31),
//                                     //   width: 20,
//                                     // ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: Container(
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                             // color: index == 4
//                                             //     ? ThemeConstants.lightblueColor
//                                             //     : ThemeConstants.whitecolor,
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 10, top: 5),
//                                           child: CustomAutoSizeTextMontserrat(
//                                             text: "Review Course",
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                             textColor: index == 4
//                                                 ? ThemeConstants.bluecolor
//                                                 : ThemeConstants.blackcolor,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                         ),
                        // if (Get.find<BaseController>()
                        //         .meetingZoneStatus
                        //         .searchCourse ==
                        //     true)
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20),
                        //   child: Align(
                        //       alignment: AlignmentDirectional.topStart,
                        //       child: InkWell(
                        //         highlightColor:
                        //             ThemeConstants.whitecolor,
                        //         onTap: () {
                        //           Get.deleteAll();
                        //           Get.toNamed(
                        //               FinalShortList.routeNamed);
                        //         },
                        //         child: Row(
                        //           children: [
                        //             svgImage(
                        //                 "Shortlist",
                        //                 index == 5
                        //                     ? ThemeConstants.bluecolor
                        //                     : const Color.fromARGB(
                        //                         255, 31, 31, 31),
                        //                 20,
                        //                 20),
                        //             // SvgPicture.asset(
                        //             //   'assets/icons/Shortlist.svg',
                        //             //   color: index == 5
                        //             //       ? ThemeConstants.bluecolor
                        //             //       : const Color.fromARGB(
                        //             //           255, 31, 31, 31),
                        //             //   width: 20,
                        //             // ),
                        //             Padding(
                        //               padding: const EdgeInsets.only(
                        //                   right: 10),
                        //               child: Container(
                        //                 height: 30,
                        //                 decoration: BoxDecoration(
                        //                     // color: index == 5
                        //                     //     ? ThemeConstants.lightblueColor
                        //                     //     : ThemeConstants.whitecolor,
                        //                     borderRadius:
                        //                         BorderRadius.circular(
                        //                             10.0)),
                        //                 child: Padding(
                        //                   padding:
                        //                       const EdgeInsets.only(
                        //                           left: 10, top: 5),
                        //                   child:
                        //                       CustomAutoSizeTextMontserrat(
                        //                     text:
                        //                         "Application Shortlist",
                        //                     fontSize: 15,
                        //                     fontWeight: FontWeight.w500,
                        //                     textColor: index == 5
                        //                         ? ThemeConstants
                        //                             .bluecolor
                        //                         : ThemeConstants
                        //                             .blackcolor,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20),
                        //   child: Align(
                        //       alignment: AlignmentDirectional.topStart,
                        //       child: InkWell(
                        //         highlightColor: ThemeConstants.whitecolor,
                        //         onTap: () {
                        //           Get.back();
                        //           // planYourFundDialog(context);
                        //         },
                        //         child: Row(
                        //           children: [
                        //             svgImage(
                        //                 "totalFees",
                        //                 index == 7
                        //                     ? ThemeConstants.bluecolor
                        //                     : const Color.fromARGB(
                        //                         255, 31, 31, 31),
                        //                 20,
                        //                 20),
                        //             // SvgPicture.asset(
                        //             //   'assets/icons/totalFees.svg',
                        //             //   color: index == 7
                        //             //       ? ThemeConstants.bluecolor
                        //             //       : const Color.fromARGB(
                        //             //           255, 31, 31, 31), index == 7
                        //             //       ? ThemeConstants.bluecolor
                        //             //       : const Color.fromARGB(
                        //             //           255, 31, 31, 31),
                        //             //   width: 20,
                        //             // ),
                        //             Padding(
                        //               padding: const EdgeInsets.only(right: 10),
                        //               child: Container(
                        //                 height: 30,
                        //                 decoration: BoxDecoration(
                        //                     // color: index == 5
                        //                     //     ? ThemeConstants.lightblueColor
                        //                     //     : ThemeConstants.whitecolor,
                        //                     borderRadius:
                        //                         BorderRadius.circular(10.0)),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.only(
                        //                       left: 10, top: 5),
                        //                   child: CustomAutoSizeTextMontserrat(
                        //                     text: "Plan your funds",
                        //                     fontSize: 15,
                        //                     fontWeight: FontWeight.w500,
                        //                     textColor: index == 7
                        //                         ? ThemeConstants.bluecolor
                        //                         : ThemeConstants.blackcolor,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )),
                        // ),
                        // if (controller
                        //             .meetingZoneStatus.markAttendance ==
                        //         true ||
                        //     controller.meetingZoneStatus.expressPass ==
                        //         true ||
                        //     controller.meetingZoneStatus
                        //             .expressPassGenerated ==
                        //         true)
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20),
                        //   child: Align(
                        //       alignment: AlignmentDirectional.topStart,
                        //       child: InkWell(
                        //         highlightColor: ThemeConstants.whitecolor,
                        //         onTap: () {
                        //           Get.back();
                        //           // eventZoneDrawerPopUp(
                        //           //     context,
                        //           //     Get.find<BaseController>()
                        //           //             .meetingZoneStatus
                        //           //             .markAttendance ??
                        //           //         false,
                        //           //     Get.find<BaseController>()
                        //           //             .meetingZoneStatus
                        //           //             .expressPass ??
                        //           //         false,
                        //           //     Get.find<BaseController>()
                        //           //             .meetingZoneStatus
                        //           //             .expressPassGenerated ??
                        //           //         false);
                        //         },
                        //         child: Row(
                        //           children: [
                        //             svgImage(
                        //                 "Calender icon",
                        //                 index == 8
                        //                     ? ThemeConstants.bluecolor
                        //                     : const Color.fromARGB(
                        //                         255, 31, 31, 31),
                        //                 20,
                        //                 20),
                        //             // SvgPicture.asset(
                        //             //   'assets/icons/Calender icon.svg',
                        //             //   color: index == 8
                        //             //       ? ThemeConstants.bluecolor
                        //             //       : const Color.fromARGB(
                        //             //           255, 31, 31, 31),
                        //             //   width: 20,
                        //             // ),
                        //             Padding(
                        //               padding: const EdgeInsets.only(right: 10),
                        //               child: Container(
                        //                 height: 30,
                        //                 decoration: BoxDecoration(
                        //                     // color: index == 8
                        //                     //     ? ThemeConstants.lightblueColor
                        //                     //     : ThemeConstants.whitecolor,
                        //                     borderRadius:
                        //                         BorderRadius.circular(10.0)),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.only(
                        //                       left: 10, top: 5),
                        //                   child: CustomAutoSizeTextMontserrat(
                        //                     text: "Event Zone",
                        //                     fontSize: 15,
                        //                     fontWeight: FontWeight.w500,
                        //                     textColor: index == 8
                        //                         ? ThemeConstants.bluecolor
                        //                         : ThemeConstants.blackcolor,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 5,
                        //             ),
                        //             Container(
                        //               decoration: BoxDecoration(
                        //                   color: ThemeConstants.red,
                        //                   borderRadius: const BorderRadius.all(
                        //                       Radius.circular(5.0))),
                        //               child: Padding(
                        //                 padding: const EdgeInsets.symmetric(
                        //                     horizontal: 5, vertical: 2),
                        //                 child: CustomAutoSizeTextMontserrat(
                        //                   text: "New",
                        //                   fontSize: 10,
                        //                   textColor: ThemeConstants.whitecolor,
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       )),
                        // ),
                        // // InkWell(
                        //   onTap: () {
                        //     Get.back();
                        //     planYourFundDialog(context);
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 20.0),
                        //     child: Row(
                        //       children: [
                        //         SvgPicture.asset(
                        //           'assets/icons/totalFees.svg',
                        //           color: index == 7
                        //               ? ThemeConstants.bluecolor
                        //               : const Color.fromARGB(
                        //                   255, 31, 31, 31),
                        //           width: 20,
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.only(
                        //               left: 10, top: 5),
                        //           child: CustomAutoSizeTextMontserrat(
                        //             text: "Plan your funds",
                        //             fontSize: 15,
                        //             fontWeight: FontWeight.w500,
                        //             textColor: index == 7
                        //                 ? ThemeConstants.bluecolor
                        //                 : ThemeConstants.blackcolor,
                        //           ),
                        //         ),
                        //         const Spacer(),
                        //         // const Icon(Icons.keyboard_arrow_down),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Get.back();
                        //     supportDialog(context);
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 20.0),
                        //     child: Row(
                        //       children: [
                        //         SvgPicture.asset(
                        //           'assets/icons/Calender icon.svg',
                        //           color: index == 6
                        //               ? ThemeConstants.bluecolor
                        //               : const Color.fromARGB(
                        //                   255, 31, 31, 31),
                        //           width: 20,
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.only(
                        //               left: 10, top: 5),
                        //           child: Row(
                        //             children: [
                        //               CustomAutoSizeTextMontserrat(
                        //                 text: "Event Zone",
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w500,
                        //               ),
                        //               const SizedBox(
                        //                 width: 10,
                        //               ),
                        //               Container(
                        //                 decoration: BoxDecoration(
                        //                     color: ThemeConstants.red,
                        //                     borderRadius:
                        //                         const BorderRadius.all(
                        //                             Radius.circular(
                        //                                 5.0))),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets
                        //                           .symmetric(
                        //                       horizontal: 5,
                        //                       vertical: 2),
                        //                   child:
                        //                       CustomAutoSizeTextMontserrat(
                        //                     text: "New",
                        //                     fontSize: 10,
                        //                     textColor: ThemeConstants
                        //                         .whitecolor,
                        //                   ),
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         ),

                        //         // const Icon(Icons.keyboard_arrow_down),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20),
                        //   child: Align(
                        //       alignment: AlignmentDirectional.topStart,
                        //       child: InkWell(
                        //         highlightColor: ThemeConstants.whitecolor,
                        //         onTap: () {
                        //           Get.deleteAll();
                        //           // Get.toNamed(
                        //           //     EventHistoryView.routeName);
                        //         },
                        //         child: Row(
                        //           children: [
                        //             svgImage(
                        //                 "Mark attendence",
                        //                 index == 9
                        //                     ? ThemeConstants.bluecolor
                        //                     : const Color.fromARGB(
                        //                         255, 31, 31, 31),
                        //                 20,
                        //                 20),
                        //             // SvgPicture.asset(
                        //             //   'assets/icons/Review Course.svg',
                        //             //   color: index == 4
                        //             //       ? ThemeConstants.bluecolor
                        //             //       : const Color.fromARGB(
                        //             //           255, 31, 31, 31),
                        //             //   width: 20,
                        //             // ),
                        //             Padding(
                        //               padding: const EdgeInsets.only(right: 10),
                        //               child: Container(
                        //                 height: 30,
                        //                 decoration: BoxDecoration(
                        //                     // color: index == 4
                        //                     //     ? ThemeConstants.lightblueColor
                        //                     //     : ThemeConstants.whitecolor,
                        //                     borderRadius:
                        //                         BorderRadius.circular(10.0)),
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.only(
                        //                       left: 10, top: 5),
                        //                   child: CustomAutoSizeTextMontserrat(
                        //                     text: "Event History",
                        //                     fontSize: 15,
                        //                     fontWeight: FontWeight.w500,
                        //                     textColor: index == 9
                        //                         ? ThemeConstants.bluecolor
                        //                         : ThemeConstants.blackcolor,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )),
                        // ),

                        // InkWell(
                        //   onTap: () {
                        //     Get.back();
                        //     // supportDialog(context);
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 20.0),
                        //     child: Row(
                        //       children: [
                        //         svgImage(
                        //             "Support",
                        //             index == 6
                        //                 ? ThemeConstants.bluecolor
                        //                 : const Color.fromARGB(255, 31, 31, 31),
                        //             20,
                        //             20),
                        //         // SvgPicture.asset(
                        //         //   'assets/icons/Support.svg',
                        //         //   color: index == 6
                        //         //       ? ThemeConstants.bluecolor
                        //         //       : const Color.fromARGB(
                        //         //           255, 31, 31, 31),
                        //         //   width: 20,
                        //         // ),
                        //         Padding(
                        //           padding:
                        //               const EdgeInsets.only(left: 10, top: 5),
                        //           child: CustomAutoSizeTextMontserrat(
                        //             text: "Gradlynk Support",
                        //             fontSize: 15,
                        //             fontWeight: FontWeight.w500,
                        //             textColor: index == 6
                        //                 ? ThemeConstants.bluecolor
                        //                 : ThemeConstants.blackcolor,
                        //           ),
                        //         ),
                        //         const Spacer(),
                        //         // const Icon(Icons.keyboard_arrow_down),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ]),
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: Align(
                //       alignment: AlignmentDirectional.topStart,
                //       child: InkWell(
                //         highlightColor: ThemeConstants.whitecolor,
                //         onTap: () {
                //           Get.deleteAll();
                //           Get.toNamed(VisaSummary.routeNamed);
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.only(right: 10),
                //           child: Container(
                //             height: 30,
                //             width: MediaQuery.of(context).size.width,
                //             decoration: BoxDecoration(
                //                 color: index == 6
                //                     ? ThemeConstants.lightblueColor
                //                     : ThemeConstants.whitecolor,
                //                 borderRadius: BorderRadius.circular(10.0)),
                //             child: Padding(
                //               padding:
                //                   const EdgeInsets.only(left: 10, top: 5),
                //               child: CustomAutoSizeTextMontserrat(
                //                 text: "My Visa",
                //                 textColor: index == 6
                //                     ? ThemeConstants.bluecolor
                //                     : ThemeConstants.blackcolor,
                //               ),
                //             ),
                //           ),
                //         ),
                //       )),
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: Align(
                //       alignment: AlignmentDirectional.topStart,
                //       child: InkWell(
                //         highlightColor: ThemeConstants.whitecolor,
                //         onTap: () {
                //           Get.deleteAll();
                //           Get.toNamed(StageProgress.routeNamed);
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.only(right: 10),
                //           child: Container(
                //             height: 30,
                //             width: MediaQuery.of(context).size.width,
                //             decoration: BoxDecoration(
                //                 color: index == 7
                //                     ? ThemeConstants.lightblueColor
                //                     : ThemeConstants.whitecolor,
                //                 borderRadius: BorderRadius.circular(10.0)),
                //             child: Padding(
                //               padding:
                //                   const EdgeInsets.only(left: 10, top: 5),
                //               child: CustomAutoSizeTextMontserrat(
                //                 text: "Processes",
                //                 textColor: index == 7
                //                     ? ThemeConstants.bluecolor
                //                     : ThemeConstants.blackcolor,
                //               ),
                //             ),
                //           ),
                //         ),
                //       )),
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: Align(
                //       alignment: AlignmentDirectional.topStart,
                //       child: InkWell(
                //         highlightColor: ThemeConstants.whitecolor,
                //         onTap: () {
                //           Get.deleteAll();
                //           Get.toNamed(CountryGuide.routeNamed);
                //         },
                //         child: Padding(
                //           padding: const EdgeInsets.only(right: 10),
                //           child: Container(
                //             height: 30,
                //             width: MediaQuery.of(context).size.width,
                //             decoration: BoxDecoration(
                //                 color: index == 8
                //                     ? ThemeConstants.lightblueColor
                //                     : ThemeConstants.whitecolor,
                //                 borderRadius: BorderRadius.circular(10.0)),
                //             child: Padding(
                //               padding:
                //                   const EdgeInsets.only(left: 10, top: 5),
                //               child: CustomAutoSizeTextMontserrat(
                //                 text: "Country Guide",
                //                 textColor: index == 8
                //                     ? ThemeConstants.bluecolor
                //                     : ThemeConstants.blackcolor,
                //               ),
                //             ),
                //           ),
                //         ),
                //       )),
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: Align(
                //       alignment: AlignmentDirectional.topStart,
                //       child: InkWell(
                //         highlightColor: ThemeConstants.whitecolor,
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.only(right: 10),
                //           child: Container(
                //             height: 30,
                //             width: MediaQuery.of(context).size.width,
                //             decoration: BoxDecoration(
                //                 color: index == 9
                //                     ? ThemeConstants.lightblueColor
                //                     : ThemeConstants.whitecolor,
                //                 borderRadius: BorderRadius.circular(10.0)),
                //             child: Padding(
                //               padding:
                //                   const EdgeInsets.only(left: 10, top: 5),
                //               child: CustomAutoSizeTextMontserrat(
                //                 text: "Pre Depature Kit",
                //                 textColor: index == 9
                //                     ? ThemeConstants.bluecolor
                //                     : ThemeConstants.blackcolor,
                //               ),
                //             ),
                //           ),
                //         ),
                //       )),
                // ),

                // const SizedBox(),
                // const SizedBox(),
                // const SizedBox(),

                // const SizedBox(),
                // SizedBox(
                //   width: 200,
                //   child: svgImage("navBottomImg",
                //       const Color.fromARGB(176, 158, 158, 158), 200, 200),

                //   //  SvgPicture.asset(
                //   //     'assets/icons/navBottomImg.svg',
                //   //     color: const Color.fromARGB(176, 158, 158, 158)),
                // ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
