class ReasonOfNotAttendingModel {
  int? id;
  int? meetingId;
  int? meetingNotesId;
  String? taskType;
  String? deadlineDate;
  int? taskOwnerId;
  bool? isActive;
  String? closedAt;
  int? closedBy;
  bool? meetingAttented;
  String? reasonOfNotAttended;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  Null? notes;

  ReasonOfNotAttendingModel(
      {this.id,
      this.meetingId,
      this.meetingNotesId,
      this.taskType,
      this.deadlineDate,
      this.taskOwnerId,
      this.isActive,
      this.closedAt,
      this.closedBy,
      this.meetingAttented,
      this.reasonOfNotAttended,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.notes});

  ReasonOfNotAttendingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingId = json['meeting_id'];
    meetingNotesId = json['meeting_notes_id'];
    taskType = json['task_type'];
    deadlineDate = json['deadline_date'];
    taskOwnerId = json['task_owner_id'];
    isActive = json['is_active'];
    closedAt = json['closed_at'];
    closedBy = json['closed_by'];
    meetingAttented = json['meeting_attented'];
    reasonOfNotAttended = json['reason_of_not_attended'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meeting_id'] = this.meetingId;
    data['meeting_notes_id'] = this.meetingNotesId;
    data['task_type'] = this.taskType;
    data['deadline_date'] = this.deadlineDate;
    data['task_owner_id'] = this.taskOwnerId;
    data['is_active'] = this.isActive;
    data['closed_at'] = this.closedAt;
    data['closed_by'] = this.closedBy;
    data['meeting_attented'] = this.meetingAttented;
    data['reason_of_not_attended'] = this.reasonOfNotAttended;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['notes'] = this.notes;
    return data;
  }
}
