import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/config/notifications/push_notifications.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/list_priece.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class RequestPage extends ConsumerStatefulWidget {
  const RequestPage({super.key});

  @override
  RequestPageState createState() => RequestPageState();
}

class RequestPageState extends ConsumerState<RequestPage> {
  List<String> listM2Bodegas = [
    "0 - 300",
    "301 - 1000",
    "1001 - 3000",
    "3001 - 5000",
    "5001 - En adelante",
  ];
  List<String> listM2Locales = [
    "0 - 100",
    "101 - 300",
    "301 - 500",
    "501 - 1000",
    "1001 - En adelante",
  ];

  List<String> listM2NaveIndustrial = [
    "0 - 1000",
    "1001 - 3000",
    "3001 - 5000",
    "5001 - En adelante",
  ];

  List<String> opcYesNo = [
    "Si",
    "No",
  ];

  List<String> findListM2(String category) {
    if (category == 'BODEGAS') {
      return listM2Bodegas;
    } else if (category == 'LOCALES') {
      return listM2Locales;
    } else if (category == 'NAVES INDUSTRIALES') {
      return listM2NaveIndustrial;
    } else {
      return [];
    }
  }

  List<StateModel> listStates = [];
  List<MunicipalityModel> listMunicipalities = [];
  List<ColoniesModel> listColonies = [];
  List<String> listMunicipalitiesString = [];
  List<String> listColoniesString = [];
  String selectedItemMunicipality = 'Seleccionar uno o varios Municipios';
  String selectedItemPrecio = 'Seleccionar un precio';
  List<String> listValues = [];
  List<UserModel2> listUser = [];
  List<OfferCreateModel> listOffering = [];
  late LoadingButtonController _btnController;
  bool showInputM2 = false;

  @override
  void initState() {
    initData();
    _btnController = LoadingButtonController();
    super.initState();
  }

  Future<List<UserModel2>> getUser() {
    final api = ApiUser();
    return api.getUsers();
  }

  Future<List<OfferCreateModel>> getOffering() {
    final api = ApiOffering();
    return api.getOffering();
  }

