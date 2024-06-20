class AddInstituteModel {
  String? message;
  Data? data;

  AddInstituteModel({this.message, this.data});

  AddInstituteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? conditionalOffer;
  int? siecPriority;
  int? import;
  int? isActive;
  bool? isNavitas;
  int? id;
  int? countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic instituteType;
  String? instSubCategory;
  dynamic affiliationId;
  String? universityName;
  String? univAddress;
  String? pincode;
  String? createdAt;
  String? updatedAt;
  String? landmark;

  Data(
      {this.conditionalOffer,
        this.siecPriority,
        this.import,
        this.isActive,
        this.isNavitas,
        this.id,
        this.countryId,
        this.stateId,
        this.cityId,
        this.instituteType,
        this.instSubCategory,
        this.affiliationId,
        this.universityName,
        this.univAddress,
        this.pincode,
        this.createdAt,
        this.updatedAt,
        this.landmark});

  Data.fromJson(Map<String, dynamic> json) {
    conditionalOffer = json['conditional_offer'];
    siecPriority = json['siec_priority'];
    import = json['import'];
    isActive = json['is_active'];
    isNavitas = json['is_navitas'];
    id = json['id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    instituteType = json['institute_type'];
    instSubCategory = json['inst_sub_category'];
    affiliationId = json['affiliation_id'];
    universityName = json['university_name'];
    univAddress = json['univ_address'];
    pincode = json['pincode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conditional_offer'] = this.conditionalOffer;
    data['siec_priority'] = this.siecPriority;
    data['import'] = this.import;
    data['is_active'] = this.isActive;
    data['is_navitas'] = this.isNavitas;
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['institute_type'] = this.instituteType;
    data['inst_sub_category'] = this.instSubCategory;
    data['affiliation_id'] = this.affiliationId;
    data['university_name'] = this.universityName;
    data['univ_address'] = this.univAddress;
    data['pincode'] = this.pincode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['landmark'] = this.landmark;
    return data;
  }
}
