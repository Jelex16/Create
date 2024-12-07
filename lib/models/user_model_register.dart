import 'package:match_home_client/shared/validator/validator.dart';

class UserModelRegister {
  String? id;
  String? urlProfile;
  GeneralField? name;
  TelePhone? phone;
  GeneralField? inmobiliario;
  GeneralField? ciudad;
  String? urlAvatar;
  Email? email;
  Password? password;

  UserModelRegister({
    this.id,
    this.urlProfile,
    this.name,
    this.phone,
    this.inmobiliario,
    this.ciudad,
    this.urlAvatar,
    this.email,
    this.password,
  });

  UserModelRegister.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urlProfile = json['urlProfile'];
    name = json['name'] != null
        ? GeneralField.dirty(json['name'])
        : const GeneralField.pure();
    phone = json['phone'] != null
        ? TelePhone.dirty(json['phone'])
        : const TelePhone.pure();
    inmobiliario = json['inmobiliario'] != null
        ? GeneralField.dirty(json['inmobiliario'])
        : const GeneralField.pure();
    ciudad = json['ciudad'] != null
        ? GeneralField.dirty(json['ciudad'])
        : const GeneralField.pure();
    urlAvatar = json['urlAvatar'];
    email =
        json['email'] != null ? Email.dirty(json['email']) : const Email.pure();
    password = json['password'] != null
        ? Password.dirty(json['password'])
        : const Password.pure();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'urlProfile': urlProfile,
      'name': name!.value,
      'phone': phone!.value,
      'inmobiliario': inmobiliario!.value,
      'ciudad': ciudad!.value,
      'urlAvatar': urlAvatar,
      'email': email!.value,
      'password': password!.value,
    };
  }

  //copyWith
  UserModelRegister copyWith({
    String? id,
    String? urlProfile,
    GeneralField? name,
    TelePhone? phone,
    GeneralField? inmobiliario,
    GeneralField? ciudad,
    String? urlAvatar,
    Email? email,
    Password? password,
  }) {
    return UserModelRegister(
      id: id ?? this.id,
      urlProfile: urlProfile ?? this.urlProfile,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      inmobiliario: inmobiliario ?? this.inmobiliario,
      ciudad: ciudad ?? this.ciudad,
      urlAvatar: urlAvatar ?? this.urlAvatar,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
