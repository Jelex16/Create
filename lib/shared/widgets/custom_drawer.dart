import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/models/user_model.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/screens/screens.dart';

class CustomDrawer extends ConsumerWidget {
  final String opcDrawer;

  const CustomDrawer({super.key, required this.opcDrawer});

  bool selecDrawer(String v1, String v2) {
    if (v1 == v2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = UserModel.instance();
    final isOffertingNotifier = ref.watch(isOffertingProvider.notifier);
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 250,
              color: Colors.white,
              child: Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: NetworkImage('${userModel.urlProfile}'),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: '${userModel.name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black)),
                        const TextSpan(text: '\n'),
                        TextSpan(
                            text: '${userModel.email}',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // ListTile(
            //   title: const Text('Ofrecer'),
            //   selected: selecDrawer('OF', opcDrawer),
            //   leading: const Icon(Icons.content_paste_go_sharp),
            //   onTap: () => {
            //     isOffertingNotifier.setIsOfferting(true),
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const OfferScreen()),
            //     )
            //   },
            // ),
            ListTile(
              title: const Text('Requerimientos'),
              selected: selecDrawer('Re', opcDrawer),
              leading: const Icon(Icons.category),
              onTap: () => {
                isOffertingNotifier.setIsOfferting(false),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const RequestScreen()),
                // )
              },
            ),
            ListTile(
              title: const Text('Ofrecimientos'),
              selected: selecDrawer('OFR', opcDrawer),
              leading: const Icon(Icons.home_repair_service_rounded),
              onTap: () => {
                isOffertingNotifier.setIsOfferting(true),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const OfferingScreen()),
                // )
              },
            ),
            ListTile(
              title: const Text('Perfil'),
              selected: selecDrawer('PE', opcDrawer),
              leading: const Icon(Icons.person),
              onTap: () => {
                //context.push(PathRouter.suscription),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PerfilScreen()),
                )
              },
            ),
            // SizedBox(
            //   height: size.height * 0.3,
            // ),
            ListTile(
              title: const Text('Cerrar Sesión'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                final api = ApiAuth();
                await api.signOut();
                // ignore: use_build_context_synchronously
                context.go(PathRouter.login);
              },
            ),
          ],
        ));
  }
}
