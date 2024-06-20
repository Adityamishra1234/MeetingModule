class AllStatesModel {
  String? status1;
  List<Data>? data;

  AllStatesModel({this.status1, this.data});

  AllStatesModel.fromJson(Map<String, dynamic> json) {
    status1 = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status1;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? stateName;

  Data({this.id, this.stateName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    return data;
  }
}



//different model
class CityModel {
  String? status2;
  List<Data1>? data1;

  CityModel({this.status2, this.data1});

  CityModel.fromJson(Map<String, dynamic> json) {
    status2 = json['status'];
    if (json['data'] != null) {
      data1 = <Data1>[];
      json['data'].forEach((v) {
        data1!.add(new Data1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data1 = new Map<String, dynamic>();
    data1['status'] = this.status2;
    if (this.data1 != null) {
      data1['data'] = this.data1!.map((v) => v.toJson()).toList();
    }
    return data1;
  }
}

class Data1 {
  int? id;
  String? cityName;

  Data1({this.id, this.cityName});

  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data1 = new Map<String, dynamic>();
    data1['id'] = this.id;
    data1['city_name'] = this.cityName;
    return data1;
  }
}



//this is for affiliation model

class AllAffiliationModel {
  String? status3;
  List<Data3>? data3;

  AllAffiliationModel({this.status3, this.data3});

  AllAffiliationModel.fromJson(Map<String, dynamic> json) {
    status3 = json['status'];
    if (json['data'] != null) {
      data3 = <Data3>[];
      json['data'].forEach((v) {
        data3!.add(new Data3.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data3 = new Map<String, dynamic>();
    data3['status'] = this.status3;
    if (this.data3 != null) {
      data3['data'] = this.data3!.map((v) => v.toJson()).toList();
    }
    return data3;
  }
}

class Data3 {
  int? id;
  String? affiliationName;

  Data3({this.id, this.affiliationName});

  Data3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    affiliationName = json['affiliation_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data3 = new Map<String, dynamic>();
    data3['id'] = this.id;
    data3['affiliation_name'] = this.affiliationName;
    return data3;
  }
}
