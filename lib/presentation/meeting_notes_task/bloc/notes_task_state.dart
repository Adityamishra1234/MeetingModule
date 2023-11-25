part of 'notes_task_bloc.dart';

sealed class NotesTaskState extends Equatable {
  const NotesTaskState();
}

enum Status {
  initial,
  loading,
  loaded,
  error,
}

class NotesTaskInitial extends NotesTaskState {
  Status status;
  List<MeetingNotesTaskModel> meetingNotesTaskModelList;
  List<MeetingIdToStringData> meetingIdStringData;
  int selectedOpenOrClose;
  Status statusOnlySpecificRegion;

  NotesTaskInitial(
      {required this.status,
      required this.selectedOpenOrClose,
      required this.meetingIdStringData,
      required this.statusOnlySpecificRegion,
      required this.meetingNotesTaskModelList});

  static NotesTaskInitial initial() => NotesTaskInitial(
      status: Status.loaded,
      statusOnlySpecificRegion: Status.loaded,
      meetingIdStringData: [],
      selectedOpenOrClose: 0,
      meetingNotesTaskModelList: []);

  NotesTaskInitial copyWith(
      {Status? status,
      Status? statusOnlySpecificRegion,
      int? selectedOpenOrClose,
      List<MeetingNotesTaskModel>? meetingNotesTaskModelList,
      List<MeetingIdToStringData>? meetingIdStringData}) {
    return NotesTaskInitial(
        statusOnlySpecificRegion:
            statusOnlySpecificRegion ?? this.statusOnlySpecificRegion,
        selectedOpenOrClose: selectedOpenOrClose ?? this.selectedOpenOrClose,
        status: status ?? this.status,
        meetingIdStringData: meetingIdStringData ?? this.meetingIdStringData,
        meetingNotesTaskModelList:
            meetingNotesTaskModelList ?? this.meetingNotesTaskModelList);
  }

  @override
  List<Object?> get props => [
        this.status,
        this.statusOnlySpecificRegion,
        this.selectedOpenOrClose,
        this.meetingIdStringData,
        this.meetingNotesTaskModelList
      ];
}

// final class NotesTaskLoadingMainState extends NotesTaskState {}



// final class NotesTaskLoadingMainSuccessfullState extends NotesTaskState {}
