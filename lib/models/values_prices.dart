class ValuesPrices {
  String? id;
  double? value1;
  double? value2;
  String? createdAt;

  ValuesPrices({this.id, this.value1, this.value2, this.createdAt});

  ValuesPrices.fromJson(Map<String, dynamic> json, {String? id}) {
    id = id ?? json['id'];
    value1 = json['value1'];
    value2 = json['value2'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value1': value1,
      'value2': value2,
      'createdAt': createdAt,
    };
  }
}
