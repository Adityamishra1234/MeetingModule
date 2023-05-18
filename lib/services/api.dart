import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/findNotesModel.dart';

abstract class API {
  getAllMeetings();

  getDropdown(String endpoint);

  findNotes(String id);
  addNotes(FindNotesModel model);
  addMeeting(AllMeetings modelData);
  createMeeting(AllMeetings model);

  selectedAudienceType();
}
