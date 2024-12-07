import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/screens/screens.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:match_home_client/models/models.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshUserData();
    });
  }

  void _refreshUserData() {
    // Invalidamos el provider para forzar una actualización
    ref.invalidate(getUserOneProviderProvider(isUpdate: true));
    ref.invalidate(getSuscribeProviderProvider());
  }

  @override
  Widget build(BuildContext context) {
    final getUserRef = ref.watch(getUserOneProviderProvider(isUpdate: true));
    final getSuscripcionesRef = ref.watch(getSuscribeProviderProvider());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                const WidgetLogo(),
                CustomButtonG(
                  onTap: () {
                    context.push(PathRouter.publishPage);
                  },
                  text: 'Publicar',
                  colorText: Colors.white,
                  color: const Color.fromARGB(255, 205, 24, 221),
                ),
                const SizedBox(height: 20),
                CustomButtonG(
                  onTap: () {
                    context.push(PathRouter.matchsPage);
                  },
                  text: 'Publicaciones',
                  colorText: Colors.blue,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(height: 20),
                CustomButtonG(
                  onTap: () {
                    context.push(PathRouter.misMatchsPage);
                  },
                  text: 'MATCHS',
                  colorText: Colors.blue,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(height: 20),
                getUserRef.when(
                  data: (userData) {
                    return getSuscripcionesRef.when(
                      data: (suscripciones) {
                        if (userData.isEmpty || suscripciones.isEmpty) {
                          return CustomButtonG(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PakeguesScreen(
                                    title: '',
                                    suscricion: suscripciones.isNotEmpty 
                                      ? suscripciones.first 
                                      : SuscribeModel(
                                          name: 'Gratuito',
                                          price: '0',
                                          cantidad: '0',
                                        ),
                                  ),
                                ),
                              ).then((_) => _refreshUserData()); // Agregamos refresh al volver
                            },
                            text: 'Paquetes',
                            colorText: Colors.white,
                            color: Colors.blue[400]!,
                            number: '0',
                          );
                        }
                        return CustomButtonG(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PakeguesScreen(
                                  title: userData[0].nameAdvertisement.toString(),
                                  suscricion: suscripciones.firstWhere(
                                    (s) => s.name == userData[0].nameAdvertisement,
                                    orElse: () => suscripciones.first,
                                  ),
                                ),
                              ),
                            ).then((_) => _refreshUserData()); // Agregamos refresh al volver
                          },
                          text: 'Paquetes',
                          colorText:
                              userData[0].numberAdvertisement == 0
                                  ? Colors.white
                                  : Colors.blue,
                          color: userData[0].numberAdvertisement == 0
                              ? Colors.red
                              : Colors.white.withOpacity(0.9),
                          number: userData[0].numberAdvertisement.toString(),
                        );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const CircularProgressIndicator(),
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
                const SizedBox(height: 20),
                CustomButtonG(
                  onTap: () {
                    context.push(PathRouter.perfilPage);
                  },
                  text: 'Perfil',
                  colorText: Colors.white,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                CustomButtonG(
                  onTap: () async {
                    CustomDialogs.generalDialog(
                      context: context,
                      title: 'Cerrar Sesión',
                      content: '¿Desea cerrar sesión?',
                      onPressed: () async {
                        final auth = ApiAuth();
                        await GeneralUtils.removeUid();
                        await GeneralUtils.removePassword();
                        await auth.signOut();
                        // ignore: use_build_context_synchronously
                        context.go(PathRouter.login);
                      },
                    );
                  },
                  text: 'Salir',
                  colorText: Colors.white,
                  color: const Color.fromARGB(255, 9, 132, 214),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                        'https://yahirmendoza.blogspot.com/2024/10/terminos-y-condiciones-de-privacidad.html');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      print('No se puede abrir el PDF');
                    }
                  },
                  child: const Text(
                    'Términos y Condiciones de privacidad',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  'v.2.1.1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}