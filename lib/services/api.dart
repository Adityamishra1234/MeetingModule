import 'package:meeting_module2/models/addRepresentative.dart';
import 'package:meeting_module2/models/allMeetingsModels.dart';
import 'package:meeting_module2/models/commonUploadDocument.dart';
import 'package:meeting_module2/models/commonUploadStatus.dart';
import 'package:meeting_module2/models/findNotesModel.dart';
import 'package:meeting_module2/models/participantsModel.dart';

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

  getOTP(String email);

  resheduleMeeting(data);

  getEmailverification(String email);

  otpMatch(String email, String otp);

  password(String email, String password);

  meetingStartedOrEnded(int meetingId, int userId, int type, bool val);

  findParticipantByMeetingId(int meetingId);

  assignTo(data);

  updateFCMToken(id, token);

  findNoteByUser(id);

  markAttendance(meetingId, userId, createdBY);

  reasonOfNotAttending(
      int taskID, int meetningID, int createdBy, String reason);

  reasonOfNotAttendingAll(int meetningID);

  findUniversityCountryByMeetingId(meetningID);

  encryptNote(note, password);

  decryptNote(note, password);

  showPublishButtonOrNot({required int meetingId, required int userId});

  uploadMeetingModuleDocument({required int meetingId, required int userId});

  uploadDocumentCommon({
    required meeting_id,
    required user_id,
    required file,
    required uploadFilename,
  });

  findUniversityIdFromMeeting({required meeting_id});

  publishNote({
    required university_id,
    required notes,
    required userId,
  });

  addAgenda({required agenda, userId});

  allAgenda();

  getMonthMeetingDates(String endpoint);

  getMeetingOfDates(String endpoint);

  getNotesTaskListByUserID(String id, int bifer);

  updateNoteTaskStatus(
      {required int id,
      required int created_by,
      required bool meeting_attended});
}
