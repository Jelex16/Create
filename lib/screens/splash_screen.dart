import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/router/path_router.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';

class SplashScreenInit extends StatefulWidget {
  const SplashScreenInit({super.key});
  @override
  State<SplashScreenInit> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenInit>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      // context.go(PathRouter.init);
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
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
