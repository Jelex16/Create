import 'package:flutter/material.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';

class WidgetLogo extends StatelessWidget {
  const WidgetLogo({super.key, this.size});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        image: const AssetImage(CustomAssets.iconMH),
        height: size ?? 150,
      ),
    );
  }
}
