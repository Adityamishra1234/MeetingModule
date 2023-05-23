class Endpoints {
  static String baseUrl = 'http://192.168.107.88:3001/api/';

  static String allMeetings = 'allMeeting';

  static String allUser = 'allUser';

  static String findNotes = 'findNotes';

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
}
