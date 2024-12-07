import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends ConsumerState<RegisterPage> {
  File? imageFile;
  File? imageFileAvatar;
  late LoadingButtonController _btnController;
  bool _isChecked = false;

  @override
  void initState() {
    _btnController = LoadingButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadRegister = ref.watch(loadRegisterProvider);
    final loadRegisterNotifier = ref.watch(loadRegisterProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Registro', style: Theme.of(context).textTheme.titleLarge),
              _text('Ingresa tus datos al sistema.', 14),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 0,
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              _loadImageProfile(),
              Center(child: _text('Sube foto', 12)),
              const SizedBox(
                height: 20,
              ),
              CustomInputs(
                errorText: loadRegister.name?.errorMessage,
                textCapitalization: false,
                colorStyle: Colors.black,
                label: const Text('Nombre',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                hintText: 'Ingrese nombre',
                onChanged: loadRegisterNotifier.setName,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInputs(
                errorText: loadRegister.phone?.errorMessage,
                textCapitalization: false,
                colorStyle: Colors.black,
                label: const Text('Teléfono',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                hintText: 'Ingrese teléfono',
                onChanged: loadRegisterNotifier.setPhone,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInputs(
                errorText: loadRegister.inmobiliario?.errorMessage,
                textCapitalization: false,
                colorStyle: Colors.black,
                label: const Text('Inmobiliaria',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                hintText: 'Ingrese la inmobiliaria',
                onChanged: loadRegisterNotifier.setInmobiliario,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInputs(
                textCapitalization: false,
                colorStyle: Colors.black,
                label: const Text('Ciudad',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                hintText: 'Ingrese la ciudad',
                onChanged: loadRegisterNotifier.setCiudad,
              ),
              const SizedBox(
                height: 10,
              ),
              _text('Sube logo', 12),
              const SizedBox(
                height: 10,
              ),
              _loadAvatar(),
              const SizedBox(
                height: 10,
              ),
              CustomInputs(
                errorText: loadRegister.email?.errorMessage,
                textCapitalization: false,
                colorStyle: Colors.black,
                label: const Text('Correo',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                hintText: 'Ingrese correo',
                onChanged: loadRegisterNotifier.setEmail,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomInputs(
                errorText: loadRegister.password?.errorMessage,
                textCapitalization: false,
                colorStyle: Colors.black,
                label: const Text('Contraseña',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                hintText: 'Ingrese la contraseña',
                onChanged: loadRegisterNotifier.setPassword,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 10), // Espacio entre checkbox y texto
                  GestureDetector(
                    onTap: () async {
                      /*final url = Uri.parse(
                          'https://drive.google.com/uc?id=1WA-sHh2iLmUAVgh50aP5_soFLiWlyB78&export=download');*/
                          final url = Uri.parse(
                          'https://yahirmendoza.blogspot.com/2024/10/terminos-y-condiciones-de-privacidad.html');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print('No se puede abrir el PDF');
                      }
                    },
                    child: const Text(
                      'Acepto los Términos y Condiciones de privacidad',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomLoadingButton(
                  primaryColor: const Color(0xFF18184E),
                  text: 'Registro',
                  icon: Icons.save,
                  btnController: _btnController,
                  onPressed: () async {
                    if (imageFile == null) {
                      CustomSnackbar.showSnackBar(
                          'Debe subir imagen de perfil',
                          // ignore: use_build_context_synchronously
                          context,
                          isSuccess: false);
                      _btnController.success();
                      _btnController.reset();
                      return;
                    }
                    if (imageFileAvatar == null) {
                      CustomSnackbar.showSnackBar(
                          'Debe subir imagen de perfil',
                          // ignore: use_build_context_synchronously
                          context,
                          isSuccess: false);
                      _btnController.success();
                      _btnController.reset();
                      return;
                    }
                    if (_isChecked == false) {
                      CustomSnackbar.showSnackBar(
                          'Debe aceptar los Términos y Condiciones de privacidad',
                          // ignore: use_build_context_synchronously
                          context,
                          isSuccess: false);
                      _btnController.success();
                      _btnController.reset();
                      return;
                    }
                    await loadRegisterNotifier.register(
                        context, imageFile, imageFileAvatar);
                    _btnController.success();
                    _btnController.reset();
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadAvatar() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: _loadImageAvatar(),
    );
  }

  Widget _text(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: size),
    );
  }

  Widget _loadImageProfile() {
    if (imageFile == null) {
      return Center(
        child: CircleAvatar(
          radius: 50,
          child: IconButton(
              onPressed: () async {
                const imageSource = ImageSource.gallery;
                imageFile = await ImageUpload.selectImage(imageSource, context);
                setState(() {});
              },
              icon: const Icon(Icons.person_pin, size: 80)),
        ),
      );
    }
    return Center(
      child: GestureDetector(
        onTap: () {
          const imageSource = ImageSource.gallery;
          ImageUpload.selectImage(imageSource, context);
        },
        child: CircleAvatar(
          radius: 50,
          backgroundImage: FileImage(imageFile!),
        ),
      ),
    );
  }

  Widget _loadImageAvatar() {
    if (imageFileAvatar == null) {
      return Center(
        child: CircleAvatar(
          radius: 50,
          child: IconButton(
              onPressed: () async {
                const imageSource = ImageSource.gallery;
                imageFileAvatar =
                    await ImageUpload.selectImage(imageSource, context);
                setState(() {});
              },
              icon: const Icon(Icons.person_pin, size: 80)),
        ),
      );
    }
    return Center(
      child: GestureDetector(
        onTap: () {
          const imageSource = ImageSource.gallery;
          ImageUpload.selectImage(imageSource, context);
        },
        child: CircleAvatar(
          radius: 50,
          backgroundImage: FileImage(imageFileAvatar!),
        ),
      ),
    );
  }
}
