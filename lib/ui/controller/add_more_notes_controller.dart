import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/services/apiServices.dart';

class AddMoreNotesController extends GetxController with StateMixin {
  RxList<int> notesVisibleToList = <int>[5, 80, 77].obs;

  // Model
  ApiServices api = ApiServices();
  RxList<FindNotesModel> model = <FindNotesModel>[].obs;

// Text fields
  Rx<TextEditingController> noteText = TextEditingController().obs;

  //Selcted dropdown fields
  RxString noteTypeSelected = "".obs;
  RxInt noteTypeSelectedID = 0.obs;
  RxList<AllUserModel> accessibileUserSelected = RxList<AllUserModel>();

  //For meeting details page
  Rx<TextEditingController> noteText_meetingdetails =
      TextEditingController().obs;
  RxList<AllUserModel> accessibileUserSelected_meetingDetail =
      RxList<AllUserModel>();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
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

  saveAndNext(int metingID) async {
    print(metingID);
    change(null, status: RxStatus.loading());
    String visibleTo = "";
    for (var element in accessibileUserSelected) {
      visibleTo = "$visibleTo${element.id},";
    }
    FindNotesModel noteModel = FindNotesModel(
        meetingId: metingID,
        noteType: noteTypeSelectedID.value,
        visibleTo: visibleTo,
        note: noteText.value.text,
        isActive: true,
        isAdded: true,
        createdBy: 101,
        updatedBy: 101);

    var res = await api.addNotes(noteModel);
    if (res != null) {
      model.value.add(res);
      model;
      model.refresh();
      noteTypeSelected = "".obs;
      noteTypeSelectedID = 0.obs;
      accessibileUserSelected = RxList<AllUserModel>();
      noteText.value.text = "";
      change(null, status: RxStatus.success());
    }
  }

  saveNotes(int metingID) async {
    change(null, status: RxStatus.loading());
    String visibleTo = "";
    for (var element in accessibileUserSelected_meetingDetail) {
      visibleTo = "$visibleTo${element.id},";
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
      change(null, status: RxStatus.success());
    }
  }
}
