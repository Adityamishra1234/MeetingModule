class Endpoints {
  static String baseUrl = 'http://192.168.107.88:3001/api/';
//jp
  // static String baseUrl = 'http://192.168.104.20:3001/api/';

  // static String baseUrl = 'http://10.0.2.2:3001/api/';
//
  // static String baseUrl = 'http://164.52.208.95:3001/api/';

  static String allMeetings = 'getMeetingListByUser';

  static String allUser = 'allUser';

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
}
