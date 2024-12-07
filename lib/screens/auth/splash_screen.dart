import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      init();
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  init() async {
    final auth = ApiAuth();
    final response = await auth.checkStatus();
    if (response['success']) {
      auth.saveTokenToDatabase();
      final user = response['user'] as UserModel;
      getRoute(user);
    } else {
      // ignore: use_build_context_synchronously
      context.go(PathRouter.login);
    }
  }

  void getRoute(UserModel? userLoged) {
    if (!userLoged!.isActive!) {
      return context.go(PathRouter.activeAccount);
    }
    context.go(PathRouter.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image(
              image: AssetImage(CustomAssets.iconMH),
              height: 200,
            ))
            // ImageIcon(
            //   AssetImage(CustomAssets.iconMH),
            // )
          ],
        ),
      ),
    );
  }
}
