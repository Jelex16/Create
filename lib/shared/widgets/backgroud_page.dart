import 'package:flutter/material.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({super.key, this.onlyBackground = false});
  final bool onlyBackground;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    CustomAssets.imgWorld,
                  ),
                  fit: BoxFit.cover)),
        ),
        if (!onlyBackground)
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),
      ],
    );
  }
}
