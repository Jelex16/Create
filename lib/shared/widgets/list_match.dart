import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

/*List<OfferCreateModel> listMatch(//<--- hace una lista de mach cuando se entra a la pagina requisitos
    List<OfferCreateModel> listaOfre, RequestModel requisitos) {
  List<OfferCreateModel> list = [];

  for (var oferta in listaOfre) {
    if ((requisitos.category != 'BODEGAS' && requisitos.category != 'NAVES INDUSTRIALES' && requisitos.category != 'LOCALES' ) &&
       (requisitos.category == oferta.category &&
        requisitos.estado == oferta.estado?.value &&
        requisitos.municipios!.contains(oferta.municipio?.value) &&
        requisitos.colonias!.contains(oferta.colonia?.value))) {
      var pricee = requisitos.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);

      if (price1 <= price3 && price2 >= price3) {
        list.add(oferta);
      }
    }else if(requisitos.category == oferta.category &&
        requisitos.estado == oferta.estado?.value &&
        requisitos.municipios!.contains(oferta.municipio?.value) &&
        requisitos.colonias!.contains(oferta.colonia?.value)) {
      var pricee = requisitos.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);

      var metros =requisitos.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(oferta.attributo1!.value)){
          if (price1 <= price3 && price2 >= price3) {
            list.add(oferta);
          }
        }
      }else{
        if(meters1 <= double.parse(oferta.attributo1!.value) && meters2 >= double.parse(oferta.attributo1!.value)){
          if (price1 <= price3 && price2 >= price3) {
            list.add(oferta);
          }
        }
      }

    }
  }

  return list;
}*/


/*List<OfferCreateModel> listMatch(//<--- hace una lista de mach cuando se entra a la pagina requisitos
    List<OfferCreateModel> listaOfre, RequestModel requisitos) {
  List<OfferCreateModel> list = [];

  for (var oferta in listaOfre) {
    if ((requisitos.category != 'BODEGAS' && requisitos.category != 'NAVES INDUSTRIALES' && requisitos.category != 'LOCALES' ) &&
       (requisitos.category == oferta.category &&
        requisitos.estado == oferta.estado?.value &&
        requisitos.isSale == oferta.isSale &&
        requisitos.municipios!.contains(oferta.municipio?.value) &&
        requisitos.colonias!.contains(oferta.colonia?.value))) {
      var pricee = requisitos.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);

      if(price2 == 0000){
        if(price1 <= price3){
          list.add(oferta);
        }
      }else if (price1 <= price3 && price2 >= price3) {
        list.add(oferta);
      }
    }else if(requisitos.category == oferta.category &&
        requisitos.estado == oferta.estado?.value &&
        requisitos.isSale == oferta.isSale &&
        requisitos.municipios!.contains(oferta.municipio?.value) &&
        requisitos.colonias!.contains(oferta.colonia?.value)) {
      var pricee = requisitos.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);

      var metros =requisitos.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(oferta.attributo1!.value)){
          if(price2==0000){
            if(price1 <= price3){
              list.add(oferta);
            }
          }else if (price1 <= price3 && price2 >= price3) {
            list.add(oferta);
          }
        }
      }else{
        if(meters1 <= double.parse(oferta.attributo1!.value) && meters2 >= double.parse(oferta.attributo1!.value)){
          if(price2==0000){
            if(price1 <= price3){
              list.add(oferta);
            }
          }else if (price1 <= price3 && price2 >= price3) {
            list.add(oferta);
          }
        }
      }

    }
  }

  return list;
}*/

