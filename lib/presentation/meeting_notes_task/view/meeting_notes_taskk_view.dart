import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_module2/models/meeting_notes_task_model.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/presentation/meeting_notes_task/controller/meeting_notes_task_controller.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/meetingDetailController.dart';
import 'package:meeting_module2/utils/check_user_connection.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/custom_button.dart';

class MeetingNotesTaskView extends StatefulWidget {
  String id;
  MeetingNotesTaskView({super.key, required this.id});

  @override
  State<MeetingNotesTaskView> createState() => _MeetingNotesTaskViewState();
}

class _MeetingNotesTaskViewState extends State<MeetingNotesTaskView> {
  var controller = Get.put(MeetingNotesTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeConstants.lightVioletColor,
        body: controller.obx(
            (state) => SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: ThemeConstants.backgroundGradient),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 20, bottom: 20),
                            child: CustomAutoSizeTextMontserrat(
                              text: "Notes Task",
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              textColor: ThemeConstants.paleYellow,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    controller.selectedOpenOrClose = 0;
                                    await controller
                                        .getMeetingNotesTaskListForUser(
                                            Get.find<BaseController>()
                                                .id
                                                .toString());

                                    controller.update();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        border: Border.all(
                                            width: 1,
                                            color: controller
                                                        .selectedOpenOrClose ==
                                                    0
                                                ? ThemeConstants.paleYellow
                                                : ThemeConstants.whitecolor)),
                                    child: CustomAutoSizeTextMontserrat(
                                      text: 'Open',
                                      fontWeight: ThemeConstants.fontWeightBold,
                                      textColor:
                                          controller.selectedOpenOrClose == 0
                                              ? ThemeConstants.paleYellow
                                              : ThemeConstants.whitecolor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    controller.selectedOpenOrClose = 1;

                                    await controller
                                        .getMeetingNotesTaskListForUser(
                                            Get.find<BaseController>()
                                                .id
                                                .toString());

                                    controller.update();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        border: Border.all(
                                            width: 1,
                                            color: controller
                                                        .selectedOpenOrClose ==
                                                    1
                                                ? ThemeConstants.paleYellow
                                                : ThemeConstants.whitecolor)),
                                    child: CustomAutoSizeTextMontserrat(
                                      text: 'Close',
                                      fontWeight: ThemeConstants.fontWeightBold,
                                      textColor:
                                          controller.selectedOpenOrClose == 1
                                              ? ThemeConstants.paleYellow
                                              : ThemeConstants.whitecolor,
                                    ),
                                  ),
                                )
                              ],
                            ),
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
                                  top: 30, left: 25, right: 25),
                              child: controller.loading == false
                                  ? ListView.builder(
                                      itemCount: controller
                                          .meetingNotesTaskModelList.length,
                                      itemBuilder: (context, index) {
                                        return NotesTaskWidget(
                                            controller: controller,
                                            idToNameDataString: controller
                                                .meetingIdStringData[index],
                                            data: controller
                                                    .meetingNotesTaskModelList[
                                                index]);
                                      },
                                    )
                                  : getLoading(context),
                            ),
                          ),
                        ]),
                  ),
                ),
            onLoading: getLoading(context)));
  }
}

class NotesTaskWidget extends StatefulWidget {
  MeetingNotesTaskModel data;
  MeetingIdToStringData idToNameDataString;
  MeetingNotesTaskController controller;

  NotesTaskWidget(
      {super.key,
      required this.data,
      required this.idToNameDataString,
      required this.controller});

  @override
  State<NotesTaskWidget> createState() => _NotesTaskWidgetState();
}

