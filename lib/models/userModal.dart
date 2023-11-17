class UserModel {
  int? id;
  int? empId;
  String? name;
  String? email;
  String? emailPassword;
  String? emailVerifiedAt;
  String? password;
  bool? tempLogin;
  String? tempPassword;
  String? tempPassValidTill;
  String? rememberToken;
  String? profilePhoto;
  String? macAddress;
  String? ipAddress;
  String? tokenId;
  String? lastOnline;
  String? createdAt;
  String? updatedAt;
  int? isUserActive;
  String? officialNumber;
  String? fcmToken;
  String? fcmTokenAndroid;
  String? fcmTokenIos;
  String? meetingModuleOtp;
  String? meetingModulePassword;
  bool? meetingModuleIsActive;
  String? registrationLinkOfTheMeeting;

  UserModel(
      {this.id,
      this.empId,
      this.name,
      this.email,
      this.emailPassword,
      this.emailVerifiedAt,
      this.password,
      this.tempLogin,
      this.tempPassword,
      this.tempPassValidTill,
      this.rememberToken,
      this.profilePhoto,
      this.macAddress,
      this.ipAddress,
      this.tokenId,
      this.lastOnline,
      this.createdAt,
      this.updatedAt,
      this.isUserActive,
      this.officialNumber,
      this.fcmToken,
      this.fcmTokenAndroid,
      this.fcmTokenIos,
      this.meetingModuleOtp,
      this.meetingModulePassword,
      this.meetingModuleIsActive,
      this.registrationLinkOfTheMeeting});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empId = json['emp_id'];
    name = json['name'];
    email = json['email'];
    emailPassword = json['email_password'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    tempLogin = json['temp_login'];
    tempPassword = json['temp_password'];
    tempPassValidTill = json['temp_pass_valid_till'];
    rememberToken = json['remember_token'];
    profilePhoto = json['profile_photo'];
    macAddress = json['mac_address'];
    ipAddress = json['ip_address'];
    tokenId = json['token_id'];
    lastOnline = json['last_online'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isUserActive = json['is_user_active'];
    officialNumber = json['official_number'];
    fcmToken = json['fcm_token'];
    fcmTokenAndroid = json['fcm_token_android'];
    fcmTokenIos = json['fcm_token_ios'];
    meetingModuleOtp = json['meeting_module_otp'];
    meetingModulePassword = json['meeting_module_password'];
    meetingModuleIsActive = json['meeting_module_is_active'];
    registrationLinkOfTheMeeting = json['registration_link_of_the_meeting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_id'] = this.empId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_password'] = this.emailPassword;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['temp_login'] = this.tempLogin;
    data['temp_password'] = this.tempPassword;
    data['temp_pass_valid_till'] = this.tempPassValidTill;
    data['remember_token'] = this.rememberToken;
    data['profile_photo'] = this.profilePhoto;
    data['mac_address'] = this.macAddress;
    data['ip_address'] = this.ipAddress;
    data['token_id'] = this.tokenId;
    data['last_online'] = this.lastOnline;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_user_active'] = this.isUserActive;
    data['official_number'] = this.officialNumber;
    data['fcm_token'] = this.fcmToken;
    data['fcm_token_android'] = this.fcmTokenAndroid;
    data['fcm_token_ios'] = this.fcmTokenIos;
    data['meeting_module_otp'] = this.meetingModuleOtp;
    data['meeting_module_password'] = this.meetingModulePassword;
    data['meeting_module_is_active'] = this.meetingModuleIsActive;
    data['registration_link_of_the_meeting'] =
        this.registrationLinkOfTheMeeting;
    return data;
  }
}
