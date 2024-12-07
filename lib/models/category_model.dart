class CategoryModel {
  String? id;
  String? name;
  String? attribute1;
  String? attribute2;
  String? createdAt;

  CategoryModel({this.id, this.name,this.attribute1,this.attribute2, this.createdAt});

  CategoryModel.fromJson(Map<String, dynamic> json, {String? id}) {
    id = id ?? json['id'];
    name = json['name'];
    attribute1 =json['attribute1'];
    attribute2 =json['attribute2'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'attribute1':attribute1, 'attribute2':attribute2, 'createdAt': createdAt};
  }
}
