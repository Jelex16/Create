import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/list_priece.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

import '../../shared/validator/validator.dart';

class UpdateRequest extends ConsumerStatefulWidget {
  const UpdateRequest({super.key, required this.model});
  final RequestModel model;

  @override
  UpdateRequestState createState() => UpdateRequestState();
}

class UpdateRequestState extends ConsumerState<UpdateRequest> {
  String estado = '';
  bool isPrecio = false;
  bool isSale = false;

  List<StateModel> listStates = [];

  List<MunicipalityModel> listMunicipalities = [];
  List<ColoniesModel> listColonies = [];
  List<String> listMunicipalitiesString = [];
  List<String> listColoniesString = [];
  List<String> listPrices = [];
  String selectedItemMunicipality = 'Seleccionar Municipios';
  late LoadingButtonController _btnController;

  @override
  void initState() {
    _btnController = LoadingButtonController();
    iniData();
    super.initState();
  }

  void iniData() {
    final offerCreate = ref.read(offerCreateProvider);
    offerCreate.estado = GeneralField.dirty(widget.model.estado ?? '');
    offerCreate.isSale = widget.model.isSale;
    offerCreate.precio = NumberInput.dirty(widget.model.precio ?? '');
    estado = widget.model.estado ?? '0';
    listMunicipalitiesString = widget.model.municipios ?? [];
    listColoniesString = widget.model.colonias ?? [];
    isSale = widget.model.isSale ?? false;
    if (widget.model.precio != null) {
      offerCreate.precio = NumberInput.dirty(widget.model.precio ?? '');
      isPrecio = true;
      listPrices = getListPrices(widget.model.category ?? '', isSale);
    }
  }

