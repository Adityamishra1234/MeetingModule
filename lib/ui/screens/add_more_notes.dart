import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeting_module2/data/data_sources.dart';
import 'package:meeting_module2/functions/uploadDoucment.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/presentation/constants/loading.dart';
import 'package:meeting_module2/ui/controller/add_more_notes_controller.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/idConstant.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_tab_widget.dart';
import 'package:meeting_module2/widget/custom_tab_widget_2.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';

class AddMoreNotesView extends StatefulWidget {
  static const routeName = 'addmorenotes';
  String meetingID;
  String tab;
  AddMoreNotesView({
    super.key,
    required this.tab,
    required this.meetingID,
  });

  @override
  State<AddMoreNotesView> createState() => _AddMoreNotesViewState();
}

class _AddMoreNotesViewState extends State<AddMoreNotesView> {
  bool _isTextFieldFocused = false;
  late final AppLifecycleListener _listener;
  // dynamic argumentData = Get.arguments;
  final _focusNode = FocusNode();
  final _keyFocusNode = FocusNode();

  var controller = Get.put(AddMoreNotesController());
  List<String> Notes = [
    "Add Notes",
    "Upload files",
  ];
  int current = 0;
  @override
  void initState() {
    print(widget.meetingID);
    SqfliteDBClass().initializedDB();
    super.initState();
    if (widget.tab == '0') {
      controller.addNotes = true;
    } else {
      controller.addNotes = false;
    }

    _focusNode.addListener(() {});
  }

