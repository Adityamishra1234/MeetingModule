// To parse this JSON data, do
//
//     final findNotesModel = findNotesModelFromJson(jsonString);

import 'dart:convert';

List<FindNotesModel> findNotesModelFromJson(String str) =>
    List<FindNotesModel>.from(
        json.decode(str).map((x) => FindNotesModel.fromJson(x)));

String findNotesModelToJson(List<FindNotesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  String? visibleTo;
  bool? isAdded;

  FindNotesModel({
    this.id,
    this.meetingId,
    this.noteType,
    this.note,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.visibleTo,
    this.isAdded,
  });

  factory FindNotesModel.fromJson(Map<String, dynamic> json) => FindNotesModel(
        id: json["id"],
        meetingId: json["meeting_id"],
        noteType: json["note_type"],
        note: json["note"],
        isActive: json["is_active"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        visibleTo: json["visible_to"],
        isAdded: json["is_added"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meeting_id": meetingId,
        "note_type": noteType,
        "note": note,
        "is_active": isActive,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": 'createdAt!.toIso8601String()',
        "updated_at": 'updatedAt!.toIso8601String()',
        "visible_to": visibleTo,
        "is_added": isAdded,
      };
}
