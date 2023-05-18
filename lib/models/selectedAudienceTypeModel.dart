import 'package:meeting_module2/models/allUserModel.dart';

class SelectAudienceType {
  int? id;
  String? teamName;
  List<AllUserModel>? teamMembers;
  bool? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;

  SelectAudienceType(
      {this.id,
      this.teamName,
      this.teamMembers,
      this.isActive,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt});

  SelectAudienceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['team_name'];
    if (json['team_members'] != null) {
      teamMembers = <AllUserModel>[];
      json['team_members'].forEach((v) {
        teamMembers!.add(new AllUserModel.fromJson(v));
      });
    }
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_name'] = this.teamName;
    if (this.teamMembers != null) {
      data['team_members'] = this.teamMembers!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TeamMembers {
  String? name;
  int? id;

  TeamMembers({this.name, this.id});

  TeamMembers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
