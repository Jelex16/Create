import 'package:flutter/material.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/screens.dart';

class CardThingMarchListAtendidos extends ConsumerStatefulWidget {
  const CardThingMarchListAtendidos(
      {super.key, required this.model, this.onPressed, this.onPressed2});
  final OfferCreateModel model;
  final void Function()? onPressed;
  final void Function()? onPressed2;

  @override
  CardThingMarchListAtendidosState createState() =>
      CardThingMarchListAtendidosState();
}

class CardThingMarchListAtendidosState
    extends ConsumerState<CardThingMarchListAtendidos> {
  List<RequestModel> getRequetRef = [];
  List<OfferCreateModel> listOffering = [];
  List<UserModel2> listUser = [];
  List<RequestModel> matchList = [];
  Future<List<RequestModel>> getRequest() {
    final api = ApiRequest();
    return api.getRequest(allData: true);
  }

  Future<List<OfferCreateModel>> getOffering() {
    final api = ApiOffering();
    return api.getOffering();
  }

  Future<List<UserModel2>> getUser() {
    final api = ApiUser();
    return api.getUsers();
  }

  Future<bool> initData() async {
    getRequetRef = await getRequest();
    listOffering = await getOffering();
    listUser = await getUser();
    //matchList = listMatchRequit(getRequetRef, widget.model);
    matchList = listMatchAtendidosOfert(getRequetRef, widget.model);
    return true;
    //updateMatchofertas(listOffering, widget.model, matchList);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initData(),
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return MatchOfrecimientoAtendidosScreen(
            listUser: listUser,
            dataOfert: widget.model,
            matchList: matchList,
            onPressed2: widget.onPressed2);
      },
    );
  }
}