List<OfferCreateModel> listMatch(//<--- hace una lista de mach cuando se entra a la pagina requisitos
    List<OfferCreateModel> listaOfre, RequestModel requisitos) {
  List<OfferCreateModel> list = [];

  for (var oferta in listaOfre) {
    if ((requisitos.category != 'BODEGAS' && requisitos.category != 'NAVES INDUSTRIALES' && requisitos.category != 'LOCALES' ) &&
       (requisitos.category == oferta.category &&
        requisitos.estado == oferta.estado?.value &&
        requisitos.isSale == oferta.isSale &&
        requisitos.municipios!.contains(oferta.municipio?.value) &&
        requisitos.colonias!.contains(oferta.colonia?.value))) {
      var pricee = requisitos.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);

      if(price2 == 0000){
        if(price1 <= price3){
          list.add(oferta);
        }
      }else if (price1 <= price3 && price2 >= price3) {
        list.add(oferta);
      }
    }else if(requisitos.category == oferta.category &&
        requisitos.estado == oferta.estado?.value &&
        requisitos.isSale == oferta.isSale &&
        requisitos.opcYesorNot == oferta.attributo2?.value &&
        requisitos.municipios!.contains(oferta.municipio?.value) &&
        requisitos.colonias!.contains(oferta.colonia?.value)) {
      

      var metros =requisitos.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(oferta.attributo1!.value)){  
              list.add(oferta);
        }
      }else{
        if(meters1 <= double.parse(oferta.attributo1!.value) && meters2 >= double.parse(oferta.attributo1!.value)){
              list.add(oferta);
        }
      }

    }
  }

  if(requisitos.atendidos!=null){
    List<OfferCreateModel> list2 = [];
  for (var requi in list) {
    if(!requisitos.atendidos!.contains(requi.id!)){
      list2.add(requi);
    }
  }

  list = list2;
  }

  if(requisitos.baneados!=null){
    List<OfferCreateModel> list2 = [];
  for (var requi in list) {
    if(!requisitos.baneados!.contains(requi.id!)){
      list2.add(requi);
    }
  }

  list = list2;
  }

  return list;
}

/////////////////////////////////////////////////////////////
/*List<String> addlistMatch(//<---crea el mach cuando se crea el requisito
  List<OfferCreateModel> listaOfre,
  OfferCreateModel requisitos,
  List<String> municipalities,
  List<String> colonies,
) {
  List<OfferCreateModel> list = [];
  List<String> listIDoFert = [];
  for (var oferta in listaOfre) {
    if ((requisitos.category != 'BODEGAS' && requisitos.category != 'NAVES INDUSTRIALES' && requisitos.category != 'LOCALES') &&
       (requisitos.category == oferta.category &&
        requisitos.estado?.value == oferta.estado?.value &&
        municipalities.contains(oferta.municipio?.value) &&
        colonies.contains(oferta.colonia?.value))) {
      var pricee = requisitos.precio!.value.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);

      if (price1 <= price3 && price2 >= price3) {
        list.add(oferta);
      }
    }else if(requisitos.category == oferta.category &&
        requisitos.estado?.value == oferta.estado?.value &&
        municipalities.contains(oferta.municipio?.value) &&
        colonies.contains(oferta.colonia?.value)) {
      var pricee = requisitos.precio!.value.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);

      var metros =requisitos.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(oferta.attributo1!.value)){
          if (price1 <= price3 && price2 >= price3) {
            list.add(oferta);
          }
        }
      }else{
        if(meters1 <= double.parse(oferta.attributo1!.value) && meters2 >= double.parse(oferta.attributo1!.value)){
          if (price1 <= price3 && price2 >= price3) {
            list.add(oferta);
          }
        }
      }

    }
  }

  for (var oferta in list) {
    listIDoFert.add(oferta.id!);
  }
  return listIDoFert;
}*/

/*List<String> addlistMatch(//<---crea el mach cuando se crea el requisito
  List<OfferCreateModel> listaOfre,
  OfferCreateModel requisitos,
  List<String> municipalities,
  List<String> colonies,
) {
  List<OfferCreateModel> list = [];
  List<String> listIDoFert = [];
  for (var oferta in listaOfre) {
    if ((requisitos.category != 'BODEGAS' && requisitos.category != 'NAVES INDUSTRIALES' && requisitos.category != 'LOCALES') &&
       (requisitos.category == oferta.category &&
       requisitos.isSale == oferta.isSale &&
        requisitos.estado?.value == oferta.estado?.value &&
        municipalities.contains(oferta.municipio?.value) &&
        colonies.contains(oferta.colonia?.value))) {
      var pricee = requisitos.precio!.value.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);
      if(price2==0000){
        if(price1 <= price3){
          list.add(oferta);
        }
      }else if (price1 <= price3 && price2 >= price3) {
        list.add(oferta);
      }
    }else if(requisitos.category == oferta.category &&
        requisitos.isSale == oferta.isSale &&
        requisitos.estado?.value == oferta.estado?.value &&
        municipalities.contains(oferta.municipio?.value) &&
        colonies.contains(oferta.colonia?.value)) {
      var pricee = requisitos.precio!.value.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);

      var metros =requisitos.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(oferta.attributo1!.value)){
          if(price2==0000){
            if(price1 <= price3){
              list.add(oferta);
            }
          }else if (price1 <= price3 && price2 >= price3) {
            list.add(oferta);
          }
        }
      }else{
        if(meters1 <= double.parse(oferta.attributo1!.value) && meters2 >= double.parse(oferta.attributo1!.value)){
          if(price2==0000){
            if(price1 <= price3){
              list.add(oferta);
            }
          }else if (price1 <= price3 && price2 >= price3) {
            list.add(oferta);
          }
        }
      }

    }
  }

  for (var oferta in list) {
    listIDoFert.add(oferta.id!);
  }
  return listIDoFert;
}*/

