import 'package:meeting_module2/models/allUserModel.dart';

class FindNotesModel {
  int? id;
  int? meetingId;
  int? noteType;
  String? note;
  bool? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  List<AllUserModel>? visibleTo;
  bool? isAdded;
  String? image_note;

  FindNotesModel(
      {this.id,
      this.image_note,
      this.meetingId,
      this.noteType,
      this.note,
      this.isActive,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.visibleTo,
      this.isAdded});

  FindNotesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meeting_id'];
    noteType = json['note_type'];
    note = json['note'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['visible_to'] != null) {
      visibleTo = <AllUserModel>[];
      json['visible_to'].forEach((v) {
        if (v != null) visibleTo!.add(new AllUserModel.fromJson(v));
      });
    }
    isAdded = json['is_added'];
    image_note = json['image_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meeting_id'] = this.meetingId;
    data['note_type'] = this.noteType;
    data['note'] = this.note;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.visibleTo != null) {
      data['visible_to'] = this.visibleTo!.map((v) => v.toJson()).toList();
    }
    data['is_added'] = this.isAdded;
    data['image_note'] = this.image_note;

    return data;
  }
}

class VisibleTo {
  String? name;
  int? id;

  VisibleTo({this.name, this.id});

  VisibleTo.fromJson(Map<String, dynamic> json) {
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