  @override
  Widget build(BuildContext context) {
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    final offerCreate = ref.watch(offerCreateProvider);
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPage(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
                child: Column(
              children: [
                _sizeBox(height: 30),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    const Text(
                      'Actualizar Ofrecimiento',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    _sizeBox(height: 10),
                  ],
                ),
                _text('Seleccione Estado'),
                _sizeBox(height: 10),
                _selectState(offerCreateNotifier),
                _sizeBox(height: 10),
                _text('Seleccione Municipio'),
                _sizeBox(height: 10),
                _selectMunicipalities(offerCreateNotifier),
                _sizeBox(height: 10),
                _text('Municipios actuales'),
                _sizeBox(height: 10),
                _listMunicipalitiesString(),
                _sizeBox(height: 10),
                _text('Seleccione Colonia'),
                _sizeBox(height: 10),
                _selectColonies(offerCreateNotifier),
                _sizeBox(height: 10),
                _text('Colonias actuales'),
                _sizeBox(height: 10),
                _listColoniesString(),
                _sizeBox(height: 10),
                _isSale(offerCreate, offerCreateNotifier),
                _sizeBox(height: 10),
                if (isPrecio)
                  DropDownSearch(
                    showSearchBox: true,
                    selectedItem: offerCreate.precio?.value ?? '',
                    items: listPrices,
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
                  ),
                _sizeBox(height: 10),
                CustomLoadingButton(
                  primaryColor: const Color(0xFF18184E),
                  text: 'ACTUALIZAR',
                  icon: Icons.update,
                  btnController: _btnController,
                  onPressed: () async {
                    final isValid = _isValid(offerCreate);
                    if (!isValid) {
                      _btnController.success();
                      _btnController.reset();
                      return;
                    }

                    await FirebaseFirestore.instance
                        .collection('request')
                        .doc(widget.model.id)
                        .update({
                      'estado': offerCreate.estado?.value,
                      'municipios': listMunicipalitiesString,
                      'colonias': listColoniesString,
                      'isSale': offerCreate.isSale,
                      'precio': offerCreate.precio?.value,
                    });

                    CustomSnackbar.showSnackBar(
                        'Requerimiento actualizado',
                        // ignore: use_build_context_synchronously
                        context,
                        isSuccess: true);
                    _btnController.success();
                    _btnController.reset();
                  },
                ),
                _sizeBox(height: 20),
              ],
            )),
          )
        ],
      ),
    );
  }

  bool _isValid(OfferCreateModel offerCreate) {
    if (offerCreate.estado?.value == null || offerCreate.estado?.value == '') {
      CustomSnackbar.showSnackBar('Debe seleccionar un estado', context,
          isSuccess: false);
      return false;
    } else if (listMunicipalitiesString.isEmpty) {
      CustomSnackbar.showSnackBar('Debe seleccionar un municipio', context,
          isSuccess: false);
      return false;
    } else if (listColoniesString.isEmpty) {
      CustomSnackbar.showSnackBar('Debe seleccionar una colonia', context,
          isSuccess: false);
      return false;
    } else if (offerCreate.precio?.value == null ||
        offerCreate.precio?.value == '') {
      CustomSnackbar.showSnackBar('Debe agregar un precio', context,
          isSuccess: false);
      return false;
    } else {
      return true;
    }
  }

  Widget _isSale(
      OfferCreateModel offerCreate, OfferCreate offerCreateNotifier) {
    return ListTile(
      title: const Text(
        '¿Es venta?',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      trailing: Checkbox(
        checkColor: Colors.white,
        // fillColor: WidgetStateProperty.resolveWith(),
        value: offerCreate.isSale,
        onChanged: (bool? value) {
          offerCreateNotifier.setIsSale(value!);
          setState(() {
            isSale = value;
            listPrices = getListPrices(widget.model.category ?? '', isSale);
          });
        },
      ),
    );
  }

  Widget _sizeBox({double? height}) {
    return SizedBox(
      height: height ?? 10,
    );
  }

  Widget _selectState(OfferCreate offerCreateNotifier) {
    final getStateProvider = ref.watch(getStatesProviderProvider);
    return getStateProvider.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text('No hay estados'),
          );
        }
        listStates = data;
        return DropDownSearch(
          showSearchBox: true,
          selectedItem: estado,
          items: data.map((e) => e.nameState).toList(),
          labelText: 'Estado',
          onChanged: (value) {
            ref.read(idMunicipalitiesProvider.notifier).setIdMunicipalities(
                  listStates
                      .firstWhere((element) => element.nameState == value)
                      .id,
                );
            offerCreateNotifier.setEstado(value!);
            setState(() {
              selectedItemMunicipality = 'Seleccionar Municipios';
              // listMunicipalitiesString = [];
              // listColoniesString = [];
            });
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _selectMunicipalities(OfferCreate offerCreateNotifier) {
    final idMunicipalities = ref.watch(idMunicipalitiesProvider);
    final getMunicipalitiesProvider =
        ref.watch(getMunicipalitiesProviderProvider(id: idMunicipalities));
    return getMunicipalitiesProvider.when(
      data: (data) {
        if (data.isEmpty) {
          return Container(
              // margin: const EdgeInsets.only(top: 20),
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
              child: const Text('Seleccionar Municipios',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)));
        }
        listMunicipalities = data;
        return DropDownSearch(
          showSearchBox: true,
          selectedItem: selectedItemMunicipality,
          items: _ordenardoAlfabetico(data.map((e) => e.nameMuni).toList()),
          labelText: 'Municipio',
          onChanged: (value) {
            //si el elemento existe return

            offerCreateNotifier.setMunicipio(value!);
            ref.read(idColoniesProvider.notifier).setIdColonies(
                  listMunicipalities
                      .firstWhere((element) => element.nameMuni == value)
                      .id,
                );
            if (listMunicipalitiesString.contains(value)) {
              return;
            }
            setState(() {
              listMunicipalitiesString.add(value);
              selectedItemMunicipality = 'Seleccionar Municipios';
            });
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _selectColonies(OfferCreate offerCreateNotifier) {
    final idColonies = ref.watch(idColoniesProvider);
    final getColoniesProvider =
        ref.watch(getColoniesProviderProvider(id: idColonies));
    return getColoniesProvider.when(
      data: (data) {
        if (data.isEmpty) {
          return Container(
              // margin: const EdgeInsets.only(top: 20),
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
              child: const Text('Seleccionar colonias',
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
            selectedItem: 'Seleccionar colonias',
            items: _ordenardoAlfabetico(data.map((e) => e.nameColo).toList()),
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
                  selectedItemMunicipality = 'Seleccionar  Municipios';
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _text(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
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

  List<String> _ordenardoAlfabetico(List<String> list) {
    list.sort((a, b) => a.compareTo(b));
    return list;
  }
}
