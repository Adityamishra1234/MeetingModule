class AllBranchModel {
  String? branchName;
  int? id;

  AllBranchModel({this.branchName, this.id});

  AllBranchModel.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_name'] = this.branchName;
    data['id'] = this.id;
    return data;
  }
}