  void initData() async {
    // final api = ApiRequest();
    // listValues = await api.getValues();
    final offerCreate = ref.read(offerCreateProvider);
    final modelCategory = ref.read(modelCategoryProvider);
    listValues =
        getListPrices(modelCategory.name ?? '', offerCreate.isSale ?? false);
    listUser = await getUser();
    listOffering = await getOffering();
    if (modelCategory.name == "LOCALES" ||
        modelCategory.name == "BODEGAS" ||
        modelCategory.name == "NAVES INDUSTRIALES") {
      showInputM2 = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final getStateProvider = ref.watch(getStatesProviderProvider);
    final idMunicipalities = ref.watch(idMunicipalitiesProvider);
    final idColonies = ref.watch(idColoniesProvider);
    final getMunicipalitiesProvider =
        ref.watch(getMunicipalitiesProviderProvider(id: idMunicipalities));
    final getColoniesProvider =
        ref.watch(getColoniesProviderProvider(id: idColonies));
    final offerCreate = ref.watch(offerCreateProvider);
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    final isUpdateRequestNotifier = ref.watch(isUpdateRequestProvider.notifier);
    final modelCategory = ref.watch(modelCategoryProvider);
    final isUpdateOffering = ref.watch(isUpdateOfferingProvider);
    final getOfferingRef =
        ref.watch(getOfferingProvider(isUpdate: isUpdateOffering));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Requerimientos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const WidgetLogo(),
              WidgetCard(
                text: offerCreate.isSale! ? 'VENTA' : 'RENTA',
                isRed: offerCreate.isSale!,
              ),
              const SizedBox(
                height: 20,
              ),
              getStateProvider.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No hay estados'),
                    );
                  }
                  listStates = data;
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: DropDownSearch(
                      showSearchBox: true,
                      selectedItem: 'Selecciona un estado',
                      items: data.map((e) => e.nameState).toList(),
                      labelText: 'Estado',
                      onChanged: (value) {
                        ref
                            .read(idMunicipalitiesProvider.notifier)
                            .setIdMunicipalities(
                              listStates
                                  .firstWhere(
                                      (element) => element.nameState == value)
                                  .id,
                            );
                        offerCreateNotifier.setEstado(value!);
                        setState(() {
                          selectedItemMunicipality =
                              'Seleccionar uno o varios Municipios';
                          listMunicipalitiesString = [];
                          listColoniesString = [];
                        });
                      },
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              getMunicipalitiesProvider.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: const Text('Seleccionar uno o varios Municipios',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)));
                  }
                  listMunicipalities = data;
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: DropDownSearch(
                      showSearchBox: true,
                      selectedItem: selectedItemMunicipality,
                      items: _ordenardoAlfabetico(
                          data.map((e) => e.nameMuni).toList()),
                      labelText: 'Municipio',
                      onChanged: (value) {
                        //si el elemento existe return

                        offerCreateNotifier.setMunicipio(value!);
                        ref.read(idColoniesProvider.notifier).setIdColonies(
                              listMunicipalities
                                  .firstWhere(
                                      (element) => element.nameMuni == value)
                                  .id,
                            );
                        if (listMunicipalitiesString.contains(value)) {
                          return;
                        }
                        setState(() {
                          listMunicipalitiesString.add(value);
                          selectedItemMunicipality =
                              'Seleccionar uno o varios Municipios';
                        });
                      },
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (listMunicipalitiesString.isNotEmpty)
                _listMunicipalitiesString(),
              const SizedBox(
                height: 20,
              ),
              getColoniesProvider.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: const Text('Seleccionar una o varias colonias',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)));
                  }
                  listColonies = data;
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: DropDownSearch(
                      showSearchBox: true,
                      selectedItem: 'Seleccionar una o varias colonias',
                      items: _ordenardoAlfabetico(
                          data.map((e) => e.nameColo).toList()),
                      labelText: 'Colonia',
                      onChanged: (value) {
                        // offerCreateNotifier.setColonia(value!);
                        if (listColoniesString.contains(value)) {
                          return;
                        }
                        setState(() {
                          listColoniesString.add(value!);
                        });
                      },
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (listColoniesString.isNotEmpty) _listColoniesString(),
              // if (modelCategory.name == "TERRENO RUSTICO" ||
              //     modelCategory.name == "TERRENO URBANO" ||
              //     modelCategory.name == "OFICINAS" ||
              //     modelCategory.name == "CASAS" ||
              //     modelCategory.name == "DEPARTAMENTOS")
              //   DropDownSearch(
              //     showSearchBox: true,
              //     selectedItem: selectedItemPrecio,
              //     items: listValues,
              //     labelText: 'Precio',
              //     onChanged: (value) {
              //       if (value != null) {
              //         value = value.replaceAll("MXN ", "");
              //         value = value.replaceAll(",", "");
              //         value = value.replaceAll("En adelante", "0000");
              //       }
              //       //print('value: $value');
              //       offerCreateNotifier.setPrecio(value!);
              //     },
              //   ),
              const SizedBox(
                height: 20,
              ),
              /* if (!offerCreate.isSale!)
                  CustomInputs(
                    hintText: "Mensual",
                    label: const Text('Mesual'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      offerCreateNotifier.setMensual(int.parse(value));
                    },
                  ),*/

              if (showInputM2)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  //padding: const EdgeInsets.only(left: 3, right: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: DropDownSearch(
                    showSearchBox: true,
                    selectedItem: "Seleccionar M2",
                    items: findListM2(modelCategory.name ?? ''),
                    labelText: modelCategory.attribute1 ?? '',
                    onChanged: (value) {
                      if (value != null && value.contains("En adelante")) {
                        value = value.replaceAll("En adelante", "0000");
                      }
                      offerCreateNotifier.setMetrosCuadrados(value!);
                    },
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              if (showInputM2)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  //padding: const EdgeInsets.only(left: 3, right: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: DropDownSearch(
                    showSearchBox: true,
                    selectedItem: "Seleccionar Si o no",
                    items: opcYesNo,
                    labelText: modelCategory.attribute2 ?? '',
                    onChanged: (value) {
                      offerCreateNotifier.setAttributo2(value!);
                    },
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              if (showInputM2)
                CustomLoadingButton(
                    primaryColor: const Color(0xFF18184E),
                    text: 'GUARDAR',
                    icon: Icons.save,
                    btnController: _btnController,
                    onPressed: () async {
                      if (showInputM2 && offerCreate.metrosCuadrados == null) {
                        CustomSnackbar.showSnackBar(
                            'Debe seleccionar un valor de metros cuadrados',
                            context,
                            isSuccess: false);
                        _btnController.success();
                        _btnController.reset();
                        return;
                      }
                      /*if (!offerCreate.isSale! && offerCreate.mensual == null) {
                        CustomSnackbar.showSnackBar(
                            'Debe seleccionar un valor de mesual', context,
                            isSuccess: false);
                        _btnController.success();
                        _btnController.reset();
                        return;
                      }*/
                      if (listMunicipalitiesString.isEmpty) {
                        CustomSnackbar.showSnackBar(
                            'Debe seleccionar al menos un municipio', context,
                            isSuccess: false);
                        _btnController.success();
                        _btnController.reset();
                        return;
                      }
                      if (listColoniesString.isEmpty) {
                        CustomSnackbar.showSnackBar(
                            'Debe seleccionar al menos una colonia', context,
                            isSuccess: false);
                        _btnController.success();
                        _btnController.reset();
                        return;
                      }

                      // if (!showInputM2 && offerCreate.precio?.value == null) {
                      //   CustomSnackbar.showSnackBar(
                      //       'Debe seleccionar un precio', context,
                      //       isSuccess: false);
                      //   _btnController.success();
                      //   _btnController.reset();
                      //   return;
                      // }
                      final api = ApiRequest();
                      await api.addRequest(
                          offerCreate,
                          listMunicipalitiesString,
                          listColoniesString,
                          getOfferingRef.value!);
                      final notifications = PushNotifications();
                      final apiOffering = ApiOffering();
                      List<OfferCreateModel> listaOfre =
                          await apiOffering.getOffering(allData: true);
                      List<UserModel2> listUserMarch = listUserMachtRequet(
                          addlistMatch(listaOfre, offerCreate,
                              listMunicipalitiesString, listColoniesString),
                          listUser,
                          listaOfre);
                      final user = UserModel.instance();
                      if (listUserMarch.isNotEmpty) {
                        for (var element in listUserMarch) {
                          await notifications.sendNotifications(
                            name: user.name!,
                            token: element.token!,
                          );
                          await notifications.sendNotifications(
                            name: element.name!,
                            token: user.token!,
                          );
                        }
                      }
                      CustomSnackbar.showSnackBar(
                          'Requerimiento creado con exito',
                          // ignore: use_build_context_synchronously
                          context,
                          isSuccess: true);
                      isUpdateRequestNotifier.setIsUpdateRequest();

                      // ignore: use_build_context_synchronously
                      context.go(PathRouter.home);
                      _btnController.success();
                      _btnController.reset();
                    }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: !showInputM2
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 205, 24, 221),
              onPressed: () {
                if (offerCreate.estado == null || offerCreate.estado!.isPure) {
                  CustomSnackbar.showSnackBar(
                      'Selecciona un estado',
                      // ignore: use_build_context_synchronously
                      context,
                      isSuccess: false);
                  return;
                }

                if (offerCreate.municipio == null ||
                    offerCreate.municipio!.isPure) {
                  CustomSnackbar.showSnackBar(
                      'Selecciona un municipio',
                      // ignore: use_build_context_synchronously
                      context,
                      isSuccess: false);
                  return;
                }

                if (listColoniesString.isEmpty) {
                  CustomSnackbar.showSnackBar(
                      'Selecciona una colonia',
                      // ignore: use_build_context_synchronously
                      context,
                      isSuccess: false);
                  return;
                }
                context.push(PathRouter.pricePage, extra: {
                  "arg1": listMunicipalitiesString,
                  "arg2": listColoniesString
                });
              },
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  Widget _listMunicipalitiesString() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: listMunicipalitiesString.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listMunicipalitiesString[index],
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold)),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  listMunicipalitiesString.removeAt(index);
                  selectedItemMunicipality =
                      'Seleccionar uno o varios Municipios';
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _listColoniesString() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: listColoniesString.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listColoniesString[index],
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold)),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  listColoniesString.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }
}

List<String> _ordenardoAlfabetico(List<String> list) {
  list.sort((a, b) => a.compareTo(b));
  return list;
}
