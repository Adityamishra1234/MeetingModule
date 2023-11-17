import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/models/meeting_notes_task_model.dart';
import 'package:meeting_module2/services/apiServices.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';

class MeetingNotesTaskController extends GetxController with StateMixin {
  ApiServices api = ApiServices();

  int selectedOpenOrClose = 0;

  var id = 0;

  @override
  void onInit() async {
    id = Get.find<BaseController>().id;

    await getMeetingNotesTaskListForUser(id.toString());

    change(null, status: RxStatus.success());

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    getMeetingNotesTaskListForUser(id.toString());
    super.onReady();
  }

  List<MeetingNotesTaskModel> meetingNotesTaskModelList = [];
  List<MeetingIdToStringData> meetingIdStringData = [];
  bool loading = false;
  getMeetingNotesTaskListForUser(String id) async {
    loading = true;
    update();
    var res = await api.getNotesTaskListByUserID(id, selectedOpenOrClose);

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

    update();
    loading = false;
    update();
    change(null, status: RxStatus.success());
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

class MeetingIdToStringData {
  final String owner;
  final String createdBy;
  final String closedBy;

  MeetingIdToStringData(
      {required this.owner, required this.createdBy, required this.closedBy});
}
