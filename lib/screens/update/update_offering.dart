import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class UpdateOffering extends ConsumerStatefulWidget {
  const UpdateOffering({super.key, required this.model});
  final OfferCreateModel model;

  @override
  UpdateOfferingState createState() => UpdateOfferingState();
}

class UpdateOfferingState extends ConsumerState<UpdateOffering> {
  List<String> imagesOffering = [];
  List<String> imagesToDelete = [];
  List<StateModel> listStates = [];
  List<MunicipalityModel> listMunicipalities = [];
  List<ColoniesModel> listColonies = [];
  late LoadingButtonController _btnController;
  @override
  void initState() {
    _btnController = LoadingButtonController();
    initData();
    super.initState();
  }

  void initData() {
    final offerCreate = ref.read(offerCreateProvider);
    offerCreate.estado = widget.model.estado;
    offerCreate.municipio = widget.model.municipio;
    offerCreate.colonia = widget.model.colonia;
    offerCreate.isSale = widget.model.isSale;
    offerCreate.precio = widget.model.precio;
    imagesOffering = widget.model.images ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final offerCreate = ref.watch(offerCreateProvider);
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    final listImages = ref.watch(loadImagesProvider);
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
                  _selectState(offerCreateNotifier),
                  _sizeBox(height: 10),
                  _selectMunicipality(offerCreateNotifier),
                  _sizeBox(),
                  _selectColonies(offerCreateNotifier),
                  _sizeBox(),
                  _isSale(offerCreate, offerCreateNotifier),
                  _sizeBox(),
                  CustomInputs(
                    label: _label('Precio'),
                    hintText: 'Precio',
                    initialValue: offerCreate.precio?.value,
                    onChanged: offerCreateNotifier.setPrecio,
                    helperText: GeneralUtils.formatearPrecio(
                        offerCreate.precio?.value ?? ''),
                  ),
                  _sizeBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Imagenes actuales',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (imagesToDelete.isNotEmpty)
                        GestureDetector(
                            onTap: () {
                              imagesOffering.addAll(imagesToDelete);
                              imagesToDelete.clear();
                              setState(() {});
                            },
                            child: _label('Cancelar')),
                    ],
                  ),
                  _sizeBox(),
                  _viewImages(),
                  _sizeBox(),
                  const Text(
                    'Agregar nuevas imagenes',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  _sizeBox(),
                  _selectNewImages(listImages),
                  _sizeBox(),
                  CustomLoadingButton(
                    primaryColor: const Color(0xFF18184E),
                    text: 'ACTUALIZAR',
                    icon: Icons.update,
                    btnController: _btnController,
                    onPressed: () async {
                      List<String> urlImages = [];
                      final isValid = _isValid(offerCreate, listImages);
                      if (!isValid) {
                        _btnController.success();
                        _btnController.reset();
                        return;
                      }

                      if (imagesToDelete.isNotEmpty) {
                        deleteImages(imagesToDelete);
                      }

                      if (listImages != null && listImages.isNotEmpty) {
                        final apiImages = ApiLoadImages();
                        urlImages = await apiImages.uploadImages(listImages);
                      }

                      if (imagesOffering.isNotEmpty) {
                        urlImages.addAll(imagesOffering);
                      }
                      await FirebaseFirestore.instance
                          .collection('offering')
                          .doc(widget.model.id)
                          .update({
                        'estado': offerCreate.estado?.value,
                        'municipio': offerCreate.municipio?.value,
                        'colonia': offerCreate.colonia?.value,
                        'isSale': offerCreate.isSale,
                        'precio': offerCreate.precio?.value,
                        'images': urlImages
                      });

                      CustomSnackbar.showSnackBar(
                          'Ofrecimiento actualizado',
                          // ignore: use_build_context_synchronously
                          context,
                          isSuccess: true);
                      _btnController.success();
                      _btnController.reset();
                    },
                  ),
                  _sizeBox(height: 20)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void deleteImages(List<String> imageUrls) async {
    if (imageUrls.isEmpty) {
      return;
    }
    for (String url in imageUrls) {
      Reference ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
    }
  }

  Widget _selectNewImages(List<File>? listImages) {
    final listImagesInstance = ref.watch(loadImagesProvider.notifier);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  if (listImages != null && listImages.length >= 10) {
                    CustomSnackbar.showSnackBar(
                        'No se pueden agregar mas de 10 imagenes', context,
                        isSuccess: false);
                    return;
                  }
                  const imageSource = ImageSource.camera;
                  final image =
                      await ImageUpload.selectImage(imageSource, context);
                  if (image != null) {
                    listImagesInstance.addImage(image);
                  }
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 45,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () async {
                  if (listImages != null && listImages.length >= 10) {
                    CustomSnackbar.showSnackBar(
                        'No se pueden agregar mas de 10 imagenes', context,
                        isSuccess: false);
                    return;
                  }
                  final images =
                      await ImageUploadMultiple.selectImages(context);
                  if (images != null) {
                    listImagesInstance.addImages(images);
                  }
                },
                icon: const Icon(
                  Icons.photo,
                  size: 45,
                  color: Colors.white,
                )),
          ],
        ),
        const SizedBox(height: 10),
        ViewImages(
          imageFiles: listImages,
        ),
      ],
    );
  }

  bool _isValid(OfferCreateModel offerCreate, List<File>? listImages) {
    if (offerCreate.estado?.value == null) {
      CustomSnackbar.showSnackBar('Debe seleccionar un estado', context,
          isSuccess: false);
      return false;
    } else if (offerCreate.municipio?.value == null) {
      CustomSnackbar.showSnackBar('Debe seleccionar un municipio', context,
          isSuccess: false);
      return false;
    } else if (offerCreate.colonia?.value == null) {
      CustomSnackbar.showSnackBar('Debe seleccionar una colonia', context,
          isSuccess: false);
      return false;
    } else if (offerCreate.precio?.value == null) {
      CustomSnackbar.showSnackBar('Debe agregar un precio', context,
          isSuccess: false);
      return false;
    } else if (imagesOffering.isEmpty &&
        (listImages == null || listImages.isEmpty)) {
      CustomSnackbar.showSnackBar('Debe agregar imagenes', context,
          isSuccess: false);
      return false;
    } else {
      return true;
    }
  }

  Widget _viewImages() {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagesOffering.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imagesOffering[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    imagesToDelete.add(imagesOffering[index]);
                    imagesOffering.removeAt(index);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          );
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
            child: Text('No hay estados',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          );
        }
        listStates = data;
        return DropDownSearch(
          showSearchBox: true,
          selectedItem: widget.model.estado?.value ?? '',
          items: data.map((e) => e.nameState).toList(),
          labelText: 'Estado',
          onChanged: (value) {
            ref.read(idMunicipalitiesProvider.notifier).setIdMunicipalities(
                  listStates
                      .firstWhere((element) => element.nameState == value)
                      .id,
                );
            offerCreateNotifier.setEstado(value!);
          },
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _label(String label) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2, top: 2),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }

  Widget _selectMunicipality(OfferCreate offerCreateNotifier) {
    final idMunicipalities = ref.watch(idMunicipalitiesProvider);
    final getMunicipalitiesProvider =
        ref.watch(getMunicipalitiesProviderProvider(id: idMunicipalities));
    return getMunicipalitiesProvider.when(
      data: (data) {
        if (data.isEmpty) {
          return Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Text(widget.model.municipio?.value ?? '',
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)));
        }
        listMunicipalities = data;
        return DropDownSearch(
          showSearchBox: true,
          selectedItem: 'Selecciona un Municipio',
          items: _ordenardoAlfabetico(data.map((e) => e.nameMuni).toList()),
          labelText: 'Municipio',
          onChanged: (value) {
            offerCreateNotifier.setMunicipio(value!);
            ref.read(idColoniesProvider.notifier).setIdColonies(
                  listMunicipalities
                      .firstWhere((element) => element.nameMuni == value)
                      .id,
                );
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
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Text(widget.model.colonia?.value ?? '',
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)));
        }
        listColonies = data;
        return Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: DropDownSearch(
              showSearchBox: true,
              selectedItem: 'Selecciona una Colonia',
              items: _ordenardoAlfabetico(data.map((e) => e.nameColo).toList()),
              labelText: 'Colonia',
              onChanged: (value) {
                offerCreateNotifier.setColonia(value!);
              },
            ));
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
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
        },
      ),
    );
  }

  List<String> _ordenardoAlfabetico(List<String> list) {
    list.sort((a, b) => a.compareTo(b));
    return list;
  }
}
