class SearchInstituteModel {
  String? status;
  List<Data>? data;

  SearchInstituteModel({this.status, this.data});

  SearchInstituteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? universityName;

  Data({this.id, this.universityName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    universityName = json['university_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['university_name'] = this.universityName;
    return data;
  }
}
