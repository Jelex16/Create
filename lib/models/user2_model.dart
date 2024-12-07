class UserModel2 {
  
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

  UserModel2({
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
    this.nameAdvertisement
  });

 
  UserModel2.fromJson(Map<String, dynamic> json, {String? id}) {
    
      id = id ?? json['id'];
      urlProfile= json['urlProfile'];
      name= json['name'];
      phone= json['phone'];
      inmobiliario= json['inmobiliario'];
      ciudad= json['ciudad'];
      urlAvatar= json['urlAvatar'];
      email= json['email'];
      uid= json['uid'];
      token= json['token'];
      createdAt= json['createdAt'];
      isActive= json['isActive'];
      numberAdvertisement= json['numberAdvertisement'];
      nameAdvertisement= json['nameAdvertisement'];
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


}