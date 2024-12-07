class UserModel {
  static UserModel? _instance;

  String? id;
  String? urlProfile;
  String? name;
  String? phone;
  String? inmobiliario;
  String? ciudad;
  String? urlAvatar;
  String? email;
  String? uid;
  String? token;
  String? createdAt;
  bool? isActive;
  int? numberAdvertisement;
  String? nameAdvertisement;

  UserModel._({
    this.id,
    this.urlProfile,
    this.name,
    this.phone,
    this.inmobiliario,
    this.ciudad,
    this.urlAvatar,
    this.email,
    this.uid,
    this.token,
    this.createdAt,
    this.isActive,
    this.numberAdvertisement,
    this.nameAdvertisement,
  });

  factory UserModel.instance() {
    _instance ??= UserModel._();
    return _instance!;
  }

  factory UserModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return UserModel._(
      id: id ?? json['id'],
      urlProfile: json['urlProfile'],
      name: json['name'],
      phone: json['phone'],
      inmobiliario: json['inmobiliario'],
      ciudad: json['ciudad'],
      urlAvatar: json['urlAvatar'],
      email: json['email'],
      uid: json['uid'],
      token: json['token'],
      createdAt: json['createdAt'],
      isActive: json['isActive'],
      numberAdvertisement: json['numberAdvertisement'],
      nameAdvertisement: json['nameAdvertisement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'urlProfile': urlProfile,
      'name': name,
      'phone': phone,
      'inmobiliario': inmobiliario,
      'ciudad': ciudad,
      'urlAvatar': urlAvatar,
      'email': email,
      'uid': uid,
      'token': token,
      'createdAt': createdAt,
      'isActive': isActive,
      'numberAdvertisement': numberAdvertisement,
      'nameAdvertisement': nameAdvertisement
    };
  }

  //set data user

  void setData(UserModel data) {
    id = data.id;
    urlProfile = data.urlProfile;
    name = data.name;
    phone = data.phone;
    inmobiliario = data.inmobiliario;
    ciudad = data.ciudad;
    urlAvatar = data.urlAvatar;
    email = data.email;
    uid = data.uid;
    token = data.token;
    createdAt = data.createdAt;
    isActive = data.isActive;
    numberAdvertisement = data.numberAdvertisement;
    nameAdvertisement = data.nameAdvertisement;
  }

  UserModel getData() {
    return UserModel._(
        id: id,
        email: email,
        name: name,
        phone: phone,
        inmobiliario: inmobiliario,
        ciudad: ciudad,
        urlAvatar: urlAvatar,
        urlProfile: urlProfile,
        uid: uid,
        token: token,
        createdAt: createdAt,
        isActive: isActive,
        numberAdvertisement: numberAdvertisement,
        nameAdvertisement: nameAdvertisement);
  }

  //reset data

  void resetData() {
    id = '';
    urlProfile = '';
    name = '';
    phone = '';
    inmobiliario = '';
    ciudad = '';
    urlAvatar = '';
    email = '';
    uid = '';
    createdAt = '';
    isActive = false;
    numberAdvertisement = 0;
    nameAdvertisement = '';
  }
}
