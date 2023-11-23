import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/meeting_notes_task_model.dart';
import 'package:meeting_module2/presentation/meeting_notes_task/controller/meeting_notes_task_controller.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';

part 'notes_task_event.dart';
part 'notes_task_state.dart';

class NotesTaskBloc extends Bloc<NotesTaskEvent, NotesTaskInitial> {
  ApiServices api;
  NotesTaskBloc({required this.api}) : super(NotesTaskInitial.initial()) {
    on<NotesTaskEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<NotesTaskChangeOpenCloseAllEvent>((event, emit) async {
      // if (event.noteType == NotesTypeToShow.open) {
      emit(state.copyWith(
        selectedOpenOrClose: event.noteType,
        statusOnlySpecificRegion: Status.loading,
      ));
      await Future.delayed(Duration(seconds: 1));
      await getMeetingNotesTaskListForUser(
          Get.find<BaseController>().id.toString(), event.noteType);

      print('object');

      var data = state.copyWith(
          statusOnlySpecificRegion: Status.loaded,
          meetingIdStringData: meetingIdStringData,
          meetingNotesTaskModelList: meetingNotesTaskModelList);

      print(data);
      emit(data);

      print(state);
      // } else {}
    });
  }
  List<MeetingNotesTaskModel> meetingNotesTaskModelList = [];
  List<MeetingIdToStringData> meetingIdStringData = [];
  getMeetingNotesTaskListForUser(String id, int selectedOpenOrCLose) async {
    // loading = true;
    // update();
    var res = await api.getNotesTaskListByUserID(id, selectedOpenOrCLose);

    var list = List<MeetingNotesTaskModel>.from(
        res.map((e) => MeetingNotesTaskModel.fromJson(e)));

    // for (var i = 0; i < list.length; i++) {
    //   meetingNotesTaskModelList.add(list[i]);
    // }

    meetingNotesTaskModelList = list;

    String owner;
    String createdBy;
    String closedBy;

    for (var i = 0; i < meetingNotesTaskModelList.length; i++) {
      owner = await nameFromid(meetingNotesTaskModelList[i].taskOwnerId);
      // owner = await nameFromid(136);

      createdBy = await nameFromid(meetingNotesTaskModelList[i].createdBy);

      // createdBy = await nameFromid(136);
      closedBy = await nameFromid(meetingNotesTaskModelList[i].closedBy);

      // closedBy = await nameFromid(136);

      meetingIdStringData.add(MeetingIdToStringData(
          owner: owner, createdBy: createdBy, closedBy: closedBy));
    }

    print(meetingNotesTaskModelList);
  }

  String nameFromid(id) {
    var data = Get.find<BaseController>().allSiecMembersList;
    var name = '';

    if (id == 0) {
      return 'null';
    }

    AllUserModel hu = data.where((element) => element.id == id).first;
    name = hu.name!;
    // data.where((element) {
    //   print(element);
    //   if (element.id == id) {
    //     name = element.name!;
    //   }
    // });

    return name;
  }
}