List<String> addlistMatch(//<---crea el mach cuando se crea el requisito
  List<OfferCreateModel> listaOfre,
  OfferCreateModel requisitos,
  List<String> municipalities,
  List<String> colonies,
) {
  List<OfferCreateModel> list = [];
  List<String> listIDoFert = [];
  for (var oferta in listaOfre) {
    if ((requisitos.category != 'BODEGAS' && requisitos.category != 'NAVES INDUSTRIALES' && requisitos.category != 'LOCALES') &&
       (requisitos.category == oferta.category &&
       requisitos.isSale == oferta.isSale &&
        requisitos.estado?.value == oferta.estado?.value &&
        municipalities.contains(oferta.municipio?.value) &&
        colonies.contains(oferta.colonia?.value))) {
      var pricee = requisitos.precio!.value.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(oferta.precio!.value);
      if(price2==0000){
        if(price1 <= price3){
          list.add(oferta);
        }
      }else if (price1 <= price3 && price2 >= price3) {
        list.add(oferta);
      }
    }else if(requisitos.category == oferta.category &&
        requisitos.isSale == oferta.isSale &&
        requisitos.estado?.value == oferta.estado?.value &&
        requisitos.attributo2?.value == oferta.attributo2?.value &&
        municipalities.contains(oferta.municipio?.value) &&
        colonies.contains(oferta.colonia?.value)) {

      var metros =requisitos.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(oferta.attributo1!.value)){
         
              list.add(oferta);
        }
      }else{
        if(meters1 <= double.parse(oferta.attributo1!.value) && meters2 >= double.parse(oferta.attributo1!.value)){
          
              list.add(oferta);
        }
      }

    }
  }

  for (var oferta in list) {
    listIDoFert.add(oferta.id!);
  }
  return listIDoFert;
}

//////////////////////////////////////////////////////////////////////////
/*List<String> addMatchRequit(//<---crea el mach cuando se crea la oferta
    List<RequestModel> listaReq, OfferCreateModel ofertaModel) {
  List<String> list = [];

  for (var requi in listaReq) {
    if ((ofertaModel.category != 'BODEGAS' && ofertaModel.category != 'NAVES INDUSTRIALES' && ofertaModel.category != 'LOCALES') &&
       (ofertaModel.category == requi.category &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value))) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);

      if (price1 <= price3 && price2 >= price3) {
        list.add(requi.id!);
      }
    } else if (ofertaModel.category == requi.category &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value)) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);

      var metros =requi.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(ofertaModel.attributo1!.value)){
          if (price1 <= price3 && price2 >= price3) {
            list.add(requi.id!);
          }
        }
      }else{
        if(meters1 <= double.parse(ofertaModel.attributo1!.value) && meters2 >= double.parse(ofertaModel.attributo1!.value)){
          if (price1 <= price3 && price2 >= price3) {
            list.add(requi.id!);
          }
        }
      }


    }
  }

  return list;
}*/

