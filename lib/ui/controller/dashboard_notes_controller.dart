import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeting_module2/models/dashboardNotesModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/screens/assign_to_view.dart';
import 'package:meeting_module2/ui/screens/assign_to_view_dasboard.dart';
import 'package:meeting_module2/utils/idConstant.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/custom_no_data_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:meeting_module2/widget/customtextfield.dart';
import 'package:meeting_module2/widget/decryption_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardNotesController extends GetxController with StateMixin {
  ApiServices apiServices = ApiServices();

  int id = 0;

  @override
  void onInit() async {
    // TODO: implement onInit

    await userID();
    await getNotesData();

    change(null, status: RxStatus.success());
    super.onInit();
  }

  List<Widget> notes = [];

  List<Map<String, List<Widget>>> viewNotes = [];

  List<Widget> toshow = [];
  var notesType = ['All Notes'];
  String selectedDropDown = 'All Notes';

  List<Widget> beta = [];

  List<FindNotesModel> data = [];
  getNotesData() async {
    var res = await apiServices.findNoteByUser(id);
    List<dynamic> data2 = res;

    data = await List<FindNotesModel>.from(
        data2.map((e) => FindNotesModel.fromJson(e)));

    print(data);

    if (data.length == 0) {
      toshow.add(CustomNoDataWidget(text: 'No Notes Available'));
      return;
    }

    for (var i = 0; i < data.length; i++) {
      print(data[i].noteType);

      if (data[i].image_note == null) {
        String note2 = await getNoteTypefromId(data[i].noteType!);
        notesType.add(note2);
      } else {
        data.remove(data[i]);
      }
    }

    notesType = notesType.toSet().toList();

    for (var i = 0; i < notesType.length; i++) {
      // String note2 = await getNoteTypefromId(data[i].noteType!);
      // notesType.add(note2);
      if (data.length > 0) {
        if (data[i].image_note == null) {
          viewNotes.add({notesType[i]: []});
        }
      }
    }

    print(notesType);

    // for (var i = 0; i < viewNotes.length; i++) {
    //   beta.addAll(viewNotes[i].entries.first.value);
    //   // documentlist.addAll(list[i].entries.first.value);
    // }
    showThisNotesList();
  }

  var decryptedNote = '';
  TextEditingController password = TextEditingController();
  showThisNotesList() {
    beta = [];
    for (var i = 0; i < data.length; i++) {
      if (selectedDropDown == 'All Notes') {
        beta.add(Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          // width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: HtmlWidget(
                    "${data[i].note}",
                    textStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: ThemeConstants.TextColor,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "${data[i].createdAt}",
                    textColor: ThemeConstants.TextColor,
                    fontSize: 12,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.to(AssignToView(), arguments: widget.dataList![i]);
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0))),
                        child: InkWell(
                          onTap: () {
                            Get.to(AssignToView2(), arguments: data[i]);
                          },
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
                  ),
                ),
              ],
            ),
          ),
        ));
      } else if (selectedDropDown == getNoteTypefromId(data[i].noteType!)) {
        beta.add(Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          // width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: HtmlWidget(
                    "${data[i].note}",
                    textStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: ThemeConstants.TextColor,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: CustomAutoSizeTextMontserrat(
                    text: "${data[i].createdAt}",
                    textColor: ThemeConstants.TextColor,
                    fontSize: 12,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Get.to(AssignToView(), arguments: widget.dataList![i]);
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0))),
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
                ),
                if (data[i].noteType == 10 && (id == 12 || id == 130)) ...[
                  InkWell(
                    onTap: () {
                      // Get.to(AssignToView(), arguments: widget.dataList![i]);
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
                          child: InkWell(
                            onTap: () {
                              var con = Get.context;
                              Get.to(PopUpForDecryption(
                                  encyrptedNote: data[i].note!));
                              // showAnimatedDialog(
                              //     animationType:
                              //         DialogTransitionType.slideFromBottomFade,
                              //     curve: Curves.easeInOutQuart,
                              //     context: con!,
                              //     builder: (_) => StatefulBuilder(
                              //         builder: (context,
                              //                 StateSetter setState) =>
                              //             AlertDialog(
                              //               content: Container(
                              //                   // height: 300,
                              //                   child: Column(
                              //                 mainAxisSize: MainAxisSize.min,
                              //                 children: [
                              //                   Text(data[i].note!),
                              //                   const SizedBox(
                              //                     height: 20,
                              //                   ),
                              //                   CustomTextField(
                              //                       hint: 'Enter Password',
                              //                       controller: password),
                              //                   const SizedBox(
                              //                     height: 20,
                              //                   ),
                              //                   InkWell(
                              //                     onTap: () async {
                              //                       // if (type == true) {
                              //                       //   await data(note, keyBaazi.text);
                              //                       //   keyBaazi.clear();
                              //                       // } else if (type == false) {

                              //                       // print(pass.text);
                              //                       decryptedNote =
                              //                           await getdecryptedNote(
                              //                               data[i].note,
                              //                               password.text);

                              //                       // print(datatoShow);
                              //                       // stateSetter(() {});
                              //                       // }
                              //                     },
                              //                     child: Container(
                              //                         decoration: BoxDecoration(
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(10),
                              //                           color:
                              //                               Colors.blue[300]!,
                              //                         ),
                              //                         width: 100,
                              //                         alignment:
                              //                             Alignment.center,
                              //                         padding:
                              //                             const EdgeInsets.all(
                              //                                 10),
                              //                         child: Text('Decrypt')),
                              //                   ),
                              //                   const SizedBox(
                              //                     height: 20,
                              //                   ),
                              //                   Container(
                              //                     decoration: BoxDecoration(
                              //                         border: Border.all(
                              //                           width: 1,
                              //                           color:
                              //                               Colors.deepOrange,
                              //                         ),
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 20)),
                              //                     width: double.infinity,
                              //                     height: 100,
                              //                     padding:
                              //                         const EdgeInsets.all(10),
                              //                     alignment: Alignment.center,
                              //                     child: Row(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment
                              //                               .spaceBetween,
                              //                       children: [
                              //                         const Text(
                              //                             'Decrypted Text:',
                              //                             style: TextStyle(
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .bold)),
                              //                         const SizedBox(
                              //                           width: 20,
                              //                         ),
                              //                         Container(
                              //                           child: Flexible(
                              //                             child: Text(
                              //                                 '$decryptedNote',
                              //                                 style: const TextStyle(
                              //                                     fontWeight:
                              //                                         FontWeight
                              //                                             .bold)),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   )
                              //                 ],
                              //               )),
                              //             )));

                              // // Get.to(AssignToView2(), arguments: data[i]);
                            },
                            child: Center(
                              child: CustomAutoSizeTextMontserrat(
                                text: "Decrypt",
                                textColor: ThemeConstants.whitecolor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ));
      }
    }

    toshow = [];
    toshow = beta;
    update();
  }

  var decryptedNoteData = '';
  getdecryptedNote(note, password) async {
    // var data = await noteText.document.toDelta();
    print(data);

    // var html = '';

    // var hello = await quillDeltaToHtml(data);
    var res = await apiServices.decryptNote(note, password);
    decryptedNoteData = res;
    update();
    return res;
  }

  userID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = await prefs.getInt('id')!;
    print(id);
  }
}
