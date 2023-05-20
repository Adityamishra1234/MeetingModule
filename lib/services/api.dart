import 'package:meeting_module2/models/addRepresentative.dart';
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

  allBranch();

  getSpecificBranchUsers(int branchCode);

  getAllCountries();

  getAllUniversity(int countryCOde);

  addRepresentative(RepresentativeModel model);

  findRepresentative(String representaiveType);

  findRepresentativeForDropDown(String representaiveType);

  getRepresentativeAllData(int id);
}
