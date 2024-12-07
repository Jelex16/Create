import 'package:match_home_client/shared/validator/validator.dart';

class OfferCreateModel {
  String? id;
  bool? isSale;
  bool? isOffer;
  GeneralField? estado;
  GeneralField? municipio;
  GeneralField? colonia;
  NumberInput? precio;
  GeneralField? attributo1;
  GeneralField? attributo2;
  List<String>? images;
  String? category;
  String? uidUser;
  List<String>? offers;
  List<String>? atendidos;
  List<String>? baneados;
  String? metrosCuadrados;
  //int? mensual;

  OfferCreateModel({
    this.id,
    this.isSale,
    this.isOffer,
    this.estado,
    this.municipio,
    this.colonia,
    this.precio,
    this.attributo1,
    this.attributo2,
    this.images,
    this.category,
    this.uidUser,
    this.offers,
    this.metrosCuadrados,
    this.atendidos,
    this.baneados,
    //this.mensual
  });

  //from joson

  OfferCreateModel.fromJson(Map<String, dynamic> json, {String? id}) {
    id = id ?? json['id'];
    isOffer = json['isOffer'];
    isSale = json['isSale'];
    estado = GeneralField.dirty(json['estado']);
    municipio = GeneralField.dirty(json['municipio']);
    colonia = GeneralField.dirty(json['colonia']);
    precio = NumberInput.dirty(json['precio']);
    attributo1 = GeneralField.dirty(json['attributo1']);
    attributo2 = GeneralField.dirty(json['attributo2']);
    images = json['images'];
    category = json['category'];
    uidUser = json['uidUser'];
    offers = json['offers'];
    metrosCuadrados = json['metersCuadrados'] ?? '0';
    atendidos = json['atendidos'];
    baneados = json['baneados'];
    //mensual = json['mensual'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isOffer': isOffer,
      'isSale': isSale,
      'estado': estado?.value,
      'municipio': municipio?.value,
      'colonia': colonia?.value,
      'precio': precio?.value,
      'attributo1': attributo1?.value,
      'attributo2': attributo2?.value,
      'images': images,
      'category': category,
      'uidUser': uidUser,
      'offers': offers,
      'metersCuadrados': metrosCuadrados,
      'atendidos': atendidos,
      'baneados': baneados,
      // 'mensual': mensual
    };
  }

  //copy with

  OfferCreateModel copyWith(
      {bool? isSale,
      bool? isOffer,
      GeneralField? estado,
      GeneralField? municipio,
      GeneralField? colonia,
      NumberInput? precio,
      GeneralField? attributo1,
      GeneralField? attributo2,
      List<String>? images,
      String? category,
      String? uidUser,
      String? metrosCuadrados,
      //int? mensual,
      List<String>? offers,
      List<String>? atendidos,
      List<String>? baneados}) {
    return OfferCreateModel(
      isOffer: isOffer ?? this.isOffer,
      isSale: isSale ?? this.isSale,
      estado: estado ?? this.estado,
      municipio: municipio ?? this.municipio,
      colonia: colonia ?? this.colonia,
      precio: precio ?? this.precio,
      attributo1: attributo1 ?? this.attributo1,
      attributo2: attributo2 ?? this.attributo2,
      images: images ?? this.images,
      category: category ?? this.category,
      uidUser: uidUser ?? this.uidUser,
      offers: offers ?? this.offers,
      atendidos: atendidos ?? this.atendidos,
      baneados: baneados ?? this.baneados,
      metrosCuadrados: metrosCuadrados ?? this.metrosCuadrados,
      //mensual: mensual ?? this.mensual
    );
  }
}