  // TextEditingController fff = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 249, 255),
        body: controller.obx(
            (state) => SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                    gradient: ThemeConstants.backgroundGradient,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                        child:
                        Row(
                          children: [
                            InkWell(onTap: (){Navigator.pop(context);},
                                child: Icon(Icons.arrow_back, color: ThemeConstants.whitecolor,)),
                            const SizedBox(width: 25,),
                            Text("Add Notes & Files", style:
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
                        height: 30,
                      ),
                      SizedBox(height: 50,
                        child: ListView.builder(
                          itemCount: Notes.length,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return  GestureDetector(
                              onTap: (){
                                setState(() {
                                  current = index;
                                  if(current==0)
                                  if (Get.find<BaseController>()
                                                .selectedMeetingData
                                                .meetingStarted ==
                                            true) {
                                          controller.addNotes = true;
                                        }
                                  else {
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                      content: Container(
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.8,
                                                    child: CustomAutoSizeTextMontserrat(
                                                        text:
                                                            'Meeting not started yet'),
                                                  )));
                                        }
                                  else {
                                        controller.addNotes = false;
                                      }
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
                                    child: Text("${Notes[index]}", style: GoogleFonts.lato(
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

                        // CustomTabWidget2(
                        //   dontChangeTab: Get.find<BaseController>()
                        //               .selectedMeetingData
                        //               .meetingStarted ==
                        //           false
                        //       ? true
                        //       : null,
                        //   defaultIndex: int.parse(widget.tab),
                        //   title0: 'Add Notes',
                        //   title1: 'Add Files',
                        //   callback: (e) {
                        //     if (e == 0) {
                        //       if (Get.find<BaseController>()
                        //               .selectedMeetingData
                        //               .meetingStarted ==
                        //           true) {
                        //         controller.addNotes = true;
                        //       } else {
                        //         showDialog(
                        //             context: context,
                        //             builder: (_) => AlertDialog(
                        //                     content: Container(
                        //                   width: MediaQuery.of(context)
                        //                           .size
                        //                           .width *
                        //                       0.8,
                        //                   child: CustomAutoSizeTextMontserrat(
                        //                       text:
                        //                           'Meeting not started yet'),
                        //                 )));
                        //       }
                        //     } else {
                        //       controller.addNotes = false;
                        //     }
                        //     controller.update();
                        //   },
                        // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: ThemeConstants.whitecolor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.addNotes == true) ...[
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CustomAutoSizeTextMontserrat(
                                  text: "Add notes for: ",
                                  fontSize: 15,
                                  textColor: ThemeConstants.TextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomMultiDownSingle(
                                callbackFunctionSingle: (value) {
                                  controller.noteTypeSelectedID.value =
                                      getNoteTypeId(value);
                                  controller.noteTypeSelected.value =
                                      value;

                                  controller.update();
                                  print(getNoteTypeId(value));
                                },
                                model: const [
                                  "Meeting Notes",
                                  "Marketing Notes",
                                  "Observation",
                                  "Propose Changes",
                                  "Process",
                                  "Training Notes",
                                  "Requirements",
                                  "University Notes",
                                  "Offline Marketing Notes",
                                  "Confidential Notes"
                                ],
                                initialSelectedValue:
                                    "${controller.noteTypeSelected}",
                                enableMultiSelect: false,
                              ),

                              // CustomTextField(
                              //   hint: "",
                              //   controller: fff,
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: CustomAutoSizeTextMontserrat(
                                  text: "Notes accessibility to: ",
                                  fontSize: 15,
                                  textColor: ThemeConstants.TextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomMultiDownSingleAllUser(
                                  ////finx alll user model
                                  model: Get.find<BaseController>()
                                      .allSiecMembersList,
                                  initialSelectedValue:
                                      "Select Add notes for",
                                  enableMultiSelect: true,
                                  callbackFunctionMulti: (value) {
                                    controller.accessibileUserSelected
                                        .value = value;
                                  }),

                              // CustomTextField(
                              //   hint: "",
                              //   controller: fff,
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              // HtmlEditor(
                              //   controller: controller.noteText, //required
                              //   htmlEditorOptions: const HtmlEditorOptions(
                              //     shouldEnsureVisible: true,
                              //     autoAdjustHeight: true,
                              //     adjustHeightForKeyboard: false,
                              //     hint: "Your text here...",
                              //   ),
                              //   htmlToolbarOptions: const HtmlToolbarOptions(
                              //       toolbarType: ToolbarType.nativeGrid),

                              //   otherOptions: OtherOptions(
                              //     height: 400,
                              //   ),
                              // ),
                              SizedBox(height: 5),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                28, 0, 0, 0),
                                            blurRadius: 2,
                                            spreadRadius: 0.2)
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      color: ThemeConstants.whitecolor),
                                  child: quil.QuillProvider(
                                    configurations:
                                        quil.QuillConfigurations(
                                      controller: controller.noteText,
                                      sharedConfigurations: const quil
                                          .QuillSharedConfigurations(
                                        locale: Locale('de'),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        quil.QuillToolbar(
                                          configurations: quil
                                              .QuillToolbarConfigurations(
                                            // controller: noteText,
                                            showAlignmentButtons: true,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        KeyboardListener(
                                          focusNode: _keyFocusNode,
                                          onKeyEvent: (value) {
                                            print(value);
                                            print(
                                                'ddddddddddddddddddddddddddddddddd');
                                          },
                                          child: GestureDetector(
                                            onTap: () {
                                              _focusNode.requestFocus();
                                            },
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  minHeight: 200),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(10),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: ThemeConstants
                                                          .bluecolor)),
                                              child: quil.QuillEditor(
                                                configurations: quil
                                                    .QuillEditorConfigurations(
                                                  scrollable: false,
                                                  padding:
                                                      EdgeInsets.all(10),
                                                  expands: false,
                                                  readOnly: false,
                                                ),
                                                // autoFocus: false,

                                                focusNode: FocusNode(),

                                                scrollController:
                                                    ScrollController(),

                                                // true for view only mode
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),

                              // Padding(
                              //   padding: const EdgeInsets.only(top: 10),
                              //   child: SizedBox(
                              //     height: 185,
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         border: Border.all(
                              //             color: const Color(0xff1940b3)),
                              //       ),
                              //       child: SizedBox(
                              //         height: 200,
                              //         child: quil.QuillEditor(
                              //           padding: EdgeInsets.all(5),
                              //           expands: true,
                              //           controller: controller.noteText,
                              //           readOnly: false,
                              //           scrollController: ScrollController(),
                              //           scrollable: true,
                              //           focusNode: FocusNode(),
                              //           autoFocus:
                              //               false, // true for view only mode
                              //         ),
                              //         // TextField(
                              //         //   controller: controller.noteText.value,
                              //         //   decoration: const InputDecoration(
                              //         //       border: InputBorder.none,
                              //         //       contentPadding: EdgeInsets.all(10)),
                              //         //   keyboardType: TextInputType.multiline,
                              //         //   expands: true,
                              //         //   maxLines: null,
                              //         // ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),

                              if (controller.noteTypeSelectedID.value ==
                                  10) ...[
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: CustomTextField(
                                      backgroundCOlour:
                                          ThemeConstants.whitecolor,
                                      hint: 'Note Password',
                                      controller: controller
                                          .passwordController.value),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    var data = await controller.noteText
                                        .getPlainText();
                                    print(controller.noteText.document
                                        .toDelta()
                                        .toString());
                                    if (controller.noteTypeSelected ==
                                        "Notes Category") {
                                      getToast(
                                          SnackBarConstants.notestype!);
                                    } else if (controller
                                            .noteText.document
                                            .toDelta()
                                            .toString() ==
                                        "insert⟨ ⏎ ⟩") {
                                      getToast(SnackBarConstants
                                          .noteTextField!);
                                    } else {
                                      controller.encryptNote(controller
                                          .passwordController.value.text);
                                      // controller.saveAndNext(
                                      //     argumentData[0], controller.noteText);
                                    }
                                  },
                                  child: Container(
                                    // color: ThemeConstants.bluecolor,
                                    decoration: BoxDecoration(
                                        color: ThemeConstants.bluecolor,
                                        borderRadius:
                                            BorderRadius.circular(500)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    child: Text(
                                      'Encrypt Note',
                                      style: TextStyle(
                                          color:
                                              ThemeConstants.whitecolor),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15),
                                  child: CustomAutoSizeTextMontserrat(
                                    text: "Encrypted Note",
                                    fontSize: 30,
                                    textColor: ThemeConstants.bluecolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: double.infinity,
                                      constraints:
                                          BoxConstraints(minHeight: 150),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color(0xff1940b3),

                                        ),
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Text(
                                                '${controller.encryptedNote}'),
                                            // InkWell(
                                            //   onTap: () {},
                                            //   child: Container(
                                            //     width: double.infinity,
                                            //     alignment: Alignment.centerRight,
                                            //     child: Container(
                                            //       width: 120,
                                            //       // color: ThemeConstants.bluecolor,
                                            //       decoration: BoxDecoration(
                                            //           color: ThemeConstants.bluecolor,
                                            //           borderRadius: BorderRadius.circular(500)),
                                            //       padding: const EdgeInsets.symmetric(
                                            //           horizontal: 20, vertical: 12),
                                            //       child: Text(
                                            //         'Assign to',
                                            //         style: TextStyle(color: ThemeConstants.whitecolor),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                              SizedBox(
                                height: 10,
                              ),
                              // if (controller.noteTypeSelectedID.value != 10)
                              InkWell(
                                onTap: () async {
                                  var data = await controller.noteText
                                      .getPlainText();
                                  print(controller.noteText.document
                                      .toDelta()
                                      .toString());
                                  if (controller.noteTypeSelected ==
                                      "Notes Category") {
                                    getToast(
                                        SnackBarConstants.notestype!);
                                  } else if (controller.noteText.document
                                          .toDelta()
                                          .toString() ==
                                      "insert⟨ ⏎ ⟩") {
                                    getToast(
                                        SnackBarConstants.noteTextField!);
                                  } else {
                                    if (controller.noteTypeSelected ==
                                        'Confidential Notes') {
                                      controller.saveAndNext(
                                          int.parse(widget.meetingID),
                                          controller.noteText,
                                          true,
                                          context);
                                    } else {
                                      controller.saveAndNext(
                                          int.parse(widget.meetingID),
                                          controller.noteText,
                                          false,
                                          context);
                                    }
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 45,
                                  // color: ThemeConstants.bluecolor,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 0.5,
                                          blurRadius: 5,
                                          offset: const Offset(0, 4),
                                        )],
                                      gradient: ThemeConstants.backgroundGradient,
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'Save & Next',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                          color: ThemeConstants.whitecolor),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                                  child: CustomAutoSizeTextMontserrat(
                                    text: "Notes",
                                    fontSize: 20,
                                    textColor:  Color(0xff3088C6),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ...listOfNotes(controller.model)
                            ],

                            if (controller.addNotes == false) ...[
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: SizedBox(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.lightBlue.withOpacity(0.2),
                                          spreadRadius: 0.5,
                                          blurRadius: 5,
                                          offset: const Offset(0, 4),
                                        )],
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      // border: Border.all(
                                      //     color: const Color(0xff1940b3)
                                      // ),
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
                                      child: InkWell(
                                        onTap: () {
                                          ///todo
                                          controller
                                              .uploadDocument(context);
                                          // uploadDocument('2', 1);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(60),
                                          child: CircleAvatar(
                                            radius: 20,
                                            child: Icon(
                                                Icons.file_upload_rounded,
                                                color: ThemeConstants
                                                    .whitecolor,
                                                size: 25),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]

                            // Expanded(
                            //     child:
                            //
                            // ListView(
                            //   children: [
                            //     Container(
                            //       width: 500,
                            //       height: 1000,
                            //       color: Colors.amber,
                            //     ),
                            //     SizedBox(
                            //       height: 20,
                            //     ),
                            //     Container(
                            //       width: 500,
                            //       height: 1000,
                            //       color: Colors.amber,
                            //     )
                            //   ],
                            // ))
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            onLoading: getLoading(context)));
  }

  List<Widget> listOfNotes(RxList<FindNotesModel> models) {
    List<Widget> data = [];
    for (var i = 0; i < models.value.length; i++) {
      data.add(
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 150),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  )],
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: const Color(0xff1940b3)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HtmlWidget(
                      models[i].note!,
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Container(
                    //     width: double.infinity,
                    //     alignment: Alignment.centerRight,
                    //     child: Container(
                    //       width: 120,
                    //       // color: ThemeConstants.bluecolor,
                    //       decoration: BoxDecoration(
                    //           color: ThemeConstants.bluecolor,
                    //           borderRadius: BorderRadius.circular(500)),
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 20, vertical: 12),
                    //       child: Text(
                    //         'Assign to',
                    //         style: TextStyle(color: ThemeConstants.whitecolor),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ]),
            ),
          ),
        ),
      );
    }
    return data;
  }
}