class _NotesTaskWidgetState extends State<NotesTaskWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Get.find<BaseController>().selectedMeeting(listToShow);
        // getNotes('${listToShow[i].id}', i);
        // context.pushNamed('secondRoute');
        // var res = await context.push('/DashBoard/MeetingDetails');
        if (true) {
          // Get.find<CalendarController>().onInit();
          // Get.find<DashBoardController>().onInit();
        }

        // Get.to(MeetingDetails());
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
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
                stops: [0.00, 0.04, 0.04],
              ),
              border: Border.all(color: const Color(0xff1940b3)),
              borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 0, right: 10),
            child: Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.calendar_month,
                      //       color: ThemeConstants.TextColor,
                      //       size: 18,
                      //     ),
                      //     SizedBox(
                      //       width: 5,
                      //     ),
                      //     CustomAutoSizeTextMontserrat(
                      //       text: '${data.deadlineDate}',
                      //       fontSize: ThemeConstants.fontSizeMedium,
                      //       textColor: ThemeConstants.TextColor,
                      //     ),
                      //     Spacer(),
                      //     // MeetingStatus(listToShow: listToShow),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: ThemeConstants.TextColor,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomAutoSizeTextMontserrat(
                            text: 'Deadline: ',
                            fontSize: ThemeConstants.fontSizeSmall,
                            textColor: ThemeConstants.TextColor,
                            fontWeight: ThemeConstants.fontWeightBold,
                          ),
                          Spacer(),
                          // MeetingStat (listToShow: listToShow),
                          SizedBox(
                            width: 10,
                          ),
                          CustomAutoSizeTextMontserrat(
                            text: '${widget.data.deadlineDate}',
                            fontSize: ThemeConstants.fontSizeSmall,
                            textColor: ThemeConstants.TextColor,
                            fontWeight: ThemeConstants.fontWeightBold,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      Row(
                        children: [
                          // CustomAutoSizeTextMontserrat(
                          //   text: 'Meeting Name',
                          //   fontSize: ThemeConstants.fontSizeMedium,
                          //   textColor: ThemeConstants.TextColor,
                          // ),
                          // Spacer(),
                          // // MeetingStat (listToShow: listToShow),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          CustomAutoSizeTextMontserrat(
                            text: '${widget.data.taskType}',
                            fontSize: ThemeConstants.fontSizelarge,
                            textColor: ThemeConstants.TextColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Row(
                        children: [
                          // CustomAutoSizeTextMontserrat(
                          //   text: 'Meeting Name',
                          //   fontSize: ThemeConstants.fontSizeMedium,
                          //   textColor: ThemeConstants.TextColor,
                          // ),
                          // Spacer(),
                          // // MeetingStat (listToShow: listToShow),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          CustomAutoSizeTextMontserrat(
                            text:
                                '${widget.data.meetingName!.nameOfTheMeeting}',
                            fontSize: ThemeConstants.fontSizeMedium,
                            textColor: ThemeConstants.TextColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Row(
                        children: [
                          CustomAutoSizeTextMontserrat(
                            text: 'All Details',
                            fontSize: ThemeConstants.fontSizeMedium,
                            textColor: ThemeConstants.TextColor,
                          ),
                          Spacer(),
                          // MeetingStat (listToShow: listToShow),
                          SizedBox(
                            width: 10,
                          ),
                          if (widget.data.closedBy == 0)
                            InkWell(
                              onTap: () {
                                showAnimatedDialog(
                                  animationType:
                                      DialogTransitionType.slideFromBottomFade,
                                  curve: Curves.easeInOutQuart,
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      backgroundColor:
                                          ThemeConstants.whitecolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      content: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        // height: 200,
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CustomAutoSizeTextMontserrat(
                                                    text: 'Task Close',
                                                    textColor: ThemeConstants
                                                        .bluecolor,
                                                    fontSize: ThemeConstants
                                                        .fontSizelarge,
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        size: 20,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomAutoSizeTextMontserrat(
                                                  fontSize: ThemeConstants
                                                      .fontSizeMedium,
                                                  text:
                                                      'Did you attend the Meeting?'),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      context.pop();
                                                      await showAnimatedDialog(
                                                          animationType:
                                                              DialogTransitionType
                                                                  .slideFromBottomFade,
                                                          context: context,
                                                          builder: (_) =>
                                                              MeetingAttendedAddNoteTask(
                                                                taskID: widget
                                                                    .data.id!,
                                                                meetingId:
                                                                    widget.data
                                                                        .id!,
                                                              ));

                                                      widget.controller
                                                          .getMeetingNotesTaskListForUser(
                                                              Get.find<
                                                                      BaseController>()
                                                                  .id
                                                                  .toString());
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 20),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: ThemeConstants
                                                                  .bluecolor)),
                                                      child: CustomAutoSizeTextMontserrat(
                                                          fontWeight:
                                                              ThemeConstants
                                                                  .fontWeightThin,
                                                          fontSize:
                                                              ThemeConstants
                                                                  .fontSizeSmall,
                                                          text: 'Yes'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      context.pop();

                                                      await showAnimatedDialog(
                                                          animationType:
                                                              DialogTransitionType
                                                                  .slideFromBottomFade,
                                                          context: context,
                                                          builder: (_) =>
                                                              MeetingTaskNoClose(
                                                                taskId: widget
                                                                    .data.id!,
                                                                meetingId: widget
                                                                    .data
                                                                    .meetingId!,
                                                              ));

                                                      widget.controller
                                                          .getMeetingNotesTaskListForUser(
                                                              Get.find<
                                                                      BaseController>()
                                                                  .id
                                                                  .toString());
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 20),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: ThemeConstants
                                                                  .bluecolor)),
                                                      child: CustomAutoSizeTextMontserrat(
                                                          fontWeight:
                                                              ThemeConstants
                                                                  .fontWeightThin,
                                                          fontSize:
                                                              ThemeConstants
                                                                  .fontSizeSmall,
                                                          text: 'No'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ThemeConstants.bluecolor,
                                    borderRadius: BorderRadius.circular(200)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: CustomAutoSizeTextMontserrat(
                                    text: 'Close Task',
                                    fontWeight: ThemeConstants.fontWeightBold,
                                    textColor: ThemeConstants.whitecolor),
                              ),
                            ),
                          InkWell(
                            onTap: () {
                              isExpanded
                                  ? _controller.reverse(from: 0.5)
                                  : _controller.forward(from: 0.25);
                              isExpanded = !isExpanded;

                              setState(() {});
                            },
                            child: SizedBox(
                              width: 30,
                              child: RotationTransition(
                                  turns: Tween(begin: 1.25, end: 2.25)
                                      .animate(_controller),
                                  child: Icon(Icons.arrow_back)),
                            ),
                          ),
                        ],
                      ),

                      if (isExpanded == true) ...[
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Notes',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.data.notes}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Deadline',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.data.deadlineDate}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Owner',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.idToNameDataString.owner}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Created By',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.idToNameDataString.createdBy}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Created By',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.data.createdBy}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Created at',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.data.createdAt}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Closed By',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.data.closedBy}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Closed At',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.data.closedAt}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Due From',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            CustomAutoSizeTextMontserrat(
                              text: '${widget.data.closedAt}',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomAutoSizeTextMontserrat(
                              text: 'Time Taken',
                              fontSize: ThemeConstants.fontSizeMedium,
                              textColor: ThemeConstants.TextColor,
                            ),
                            Spacer(),
                            // MeetingStat (listToShow: listToShow),
                            SizedBox(
                              width: 10,
                            ),
                            // CustomAutoSizeTextMontserrat(
                            //   text: '${data}',
                            //   fontSize: ThemeConstants.fontSizeMedium,
                            //   textColor: ThemeConstants.TextColor,
                            // ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            // runAlignment: WrapAlignment.end,
                            // crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Wrap(children: [
                                  CustomAutoSizeTextMontserrat(
                                    text: "",
                                    fontWeight: FontWeight.w600,
                                    fontSize: ThemeConstants.fontSizeMedium,
                                  ),
                                ]),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),

                        // SizedBox(
                        //   height: 2,
                        // ),
                        // CustomAutoSizeTextMontserrat(
                        //   text: "",
                        //   fontSize: 13,
                        //   fontWeight: FontWeight.w600,
                        //   textColor: ThemeConstants.TextColor,
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // CustomAutoSizeTextMontserrat(
                        //   text: "${listToShow.meetingType}",
                        //   fontSize: 13,
                        //   fontWeight: FontWeight.w600,
                        //   textColor: ThemeConstants.TextColor,
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // CustomAutoSizeTextMontserrat(
                        //   text: "${listToShow.dateOfMeeting}",
                        //   fontSize: 13,
                        //   fontWeight: FontWeight.w600,
                        //   textColor: ThemeConstants.TextColor,
                        // ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 20),
                        //       child: SizedBox(
                        //         // color: Colors.amber,
                        //         height: 50,
                        //         width: 120,
                        //         child: Stack(
                        //           //alignment:new Alignment(x, y)
                        //           children: [
                        //             // Expanded(
                        //             //     child: ListView.builder(
                        //             //         itemCount: itemcount(indexs),

                        //             //         itemBuilder: (context, index) {
                        //             //           return Positioned(
                        //             //             left: 25.0,
                        //             //             child: Container(
                        //             //               height: 36.0,
                        //             //               width: 36.0,
                        //             //               decoration: BoxDecoration(
                        //             //                 color: Color(0xFFFEF0F0),
                        //             //                 shape: BoxShape.circle,
                        //             //                 border: Border.all(
                        //             //                     color: Color(0xFFFF7171)),
                        //             //               ),
                        //             //               child: Center(
                        //             //                   child: CustomAutoSizeTextMontserrat(
                        //             //                       text:
                        //             //                           "${controller.listToShow[indexs].siecParticipants![index].name!.substring(0, 1)}")),
                        //             //             ),
                        //             //           );
                        //             //         })),
                        //             // Icon(Icons.monetization_on,
                        //             //     size: 36.0,
                        //             //     color: Color.fromRGBO(218, 165, 32, 1.0)),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     // Spacer(),

                        //     // CustomButton(text: 'Delete', onPressed: () {})
                        //   ],
                        // )
                      ],

                      SizedBox(
                        height: 10,
                      )
                    ]),

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

