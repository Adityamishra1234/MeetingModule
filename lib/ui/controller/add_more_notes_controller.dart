import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/services/apiServices.dart';

class AddMoreNotesController extends GetxController {
  Rx<TextEditingController> noteText = TextEditingController().obs;

  RxInt noteType = 0.obs;
  // RxList<AllUserModel> notesVisibleToList = <AllUserModel>[].obs;
  RxList<int> notesVisibleToList = <int>[5, 80, 77].obs;
  Rx<FindNotesModel> model = FindNotesModel().obs;
  ApiServices api = ApiServices();

  @override
  addNote(int meetingID) async {
    print(noteText.value.text);
    model.value.note = await noteText.value.text;

    model.value.noteType = await noteType.value;
    model.value.visibleTo = await notesVisibleToList.toString();

    // print(model.value);

    // var res = await api.addNotes(meetingID, noteType.value, noteText.value.text,
    //     "ddd", notesVisibleToList.value);

    var res = await api.addNotes(model.value);
  }
}
