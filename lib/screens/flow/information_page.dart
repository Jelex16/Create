import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class InformationPage extends ConsumerStatefulWidget {
  const InformationPage({super.key});

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends ConsumerState<InformationPage> {
  List<StateModel> listStates = [];
  List<MunicipalityModel> listMunicipalities = [];
  List<ColoniesModel> listColonies = [];
  @override
  Widget build(BuildContext context) {
    final getStateProvider = ref.watch(getStatesProviderProvider);
    final idMunicipalities = ref.watch(idMunicipalitiesProvider);
    final idColonies = ref.watch(idColoniesProvider);
    final getMunicipalitiesProvider =
        ref.watch(getMunicipalitiesProviderProvider(id: idMunicipalities));
    final getColoniesProvider =
        ref.watch(getColoniesProviderProvider(id: idColonies));
    final offerCreate = ref.watch(offerCreateProvider);
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 205, 24, 221),
          onPressed: () {
            if (offerCreate.estado == null || offerCreate.estado!.isPure) {
              CustomSnackbar.showSnackBar(
                  'Selecciona un estado',
                  // ignore: use_build_context_synchronously
                  context,
                  isSuccess: false);
              return;
            }

            if (offerCreate.municipio == null ||
                offerCreate.municipio!.isPure) {
              CustomSnackbar.showSnackBar(
                  'Selecciona un municipio',
                  // ignore: use_build_context_synchronously
                  context,
                  isSuccess: false);
              return;
            }

            if (offerCreate.colonia == null || offerCreate.colonia!.isPure) {
              CustomSnackbar.showSnackBar(
                  'Selecciona una colonia',
                  // ignore: use_build_context_synchronously
                  context,
                  isSuccess: false);
              return;
            }
            context.push(PathRouter.description);
          },
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const WidgetLogo(),
              WidgetCard(
                text: offerCreate.isSale! ? 'VENTA' : 'RENTA',
                isRed: true,
              ),
              const SizedBox(
                height: 20,
              ),
              getStateProvider.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No hay estados',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    );
                  }
                  listStates = data;
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
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
                      selectedItem: 'Selecciona un Estado',
                      items: data.map((e) => e.nameState).toList(),
                      labelText: 'Estado',
                      onChanged: (value) {
                        ref
                            .read(idMunicipalitiesProvider.notifier)
                            .setIdMunicipalities(
                              listStates
                                  .firstWhere(
                                      (element) => element.nameState == value)
                                  .id,
                            );
                        offerCreateNotifier.setEstado(value!);
                      },
                    ),
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              getMunicipalitiesProvider.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: const Text('No hay municipios',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)));
                  }
                  listMunicipalities = data;
                  return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20),
                      //padding: const EdgeInsets.only(left: 3, right: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: DropDownSearch(
                        showSearchBox: true,
                        selectedItem: 'Selecciona un Municipio',
                        items: _ordenardoAlfabetico(
                            data.map((e) => e.nameMuni).toList()),
                        labelText: 'Municipio',
                        onChanged: (value) {
                          offerCreateNotifier.setMunicipio(value!);
                          ref.read(idColoniesProvider.notifier).setIdColonies(
                                listMunicipalities
                                    .firstWhere(
                                        (element) => element.nameMuni == value)
                                    .id,
                              );
                        },
                      ));
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              getColoniesProvider.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: const Text('No hay colonias',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)));
                  }
                  listColonies = data;
                  return Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: DropDownSearch(
                        showSearchBox: true,
                        selectedItem: 'Selecciona una Colonia',
                        items: _ordenardoAlfabetico(
                            data.map((e) => e.nameColo).toList()),
                        labelText: 'Colonia',
                        onChanged: (value) {
                          offerCreateNotifier.setColonia(value!);
                        },
                      ));
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ));
  }
}

List<String> _ordenardoAlfabetico(List<String> list) {
  list.sort((a, b) => a.compareTo(b));
  return list;
}
