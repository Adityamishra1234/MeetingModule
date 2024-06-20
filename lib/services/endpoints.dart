class Endpoints {
/////fcmToken
  ///

  ///aman pc
  // static String baseUrl = 'http://192.168.0.104:3001/api/';
//jp
  // static String baseUrl = 'http://192.168.104.20:3001/api/';

  // static String baseUrl = 'http://10.0.2.2:3001/api/';

  ///production
  static String baseUrl = 'https://meeting.sieceducation.in/api/';

  static String allMeetings = 'getMeetingListByUser';

  static String allUser = 'allUser';

  static String addAgenda = 'addAgenda';
  static String allAgenda = 'allAgenda';

  static String findNotes = 'findNotesByMeetingID';

  static String addNotes = 'addNotes';

  static String addMeeting = 'createMeeting';

  static String selectedAudienceType = 'targetAudienceType';

  static String allBranch = 'allBranch';

  static String specificBranchUsers = 'findUserByBranch';

  static String allCountry = 'allCountry';

  static String universtiyByCountry = 'findUniversityByCountryId';

  static String addRepresentative = 'addRepresentative';

  static String findRepresentative = 'findRepresentative';

  static String findRepresentativeForDropDown = 'findRepresentativeForDropDown';

  static String findRepresentativeByID = 'findRepresentativeByID';
  static String emailverification = 'Emailverification';
  // /Otp/:email
  static String otp = 'Otp';
  // OtpMatch/developer4@siecindia.com/120863
  static String otpMatch = 'OtpMatch';

  // /passwordUpdate/:email/:password
  static String passwordUpdate = 'passwordUpdate';

  static String findRepresentativeForUniversity =
      'findRepresentativeForUniversity';

  static String addParticipants = 'addPartcipants';

  static String login = 'login';

  static String resheduleMeeting = 'rescheduleMeeting';

  static String meetingStartedOrEnded = 'meetingStarted';

  static String meetingEnded = 'meetingEnded';

  static String findMeetingParticipants = 'findParticipantByMeetingId';

  static String assignTo = 'assignTo';

  static String uodateFCMToken = 'updateFcmToken';

  static String findNoteByUser = 'findNoteByUser';

  static String userAttendance = 'userAttendance';

  static String reasonOfNotAttendingAll = 'reasonOfNotAttending';

  static String reasonOfNotAttending = 'reasonOfNotAttendingUpdate';

  static String findUniversityCountryByMeetingId =
      'findUniversityCountryByMeetingId';

  static String checkShowPublishButton = 'checkShowPublishButton';

  static String publishNote = 'notesPublish';

  static String encrypt = 'encryptionAPI2';

  static String decrypt = 'decryptionAPI2';

  static String uploadMeetingDocument = 'meeting-attachment';
  static String forgetPassword = 'forgetPassword';
  static String passwordUpdateForgetCase = 'otpPasswordUpdate';
  // static String passwordUpdateForgetCase = 'otpPasswordUpdate';
  static String otpmatch = '/OtpMatch';

  static String universityIdByMeetingId = 'univeristyByMeetingID';

  static String getAllBranchesWithImage = 'get-all-branches-address';

  static String findUserNotesTaskById = 'findMeetingNotesTaskById';

  static String findMeetingNotesTaskByIdwithUpdate =
      'findMeetingNotesTaskByIdwithUpdate';

  static String generateNotifications = 'fcmMultiUser';

  static String generateNotificationsOnNoteCreation = 'noteForFCM';

  static String getVendorBankRepNameDropdown = 'sc_contact_person_vendor';

  static String deleteOption = 'deleteOption';

  static String deleteUserData = 'deleteAccount';
  static String registerOption = 'registerpage';
}

datesOfCalendarMeetingEndpoint(int id, int month, int year) {
  return 'getMeetingListByUserForDate/$id/$month/$year';
}

meetingsOfCalendarMeetingEndpoint(int id, int month, int year, int day) {
  return 'getMeetingListByUser/$id/$day/$month/$year';
}


// datesOfCalendarMertingEndpoint(int id, int month, int year) {
//   return 'getMeetingListByUser/:date/$id/$month/$year';
// }