/*List<String> addMatchRequit(//<---crea el mach cuando se crea la oferta
    List<RequestModel> listaReq, OfferCreateModel ofertaModel) {
  List<String> list = [];

  for (var requi in listaReq) {
    if ((ofertaModel.category != 'BODEGAS' && ofertaModel.category != 'NAVES INDUSTRIALES' && ofertaModel.category != 'LOCALES') &&
       (ofertaModel.category == requi.category &&
       ofertaModel.isSale == requi.isSale &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value))) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);
      if(price2==0000){
        if(price1 <= price3){
          list.add(requi.id!);
        }
      }else if (price1 <= price3 && price2 >= price3) {
        list.add(requi.id!);
      }
    } else if (ofertaModel.category == requi.category &&
        ofertaModel.isSale == requi.isSale &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value)) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);

      var metros =requi.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(ofertaModel.attributo1!.value)){
          if(price2==0000){
            if(price1 <= price3){
              list.add(requi.id!);
            }
          }else if (price1 <= price3 && price2 >= price3) {
            list.add(requi.id!);
          }
        }
      }else{
        if(meters1 <= double.parse(ofertaModel.attributo1!.value) && meters2 >= double.parse(ofertaModel.attributo1!.value)){
          if(price2==0000){
            if(price1 <= price3){
              list.add(requi.id!);
            }
          }else if (price1 <= price3 && price2 >= price3) {
            list.add(requi.id!);
          }
        }
      }


    }
  }

  return list;
}*/
List<String> addMatchRequit(//<---crea el mach cuando se crea la oferta
    List<RequestModel> listaReq, OfferCreateModel ofertaModel) {
  List<String> list = [];

  for (var requi in listaReq) {
    if ((ofertaModel.category != 'BODEGAS' && ofertaModel.category != 'NAVES INDUSTRIALES' && ofertaModel.category != 'LOCALES') &&
       (ofertaModel.category == requi.category &&
       ofertaModel.isSale == requi.isSale &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value))) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);
      if(price2==0000){
        if(price1 <= price3){
          list.add(requi.id!);
        }
      }else if (price1 <= price3 && price2 >= price3) {
        list.add(requi.id!);
      }
    } else if (ofertaModel.category == requi.category &&
        ofertaModel.isSale == requi.isSale &&
        ofertaModel.estado?.value == requi.estado &&
        ofertaModel.attributo2?.value == requi.opcYesorNot &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value)) {
      

      var metros =requi.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(ofertaModel.attributo1!.value)){
              list.add(requi.id!);
        }
      }else{
        if(meters1 <= double.parse(ofertaModel.attributo1!.value) && meters2 >= double.parse(ofertaModel.attributo1!.value)){
      
              list.add(requi.id!);
        }
      }


    }
  }

  return list;
}
////////////////////////////////////////////////////////////////////////
void updateMatchRequisitos(List<OfferCreateModel> listaOfre,
    RequestModel requisitos, List<RequestModel> requets) async {
  List<String> listUpdate = [];
  for (var req in requets) {
    if (req.id == requisitos.id) {
      {
        for (var ofre in listaOfre) {
          if (!(req.offers!.contains(ofre.id!))) {
            listUpdate.add(ofre.id!);
          }
        }
      }
    }
  }

  if (listUpdate.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection('request')
        .doc('${requisitos.id}')
        .update({
      'offers': listUpdate,
    });
  }
}

////////////////////////////////////////////////////////////////
void updateMatchofertas(List<OfferCreateModel> listaOfre,
    OfferCreateModel oferta, List<RequestModel> requets) async {
  List<String> listUpdate = [];
  for (var ofre in listaOfre) {
    if (ofre.id == oferta.id) {
      for (var req in requets) {
        if (ofre.offers != null) {
          if (!(ofre.offers!.contains(req.id!))) {
            listUpdate.add(req.id!);
          }
        }
      }
    }
  }
  if ((listUpdate.isNotEmpty)) {
    await FirebaseFirestore.instance
        .collection('offering')
        .doc('${oferta.id}')
        .update({
      'offers': listUpdate,
    });
  }
}

////////////////////////////////////////////////////////
UserModel2 usurio(String idUser, List<UserModel2> listUser) {
  UserModel2 user = UserModel2();
  //var uid=codigoUser(idUser) ;
  for (var i = 0; i < listUser.length; i++) {
    if (listUser[i].uid == idUser) {
      user = listUser[i];
      return user;
    }
  }
  return user;
}

/////////////////////////////////////////////////////////////////////

