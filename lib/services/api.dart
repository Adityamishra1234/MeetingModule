import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/findNotesModel.dart';

abstract class API {
  getAllMeetings();

  getAllUsers();

  findNotes(String id);

  // addNotes(int meetingID, int noteType, String note, String createdBY,
  //     List<int> visibleToList);

  addNotes(FindNotesModel model);

  createMeeting(AllMeetings model);
}
