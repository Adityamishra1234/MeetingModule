import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';

import '../../widget/customautosizetextmontserrat.dart';
import '../controller/base_controller.dart';

class ViewNotesDetails extends StatefulWidget {
  final String id;

  static const routeNamed = 'ViewNotesDetails';

  ViewNotesDetails({super.key, required this.id});

  @override
  State<ViewNotesDetails> createState() => _ViewNotesDetailsState();
}

class _ViewNotesDetailsState extends State<ViewNotesDetails> {
  var controller = Get.find<AddMoreNotesController>();

  List<String>viewNotes = [
    "All Notes",
    "Reasons for not Attending"
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.id);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        print('objectdeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        controller.viewNotesSection = 0;
      },
      child: Scaffold(
          body: controller.obx(
        (state) => Container(
          decoration: BoxDecoration(
            gradient: ThemeConstants.backgroundGradient,
          ),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70,),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                  child:
                  Row(
                    children: [
                      InkWell(onTap: (){Navigator.pop(context);},
                          child: Icon(Icons.arrow_back, color: ThemeConstants.whitecolor,)),
                      const SizedBox(width: 25,),
                      Text("View Notes", style:
                      GoogleFonts.adamina(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: ThemeConstants.paleYellow
                          )
                      ),),
                    ],
                  )
                // CustomAutoSizeTextMontserrat(
                //   text: "Add notes & files",
                //   fontSize: 35,
                //   textColor: ThemeConstants.paleYellow,
                //   fontWeight: FontWeight.w600,
                // ),
              ),
              SizedBox(
                height: 10,
              ),


