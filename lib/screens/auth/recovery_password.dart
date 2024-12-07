import 'package:flutter/material.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class RecoveryPassword extends StatefulWidget {
  const RecoveryPassword({super.key});

  @override
  State<RecoveryPassword> createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPassword> {
  late LoadingButtonController _btnController;

  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    _btnController = LoadingButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPage(),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
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
                ],
              ),
              const Text('Ólvide mi contraseña',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 0,
                color: Colors.white,
              ),
              _text(
                  'Ingresa tu correo para enviar el link de cambio de contraseña',
                  12),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomInputs(
                  controller: emailController,
                  textCapitalization: false,
                  colorStyle: Colors.black,
                  label: const Text('Correo',
                      style: TextStyle(color: Colors.white)),
                  hintText: 'Ingrese correo',
                  // errorText: 'Por favor ingresa tu correo',
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Por favor ingresa tu correo';
                  //   }

                  //   // Validar formato de correo electrónico
                  //   String pattern =
                  //       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  //   RegExp regex = RegExp(pattern);
                  //   if (!regex.hasMatch(value)) {
                  //     return 'Por favor ingresa un correo válido';
                  //   }

                  //   return null;
                  // },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomLoadingButton(
                  primaryColor: const Color(0xFF18184E),
                  text: 'ENVIAR',
                  icon: Icons.send,
                  btnController: _btnController,
                  onPressed: () async {
                    final api = ApiAuth();
                    await api.sendCode(emailController.text);
                    CustomSnackbar.showSnackBar(
                        'Correo enviado',
                        // ignore: use_build_context_synchronously
                        context,
                        isSuccess: true);
                    setState(() {
                      emailController.clear();
                    });
                    _btnController.success();
                    _btnController.reset();
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _text(String text, double size) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: size, color: Colors.white),
    );
  }
}
