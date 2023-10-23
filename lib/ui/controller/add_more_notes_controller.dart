import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeting_module2/extensions/siecMemberNamefromId.dart';
import 'package:meeting_module2/models/addRepresentative.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/commonUploadDocument.dart';
import 'package:meeting_module2/models/commonUploadStatus.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/models/findParticipantByIdModel.dart';
import 'package:meeting_module2/models/reasonOfAttendingAll.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';
import 'package:meeting_module2/ui/controller/dashboardController.dart';
import 'package:meeting_module2/ui/screens/assign_to_view.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/custom_doc_viewer.dart';
import 'package:meeting_module2/utils/custom_image_viewer.dart';
import 'package:meeting_module2/utils/idConstant.dart';
import 'package:meeting_module2/utils/routes/router_config.dart';
import 'package:meeting_module2/utils/theme.dart';
import 'package:meeting_module2/widget/customExpansionTile.dart';
import 'package:meeting_module2/widget/custom_no_data_widget.dart';
import 'package:meeting_module2/widget/customautosizetextmontserrat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class AddMoreNotesController extends GetxController with StateMixin {
  RxList<int> notesVisibleToList = <int>[5, 80, 77].obs;
  bool showLoading = false;
  bool addNotes = true;
  // Model

  int viewNotesSection = 0;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ApiServices api = ApiServices();
  RxList<FindNotesModel> model = <FindNotesModel>[].obs;

  quill.QuillController noteText = quill.QuillController.basic();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

