class MunicipalityModel {
  String id;
  String nameMuni;
  String idFk;
  String createdAt;

  MunicipalityModel({
    required this.id,
    required this.nameMuni,
    required this.idFk,
    required this.createdAt,
  });

  factory MunicipalityModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return MunicipalityModel(
      id: id ?? json['id'],
      nameMuni: json['nameMuni'],
      idFk: json['idFk'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameMuni': nameMuni,
      'idFk': idFk,
      'createdAt': createdAt,
    };
  }
}
