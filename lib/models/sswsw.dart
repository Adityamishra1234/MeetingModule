// class AllMeetingsModel {
//   int? id;
//   String? meetingType;
//   String? meetingWith;
//   String? meetingAgenda;
//   String? specificPurposeOfTheMeeting;
//   String? nameOfTheMeeting;
//   String? dateOfMeeting;
//   String? timeOfTheMeeting;
//   String? durationOfMeeting;
//   bool? meetingMode;
//   String? meetingModeType;
//   String? meetingLink;
//   String? locationOfTheMeeting;
//   int? siecBranch;
//   String? specificLocationOfTheMeeting;
//   List<SiecParticipants>? siecParticipants;
//   List<MeetingCoordinator>? meetingCoordinator;
//   bool? meetingStarted;
//   bool? isReschedule;
//   bool? meetingEnded;
//   bool? meetingExceeded;
//   bool? isActive;
//   int? createdBy;
//   int? updatedBy;
//   String? createdAt;
//   String? updatedAt;
//   Null? meetingStartedTime;
//   Null? meetingEndedTime;
//   Null? meetingStartedBy;
//   Null? meetingEndedBy;

//   AllMeetingsModel(
//       {this.id,
//       this.meetingType,
//       this.meetingWith,
//       this.meetingAgenda,
//       this.specificPurposeOfTheMeeting,
//       this.nameOfTheMeeting,
//       this.dateOfMeeting,
//       this.timeOfTheMeeting,
//       this.durationOfMeeting,
//       this.meetingMode,
//       this.meetingModeType,
//       this.meetingLink,
//       this.locationOfTheMeeting,
//       this.siecBranch,
//       this.specificLocationOfTheMeeting,
//       this.siecParticipants,
//       this.meetingCoordinator,
//       this.meetingStarted,
//       this.isReschedule,
//       this.meetingEnded,
//       this.meetingExceeded,
//       this.isActive,
//       this.createdBy,
//       this.updatedBy,
//       this.createdAt,
//       this.updatedAt,
//       this.meetingStartedTime,
//       this.meetingEndedTime,
//       this.meetingStartedBy,
//       this.meetingEndedBy});

//   AllMeetingsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     meetingType = json['meeting_type'];
//     meetingWith = json['meeting_with'];
//     meetingAgenda = json['meeting_agenda'];
//     specificPurposeOfTheMeeting = json['specific_purpose_of_the_meeting'];
//     nameOfTheMeeting = json['name_of_the_meeting'];
//     dateOfMeeting = json['date_of_meeting'];
//     timeOfTheMeeting = json['time_of_the_meeting'];
//     durationOfMeeting = json['duration_of_meeting'];
//     meetingMode = json['meeting_mode'];
//     meetingModeType = json['meeting_mode_type'];
//     meetingLink = json['meeting_link'];
//     locationOfTheMeeting = json['location_of_the_meeting'];
//     siecBranch = json['siec_branch'];
//     specificLocationOfTheMeeting = json['specific_location_of_the_meeting'];
//     if (json['siec_participants'] != null) {
//       siecParticipants = <SiecParticipants>[];
//       json['siec_participants'].forEach((v) {
//         siecParticipants!.add(new SiecParticipants.fromJson(v));
//       });
//     }
//     if (json['meeting_coordinator'] != null) {
//       meetingCoordinator = <MeetingCoordinator>[];
//       json['meeting_coordinator'].forEach((v) {
//         meetingCoordinator!.add(new MeetingCoordinator.fromJson(v));
//       });
//     }
//     meetingStarted = json['meeting_started'];
//     isReschedule = json['is_reschedule'];
//     meetingEnded = json['meeting_ended'];
//     meetingExceeded = json['meeting_exceeded'];
//     isActive = json['is_active'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     meetingStartedTime = json['meeting_started_time'];
//     meetingEndedTime = json['meeting_ended_time'];
//     meetingStartedBy = json['meeting_started_by'];
//     meetingEndedBy = json['meeting_ended_by'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['meeting_type'] = this.meetingType;
//     data['meeting_with'] = this.meetingWith;
//     data['meeting_agenda'] = this.meetingAgenda;
//     data['specific_purpose_of_the_meeting'] = this.specificPurposeOfTheMeeting;
//     data['name_of_the_meeting'] = this.nameOfTheMeeting;
//     data['date_of_meeting'] = this.dateOfMeeting;
//     data['time_of_the_meeting'] = this.timeOfTheMeeting;
//     data['duration_of_meeting'] = this.durationOfMeeting;
//     data['meeting_mode'] = this.meetingMode;
//     data['meeting_mode_type'] = this.meetingModeType;
//     data['meeting_link'] = this.meetingLink;
//     data['location_of_the_meeting'] = this.locationOfTheMeeting;
//     data['siec_branch'] = this.siecBranch;
//     data['specific_location_of_the_meeting'] =
//         this.specificLocationOfTheMeeting;
//     if (this.siecParticipants != null) {
//       data['siec_participants'] =
//           this.siecParticipants!.map((v) => v.toJson()).toList();
//     }
//     if (this.meetingCoordinator != null) {
//       data['meeting_coordinator'] =
//           this.meetingCoordinator!.map((v) => v.toJson()).toList();
//     }
//     data['meeting_started'] = this.meetingStarted;
//     data['is_reschedule'] = this.isReschedule;
//     data['meeting_ended'] = this.meetingEnded;
//     data['meeting_exceeded'] = this.meetingExceeded;
//     data['is_active'] = this.isActive;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['meeting_started_time'] = this.meetingStartedTime;
//     data['meeting_ended_time'] = this.meetingEndedTime;
//     data['meeting_started_by'] = this.meetingStartedBy;
//     data['meeting_ended_by'] = this.meetingEndedBy;
//     return data;
//   }
// }

// class SiecParticipants {
//   String? name;
//   int? id;

//   SiecParticipants({this.name, this.id});

//   SiecParticipants.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['id'] = this.id;
//     return data;
//   }
// }