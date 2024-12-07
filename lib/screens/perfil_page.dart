import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/user_model.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';

import '../shared/widgets/widgets.dart';

class PerfilScreen extends ConsumerStatefulWidget {
  const PerfilScreen({super.key});

  @override
  PerfilScreenState createState() => PerfilScreenState();
}

class PerfilScreenState extends ConsumerState<PerfilScreen> {
  late LoadingButtonController _btnController;

  String textButtonPerfil = 'Guardar Cambios';
  File? imageFile;
  File? imageFileAvatar;

  @override
  void initState() {
    _btnController = LoadingButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final isUpdateRequestNotifier = ref.watch(isUpdateRequestProvider.notifier);
    final userModel = UserModel.instance();
    return Scaffold(
        //drawer: const CustomDrawer(opcDrawer: 'PE',) ,
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.7),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text("PERFIL",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 30,
                ),
                _photoProfile(userModel.urlProfile ?? ''),
                const SizedBox(
                  height: 30,
                ),
                CustomInputs(
                  controller: TextEditingController(text: userModel.name),
                  textCapitalization: false,
                  keyboardType: TextInputType.text,
                  label: _label('Nombre'),
                  hintText: '',
                  colorStyle: Colors.black,
                  onChanged: (value) {
                    userModel.name = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInputs(
                  controller: TextEditingController(text: userModel.email),
                  textCapitalization: false,
                  keyboardType: TextInputType.text,
                  label: _label('Email'),
                  hintText: '',
                  colorStyle: Colors.black,
                  onChanged: (value) {
                    userModel.email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInputs(
                  controller: TextEditingController(text: userModel.phone),
                  textCapitalization: false,
                  keyboardType: TextInputType.number,
                  label: _label('Celular'),
                  hintText: '',
                  colorStyle: Colors.black,
                  onChanged: (value) {
                    userModel.phone = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInputs(
                  controller: TextEditingController(text: userModel.ciudad),
                  textCapitalization: true,
                  keyboardType: TextInputType.number,
                  label: _label('Ciudad'),
                  hintText: '',
                  colorStyle: Colors.black,
                  onChanged: (value) {
                    userModel.ciudad = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _photoAvatar(userModel.urlAvatar ?? ''),
                const SizedBox(
                  height: 30,
                ),
                CustomLoadingButton(
                    primaryColor: const Color.fromARGB(255, 255, 175, 1),
                    text: textButtonPerfil,
                    color: Colors.white,
                    btnController: _btnController,
                    onPressed: () async {
                      print('userModel: ${userModel.toJson()}');

                      List<String> imageUrlsDelete = [];
                      List<File> images = [];
                      if (imageFile != null) {
                        images.add(imageFile!);
                        imageUrlsDelete.add(userModel.urlProfile!);
                      }
                      if (imageFileAvatar != null) {
                        images.add(imageFileAvatar!);
                        imageUrlsDelete.add(userModel.urlAvatar!);
                      }
                      if (images.isNotEmpty) {
                        final apiImages = ApiLoadImages();
                        deleteImages(imageUrlsDelete);
                        final urlImages = await apiImages.uploadImages(images);
                        // ignore: use_build_context_synchronously
                        if (urlImages.length == 1 && imageFile != null) {
                          userModel.urlProfile = urlImages[0];
                        } else if (urlImages.length == 1 &&
                            imageFileAvatar != null) {
                          userModel.urlAvatar = urlImages[0];
                        } else if (urlImages.length == 2) {
                          userModel.urlProfile = urlImages[0];
                          userModel.urlAvatar = urlImages[1];
                        }
                      }
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userModel.id)
                          .update({
                        'urlProfile': userModel.urlProfile,
                        'urlAvatar': userModel.urlAvatar,
                        'name': userModel.name,
                        'email': userModel.email,
                        'phone': userModel.phone,
                        'ciudad': userModel.ciudad
                      });
                      CustomSnackbar.showSnackBar(
                          'Perfil Actualizado',
                          // ignore: use_build_context_synchronously
                          context,
                          isSuccess: true);
                      _btnController.success();
                      _btnController.reset();
                    })
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))
            ],
          ),
        )
      ],
    ));
  }

  Widget _label(String label) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2, top: 2),
      child: Text(label,
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 175, 1),
              fontWeight: FontWeight.bold,
              fontSize: 18)),
    );
  }

  Widget _photoProfile(String url) {
    return GestureDetector(
      onTap: () async {
        const imageSource = ImageSource.gallery;
        imageFile = await ImageUpload.selectImage(imageSource, context);
        setState(() {});
      },
      child: imageFile != null
          ? CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(imageFile!),
            )
          : CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(url),
            ),
    );
  }

  Widget _photoAvatar(String url) {
    return GestureDetector(
      onTap: () async {
        const imageSource = ImageSource.gallery;
        imageFileAvatar = await ImageUpload.selectImage(imageSource, context);
        setState(() {});
      },
      child: imageFileAvatar != null
          ? CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(imageFileAvatar!),
            )
          : CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(url),
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
}
