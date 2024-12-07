import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class SaleRentPage extends ConsumerWidget {
  const SaleRentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    final offerCreate = ref.watch(offerCreateProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(CustomAssets.imgWorld),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(offerCreate.category!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 50,
                ),
                CustomButtonG(
                  onTap: () {
                    offerCreateNotifier.setIsSale(true);
                    if (offerCreate.isOffer!) {
                      context.push(PathRouter.information);
                    } else {
                      context.push(PathRouter.requestPage);
                    }
                  },
                  text: 'Venta',
                  colorText: Colors.blue,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButtonG(
                  onTap: () {
                    offerCreateNotifier.setIsSale(false);
                    if (offerCreate.isOffer!) {
                      context.push(PathRouter.information);
                    } else {
                      context.push(PathRouter.requestPage);
                    }
                  },
                  text: 'Renta',
                  colorText: Colors.blue,
                  color: Colors.white.withOpacity(0.9),
                ),
              ],
            )),
        floatingActionButton: Container(
            alignment: Alignment.bottomCenter,
            child: const FittedBox(
              alignment: Alignment.center,
              child: WidgetLogo(size: 120),
            )));
  }
}
