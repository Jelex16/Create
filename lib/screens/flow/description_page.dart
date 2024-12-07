import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class DescriptionPage extends ConsumerWidget {
  const DescriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> opcYesNo = [
      "Si",
      "No",
    ];
    final modelCategory = ref.watch(modelCategoryProvider);
    final offerCreate = ref.watch(offerCreateProvider);
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 205, 24, 221),
          onPressed: () {
            if (offerCreate.precio == null || offerCreate.precio!.isPure) {
              CustomSnackbar.showSnackBar(
                  'Introduce un precio',
                  // ignore: use_build_context_synchronously
                  context,
                  isSuccess: false);
              return;
            }

            if (offerCreate.attributo1 == null ||
                offerCreate.attributo1!.isPure) {
              CustomSnackbar.showSnackBar(
                  'Completa el primer atributo',
                  // ignore: use_build_context_synchronously
                  context,
                  isSuccess: false);
              return;
            }

            if (offerCreate.attributo2 == null ||
                offerCreate.attributo2!.isPure) {
              CustomSnackbar.showSnackBar(
                  'Completa el segundo atributo',
                  // ignore: use_build_context_synchronously
                  context,
                  isSuccess: false);
              return;
            }
            context.push(PathRouter.loadImages);
          },
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
        ),
        body: Container(
            height: size.height,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            //width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(CustomAssets.imgWorld),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const WidgetLogo(),
                  const WidgetCard(text: 'DESCRIPCIÓN', isRed: true),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputs(
                    suffixIcon: const Icon(
                      Icons.monetization_on,
                      color: Colors.green,
                    ),
                    textCapitalization: false,
                    keyboardType: TextInputType.number,
                    label: _label('PRECIO'),
                    hintText: 'PRECIO',
                    errorText: offerCreate.precio?.errorMessage,
                    onChanged: offerCreateNotifier.setPrecio,
                    helperText: GeneralUtils.formatearPrecio(
                        offerCreate.precio?.value ?? ''),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInputs(
                      keyboardType: TextInputType.number,
                      suffixIcon: const Icon(Icons.bed),
                      label: _label(modelCategory.attribute1 ?? ''),
                      hintText: modelCategory.attribute1 ?? '',
                      errorText: offerCreate.attributo1?.errorMessage,
                      onChanged: offerCreateNotifier.setAttributo1),
                  const SizedBox(
                    height: 20,
                  ),
                  if (modelCategory.name == "NAVES INDUSTRIALES" ||
                      modelCategory.name == "BODEGAS" ||
                      modelCategory.name == "LOCALES" ||
                      modelCategory.name == "TERRENO RUSTICO" ||
                      modelCategory.name == "TERRENO URBANO" ||
                      modelCategory.name == "OFICINAS")
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 2, top: 2),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(modelCategory.attribute2 ?? '',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: DropDownSearch(
                            showSearchBox: true,
                            selectedItem: "Seleccionar Si o No",
                            items: opcYesNo,
                            labelText: "",
                            onChanged: (value) {
                              offerCreateNotifier.setAttributo2(value!);
                            },
                          ),
                        )
                      ],
                    ),
                  if (modelCategory.name == "CASAS" ||
                      modelCategory.name == "DEPARTAMENTOS")
                    CustomInputs(
                        keyboardType: TextInputType.number,
                        suffixIcon: const Icon(
                          Icons.window,
                          color: Colors.grey,
                        ),
                        label: _label(modelCategory.attribute2 ?? ''),
                        hintText: modelCategory.attribute2 ?? '',
                        errorText: offerCreate.attributo2?.errorMessage,
                        onChanged: offerCreateNotifier.setAttributo2),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }

  Widget _label(String label) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2, top: 2),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }
}
