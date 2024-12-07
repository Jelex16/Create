class SuscribeModel{
  String? id;
  String? name;
  String? price;
  String? cantidad;
  String? createdAt;

  SuscribeModel({this.id,this.name,this.price,this.cantidad,this.createdAt});

  SuscribeModel.fromJson(Map<String, dynamic> json, {String? id}) {
    id = id ?? json['id'];
    name = json['name'];
    price =json['price'];
    cantidad =json['cantidad'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name,'price': price, 'cantidad': cantidad ,'createdAt': createdAt};
  }

}