import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

import '../../api/api.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  late LoadingButtonController _btnController;
  bool show = true;

  @override
  void initState() {
    _btnController = LoadingButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authUserProvider);
    final authUserNotifier = ref.watch(authUserProvider.notifier);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: size.height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                _logo(),
                const SizedBox(
                  height: 20,
                ),
                const Text('Iniciar Sesión',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20)),
                const Text('Iniciar sesión para continuar usando la aplicación',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16)),
                // _text('Iniciar Sesión', 20, isBold: true),
                // _text('Iniciar sesión para continuar usando la aplicación', 11),
                const SizedBox(
                  height: 30,
                ),
                CustomInputs(
                  errorText: authUser.email?.errorMessage,
                  textCapitalization: false,
                  colorStyle: Colors.black,
                  label: const Text('Correo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16)),
                  hintText: 'Ingrese correo',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: authUserNotifier.setEmail,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInputs(
                  errorText: authUser.password?.errorMessage,
                  maxLines: 1,
                  textCapitalization: false,
                  obscureText: show,
                  colorStyle: Colors.black,
                  label: const Text('Contraseña',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16)),
                  hintText: 'Ingrese su contraseña',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye)),
                  onChanged: authUserNotifier.setPassword,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.push(PathRouter.recoveryPassword);
                        },
                        child: _text('¿Olvidaste tu contraseña?', 15)),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomLoadingButton(
                    primaryColor: const Color(0xFF18184E),
                    text: 'INICIAR SESIÓN',
                    icon: Icons.home,
                    btnController: _btnController,
                    onPressed: () async {
                      if (!authUserNotifier.isValid) {
                        // ignore: use_build_context_synchronously
                        CustomSnackbar.showSnackBar(
                            'Usuario o contraseña incorrectos', context,
                            isSuccess: false);
                        _btnController.reset();
                        return;
                      }
                      final authInstance = ApiAuth();
                      final response = await authInstance.signIn(
                          authUser.email!.value, authUser.password!.value);
                      if (response['success']) {
                        final user = response['user'];
                        final userLoged =
                            await authInstance.getDataUser(user!.user!.uid);
                        final userModel = UserModel.instance();
                        if (userLoged != null) {
                          userModel.setData(userLoged);
                        }

                        GeneralUtils.setUid(user.user?.uid ?? '');
                        GeneralUtils.setPassword(authUser.password!.value);
                        // ignore: use_build_context_synchronously
                        CustomSnackbar.showSnackBar('Login exitoso', context,
                            isSuccess: true);
                        authInstance.saveTokenToDatabase();
                        // ignore: use_build_context_synchronously
                        getRoute(userLoged);
                      } else {
                        CustomSnackbar.showSnackBar(
                            response['message'],
                            // ignore: use_build_context_synchronously
                            context,
                            isSuccess: false);
                      }
                      _btnController.success();
                      _btnController.reset();
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No estas registrado?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          context.push(PathRouter.register);
                        },
                        child: const Text(
                          'Registrate ahora',
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          context.push(PathRouter.recoveryPassword);
                        },
                        child: const Text(
                          'Recuperar contraseña',
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void getRoute(UserModel? userLoged) {
    if (!userLoged!.isActive!) {
      return context.go(PathRouter.activeAccount);
    }
    context.go(PathRouter.home);
  }

  Widget _logo() {
    return const Center(
      child: Image(
        image: AssetImage(CustomAssets.iconMH),
        height: 200,
      ),
    );
  }

  Widget _text(String text, double size, {bool isBold = false}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
          fontSize: size,
          color: Colors.white),
    );
  }
}