/*List<RequestModel> listMatchRequit(//<---cre una lista de mach cuando se entra en la pagina de ofrecimiento
    List<RequestModel> listaRequi, OfferCreateModel ofertaModel) {
  List<RequestModel> list = [];

  for (var requi in listaRequi) {
    if ((ofertaModel.category != 'BODEGAS' && ofertaModel.category != 'NAVES INDUSTRIALES' && ofertaModel.category != 'LOCALES') &&
       (ofertaModel.category == requi.category &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value))) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);

      if (price1 <= price3 && price2 >= price3) {
        list.add(requi);
      }
    } else if (ofertaModel.category == requi.category &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value)) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);

      var metros =requi.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(ofertaModel.attributo1!.value)){
          if (price1 <= price3 && price2 >= price3) {
            list.add(requi);
          }
        }
      }else{
        if(meters1 <= double.parse(ofertaModel.attributo1!.value) && meters2 >= double.parse(ofertaModel.attributo1!.value)){
          if (price1 <= price3 && price2 >= price3) {
            list.add(requi);
          }
        }
      }

    }
  }

  return list;
}*/

/*List<RequestModel> listMatchRequit(//<---cre una lista de mach cuando se entra en la pagina de ofrecimiento
    List<RequestModel> listaRequi, OfferCreateModel ofertaModel) {
  List<RequestModel> list = [];

  for (var requi in listaRequi) {
    if ((ofertaModel.category != 'BODEGAS' && ofertaModel.category != 'NAVES INDUSTRIALES' && ofertaModel.category != 'LOCALES') &&
       (ofertaModel.category == requi.category &&
        ofertaModel.isSale == requi.isSale &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value))) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);
      if(price2==0000){
        if(price1 <= price3){
          list.add(requi);
        }
      }else if (price1 <= price3 && price2 >= price3) {
        list.add(requi);
      }
    } else if (ofertaModel.category == requi.category &&
        ofertaModel.isSale == requi.isSale &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value)) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);

      var metros =requi.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(ofertaModel.attributo1!.value)){
          if(price2==0000){
            if(price1 <= price3){
              list.add(requi);
            }
          }else if (price1 <= price3 && price2 >= price3) {
            list.add(requi);
          }
        }
      }else{
        if(meters1 <= double.parse(ofertaModel.attributo1!.value) && meters2 >= double.parse(ofertaModel.attributo1!.value)){
          if(price2==0000){
            if(price1 <= price3){
              list.add(requi);
            }
          }else if (price1 <= price3 && price2 >= price3) {
            list.add(requi);
          }
        }
      }

    }
  }

  return list;
}*/

List<RequestModel> listMatchRequit(//<---cre una lista de mach cuando se entra en la pagina de ofrecimiento
    List<RequestModel> listaRequi, OfferCreateModel ofertaModel) {
  List<RequestModel> list = [];

  for (var requi in listaRequi) {
    if ((ofertaModel.category != 'BODEGAS' && ofertaModel.category != 'NAVES INDUSTRIALES' && ofertaModel.category != 'LOCALES') &&
       (ofertaModel.category == requi.category &&
        ofertaModel.isSale == requi.isSale &&
        ofertaModel.estado?.value == requi.estado &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value))) {
      var pricee = requi.precio!.split(" - ");
      double price1 = double.parse(pricee[0]);
      double price2 = double.parse(pricee[1]);
      double price3 = double.parse(ofertaModel.precio!.value);
      if(price2==0000){
        if(price1 <= price3){
          list.add(requi);
        }
      }else if (price1 <= price3 && price2 >= price3) {
        list.add(requi);
      }
    } else if (ofertaModel.category == requi.category &&
        ofertaModel.isSale == requi.isSale &&
        ofertaModel.estado?.value == requi.estado &&
        ofertaModel.attributo2?.value == requi.opcYesorNot &&
        requi.municipios!.contains(ofertaModel.municipio?.value) &&
        requi.colonias!.contains(ofertaModel.colonia?.value)) {
      

      var metros =requi.metrosCuadrados!.split(" - ");
      double meters1 = double.parse(metros[0]);
      double meters2 = double.parse(metros[1]);

      if(meters2 == 0000){
        if(meters1 <= double.parse(ofertaModel.attributo1!.value)){
        
              list.add(requi);
        }
      }else{
        if(meters1 <= double.parse(ofertaModel.attributo1!.value) && meters2 >= double.parse(ofertaModel.attributo1!.value)){
         
              list.add(requi);
        }
      }

    }
  }
  
  if(ofertaModel.atendidos!=null){
    List<RequestModel> list2 = [];
  for (var requi in list) {
    if(!ofertaModel.atendidos!.contains(requi.id!)){
      list2.add(requi);
    }
  }

  list = list2;
  }

  if(ofertaModel.baneados!=null){
    List<RequestModel> list2 = [];
  for (var requi in list) {
    if(!ofertaModel.baneados!.contains(requi.id!)){
      //print("${requi.id}");
      //list2.remove(requi);
      list2.add(requi);
    }
  }

  list = list2;
  }

  return list;
}
/////////////////////////////////////////////////////////////////////

