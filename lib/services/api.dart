import 'package:meeting_module2/models/addRepresentative.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/models/participantsModel.dart';
import 'package:meeting_module2/ui/screens/participants_details.dart';

abstract class API {
  getAllMeetings(int id);

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

  getRepresentativeByUniversity(
      {required String type,
      required int collegecode,
      required int countrycode});

  addParticipants(List<ParticipantsModel> model);

  login({required String email, required String password});
}
