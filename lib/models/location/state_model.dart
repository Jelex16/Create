class StateModel {
  String id;
  String nameState;
  String createdAt;

  StateModel({
    required this.id,
    required this.nameState,
    required this.createdAt,
  });

  factory StateModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return StateModel(
      id: id ?? json['id'],
      nameState: json['nameState'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameState': nameState,
      'createdAt': createdAt,
    };
  }
}
