import 'package:get/get.dart';
import 'package:meeting_module2/services/apiServices.dart';

class DecryptionOfNotesController extends GetxController {
  RxString decryptedNoteData = ''.obs;
  ApiServices apiServices = ApiServices();
  getdecryptedNote(note, password) async {
    // var data = await noteText.document.toDelta();
    // print(data);

    // var html = '';

    // var hello = await quillDeltaToHtml(data);
    var res = await apiServices.decryptNote(note, password);
    decryptedNoteData.value = res;
    update();
    return res;
  }
}
