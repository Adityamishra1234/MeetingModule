import 'package:get/get.dart';
import 'package:meeting_module2/models/allUserModel.dart';
import 'package:meeting_module2/ui/controller/base_controller.dart';

extension SiecMemeberNameFromIdExtension on int {
  String nameFromId() {
    var data = Get.find<BaseController>().allSiecMembersList;
    var name = '';
    data.where((element) {
      if (element.id == this) {
        name = element.name!;
      }
      return true;
    });

    return name;
  }
}
