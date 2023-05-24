import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/assign_to_view.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/assignTo.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/text_underline.dart';

class ViewNotesDetails extends StatelessWidget {
  var controller = Get.find<DashBoardController>();

  static const routeNamed = '/ViewNotesDetails';
  @override
  Widget build(BuildContext context) {
    int meetingID = Get.arguments;
    controller.getNotes(meetingID.toString(), null);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: CustomTabWidget(
                      title0: "Viewnotes",
                      title1: "Reason of attending",
                      callback: (val) => val,
                    ),
                  ),
                  // TextUnderLine(
                  //   text1: "View",
                  //   text: "Notes",
                  //   textColor: ThemeConstants.firstColor,
                  //   underlinceColor: ThemeConstants.firstColor,
                  // ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  // TextUnderLine(
                  //   text1: "Reason",
                  //   text: " of Attending",
                  //   underlinceColor: Colors.transparent,
                  // ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                    itemCount: controller.notesList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 30,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: CustomAutoSizeTextMontserrat(
                                    text:
                                        "${controller.notesList[index].note}"),
                              ),
                              Align(
                                alignment: AlignmentDirectional.topStart,
                                child: CustomAutoSizeTextMontserrat(
                                  text:
                                      "${controller.notesList[index].createdBy}",
                                  textColor: ThemeConstants.TextColor,
                                  fontSize: 12,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(AssignToView());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: ThemeConstants.bluecolor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30.0))),
                                      child: Center(
                                        child: CustomAutoSizeTextMontserrat(
                                          text: "Assign to",
                                          textColor: ThemeConstants.whitecolor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
