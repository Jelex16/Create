class ColoniesModel {
  String id;
  String nameColo;
  String idFk;
  String createdAt;

  ColoniesModel({
    required this.id,
    required this.nameColo,
    required this.idFk,
    required this.createdAt,
  });

  factory ColoniesModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return ColoniesModel(
      id: id ?? json['id'],
      nameColo: json['nameColo'],
      idFk: json['idFk'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameColo': nameColo,
      'idFk': idFk,
      'createdAt': createdAt,
    };
  }
}
