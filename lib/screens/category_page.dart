import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/models/category_model.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getCategoryProvider = ref.watch(getCategoriesProviderProvider);
    final modelCategoryNotifier = ref.watch(modelCategoryProvider.notifier);
    final offerCreate = ref.watch(offerCreateProvider);
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
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
                CustomButtonG(
                  text:
                      offerCreate.isOffer! ? 'Ofrecimientos' : 'Requerimientos',
                  colorText: Colors.white,
                  color: Colors.transparent,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      getCategoryProvider.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const Center(
                              child: Text('No hay categorias'),
                            );
                          }
                          List<CategoryModel> data2 = [];
                          for (var datat in data) {
                            if (datat.name != 'TERRENO RUSTICO' &&
                                datat.name != 'TERRENO URBANO') {
                              data2.add(datat);
                            }
                          }
                          data = data2;
                          data.add(CategoryModel(
                              name: 'TERRENOS',
                              createdAt: '2024-06-14 10:45:00.234267'));
                          //data.sort((a, b) => a.name!.compareTo(b.name!));
                          data.sort(
                              (a, b) => b.createdAt!.compareTo(a.createdAt!));
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  onTap: () {
                                    if (data[index].name != 'TERRENOS') {
                                      offerCreateNotifier
                                          .setCategory(data[index].name ?? '');
                                      modelCategoryNotifier
                                          .setCategory(data[index]);
                                      context.push(PathRouter.saleRent);
                                    } else {
                                      context.push(PathRouter.terrenosPage);
                                    }
                                  },
                                  title: Text(
                                    data[index].name!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
