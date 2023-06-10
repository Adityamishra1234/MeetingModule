import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:meeting_module2/utils/constants.dart';
import 'package:meeting_module2/utils/snackbarconstants.dart';

uploadDocument(String id, int index) async {
  try {
    String uploadFilename = "";
    PlatformFile? csvFile2;
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'tiff', 'pdf', 'doc', 'docx'],
    );

    if (results != null) {
      csvFile2 = results.files.first;
      uploadFilename = results.files.first.name;
    } else {
      // model.documents![index].viewLink = "";
      // update();
    }
    if (csvFile2 != null) {
      if (csvFile2.path != null) {
        final f = File(csvFile2.path!);
        int sizeInBytes = f.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 5) {
          getToast('${SnackBarConstants.toastForUploadFile}');
        } else {
          // String? res = await apiServices.sendFile(
          //     csvFile2.path,
          //     uploadFilename,
          //     Get.find<BaseController>().model1.id.toString(),
          //     id,
          //     Endpoints.applicationDocumentUpload!);
          // model.documents![index].viewLink = res;
          // update();
        }
      }
    }
  } catch (e) {
    // await ApiServices().errorHandle(
    //   Get.find<BaseController>().model1.id.toString(),
    //   e.toString(),
    //   "1111",
    //   StackTrace.current.toString(),
    // );
  }
}
