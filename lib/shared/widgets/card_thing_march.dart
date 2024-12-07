import 'package:flutter/material.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/screens/flow/match_ofre_page.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardThingMarch extends ConsumerStatefulWidget {
  const CardThingMarch({super.key, required this.model, this.onPressed});
  final OfferCreateModel model;
  final void Function()? onPressed;

  @override
  CardThingMarchState createState() => CardThingMarchState();
}

class CardThingMarchState extends ConsumerState<CardThingMarch> {
  @override
  void initState() {
    initData();
    super.initState();
  }

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

  void initData() async {
    getRequetRef = await getRequest();
    listOffering = await getOffering();
    listUser = await getUser();
    matchList = listMatchRequit(getRequetRef, widget.model);
    updateMatchofertas(listOffering, widget.model, matchList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 10),
        padding: const EdgeInsets.only(bottom: 5, right: 30, left: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.grey,
          //     spreadRadius: 5,
          //     blurRadius: 7,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        child: Stack(children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: size.width * 0.35,
                  child: CarouselSliderWidget(
                    images: widget.model.images!,
                    height: 50,
                    width: size.width * 0.35,
                  ),
                ),
              ),
              const SizedBox(width: 30),
              _data(),
            ],
          ),
          Positioned(
            top: 10,
            right: 5,
            child: Row(
              children: [
                const Text('Matchs:'),
                const SizedBox(width: 10),
                buttonRequet(context, matchList.length, listUser, matchList),
                IconButton(
                  onPressed: widget.onPressed,
                  icon: const Icon(Icons.delete, color: Colors.red),
                )
              ],
            ),
          )
        ]));
  }

  Widget _data() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(widget.model.category!,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(widget.model.isSale! ? 'Venta' : 'Renta',
              style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(GeneralUtils.formatearPrecio(widget.model.precio!.value),
                  style: const TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonRequet(BuildContext context, int listMacht,
      List<UserModel2> getUserRef, List<RequestModel> matchList) {
    return CircleAvatar(
      backgroundColor: Colors.blue[400],
      child: TextButton(
        onPressed: () {
          if (listMacht == 0) {
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MatchOfrecimientoScreen(
                      listUser: getUserRef,
                      dataOfert: widget.model,
                      matchList: matchList,
                    )),
          );
        },
        child: Text('$listMacht', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
