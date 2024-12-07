import 'package:flutter/material.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/screens/screens.dart';
// import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/widgets/list_match.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/utils.dart';

class CardRequest extends ConsumerStatefulWidget {
  const CardRequest({super.key, required this.model, this.onPressed});
  final RequestModel model;
  final void Function()? onPressed;

  @override
  CardRequestState createState() => CardRequestState();
}

class CardRequestState extends ConsumerState<CardRequest> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  List<RequestModel> listRequest = [];
  List<OfferCreateModel> listOffering = [];
  List<OfferCreateModel> matchList = [];

  Future<List<RequestModel>> getRequest() {
    final api = ApiRequest();
    return api.getRequest();
  }

  Future<List<OfferCreateModel>> getOffering() {
    final api = ApiOffering();
    return api.getOffering(allData: true);
  }

  void initData() async {
    listRequest = await getRequest();
    listOffering = await getOffering();
    matchList = listMatch(listOffering, widget.model);
    updateMatchRequisitos(matchList, widget.model, listRequest);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final isUpdateUser = ref.watch(updateUserProvider);
    // final getUserRef =
    //     ref.watch(getUserProviderProvider(updateState: isUpdateUser));
    return Container(
      margin: const EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 10),
      padding: const EdgeInsets.only(bottom: 5, right: 30, left: 10, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.model.isSale! ? 'Venta' : 'Renta',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: widget.model.isSale! ? Colors.green : Colors.red),
              ),
              const Spacer(),
              IconButton(
                onPressed: widget.onPressed,
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateRequest(
                          model: widget.model,
                        ),
                      ));
                },
                icon: const Icon(Icons.edit, color: Colors.blue),
              )
            ],
          ),
          _text('Categoria', widget.model.category ?? ''),
          _text('Estado', widget.model.estado ?? ''),
          //_text('Precio', widget.model.precio ?? ''),
          if (widget.model.category != 'BODEGAS' &&
              widget.model.category != 'NAVES INDUSTRIALES' &&
              widget.model.category != 'LOCALES')
            _text('Precio',
                '${GeneralUtils.formatearPrecio(_listaPrecio(widget.model.precio!)[0])} - ${_segundoValor(_listaPrecio(widget.model.precio!)[1])}'),
          //if (widget.model.isOffer ?? false)
          // _text('Valor mensual', widget.model.mensual.toString()),
          const Text(
            'Muncipios:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Column(
            children: widget.model.municipios!
                .map((e) => Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        Text(e),
                      ],
                    ))
                .toList(),
          ),
          const Text(
            'Colonias: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Column(
            children: widget.model.colonias!
                .map((e) => Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        Text(e),
                      ],
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          /*Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            const Text('Matchs:'),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  if (matchList.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchScreen(
                                dataRequest: widget.model,
                                matchList: [...matchList],
                                listUser: [...getUserRef.value!],
                              )),
                    );
                  }
                },
                child: Text(
                  '${matchList.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ])*/
        ],
      ),
    );
  }

  Widget _text(String text, String value, {Color? color}) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.all(0),
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        value,
        style: TextStyle(color: color ?? Colors.black),
      ),
      trailing: const Icon(Icons.info, color: Colors.blue),
    );
  }

  List<String> _listaPrecio(String precios) {
    var pricee = precios.split(" - ");
    return pricee;
  }

  String _segundoValor(String valor) {
    if (valor == '0000') {
      return 'En adelante';
    } else {
      return GeneralUtils.formatearPrecio(valor);
    }
  }
}