class MeetingAttendedAddNoteTask extends StatelessWidget {
  final int meetingId;
  final int taskID;

  MeetingAttendedAddNoteTask(
      {super.key, required this.meetingId, required this.taskID});

  quil.QuillController noteText = quil.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CustomAutoSizeTextMontserrat(
                      textColor: ThemeConstants.bluecolor, text: "Add Note"),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 20,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(28, 0, 0, 0),
                          blurRadius: 2,
                          spreadRadius: 0.2)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: ThemeConstants.whitecolor),
                child: Column(
                  children: [
                    quil.QuillToolbar.basic(
                      controller: noteText,
                      showAlignmentButtons: true,
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        // _focusNode.requestFocus();
                      },
                      child: Container(
                        constraints: BoxConstraints(minHeight: 200),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1, color: ThemeConstants.bluecolor)),
                        child: quil.QuillEditor(
                          autoFocus: false,
                          padding: EdgeInsets.all(10),
                          expands: false,
                          focusNode: FocusNode(),
                          scrollable: false,
                          scrollController: ScrollController(),
                          controller: noteText,

                          readOnly: false, // true for view only mode
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  var data = await noteText.getPlainText();
                  print(noteText.document.toDelta().toString());

                  await Get.put<AddMoreNotesController>(
                          AddMoreNotesController())
                      .saveAndNext(meetingId, noteText, false, context);

                  await ApiServices().updateNoteTaskStatus(
                      id: taskID,
                      created_by: Get.find<BaseController>().id,
                      meeting_attended: true);

                  context.pop();
                  // controller.saveAndNext(int.parse(widget.meetingID),
                  //     controller.noteText, false, context);
                },
                child: Container(
                  // color: ThemeConstants.bluecolor,
                  decoration: BoxDecoration(
                      color: ThemeConstants.bluecolor,
                      borderRadius: BorderRadius.circular(500)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'Save & Next',
                    style: TextStyle(color: ThemeConstants.whitecolor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeetingTaskNoClose extends StatelessWidget {
  int taskId;
  int meetingId;
  MeetingTaskNoClose(
      {super.key, required this.taskId, required this.meetingId});

  TextEditingController reasonOfNotAttending = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAutoSizeTextMontserrat(
                      textColor: ThemeConstants.bluecolor,
                      text: "Reason of Not Attending"),
                  // InkWell(
                  //   onTap:
                  //       () {
                  //     context.pop();
                  //     // Get.back();
                  //   },
                  //   child:
                  //       CircleAvatar(
                  //     backgroundColor:
                  //         ThemeConstants.bluecolor,
                  //     radius:
                  //         10,
                  //     child:
                  //         Icon(
                  //       Icons.close,
                  //       size: 16,
                  //     ),
                  //   ),
                  // ),

                  Spacer(),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 20,
                      ))
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAutoSizeTextMontserrat(
                      textColor: ThemeConstants.bluecolor,
                      text: "Mark Attendance"),
                  // InkWell(
                  //   onTap:
                  //       () {
                  //     context.pop();
                  //     // Get.back();
                  //   },
                  //   child:
                  //       CircleAvatar(
                  //     backgroundColor:
                  //         ThemeConstants.bluecolor,
                  //     radius:
                  //         10,
                  //     child:
                  //         Icon(
                  //       Icons.close,
                  //       size: 16,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              InkWell(
                onTap: () {
                  // setState(() {
                  //   daata = 1;
                  // });
                },
                child: Row(
                  children: [
                    // Radio(
                    //     value: 1,
                    //     groupValue: daata,
                    //     onChanged: (val) async {
                    //       setState(() {
                    //         daata = val!;
                    //       });
                    //     }),
                    // CustomAutoSizeTextMontserrat(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //     text: "Present")
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  // setState(() {
                  //   daata = 2;
                  // });
                },
                child: Row(
                  children: [
                    // Radio(
                    //     value: 2,
                    //     groupValue: daata,
                    //     onChanged: (val) {
                    //       print(daata);
                    //       print(val);
                    //       setState(() {
                    //         daata = val!;
                    //       });

                    //       print(daata);
                    //       ;
                    //     }),
                    // CustomAutoSizeTextMontserrat(
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500,
                    //     text: "Absent")
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // if (daata ==
              //     2) ...[
              //   Container(
              //     width: double.infinity,
              //     alignment: Alignment.topLeft,
              //     child: CustomAutoSizeTextMontserrat(fontSize: 14, fontWeight: FontWeight.w500, text: 'Please Specify reason of absent'),
              //   ),
              //   SizedBox(
              //     height: 10,
              //   ),
              //   Form(
              //     key: _keyForReasonOfNotAttending,
              //     child: CustomTextField(validator: Validator.notEmpty, hint: 'Enter', controller: reasonOfNotAttending),
              //   )
              // ],
              //                                                             CustomButton(
              //                                                                 backgroundColor: ThemeConstants.bluecolor,
              //                                                                 text: 'Submit',
              //                                                                 onPressed: () {
              //                                                                   if (daata == 1) {
              //                                                                     controller.markAttendance(meetingData.id!);
              //                                                                   } else {
              //                                                                     if (_keyForReasonOfNotAttending.currentState!.validate()) {
              //                                                                       controller.reasonOfNotAttendance(meetingData.id!, reasonOfNotAttending.text);
              //                                                                       print('object');
              //                                                                     }
              //                                                                   }
              //                                                                 })
              // // InkWell(
              //   onTap: () {
              //     setState(() {
              //       daata = 1;
              //     });
              //   },
              //   child: Row(
              //     children: [
              //       Radio(
              //           value: 1,
              //           groupValue: daata,
              //           onChanged: (val) async {
              //             setState(() {
              //               daata = val!;
              //             });
              //           }),
              //       CustomAutoSizeTextMontserrat(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w500,
              //           text: "Present")
              //     ],
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       daata = 2;
              //     });
              //   },
              //   child: Row(
              //     children: [
              //       Radio(
              //           value: 2,
              //           groupValue: daata,
              //           onChanged: (val) {
              //             print(daata);
              //             print(val);
              //             setState(() {
              //               daata = val!;
              //             });

              //             print(daata);
              //             ;
              //           }),
              //       CustomAutoSizeTextMontserrat(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w500,
              //           text: "Absent")
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // if (daata == 2) ...[
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: CustomAutoSizeTextMontserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    text: 'Please Specify reason of absent'),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                // key: _keyForReasonOfNotAttending,
                child: CustomTextField(
                    validator: Validator.notEmpty,
                    hint: 'Enter',
                    controller: reasonOfNotAttending),
              ),
              CustomButton(
                  backgroundColor: ThemeConstants.bluecolor,
                  text: 'Submit',
                  onPressed: () async {
                    ApiServices api = ApiServices();

                    // reasonOfNotAttendance(meetingID, String text) async {
                    var res = await api.reasonOfNotAttending(
                        taskId,
                        meetingId,
                        Get.find<BaseController>().id,
                        reasonOfNotAttending.text);

                    await api.updateNoteTaskStatus(
                        id: taskId,
                        created_by: Get.find<BaseController>().id,
                        meeting_attended: false);
                    // }

                    // if (daata == 1) {
                    //   controller.markAttendance(meetingData.id!);
                    // } else {
                    //   if (_keyForReasonOfNotAttending.currentState!
                    //       .validate()) {
                    //     controller.reasonOfNotAttendance(
                    //         meetingData.id!, reasonOfNotAttending.text);
                    //     print('object');
                    //   }
                    // }
                  })
            ],
          )),
    );
  }
}

