import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/models/category_model.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class TerrenoPage extends ConsumerWidget {
  const TerrenoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getCategoryProvider = ref.watch(getCategoriesProviderProvider);
    final modelCategoryNotifier = ref.watch(modelCategoryProvider.notifier);
    final offerCreate = ref.watch(offerCreateProvider);
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: Text(offerCreate.isOffer!
              ? 'Mis Ofrecimientos'
              : 'Mis Requerimientos'),
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(CustomAssets.imgWorld),
                    fit: BoxFit.cover)),
            child: Column(children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const WidgetLogo(size: 150),
                    const SizedBox(
                      height: 10,
                    ),
                    getCategoryProvider.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return const Center(
                            child: Text('No hay categorias'),
                          );
                        }
                        List<CategoryModel> data2 = [];
                        for (var datat in data) {
                          if (datat.name == 'TERRENO RUSTICO' ||
                              datat.name == 'TERRENO URBANO') {
                            data2.add(datat);
                          }
                        }
                        data = data2;
                        data.sort((a, b) => a.name!.compareTo(b.name!));
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: ListTile(
                                  onTap: () {
                                    offerCreateNotifier
                                        .setCategory(data[index].name ?? '');
                                    modelCategoryNotifier
                                        .setCategory(data[index]);
                                    context.push(PathRouter.saleRent);
                                  },
                                  title: Text(
                                    data[index].name!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  textColor: Colors.blue),
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }
}
