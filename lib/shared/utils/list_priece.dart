List<String> listCasaVenta = [
  "MXN 0 - MXN 3,000,000",
  "MXN 3,000,001 - MXN 5,000,000",
  "MXN 5,000,001 - MXN 7,000,000",
  "MXN 7,000,001 - MXN 10,000,000",
  "MXN 10,000,001 - En adelante",
];

List<String> listCasaRenta = [
  "MXN 0 - MXN 10,000",
  "MXN 10,001 - MXN 15,000",
  "MXN 15,001 - MXN 20,000",
  "MXN 20,001 - MXN 30,000",
  "MXN 30,001 - MXN 40,000",
  "MXN 40,001 - En adelante",
];

List<String> listDepartVenta = [
  "MXN 0 - MXN 3,000,000",
  "MXN 3,000,001 - MXN 5,000,000",
  "MXN 5,000,001 - MXN 7,000,000",
  "MXN 7,000,001 - MXN 10,000,000",
  "MXN 10,000,001 - En adelante",
];

List<String> listDepartRenta = [
  "MXN 0 - MXN 10,000",
  "MXN 10,001 - MXN 15,000",
  "MXN 15,001 - MXN 20,000",
  "MXN 20,001 - MXN 30,000",
  "MXN 30,001 - MXN 40,000",
  "MXN 40,001 - En adelante",
];

List<String> listTerrenoUrbanoVenta = [
  "MXN 0 - MXN 3,000,000",
  "MXN 3,000,001 - MXN 5,000,000",
  "MXN 5,000,001 - MXN 7,000,000",
  "MXN 7,000,001 - MXN 10,000,000",
  "MXN 10,000,001 - En adelante",
];

List<String> listTerrenoUrbanoRenta = [////
  "MXN 0 - MXN 3,000,000",
  "MXN 3,000,001 - MXN 5,000,000",
  "MXN 5,000,001 - MXN 7,000,000",
  "MXN 7,000,001 - MXN 10,000,000",
  "MXN 10,000,001 - En adelante",
];

List<String> listTerrenoRusticoVenta = [
  "MXN 0 - MXN 13,000,000",
  "MXN 13,000,001 - MXN 15,000,000",
  "MXN 15,000,001 - MXN 17,000,000",
  "MXN 17,000,001 - MXN 20,000,000",
  "MXN 20,000,001 - En adelante",
];

List<String> listTerrenoRusticoRenta = [////
  "MXN 0 - MXN 13,000,000",
  "MXN 13,000,001 - MXN 15,000,000",
  "MXN 15,000,001 - MXN 17,000,000",
  "MXN 17,000,001 - MXN 20,000,000",
  "MXN 20,000,001 - En adelante",
];

List<String> listBoegasVenta = [
  "MXN 0 - MXN 300",
  "MXN 301 - MXN 1,000",
  "MXN 1,001 - MXN 3,000",
  "MXN 3,001 - MXN 5,000",
  "MXN 5,001 - En adelante",
];

List<String> listBoegasRenta = [////
  "MXN 0 - MXN 300",
  "MXN 301 - MXN 1,000",
  "MXN 1,001 - MXN 3,000",
  "MXN 3,001 - MXN 5,000",
  "MXN 5,001 - En adelante",
];

List<String> listLocalesVenta = [
  "MXN 0 - MXN 100",
  "MXN 101 - MXN 300",
  "MXN 301 - MXN 500",
  "MXN 501 - MXN 1,000",
  "MXN 1,001 - En adelante",
];

List<String> listLocalesRenta = [/////
  "MXN 0 - MXN 100",
  "MXN 101 - MXN 300",
  "MXN 301 - MXN 500",
  "MXN 501 - MXN 1,000",
  "MXN 1,001 - En adelante",
];

List<String> listOficinaRenta = [
  "MXN 0 - MXN 10,000",
  "MXN 10,001 - MXN 15,000",
  "MXN 15,001 - MXN 20,000",
  "MXN 20,001 - MXN 30,000",
  "MXN 30,001 - MXN 50,000",
  "MXN 50,001 - En adelante",
];

List<String> listOficinaVenta = [/////
  "MXN 0 - MXN 10,000",
  "MXN 10,001 - MXN 15,000",
  "MXN 15,001 - MXN 20,000",
  "MXN 20,001 - MXN 30,000",
  "MXN 30,001 - MXN 50,000",
  "MXN 50,001 - En adelante",
];

List<String> listNaveIndVenta = [
  "MXN 0 - MXN 1,000",
  "MXN 1,001 - MXN 3,000",
  "MXN 3,001 - MXN 5,000",
  "MXN 5,001 - En adelante",
];

List<String> listNaveIndRenta = [////
  "MXN 0 - MXN 1,000",
  "MXN 1,001 - MXN 3,000",
  "MXN 3,001 - MXN 5,000",
  "MXN 5,001 - En adelante",
];

List<String> getListPrices(String category, bool isSale) {
  //print('category: $category, isSale: $isSale');
  switch (category) {
    case 'BODEGAS':
      return isSale ? listBoegasVenta : listBoegasRenta;
    case 'CASAS':
      return isSale ? listCasaVenta : listCasaRenta;
    case 'DEPARTAMENTOS':
      return isSale ? listDepartVenta : listDepartRenta;
    case 'LOCALES':
      return isSale ? listLocalesVenta : listLocalesRenta;
    case 'NAVES INDUSTRIALES':
      return isSale ? listNaveIndVenta : listNaveIndRenta;
    case 'TERRENO RUSTICO':
      return isSale ? listTerrenoRusticoVenta : listTerrenoRusticoRenta;
    case 'TERRENO URBANO':
      return isSale ? listTerrenoUrbanoVenta : listTerrenoUrbanoRenta;
    case 'OFICINAS':
      return isSale ? listOficinaVenta : listOficinaRenta;
    default:
      return ['Nada'];
  }
}
