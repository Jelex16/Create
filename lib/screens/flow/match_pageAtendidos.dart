import 'package:flutter/material.dart';
import 'package:match_home_client/models/model_create_offer.dart';
import 'package:match_home_client/models/request_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user2_model.dart';
import '../../shared/widgets/widgets.dart';

class MatchScreenAtendidos extends ConsumerStatefulWidget {
  const MatchScreenAtendidos(
      {super.key,
      required this.dataRequest,
      required this.matchList,
      required this.listUser,
      this.onPressed2});
  final RequestModel dataRequest;
  final List<OfferCreateModel> matchList;
  final List<UserModel2> listUser;
  final void Function()? onPressed2;
  @override
  MatchScreenAtendidosState createState() => MatchScreenAtendidosState();
}

class MatchScreenAtendidosState extends ConsumerState<MatchScreenAtendidos> {
  List<OfferCreateModel> matchList2 = [];

  Future<List<OfferCreateModel>> initData() async {
    await Future.delayed(const Duration(seconds: 1));
    matchList2 = widget.matchList.toSet().toList();
    return matchList2;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            heightFactor: 3,
            child: Container(
              color: Colors.black12,
              height: 70,
              width: 70,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 5,
                semanticsLabel: 'cargando',
              ),
            ),
          );
        }
        return SizedBox(
          child: Column(
            children: [
              ListView.builder(
                itemCount: matchList2.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CardAtendidos(
                      model: matchList2[index],
                      listUser: widget.listUser,
                      request: widget.dataRequest,
                      onPressed: () {
                        setState(() {
                          //matchList2.removeAt(index);
                          widget.matchList.removeAt(index);
                        });
                        widget.onPressed2!();
                      });
                },
              )
            ],
          ),
        );
      },
    );
  }
}
