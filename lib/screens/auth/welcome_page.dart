import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    redirict();
  }

  void redirict() {
    Future.delayed(const Duration(seconds: 3), () {
      context.go(PathRouter.activeAccount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const WidgetLogo(
              size: 300,
            ),
            Text('Registro exitoso',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(
              'Bienvenido a Match Home',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Nos esforzamos por que los usuarios tengan la mejor experiencia',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 30),
            Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  size: 100, color: Theme.of(context).primaryColorDark),
            ),
            const SizedBox(height: 30),
            const Text(
              'Redirigiendo a inicio....',
              style: TextStyle(fontSize: 25, fontFamily: 'NimbusSans'),
            ),
          ],
        ),
      ),
    );
  }
}