              SizedBox(height: 50,
                child: ListView.builder(
                  itemCount: viewNotes.length,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return  GestureDetector(
                      onTap: (){
                        setState(() {
                          current = index;
                          controller.viewNotesSection = current;
                          controller.update();
                          //   },
                        });
                      },
                      child: AnimatedContainer(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        height: 55,
                        decoration: BoxDecoration(
                            border:  current  == index ? Border.all(color: Colors.transparent):Border.all(color: Colors.black12),
                            color: current == index? ThemeConstants.whitecolor: Color(0x50FFFFFF),
                            borderRadius: current == index ? BorderRadius.all(Radius.circular(10)):BorderRadius.all(Radius.circular(5),)
                        ),
                        duration: Duration(milliseconds: 200),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0, left: 18.0, top: 10, bottom: 10),
                          child: Center(
                            child: Text("${viewNotes[index]}", style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: current == index? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w600
                                )
                            ),),
                          ),
                        ),
                      ),
                    );
                  },),),
              // Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              //       child: CustomTabWidget(
              //         title0: "All notes",
              //         defaultIndex: 0,
              //         title1: "Reason of not attending",
              //         callback: (val) {
              //           controller.viewNotesSection = val;
              //           controller.update();
              //         },
              //       ),
              //     ),
              //     // TextUnderLine(
              //     //   text1: "View",
              //     //   text: "Notes",
              //     //   textColor: ThemeConstants.firstColor,
              //     //   underlinceColor: ThemeConstants.firstColor,
              //     // ),
              //     // const SizedBox(
              //     //   width: 20,
              //     // ),
              //     // TextUnderLine(
              //     //   text1: "Reason",
              //     //   text: " of Attending",
              //     //   underlinceColor: Colors.transparent,
              //     // ),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              // CustomMultiDownSingle(
              //     enableMultiSelect: false,
              //     callbackFunctionSingle: (val) {
              //       controller.meetingWith.value = val;

              //       controller.getRepresentativeDropDownData();
              //       // controller.inItGetRepresentative();
              //     },
              //     model: controller.meetingWithList,
              //     initialSelectedValue: '${controllers.meetingWith}'),
              // const SizedBox(
              //   height: 10,
              // ),
              // if (controller.viewNotesSection == 0 && controller.notesList.length > 0) ...[
              //   if (controller.selectedDropDown != "")
              //     Container(
              //       padding: EdgeInsets.only(left: 5),
              //       alignment: Alignment.centerLeft,
              //       child: DropdownButton2(
              //         underline: Container(),
              //         buttonStyleData: ButtonStyleData(
              //             elevation: 0,
              //             height: 40,
              //             decoration: BoxDecoration(
              //                 color: Colors.transparent,
              //                 borderRadius: BorderRadius.circular(8),
              //                 border: Border.all(
              //                     width: 1,
              //                     color: ThemeConstants.whitecolor))),
              //         dropdownStyleData: DropdownStyleData(elevation: 1),
              //         hint: Text(
              //           '${controller.selectedDropDown}',
              //           style: TextStyle(
              //             fontSize: 14,
              //             color: Theme.of(context).canvasColor,
              //           ),
              //         ),
              //
              //         items: controller.notesTypeToShowInDropDown
              //             .map((item) => DropdownMenuItem<String>(
              //                   value: item,
              //                   child: Text(
              //                     item,
              //                     style: const TextStyle(
              //                       fontSize: 14,
              //                     ),
              //                   ),
              //                 ))
              //             .toList(),
              //         // value: controller.selectedDropDown == null
              //         //     ?
              //         //     : controller.selectedFilter.value,
              //         onChanged: (value) {
              //           // controller.frfr(value);
              //
              //           controller.selectedDropDown = value.toString();
              //
              //           controller.showThisNote(context);
              //
              //           controller.update();
              //
              //           // controller.showSpecificMeeting(value);
              //         },
              //         // buttonHeight: 40,
              //         // buttonWidth: 140,
              //         // itemHeight: 40,
              //         // itemWidth: 140,
              //       ),
              //     ),
              // ],
              Expanded(
                child: Container(
                  // padding: EdgeInsets.symmetric(
                  //     vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: ThemeConstants.whitecolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: ListView(
                    children: [
                      if (controller.viewNotesSection == 0 && controller.notesList.length > 0) ...[
                        if (controller.selectedDropDown != "")
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                            alignment: Alignment.centerLeft,
                            child: DropdownButton2(
                              underline: Container(),
                              buttonStyleData: ButtonStyleData(
                                  elevation: 0,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 1,
                                          color: ThemeConstants.blackcolor))),
                              dropdownStyleData: DropdownStyleData(elevation: 1),
                              hint: Text(
                                '${controller.selectedDropDown}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),

                              items: controller.notesTypeToShowInDropDown
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
                              // value: controller.selectedDropDown == null
                              //     ?
                              //     : controller.selectedFilter.value,
                              onChanged: (value) {
                                // controller.frfr(value);

                                controller.selectedDropDown = value.toString();

                                controller.showThisNote(context);

                                controller.update();

                                // controller.showSpecificMeeting(value);
                              },
                              // buttonHeight: 40,
                              // buttonWidth: 140,
                              // itemHeight: 40,
                              // itemWidth: 140,
                            ),
                          ),
                      ],
                      SizedBox(height: 15,),
                      if (controller.viewNotesSection == 0) ...[
                        ...controller.documentlist,
                      ] else ...[
                        ...controller.reasonofNotAtteding
                      ]
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Meeting Notes',
                      //   dataList: controller.meetingNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Observation Notes',
                      //   dataList: controller.observationNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Propose Changes Notes',
                      //   dataList: controller.processNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Process Notes Notes',
                      //   dataList: controller.processNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Training Notes',
                      //   dataList: controller.traningNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Requirement Notes',
                      //   dataList: controller.requirementsNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'University Notes',
                      //   dataList: controller.universityNotesList,
                      // ),
                      // CustomExpansionPlanList(
                      //   text: "Meeting Notes",
                      //   titel: 'Offline Marketing Notes',
                      //   dataList: controller.offlineMarketingNotesList,
                      // ),
                    ],
                  ),
                ),
              ),

              // Expanded(
              //   child: ListView.separated(
              //       separatorBuilder: (context, index) => SizedBox(
              //             height: 20,
              //           ),
              //       itemCount: controller.notesList.length,
              //       itemBuilder: (context, index) {
              //         return Container(
              //           width: MediaQuery.of(context).size.width - 30,
              //           decoration: BoxDecoration(
              //               border: Border.all(),
              //               borderRadius: BorderRadius.circular(20.0)),
              //           child: Padding(
              //             padding: const EdgeInsets.all(12.0),
              //             child: Column(
              //               children: [
              //                 Align(
              //                   alignment: AlignmentDirectional.topStart,
              //                   child: CustomAutoSizeTextMontserrat(
              //                       text:
              //                           "${controller.notesList[index].note}"),
              //                 ),
              //                 Align(
              //                   alignment: AlignmentDirectional.topStart,
              //                   child: CustomAutoSizeTextMontserrat(
              //                     text:
              //                         "${controller.notesList[index].createdBy}",
              //                     textColor: ThemeConstants.TextColor,
              //                     fontSize: 12,
              //                   ),
              //                 ),
              //                 InkWell(
              //                   onTap: () {
              //                     Get.to(AssignToView());
              //                   },
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(top: 10),
              //                     child: Align(
              //                       alignment: AlignmentDirectional.topEnd,
              //                       child: Container(
              //                         height: 30,
              //                         width: 120,
              //                         decoration: BoxDecoration(
              //                             color: ThemeConstants.bluecolor,
              //                             borderRadius: const BorderRadius.all(
              //                                 Radius.circular(30.0))),
              //                         child: Center(
              //                           child: CustomAutoSizeTextMontserrat(
              //                             text: "Assign to",
              //                             textColor: ThemeConstants.whitecolor,
              //                             fontSize: 14,
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         );
              //       }),
              // )
            ],
          ),
        ),
      )),
    );
  }
}