List<UserModel2> listUserMachtRequet(List<String> machtsOfrecimiento,
    List<UserModel2> listaUsuarios, List<OfferCreateModel> listOfrecimientos) {
  List<UserModel2> usuarioMacthRequet = [];

  if (machtsOfrecimiento.isEmpty) {
    return usuarioMacthRequet;
  }

  // Filtrar los elementos de listOfrecimientos que coinciden con machtsOfrecimiento
  final matchingOffers = listOfrecimientos.where((oferta) {
    return machtsOfrecimiento.any((id) => oferta.id!.contains(id));
  }).toList();

  // Obtener los uidUser de las ofertas coincidentes
  final listUidUser = matchingOffers.map((oferta) => oferta.uidUser!).toSet();

  // Filtrar los usuarios según los uidUser
  for (var lisUser in listaUsuarios) {
    if (listUidUser.contains(lisUser.uid!)) {
      usuarioMacthRequet.add(lisUser);
    }
  }

  return usuarioMacthRequet;
}

////////////////////////////////////////////////////////////////////////
List<UserModel2> listUserMachtOffer(List<String> machtsrequit,
    List<UserModel2> listaUsuarios, List<RequestModel> listRequest) {   

  List<UserModel2> usuarioMacthRequet = [];
  if (machtsrequit.isEmpty) {
    return usuarioMacthRequet;
  }

  // Filtrar los elementos de listRequest que coinciden con machtsrequit
  final matchingOffers = listRequest.where((oferta) {
    return machtsrequit.any((id) => oferta.id!.contains(id));
  }).toList();

  // Obtener los uidUser de las ofertas coincidentes
  final listUidUser = matchingOffers.map((oferta) => oferta.uidUser!).toSet();

  // Filtrar los usuarios por los uidUser
  for (var lisUser in listaUsuarios) {
    if (listUidUser.contains(lisUser.uid!)) {
      usuarioMacthRequet.add(lisUser);
    }
  }

  return usuarioMacthRequet;
}


List<RequestModel> listMatchAtendidosOfert(//<---se trae la lista de macht atendidos de ofertas
    List<RequestModel> listaRequi, OfferCreateModel ofertaModel) {
  List<RequestModel> list = [];

  if(ofertaModel.atendidos!=null){
    for(var ofer in ofertaModel.atendidos!){
      for(var requi in listaRequi){
        if(requi.id==ofer){
          list.add(requi);
        }
      }
    }
  }
  if(ofertaModel.baneados!=null){
    for(var ofer in ofertaModel.baneados!){
      for(var requi in list){
        if(requi.id==ofer){
          list.remove(requi);
        }
      }
    }
  }
 
  return list;
}

List<OfferCreateModel> listMatchRequestAtendidos(//<--- se trae la lista de macht atendidos de requisitos
    List<OfferCreateModel> listaOfre, RequestModel requisitos) {
  List<OfferCreateModel> list = [];

  if(requisitos.atendidos!=null){
    for(var ofer in requisitos.atendidos!){
      for(var requi in listaOfre){
        if(requi.id==ofer){
          list.add(requi);
        }
      }
    }
  }

  if(requisitos.baneados!=null){
    for(var ofer in requisitos.baneados!){
      for(var requi in list){
        if(requi.id==ofer){
          list.remove(requi);
        }
      }
    }
  }

  return list;
}
