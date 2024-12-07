class RequestModel {
  String? id;
  String? uidUser;
  bool? isSale;
  bool? isOffer;
  String? estado;
  List<String>? municipios;
  List<String>? colonias;
  String? precio;
  String? category;
  String? createdAt;
  List<String>? offers;
  List<String>? atendidos;
  List<String>? baneados;
  String? metrosCuadrados;
  //int? mensual;
  String? opcYesorNot;
  RequestModel(
      {this.id,
      this.uidUser,
      this.isSale,
      this.isOffer,
      this.estado,
      this.municipios,
      this.colonias,
      this.precio,
      this.category,
      this.createdAt,
      this.offers,
      this.atendidos,
      this.baneados,
      this.metrosCuadrados,
      //this.mensual
      this.opcYesorNot
      });

  RequestModel.fromJson(Map<String, dynamic> json, {String? id}) {
    id = id ?? json['id'];
    uidUser = json['uidUser'];
    isSale = json['isSale'];
    isOffer = json['isOffer'];
    estado = json['estado'];
    municipios = json['municipios'].cast<String>();
    colonias = json['colonias'].cast<String>();
    precio = json['precio'];
    category = json['category'];
    createdAt = json['createdAt'];
    offers = json['offers'].cast<String>();
    atendidos = json['atendidos'].cast<String>();
    baneados = json['baneados'].cast<String>();
    metrosCuadrados = json['metersCuadrados'] ?? '0';
   // mensual = json['mensual'] ?? 0;
   opcYesorNot = json['opcYesorNot'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uidUser': uidUser,
      'isSale': isSale,
      'isOffer': isOffer,
      'estado': estado,
      'municipios': municipios,
      'colonias': colonias,
      'precio': precio,
      'category': category,
      'createdAt': createdAt,
      'offers': offers,
      'atendidos': atendidos,
      'baneados': baneados,
      'metersCuadrados': metrosCuadrados,
      //'mensual': mensual
      'opcYesorNot': opcYesorNot
    };
  }
}
