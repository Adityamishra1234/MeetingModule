import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
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
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropDown_allUsers.dart';
import 'package:meeting_module2/widget/dropdown_multi_select/custom_dropdown.dart';

class AddMoreNotesView extends StatefulWidget {
  static String routeName = '/addmorenotes';
  AddMoreNotesView({super.key});

  @override
  State<AddMoreNotesView> createState() => _AddMoreNotesViewState();
}

class _AddMoreNotesViewState extends State<AddMoreNotesView> {
  bool _isTextFieldFocused = false;
  dynamic argumentData = Get.arguments;
  final _focusNode = FocusNode();
  var controller = Get.put(AddMoreNotesController());
  @override
  void initState() {
    super.initState();
    if (argumentData[1] == 0) {
      controller.addNotes = true;
    } else {
      controller.addNotes = false;
    }
  }

  // TextEditingController fff = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 249, 255),
        body: controller.obx(
            (state) => SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: CustomAutoSizeTextMontserrat(
                                text: "Add more \nnotes & files",
                                fontSize: 40,
                                textColor: ThemeConstants.bluecolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            CustomTabWidget(
                              defaultIndex: argumentData[1],
                              title0: 'Add Notes',
                              title1: 'Add Files',
                              callback: (e) {
                                if (e == 0) {
                                  controller.addNotes = true;
                                } else {
                                  controller.addNotes = false;
                                }
                                controller.update();
                              },
                            ),

                            if (controller.addNotes == true) ...[
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: CustomAutoSizeTextMontserrat(
                                  text: "Add notes for:",
                                  fontSize: 12,
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
                                  controller.noteTypeSelected.value = value;

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
                                  text: "Notes accessibility to",
                                  fontSize: 12,
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
                                  initialSelectedValue: "Select Add notes for",
                                  enableMultiSelect: true,
                                  callbackFunctionMulti: (value) {
                                    controller.accessibileUserSelected.value =
                                        value;
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
                                          color: Color.fromARGB(28, 0, 0, 0),
                                          blurRadius: 2,
                                          spreadRadius: 0.2)
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: ThemeConstants.whitecolor),
                                child: Column(
                                  children: [
                                    quil.QuillToolbar.basic(
                                      controller: controller.noteText,
                                      showAlignmentButtons: true,
                                    ),
                                    SizedBox(height: 15),
                                    GestureDetector(
                                      onTap: () {
                                        _focusNode.requestFocus();
                                      },
                                      child: Container(
                                        constraints:
                                            BoxConstraints(minHeight: 200),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 1,
                                                color:
                                                    ThemeConstants.bluecolor)),
                                        child: quil.QuillEditor(
                                          autoFocus: false,
                                          padding: EdgeInsets.all(10),
                                          expands: false,
                                          focusNode: _focusNode,
                                          scrollable: false,
                                          scrollController: ScrollController(),
                                          controller: controller.noteText,

                                          readOnly:
                                              false, // true for view only mode
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

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
                                      controller:
                                          controller.passwordController.value),
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
                                        "Select Add notes for") {
                                      getToast(SnackBarConstants.notestype!);
                                    } else if (controller.noteText.document
                                            .toDelta()
                                            .toString() ==
                                        "insert⟨ ⏎ ⟩") {
                                      getToast(
                                          SnackBarConstants.noteTextField!);
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
                                          color: ThemeConstants.whitecolor),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
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
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color(0xff1940b3)),
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${controller.encryptedNote}'),
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
                                  var data =
                                      await controller.noteText.getPlainText();
                                  print(controller.noteText.document
                                      .toDelta()
                                      .toString());
                                  if (controller.noteTypeSelected ==
                                      "Select Add notes for") {
                                    getToast(SnackBarConstants.notestype!);
                                  } else if (controller.noteText.document
                                          .toDelta()
                                          .toString() ==
                                      "insert⟨ ⏎ ⟩") {
                                    getToast(SnackBarConstants.noteTextField!);
                                  } else {
                                    if (controller.noteTypeSelected ==
                                        'Confidential Notes') {
                                      controller.saveAndNext(argumentData[0],
                                          controller.noteText, true);
                                    } else {
                                      controller.saveAndNext(argumentData[0],
                                          controller.noteText, false);
                                    }
                                  }
                                },
                                child: Container(
                                  // color: ThemeConstants.bluecolor,
                                  decoration: BoxDecoration(
                                      color: ThemeConstants.bluecolor,
                                      borderRadius: BorderRadius.circular(500)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Text(
                                    'Save & Next',
                                    style: TextStyle(
                                        color: ThemeConstants.whitecolor),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: CustomAutoSizeTextMontserrat(
                                  text: "Notes",
                                  fontSize: 30,
                                  textColor: ThemeConstants.bluecolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ...listOfNotes(controller.model)
                            ],

                            if (controller.addNotes == false) ...[
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  height: 185,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xff1940b3)),
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.height,
                                      height: 200,
                                      child: InkWell(
                                        onTap: () {
                                          ///todo
                                          controller.uploadDocument();
                                          // uploadDocument('2', 1);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(60),
                                          child: CircleAvatar(
                                            radius: 20,
                                            child: Icon(
                                                Icons.file_upload_rounded,
                                                color:
                                                    ThemeConstants.blackcolor,
                                                size: 30),
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
                        )),
                  ),
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
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xff1940b3)),
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
