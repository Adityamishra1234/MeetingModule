class RepresentativeModel {
  int? id;
  String? representativeType;
  String? personName;
  String? designation;
  String? email;
  int? phone;
  int? country;
  int? university;
  String? vendorName;
  String? bankName;
  bool? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  RepresentativeModel(
      {this.id,
      this.representativeType,
      this.personName,
      this.designation,
      this.email,
      this.phone,
      this.country,
      this.university,
      this.vendorName,
      this.bankName,
      this.isActive,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  RepresentativeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    representativeType = json['representative_type'];
    personName = json['person_name'];
    designation = json['designation'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    university = json['university'];
    vendorName = json['vendor_name'];
    bankName = json['bank_name'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['representative_type'] = this.representativeType;
    data['person_name'] = this.personName;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['university'] = this.university;
    data['vendor_name'] = this.vendorName;
    data['bank_name'] = this.bankName;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