class MeetingTaskClose extends StatelessWidget {
  const MeetingTaskClose({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAutoSizeTextMontserrat(
                      textColor: ThemeConstants.bluecolor,
                      text: "Reason of Not Attending"),
                  // InkWell(
                  //   onTap:
                  //       () {
                  //     context.pop();
                  //     // Get.back();
                  //   },
                  //   child:
                  //       CircleAvatar(
                  //     backgroundColor:
                  //         ThemeConstants.bluecolor,
                  //     radius:
                  //         10,
                  //     child:
                  //         Icon(
                  //       Icons.close,
                  //       size: 16,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       daata = 1;
              //     });
              //   },
              //   child: Row(
              //     children: [
              //       Radio(
              //           value: 1,
              //           groupValue: daata,
              //           onChanged: (val) async {
              //             setState(() {
              //               daata = val!;
              //             });
              //           }),
              //       CustomAutoSizeTextMontserrat(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w500,
              //           text: "Present")
              //     ],
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       daata = 2;
              //     });
              //   },
              //   child: Row(
              //     children: [
              //       Radio(
              //           value: 2,
              //           groupValue: daata,
              //           onChanged: (val) {
              //             print(daata);
              //             print(val);
              //             setState(() {
              //               daata = val!;
              //             });

              //             print(daata);
              //             ;
              //           }),
              //       CustomAutoSizeTextMontserrat(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w500,
              //           text: "Absent")
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 5,
              // ),
              // if (daata == 2) ...[
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: CustomAutoSizeTextMontserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    text: 'Please Specify reason of absent'),
              ),
              SizedBox(
                height: 10,
              ),
              // Form(
              //   key: _keyForReasonOfNotAttending,
              //   child: CustomTextField(
              //       validator: Validator.notEmpty,
              //       hint: 'Enter',
              //       controller: reasonOfNotAttending),
              // )
            ],
            // CustomButton(
            //     backgroundColor: ThemeConstants.bluecolor,
            //     text: 'Submit',
            //     onPressed: () {
            //       if (daata == 1) {
            //         controller.markAttendance(meetingData.id!);
            //       } else {
            //         if (_keyForReasonOfNotAttending.currentState!
            //             .validate()) {
            //           controller.reasonOfNotAttendance(
            //               meetingData.id!, reasonOfNotAttending.text);
            //           print('object');
            //         }
            //       }
            //     })
          )),
    );
  }
}