// Text fields
  // Rx<TextEditingController> noteText = TextEditingController().obs;

  //Selcted dropdown fields
  RxString noteTypeSelected = "Notes Category".obs;
  RxInt noteTypeSelectedID = 0.obs;
  RxList<AllUserModel> accessibileUserSelected = RxList<AllUserModel>();

  //For meeting details page
  Rx<TextEditingController> noteText_meetingdetails =
      TextEditingController().obs;
  RxList<AllUserModel> accessibileUserSelected_meetingDetail =
      RxList<AllUserModel>();

  Rx<TextEditingController> passwordController = TextEditingController().obs;

  late bool meetingStartedValue;
  late bool meetingEndedValue;

  BaseController baseController = Get.find<BaseController>();

  int id = 0;
  @override
  void onInit() async {
    super.onInit();

    id = baseController.id;
    print('$id fffff');
    // await meetingId();

    await checkUserIsCordinator();
    await getMeetingParticipantsList();
    await getReasonOfNotAttedingsAll(baseController.selectedMeetingData.id!);
    // getMeetingCountryAndUniversity();
    // await showPublishButtonOrNot();
    meetingStartedValue = baseController.selectedMeetingData.meetingStarted!;
    meetingEndedValue = baseController.selectedMeetingData.meetingEnded!;
    change(null, status: RxStatus.success());
  }

  @override
  void onReady() async {
    change(null, status: RxStatus.loading());
    id = baseController.id;
    print('$id fffff');
    // await meetingId();

    await checkUserIsCordinator();
    await getMeetingParticipantsList();
    await getReasonOfNotAttedingsAll(baseController.selectedMeetingData.id!);
    // getMeetingCountryAndUniversity();
    // await showPublishButtonOrNot();
    meetingStartedValue = baseController.selectedMeetingData.meetingStarted!;
    meetingEndedValue = baseController.selectedMeetingData.meetingEnded!;

    change(null, status: RxStatus.success());
    // TODO: implement onReady
    super.onReady();
  }

  int meetingUniversityID = 0;
  var meetingCountryID = 0;

  // getMeetingCountryAndUniversity() async {
  //   if (baseController.selectedMeetingData.meetingWith == 'university') {
  //     var res = await api.findUniversityCountryByMeetingId(
  //         baseController.selectedMeetingData.id);

  //     meetingCountryID = res['country'];
  //     meetingUniversityID = res['university'];

  //     // print('${res} dddddd  ddd');
  //   }
  // }

  String nameFromid(id) {
    var data = Get.find<BaseController>().allSiecMembersList;
    var name = '';

    AllUserModel hu = data.where((element) => element.id == id).first;
    name = hu.name!;
    // data.where((element) {
    //   print(element);
    //   if (element.id == id) {
    //     name = element.name!;
    //   }
    // });

    return name;
  }

  showPublishButton() async {
    var res = await api.showPublishButtonOrNot(
        meetingId: baseController.selectedMeetingData.id!,
        userId: baseController.id);
    return res;
  }

  List<Widget> reasonofNotAtteding = [];
  getReasonOfNotAttedingsAll(int MeetingId) async {
    var res = await api.reasonOfNotAttendingAll(MeetingId);
    print(res);

    var data = List<ReasonOfNotAttendingModel>.from(
        res.map((e) => ReasonOfNotAttendingModel.fromJson(e))).toList();

    reasonofNotAtteding = [];

    String nameFromid(id) {
      var data = Get.find<BaseController>().allSiecMembersList;
      var name = '';

      AllUserModel hu = data.where((element) => element.id == id).first;
      name = hu.name!;
      // data.where((element) {
      //   print(element);
      //   if (element.id == id) {
      //     name = element.name!;
      //   }
      // });

      return name;
    }

    if (data.length == 0) {
      reasonofNotAtteding.add(
          CustomNoDataWidget(text: 'No Reason of Not attending Available'));

      return false;
    }

    for (var i = 0; i < data.length; i++) {
      var name = await nameFromid(data[i].createdBy);
      reasonofNotAtteding.add(Container(
        constraints: BoxConstraints(minHeight: 100),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: CustomAutoSizeTextMontserrat(
                  text: "${data[i].reasonOfNotAttended}",
                  fontSize: 14,
                  textColor: ThemeConstants.bluecolor,
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: CustomAutoSizeTextMontserrat(
                  text: "${name}",
                  textColor: ThemeConstants.TextColor,
                  fontSize: 14,
                ),
              ),

              // InkWell(
              //   onTap: () {
              //     // Get.to(AssignToView(), arguments: widget.dataList![i]);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 10),
              //     child: Align(
              //       alignment: AlignmentDirectional.topEnd,
              //       child: Container(
              //         height: 30,
              //         width: 120,
              //         decoration: BoxDecoration(
              //             color: ThemeConstants.bluecolor,
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(30.0))),
              //         child: Center(
              //           child: CustomAutoSizeTextMontserrat(
              //             text: "Assign to",
              //             textColor: ThemeConstants.whitecolor,
              //             fontSize: 14,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ));
    }
  }

  List<FindNotesModel> notesList = <FindNotesModel>[];
  List<Widget> documentlist = [];
  List notesTypeToShowInDropDown = [];
  String selectedDropDown = '';

  List<FindNotesModel> imageNotesList = <FindNotesModel>[];

  reasonOfNoteAttedning() {}

  getNotesOfMeeting(BuildContext context) async {
    documentlist = [];
    notesList = [];
    selectedDropDown = '';
    notesTypeToShowInDropDown = [];
    // getNotes(String id, int? index) async {
    // if (index != null) {
    //   selectedMeetingdata.value = listToShow[index];
    // }

    var selectedMeetingData = baseController.selectedMeetingData;

    var res = await api.findNotes(selectedMeetingData.id.toString());

    print('res');

    print(res.toString());

    // List<FindNotesModel> data = List<FindNotesModel>.from(
    //     json.decode(res).map((x) => FindNotesModel.fromJson(x)));
    if (res == null) {
      documentlist.add(CustomNoDataWidget(text: 'No Notes Available'));
      return;
    }

    var data =
        List<FindNotesModel>.from(res.map((x) => FindNotesModel.fromJson(x)));

    notesList = await data;

    if (notesList.length == 0) {
      documentlist.add(CustomNoDataWidget(text: 'No Notes Available'));
      return false;
    }

    List notesType = [];
    List notesTypeString = [];

    List<FindNotesModel> writtenNotes = [];

    for (var i = 0; i < notesList.length; i++) {
      if (notesList[i].image_note == null) {
        writtenNotes.add(notesList[i]);
        // notesType.add(notesList[i].noteType);
      } else {
        imageNotesList.add(notesList[i]);
      }
    }

    for (var i = 0; i < writtenNotes.length; i++) {
      var res = getNoteTypefromId(writtenNotes[i].noteType!);
      notesTypeString.add(res);
    }

    notesTypeString = notesTypeString.toSet().toList();

    // for (var i = 0; i < notesType.length; i++) {
    //   for (var j = 0; j < notesList.length; j++) {
    //     if (notesList[j].image_note == null) {
    //       var res = getNoteTypefromId(notesType[i]);
    //       notesTypeString.add(res);
    //     } else {
    //       imageNotesList.add(notesList[j]);
    //     }
    //   }
    //   // if (notesList[i].image_note == null) {
    //   //   var res = getNoteTypefromId(notesType[i]);
    //   //   notesTypeString.add(res);
    //   // }

    //   // var data1 = res.toString().split(' ')[0];
    //   // var data2 = res.toString().split(' ')[1] == null
    //   //     ? ''
    //   //     : res.toString().split(' ')[1];
    //   // print(data1 + data2);

    //   // print(temp);
    // }

    notesTypeToShowInDropDown.addAll(notesTypeString);
    // print(notesTypeToShowInDropDown);

    List<Map<String, List<FindNotesModel>>> list = [];
    for (var i = 0; i < notesTypeString.length; i++) {
      list.add({notesTypeString[i]: []});
    }

    if (notesTypeString.length > 0) {
      selectedDropDown = notesTypeString[0];
    }
    showThisNote(context);

    // for (var i = 0; i < notesList.length; i++) {
    //   for (var j = 0; j < notesTypeString.length; j++) {
    //     if (list[j].entries.first.key ==
    //         getNoteTypefromId(notesList[i].noteType!)) {
    //       list[j].entries.first.value.add(notesList[i]);
    //     }
    //   }

    //   // if(  notesList[i].noteType )
    //   // list.add({[]: })
    // }

    // List<Widget> beta = [];
    // for (var i = 0; i < list.length; i++) {
    //   beta.add(CustomExpansionPlanList(
    //     titel: list[i].keys.first,
    //     dataList: list[i].values.first,
    //   ));
    //   // documentlist.addAll(list[i].entries.first.value);
    // }
    // documentlist = [];
    // documentlist = beta;
    // print(documentlist.length);

    update();

    // dataBaazi = list;

    ///todo
    // await notesList.value.where((e) {
    //   if (e.noteType == 1) {
    //     meetingNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 2) {
    //     observationNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 3) {
    //     proposeChangesNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 4) {
    //     processNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 5) {
    //     traningNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 6) {
    //     requirementsNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 7) {
    //     universityNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // await notesList.value.where((e) {
    //   if (e.noteType == 8) {
    //     offlineMarketingNotesList.add(e);
    //   }
    //   return false;
    // }).toList();

    // proposeChangesNotesList =
    //     await notesList.value.where((e) => e.noteType == 3).toList();
    // processNotesList =
    //     await notesList.value.where((e) => e.noteType == 4).toList();

    // traningNotesList =
    //     await notesList.value.where((e) => e.noteType == 5).toList();
    // requirementsNotesList =
    //     await notesList.value.where((e) => e.noteType == 6).toList();

    // universityNotesList =
    //     await notesList.value.where((e) => e.noteType == 7).toList();

    // offlineMarketingNotesList =
    //     await notesList.value.where((e) => e.noteType == 8).toList();
  }

  Future<bool> showPublish(FindNotesModel note) async {
    var noteType = getNoteTypefromId(note.noteType!);
    if (noteType == 'Training Notes' &&
        baseController.selectedMeetingData.meetingType == 'External Meeting') {
      var res = await showPublishButton();
      if (res == true) {
        return true;
      } else {
        return false;
      }

      // switch (id) {
      //   case :

      //     break;
      //   default:
      // }
    } else {
      return false;
    }
  }

  showThisNote(BuildContext context) async {
    print('daaa');
    List<Widget> beta = [];
    for (var i = 0; i < notesList.length; i++) {
      bool showPublishorNot = await showPublish(notesList[i]);
      if (selectedDropDown == getNoteTypefromId(notesList[i].noteType!)) {
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
                    "${notesList[i].note}",
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
                    text: "${notesList[i].createdAt}",
                    textColor: ThemeConstants.TextColor,
                    fontSize: 12,
                  ),
                ),
                Visibility(
                  visible: showPublishorNot,
                  // visible:   true,
                  child: InkWell(
                    onTap: () {
                      publishNote(notesList[i]);
                      // Get.to( )
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
                              color: ThemeConstants.GreenColor,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(30.0))),
                          child: Center(
                            child: CustomAutoSizeTextMontserrat(
                              text: "Publish",
                              textColor: ThemeConstants.whitecolor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print(context);

                    context.push('${Routes.assignViewMeetings}',
                        extra: notesList[i]);
                    // Get.to(AssignToView(), arguments: notesList![i]);
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
              ],
            ),
          ),
        ));
      }
    }
    documentlist = [];
    documentlist = beta;
  }

  addNote(int meetingID) async {
    // print(noteText.value.text);
    // model.value.note = await noteText.value.text;

    // model.value.noteType = await noteType.value;
    // model.value.visibleTo = await notesVisibleToList.toString();

    // // print(model.value);

    // // var res = await api.addNotes(meetingID, noteType.value, noteText.value.text,
    // //     "ddd", notesVisibleToList.value);

    // var res = await api.addNotes(model.value);
  }

  var encryptedNote = '';
  encryptNote(password) async {
    var data = await noteText.document.toDelta();
    print(data);

    // var html = '';

    var hello = await quillDeltaToHtml(data);
    var res = await api.encryptNote(hello, password);
    encryptedNote = res;
    update();
  }

  saveAndNext(int metingID, quill.QuillController contro, bool encrypted,
      BuildContext context) async {
    print(metingID);
    change(null, status: RxStatus.loading());
    List<AllUserModel> visibleTo = [];

    // var data = await noteText.getText();

    var data = await contro.document.toDelta();
    print(data);

    // var html = '';

    var hello = await quillDeltaToHtml(data);
    print(hello);
    for (var element in accessibileUserSelected) {
      visibleTo.add(element);
    }
    FindNotesModel noteModel = FindNotesModel(
        meetingId: metingID,
        noteType: noteTypeSelectedID.value,
        visibleTo: visibleTo,
        note: hello,
        isActive: true,
        isAdded: true,
        createdBy: baseController.id,
        updatedBy: baseController.id);

    if (encrypted == true) {
      noteModel.note = encryptedNote;
    }

    var res = await api.addNotes(noteModel);
    if (res != null) {
      model.value.add(noteModel);
      model;
      model.refresh();
      noteTypeSelected = "Select Add notes for".obs;

      noteText.clear();

      noteTypeSelectedID = 0.obs;
      accessibileUserSelected = RxList<AllUserModel>();

      // change(null, status: RxStatus.success());
    }

    await getNotesOfMeeting(context);

    update();
    change(null, status: RxStatus.success());
  }

  quillDeltaToHtml(quill.Delta delta) async {
    var data = delta.toJson();

    List<Map<String, dynamic>> data2 = [];
    data2 = await data.map((item) {
      if (item is Map) {
        return item as Map<String, dynamic>;
      } else {
        return {"value": item};
      }
    }).toList();

    print(data2);
    var ddata = [
      {'insert': 'Hello\n'},
      {
        'insert': 'This is colorful',
        'attributes': {'color': '#f00'}
      }
    ];
    print(ddata.toString());

    data2 = data2.map((map) {
      if (map["attributes"] != null && map["attributes"]["color"] != null) {
        map["attributes"]["color"] =
            '#${map["attributes"]["color"].toString().substring(3, map["attributes"]["color"].toString().length)}'; // change the color value here
      } else if (map["attributes"] != null &&
          map["attributes"]["background"] != null) {
        map["attributes"]["background"] =
            '#${map["attributes"]["background"].toString().substring(3, map["attributes"]["background"].toString().length)}';
      }
      return map;
    }).toList();

    print(data2);
    // const encoder = JsonEncoder.withIndent('  ');
    // var _delta = encoder.convert(data);

    final converter = QuillDeltaToHtmlConverter(
      data2,
    );

    var html = await converter.convert();

    // final html = converter.convert();
    // final convertedValue = jsonEncode(delta.toJson());
    // final markdown = quillToMarkdown(convertedValue);
    // final html = md.markdownToHtml(markdown!);
    return html;
  }

  saveNotes(int metingID, BuildContext context) async {
    change(null, status: RxStatus.loading());
    List<AllUserModel> visibleTo = [];
    for (var element in accessibileUserSelected_meetingDetail) {
      visibleTo = visibleTo;
    }
    FindNotesModel noteModel = FindNotesModel(
        meetingId: metingID,
        noteType: 1,
        visibleTo: visibleTo,
        note: noteText_meetingdetails.value.text,
        isActive: true,
        isAdded: true,
        createdBy: 101,
        updatedBy: 101);

    var res = await api.addNotes(noteModel);
    if (res != null) {
      model.value.add(res);
      model;
      model.refresh();
      noteText_meetingdetails.value.text = "";
      accessibileUserSelected_meetingDetail.value = [];
      accessibileUserSelected_meetingDetail.refresh();
      getNotesOfMeeting(context);
      change(null, status: RxStatus.success());
    }
  }

  // bool meetingStartedValue = false;
  // bool meetingEndedValue = false;
  // int id = 0;

  meetingId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = await prefs.getInt('id')!;
  }

  meetingStarted(int meetingId, bool val) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var id = await prefs.getInt('id');
    // var controllerDashboard = Get.find<DashBoardController>();

    AllMeetings meetingData = baseController.selectedMeetingData;
    var res = await api.meetingStartedOrEnded(meetingId, id, 0, val);
    // meetingData.meetingStarted = val;

    // await controllerDashboard.getMeetingData();
    // await Get.find<DashBoardController>().getsss();
    update();
  }

  meetingEnded(int meetingId, bool val) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var id = await prefs.getInt('id');

    var controllerDashboard = Get.find<DashBoardController>();
    var res = await api.meetingStartedOrEnded(meetingId, id, 1, val);
    // meetingData.meetingEnded = val;

    // controllerDashboard.indexOfTab.value =
    //     controllerDashboard.indexOfTab.value == 0 ? 1 : 0;
    controllerDashboard.update();
    update();
  }

  bool showTheStartEndOptions = false;

  checkUserIsCordinator() {
    print(id);
    var data = baseController.selectedMeetingData.meetingCoordinator;

    var started = baseController.selectedMeetingData.createdBy;

    data!.forEach((element) {
      if (element.id == id || started == id) {
        showTheStartEndOptions = true;
      } else {
        print('${element.id}dddddddd');
        showTheStartEndOptions = false;
      }
    });
  }

  List<FindParticipantByMeetingIdModel> participantList = [];

  List<Widget> participantDataList = [];

  getMeetingParticipantsList() async {
    if (baseController.selectedMeetingData.meetingType == 'External Meeting') {
      var res = await api
          .findParticipantByMeetingId(baseController.selectedMeetingData.id!);

      participantList = await List<FindParticipantByMeetingIdModel>.from(
          res.map((e) => FindParticipantByMeetingIdModel.fromJson(e)));

      List<RepresentativeModel> dataList = [];
      for (var i = 0; i < participantList.length; i++) {
        var res = await api
            .getRepresentativeAllData(participantList[i].participantId!);

        print(res);
        // var data = await json.decode(res);

        if (res != null) {
          var deta = await RepresentativeModel.fromJson(res);

          dataList.add(deta);
        }
      }

      for (var i = 0; i < dataList.length; i++) {
        participantDataList.add(Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              // color: ThemeConstants.whitecolor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: ThemeConstants.whitecolor)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                child: Icon(
                  Icons.person,
                  color: ThemeConstants.whitecolor,
                  size: 15,
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:  ${dataList[i].personName}',
                      style: TextStyle(color: ThemeConstants.whitecolor),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      'Designation:  ${dataList[i].designation}',
                      style: TextStyle(color: ThemeConstants.whitecolor),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      'Email:  ${dataList[i].email}',
                      style: TextStyle(color: ThemeConstants.whitecolor),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      'Phone:  ${dataList[i].phone}',
                      style: TextStyle(color: ThemeConstants.whitecolor),
                    ),
                  ]),
            ],
          ),
        ));
      }
      update();

      // participantsList.forEach((element) {

      // });
      print(participantList);
    }
  }

  markAttendance(meetingID) async {
    var res = await api.markAttendance(meetingID, id, id);
  }

  reasonOfNotAttendance(meetingID, String text) async {
    var res = await api.reasonOfNotAttending(meetingID, id, text);
  }

  bool showPublishButtonOrNotBool = false;
  showPublishButtonOrNot() async {
    var res = await api.showPublishButtonOrNot(
        meetingId: baseController.selectedMeetingData.id!, userId: id);
  }

  List<CommonUploadDocument> documentModel = [];

  uploadDocument(BuildContext context
      //   String id, {
      //   String orgname = "",
      // }
      ) async {
    try {
      String uploadFilename = "";
      PlatformFile? csvFile2;
      final results = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'tiff', 'pdf', 'doc', 'docx'],
      );
      if (results != null) {
        csvFile2 = results.files.first;
        uploadFilename = results.files.first.name;
      }
      if (csvFile2 != null) {
        if (csvFile2.path != null) {
          final f = File(csvFile2.path!);
          int sizeInBytes = f.lengthSync();
          double sizeInMb = sizeInBytes / (1024 * 1024);
          if (sizeInMb > 5) {
            getToast('Maximuam upload size');
          } else {
            // var res = await api.uploadDocumentCommon(
            //   ,
            //     uploadFilename,
            //     Get.find<BaseController>().model1.id.toString(),
            //     id,
            //     orgname: orgname,
            //     is_event: is_event);

            var res = await api.uploadDocumentCommon(
                meeting_id: baseController.selectedMeetingData.id,
                user_id: id,
                file: csvFile2.path,
                uploadFilename: uploadFilename);
            if (res != null) {
              await saveImageNote(
                  baseController.selectedMeetingData.id!, res['view'], context);
              // CommonUploadStatus model = CommonUploadStatus();
              // model = res;
              // if (model.status == "sucesss") {
              //   documentModel.add(model.dataModal!);
              // }
              // getDocumentType();
              // getOrganizationName();
            }
            // if (is_event == 1) {
            //   Get.offAndToNamed(DashBoard.routeNamed);
            // }
            update();
          }
        }
      }
    } catch (e) {
      await getToast('Please give Storage Permission');
      // await ApiServices(). (
      //   Get.find<BaseController>().model1.id.toString(),
      //   e.toString(),
      //   "1111",
      //   StackTrace.current.toString(),
      // );
    }
  }

  saveImageNote(int metingID, String imageId, BuildContext context) async {
    print(metingID);
    change(null, status: RxStatus.loading());
    List<AllUserModel> visibleTo = [];

    // var data = await noteText.getText();

    // var data = await contro.document.toDelta();
    // print(data);

    // var html = '';

    // var hello = awasit quillDeltaToHtml(data);
    // print(hello);
    for (var element in accessibileUserSelected) {
      visibleTo.add(element);
    }
    FindNotesModel noteModel = FindNotesModel(
        meetingId: metingID,
        noteType: noteTypeSelectedID.value,
        visibleTo: visibleTo,
        note: '',
        isActive: true,
        isAdded: true,
        image_note: imageId,
        createdBy: baseController.id,
        updatedBy: baseController.id);

    // if (encrypted == true) {
    //   noteModel.note = encryptedNote;
    // }

    var res = await api.addNotes(noteModel);
    if (res != null) {
      model.value.add(noteModel);
      model;
      model.refresh();
      noteTypeSelected = "Select Add notes for".obs;

      noteText.clear();

      noteTypeSelectedID = 0.obs;
      accessibileUserSelected = RxList<AllUserModel>();

      // change(null, status: RxStatus.success());
    }

    await getNotesOfMeeting(context);

    update();
    change(null, status: RxStatus.success());
  }

  getViewDocument(String url) {
    print(url);
    String extension = url.split('.').last;
    print(extension);
    if (extension == "pdf") {
      return Get.to(CustomDocumentViewer(
        url: url,
      ));
    } else if (extension == "doc") {
      Get.to(CustomDocumentViewer(
        url: url,
      ));
    } else if (extension == "docx") {
      Get.to(CustomDocumentViewer(
        url: url,
      ));
    } else {
      Get.to(CustomImageViewer(
        url: url,
      ));
    }
  }

  publishNote(FindNotesModel notes) async {
    var universityID = await api.findUniversityIdFromMeeting(
        meeting_id: baseController.selectedMeetingData.id);

    var res = await api.publishNote(
        university_id: universityID, notes: notes.note, userId: id);
  }
}
