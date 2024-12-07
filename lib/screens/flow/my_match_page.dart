import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/models/model_create_offer.dart';
import 'package:match_home_client/models/request_model.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/screens/screens.dart';

import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class MisMatchsPage extends ConsumerStatefulWidget {
  const MisMatchsPage({super.key});

  @override
  MisMatchsPageState createState() => MisMatchsPageState();
}

class MisMatchsPageState extends ConsumerState<MisMatchsPage> {
  @override
  Widget build(BuildContext context) {
    final isUpdateOffering = ref.watch(isUpdateOfferingProvider);
    final isUpdateRequest = ref.watch(isUpdateRequestProvider);
    final getOfferingRef =
        ref.watch(getOfferingProvider(isUpdate: isUpdateOffering));
    final getRequestRef =
        ref.watch(getRequestProvider(isUpdate: isUpdateRequest));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'MATCHES',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.invalidate(getOfferingProvider(isUpdate: isUpdateRequest));
                ref.invalidate(getRequestProvider(isUpdate: isUpdateRequest));
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
          //automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const WidgetLogo(size: 150),
              const SizedBox(height: 20),
              getOfferingRef.when(
                data: (data) {
                  List<OfferCreateModel> data2 = [];
                  List<OfferCreateModel> dataposrsia = [];
                  //int contador=0;
                  //<String> noAtendidos2 = [];
                  /*for (var e in data) {
                    if (e.offers != null && e.offers!.isNotEmpty) {
                      final offersFiltered = e.offers!.where((id) {
                        final isAtendido =
                            e.atendidos != null && e.atendidos!.contains(id);
                        final isBaneado =
                            e.baneados != null && e.baneados!.contains(id);
                        return !isAtendido && !isBaneado;
                      }).toList();

                      if (offersFiltered.isNotEmpty) {
                        e.offers = offersFiltered;
                        data2.add(e);
                      }
                    }
                  }*/
                  for (var e in data) {
                    if (e.offers != null && e.offers!.isNotEmpty) {
                      data2.add(e);
                    }
                  }
                  for (var e in data2) {
                    if (e.atendidos != null && e.atendidos!.isNotEmpty) {
                      for (var atendido in e.atendidos!) {
                        if (e.offers != null &&
                            (e.offers!.contains(atendido))) {
                          e.offers!.remove(atendido);
                        }
                      }
                    }
                  }

                  for (var e in data2) {
                    if (e.baneados != null && e.baneados!.isNotEmpty) {
                      for (var baneado in e.baneados!) {
                        if (e.offers != null && (e.offers!.contains(baneado))) {
                          e.offers!.remove(baneado);
                        }
                      }
                    }
                  }

                  for (var e in data2) {
                    //de seguro te preguntaras porque esto se repite es un porsia en caso de los for anteriores allan vaciado las listas oferts
                    if (e.offers != null && e.offers!.isNotEmpty) {
                      dataposrsia.add(e);
                    }
                  }
                  data2 = dataposrsia;
                  /*for (var e in data2) {
                    if(e.offers != null && e.offers!.isNotEmpty){
                      contador=contador+e.offers!.length;
                    }
                  }*/

                  if (data2.isEmpty) {
                    return CustomButtonG(
                      onTap: null,
                      text: 'Ofrecimientos',
                      colorText: Colors.blue,
                      color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                      number: '0',
                    );
                  }
                  return CustomButtonG(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OfferingMachtScreen(
                                    listOffering: data2,
                                  )));
                    },
                    text: 'Ofrecimientos',
                    colorText: Colors.blue,
                    color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                    number: data2.length.toString(),
                  );
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              getRequestRef.when(
                data: (data) {
                  List<RequestModel> data2 = [];
                  List<RequestModel> dataposrsia = [];
                  //int contador=0;
                  /*List<RequestModel> data2 = [];
                  for (var e in data) {
                    if (e.offers != null && e.offers!.isNotEmpty) {
                      final offersFiltered = e.offers!.where((id) {
                        final isAtendido =
                            e.atendidos != null && e.atendidos!.contains(id);
                        final isBaneado =
                            e.baneados != null && e.baneados!.contains(id);
                        return !isAtendido && !isBaneado;
                      }).toList();

                      if (offersFiltered.isNotEmpty) {
                        e.offers = offersFiltered;
                        data2.add(e);
                      }
                    }
                  }*/
                  for (var e in data) {
                    if (e.offers != null && e.offers!.isNotEmpty) {
                      data2.add(e);
                    }
                  }
                  for (var e in data2) {
                    if (e.atendidos != null && e.atendidos!.isNotEmpty) {
                      for (var atendido in e.atendidos!) {
                        if (e.offers != null &&
                            (e.offers!.contains(atendido))) {
                          e.offers!.remove(atendido);
                        }
                      }
                    }
                  }

                  for (var e in data2) {
                    if (e.baneados != null && e.baneados!.isNotEmpty) {
                      for (var baneado in e.baneados!) {
                        if (e.offers != null && (e.offers!.contains(baneado))) {
                          e.offers!.remove(baneado);
                        }
                      }
                    }
                  }

                  for (var e in data2) {
                    //de seguro te preguntaras porque esto se repite es un porsia en caso de los for anteriores allan vaciado las listas oferts
                    if (e.offers != null && e.offers!.isNotEmpty) {
                      dataposrsia.add(e);
                    }
                  }
                  data2 = dataposrsia;
                  /*for (var e in data2) {
                    if(e.offers != null && e.offers!.isNotEmpty){
                      contador=contador+e.offers!.length;
                      print('contador: ${e.offers!.length}');
                    }
                  }*/

                  if (data2.isEmpty) {
                    return CustomButtonG(
                      onTap: null,
                      text: 'Requerimientos',
                      colorText: Colors.blue,
                      color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                      number: '0',
                    );
                  }
                  return CustomButtonG(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestMatchScreen(
                                    data: data2,
                                  )));
                    },
                    text: 'Requerimientos',
                    colorText: Colors.blue,
                    color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                    number: data2.length.toString(),
                  );
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButtonG(
                onTap: () {
                  context.push(PathRouter.attendedPage);
                },
                text: 'Atendidos',
                colorText: Colors.white,
                color: const Color.fromARGB(255, 205, 24, 221),
              ),
            ],
          ),
        ));
  }
}
