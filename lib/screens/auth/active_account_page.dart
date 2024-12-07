import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class ActiveAccountPage extends StatefulWidget {
  const ActiveAccountPage({super.key});

  @override
  State<ActiveAccountPage> createState() => _ActiveAccountPageState();
}

class _ActiveAccountPageState extends State<ActiveAccountPage> {
  late LoadingButtonController _btnController;

  @override
  void initState() {
    _btnController = LoadingButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _text('Procesando tu solicitud pendiente', 16, bold: true),
            const SizedBox(
              height: 10,
            ),
            _icon(),
            const SizedBox(
              height: 10,
            ),
            _text(
                'Tu solicitud está siendo revisada, por favor regresa más tarde. Recuerda tener a la mano tu documentación',
                12,
                bold: true),
            const SizedBox(
              height: 20,
            ),
            CustomLoadingButton(
                primaryColor: const Color(0xFF18184E),
                text: 'CERRAR SESIÓN',
                icon: Icons.exit_to_app_outlined,
                btnController: _btnController,
                onPressed: () async {
                  final api = ApiAuth();
                  await api.signOut();
                  // ignore: use_build_context_synchronously
                  context.go(PathRouter.login);
                }),
          ],
        ),
      ),
    ));
  }

  Widget _icon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.black,
          )),
      child: const Icon(
        Icons.question_mark_outlined,
        color: Colors.black,
      ),
    );
  }

  Widget _text(String text, double size, {bool bold = false}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.w400, fontSize: size),
    );
  }
}
