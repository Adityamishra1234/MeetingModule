class DashBoardNotes {
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

  DashBoardNotes(
      {this.id,
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

  DashBoardNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meeting_id'];
    noteType = json['note_type'];
    note = json['note'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    visibleTo = json['visible_to'];
    isAdded = json['is_added'];
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
    data['visible_to'] = this.visibleTo;
    data['is_added'] = this.isAdded;
    return data;
  }
}
