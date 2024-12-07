import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class PublishPage extends ConsumerWidget {
  const PublishPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    final isUpdateuser = ref.watch(updateUserProvider);
    final getUserRef =
        ref.watch(getUserOneProviderProvider(isUpdate: isUpdateuser));
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
                  height: 20,
                ),
                const WidgetLogo(size: 150),
                CustomButtonG(
                  onTap: () {
                    if (getUserRef.value?.first.numberAdvertisement == 0) {
                      CustomDialogs.generalDialog(
                          context: context,
                          title: 'Alerta',
                          content:
                              'No tienes anuncios para publicar ofrecimientos',
                          onPressed: () {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          });
                    } else {
                      offerCreateNotifier.setIsOffer(true);
                      context.push(PathRouter.category);
                    }
                  },
                  text: 'Ofrecimientos',
                  colorText: Colors.blue,
                  color: Colors.white.withOpacity(0.9),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButtonG(
                  onTap: () {
                    offerCreateNotifier.setIsOffer(false);
                    context.push(PathRouter.category);
                  },
                  text: 'Requerimientos',
                  colorText: Colors.blue,
                  color: Colors.white.withOpacity(0.9),
                ),
              ],
            )));
  }
}
