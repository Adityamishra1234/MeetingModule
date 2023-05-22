import 'dart:math';

class AllMeetings {
  int? id;
  String? meetingType;
  String? meetingWith;
  String? meetingAgenda;
  String? specificPurposeOfTheMeeting;
  String? nameOfTheMeeting;
  String? dateOfMeeting;
  String? timeOfTheMeeting;
  String? durationOfMeeting;
  bool? meetingMode;
  String? meetingModeType;
  String? meetingLink;
  String? locationOfTheMeeting;
  int? siecBranch;
  String? specificLocationOfTheMeeting;
  List<SiecParticipants>? siecParticipants;
  List<SiecParticipants>? meetingCoordinator;
  bool? meetingStarted;
  bool? isReschedule;
  bool? meetingEnded;
  bool? meetingExceeded;
  bool? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? meeting_started_time;
  String? meeting_ended_time;
  String? meeting_started_by;
  String? meeting_ended_by;

  AllMeetings({
    this.id = 0,
    this.meetingType = 'Internal Meeting',
    this.meetingWith = 'University Meetings',
    this.meetingAgenda = 'All Meetings',
    this.specificPurposeOfTheMeeting = '',
    this.nameOfTheMeeting = '',
    this.dateOfMeeting = '2023-04-27',
    this.timeOfTheMeeting = '17:20',
    this.durationOfMeeting = '',
    this.meetingMode = true,
    this.meetingModeType = 'Zoom',
    this.meetingLink = 'test',
    this.locationOfTheMeeting = '',
    this.siecBranch = 0,
    this.specificLocationOfTheMeeting = '',
    this.siecParticipants,
    this.meetingCoordinator,
    this.meetingStarted = false,
    this.isReschedule = false,
    this.meetingEnded = false,
    this.meetingExceeded = false,
    this.isActive = true,
    this.createdBy = 105,
    this.updatedBy = 105,
    this.createdAt = "2023-04-07T09:48:35.000Z",
    this.updatedAt = "2023-04-07T09:48:35.000Z",
    this.meeting_started_time = null,
    this.meeting_ended_time = null,
    this.meeting_started_by = null,
    this.meeting_ended_by = null,
  });

  // List<SiecParticipants> defaultSiecList = [
  //   {"name": "dddd", "id": 150},
  //   {"name": "dddd", "id": 150}
  // ].forEach((element) {
  //   SiecParticipants.fromJson(element);

  // });
  AllMeetings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meetingType = json['meeting_type'];
    meetingWith = json['meeting_with'];
    meetingAgenda = json['meeting_agenda'];
    specificPurposeOfTheMeeting = json['specific_purpose_of_the_meeting'];
    nameOfTheMeeting = json['name_of_the_meeting'];
    dateOfMeeting = json['date_of_meeting'];
    timeOfTheMeeting = json['time_of_the_meeting'];
    durationOfMeeting = json['duration_of_meeting'];
    meetingMode = json['meeting_mode'];
    meetingModeType = json['meeting_mode_type'];
    meetingLink = json['meeting_link'];
    locationOfTheMeeting = json['location_of_the_meeting'];
    siecBranch = json['siec_branch'];
    specificLocationOfTheMeeting = json['specific_location_of_the_meeting'];
    if (json['siec_participants'] != null) {
      siecParticipants = <SiecParticipants>[];
      json['siec_participants'].forEach((v) {
        if (v != null) {
          siecParticipants!.add(new SiecParticipants.fromJson(v));
        } else {
          '';
        }
      });
    } else {
      null;
    }

    // meetingCoordinator = json['meeting_coordinator'];
    if (json['meeting_coordinator'] != null) {
      meetingCoordinator = <SiecParticipants>[];
      json['meeting_coordinator'].forEach((v) {
        if (v != null) {
          meetingCoordinator!.add(new SiecParticipants.fromJson(v));
        } else {
          '';
        }
      });
    } else {
      null;
    }
    // meetingCoordinator = json['meeting_coordinator'] != null
    //     ? new SiecParticipants.fromJson(json['meeting_coordinator'])
    //     : null;
    meetingStarted = json['meeting_started'];
    isReschedule = json['is_reschedule'];
    meetingEnded = json['meeting_ended'];
    meetingExceeded = json['meeting_exceeded'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['meeting_type'] = meetingType;
    data['meeting_with'] = meetingWith;
    data['meeting_agenda'] = meetingAgenda;
    data['specific_purpose_of_the_meeting'] = specificPurposeOfTheMeeting;
    data['name_of_the_meeting'] = nameOfTheMeeting;
    data['date_of_meeting'] = dateOfMeeting;
    data['time_of_the_meeting'] = timeOfTheMeeting;
    data['duration_of_meeting'] = durationOfMeeting;
    data['meeting_mode'] = meetingMode;
    data['meeting_mode_type'] = meetingModeType;
    data['meeting_link'] = meetingLink;
    data['location_of_the_meeting'] = locationOfTheMeeting;
    data['siec_branch'] = siecBranch;
    data['specific_location_of_the_meeting'] = specificLocationOfTheMeeting;

    if (siecParticipants != null) {
      data['siec_participants'] =
          siecParticipants!.map((v) => v.toJson()).toList();
    }
    if (meetingCoordinator != null) {
      data['meeting_coordinator'] =
          meetingCoordinator!.map((v) => v.toJson()).toList();
      // data['meeting_coordinator'] = meetingCoordinator!.toJson();
    }
    data['meeting_started'] = meetingStarted;
    data['is_reschedule'] = isReschedule;
    data['meeting_ended'] = meetingEnded;
    data['meeting_exceeded'] = meetingExceeded;
    data['is_active'] = isActive;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SiecParticipants {
  String? name;
  int? id;

  SiecParticipants({this.name, this.id});

  SiecParticipants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['id'] = id;

    return data;
  }
}
