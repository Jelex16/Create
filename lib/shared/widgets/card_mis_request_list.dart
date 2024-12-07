import 'package:flutter/material.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/screens/flow/match_page.dart';
import 'package:match_home_client/shared/widgets/list_match.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardMisRequestList extends ConsumerStatefulWidget {
  const CardMisRequestList(
      {super.key, required this.model, this.onPressed, this.onPressed2});
  final RequestModel model;
  final void Function()? onPressed;
  final void Function()? onPressed2;

  @override
  CardMisRequestListState createState() => CardMisRequestListState();
}

class CardMisRequestListState extends ConsumerState<CardMisRequestList> {
  List<RequestModel> listRequest = [];
  List<OfferCreateModel> listOffering = [];
  List<OfferCreateModel> matchList = [];
  List<UserModel2> listUser = [];

  Future<List<RequestModel>> getRequest() {
    final api = ApiRequest();
    return api.getRequest();
  }

  Future<List<OfferCreateModel>> getOffering() {
    final api = ApiOffering();
    return api.getOffering(allData: true);
  }

  Future<List<UserModel2>> getUser() {
    final api = ApiUser();
    return api.getUsers();
  }

  Future<bool> initData() async {
    listRequest = await getRequest();
    listOffering = await getOffering();
    listUser = await getUser();
    matchList = listMatch(listOffering, widget.model);
    updateMatchRequisitos(matchList, widget.model, listRequest);
    return true;
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
        return MatchScreen(
            dataRequest: widget.model,
            matchList: matchList,
            listUser: listUser,
            onPressed2: widget.onPressed2);
      },
    );
  }
}
