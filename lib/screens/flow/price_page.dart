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

class PricePage extends ConsumerStatefulWidget {
  const PricePage({
    super.key,
    required this.listMunicipalitiesString,
    required this.listColoniesString,
  });

  final List<String> listMunicipalitiesString;
  final List<String> listColoniesString;

  @override
  PricePageState createState() => PricePageState();
}

class PricePageState extends ConsumerState<PricePage> {
  String selectedItemPrecio = 'Seleccionar un precio';
  List<String> listValues = [];
  // List<UserModel2> listUser = [];
  List<OfferCreateModel> listOffering = [];
  late LoadingButtonController _btnController;

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final getStateProvider = ref.watch(getStatesProviderProvider);
    // final idMunicipalities = ref.watch(idMunicipalitiesProvider);
    // final idColonies = ref.watch(idColoniesProvider);
    // // final getMunicipalitiesProvider =
    //     ref.watch(getMunicipalitiesProviderProvider(id: idMunicipalities));
    // final getColoniesProvider =
    //     ref.watch(getColoniesProviderProvider(id: idColonies));
    final offerCreate = ref.watch(offerCreateProvider);
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    final isUpdateRequestNotifier = ref.watch(isUpdateRequestProvider.notifier);
    final modelCategory = ref.watch(modelCategoryProvider);
    final isUpdateOffering = ref.watch(isUpdateOfferingProvider);
    final getOfferingRef =
        ref.watch(getOfferingProvider(isUpdate: isUpdateOffering));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
        child: Column(
          children: [
            SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const WidgetLogo(),
                const WidgetCard(text: 'PRECIO', isRed: true),
                const SizedBox(
                  height: 20,
                ),
                if (modelCategory.name == "TERRENO RUSTICO" ||
                    modelCategory.name == "TERRENO URBANO" ||
                    modelCategory.name == "OFICINAS" ||
                    modelCategory.name == "CASAS" ||
                    modelCategory.name == "DEPARTAMENTOS")
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 2, top: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: const Text('RANGO',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ),
                      ),
                      DropDownSearch(
                        showSearchBox: true,
                        selectedItem: selectedItemPrecio,
                        items: listValues,
                        labelText: 'Precio',
                        onChanged: (value) {
                          if (value != null) {
                            value = value.replaceAll("MXN ", "");
                            value = value.replaceAll(",", "");
                            value = value.replaceAll("En adelante", "0000");
                          }
                          //print('value: $value');
                          offerCreateNotifier.setPrecio(value!);
                        },
                      )
                    ],
                  ),
                const SizedBox(
                  height: 70,
                ),
                CustomLoadingButton(
                    primaryColor: const Color(0xFF18184E),
                    text: 'GUARDAR',
                    icon: Icons.save,
                    btnController: _btnController,
                    onPressed: () async {
                      if (widget.listMunicipalitiesString.isEmpty) {
                        CustomSnackbar.showSnackBar(
                            'Debe seleccionar al menos un municipio', context,
                            isSuccess: false);
                        _btnController.success();
                        _btnController.reset();
                        return;
                      }
                      if (widget.listColoniesString.isEmpty) {
                        CustomSnackbar.showSnackBar(
                            'Debe seleccionar al menos una colonia', context,
                            isSuccess: false);
                        _btnController.success();
                        _btnController.reset();
                        return;
                      }

                      if (offerCreate.precio?.value == null) {
                        CustomSnackbar.showSnackBar(
                            'Debe seleccionar un precio', context,
                            isSuccess: false);
                        _btnController.success();
                        _btnController.reset();
                        return;
                      }
                      final api = ApiRequest();
                      await api.addRequest(
                          offerCreate,
                          widget.listMunicipalitiesString,
                          widget.listColoniesString,
                          getOfferingRef.value!);
                      final notifications = PushNotifications();
                      final apiOffering = ApiOffering();
                      List<UserModel2> listUser = await getUser();
                      List<OfferCreateModel> listaOfre =
                          await apiOffering.getOffering(allData: true);
                      List<UserModel2> listUserMarch = listUserMachtRequet(
                          addlistMatch(
                              listaOfre,
                              offerCreate,
                              widget.listMunicipalitiesString,
                              widget.listColoniesString),
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
            )),
          ],
        ),
      ),
    );
  }
}
