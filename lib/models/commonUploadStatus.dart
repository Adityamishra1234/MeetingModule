import 'package:meeting_module2/models/commonUploadDocument.dart';

class CommonUploadStatus {
  String? status;
  String? data;
  CommonUploadDocument? dataModal;

  CommonUploadStatus({this.status, this.data, this.dataModal});

  CommonUploadStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    dataModal = json['dataModal'] != null
        ? CommonUploadDocument.fromJson(json['dataModal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data;
    if (dataModal != null) {
      data['dataModal'] = dataModal!.toJson();
    }
    return data;
  }
}
