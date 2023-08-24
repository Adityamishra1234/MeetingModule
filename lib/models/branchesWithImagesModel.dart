class BranchWithImagesModel {
  int? id;
  String? name;
  String? address;
  String? link;
  String? imageLink;

  BranchWithImagesModel(
      {this.id, this.name, this.address, this.link, this.imageLink});

  BranchWithImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    link = json['link'];
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['link'] = this.link;
    data['image_link'] = this.imageLink;
    return data;
  }
}
