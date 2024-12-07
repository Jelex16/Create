import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../../shared/widgets/widgets.dart';

class MatchOfrecimientoAtendidosScreen extends ConsumerStatefulWidget {
  const MatchOfrecimientoAtendidosScreen(
      {super.key,
      required this.listUser,
      required this.dataOfert,
      required this.matchList,
      this.onPressed2});

  final OfferCreateModel dataOfert;
  final List<RequestModel> matchList;
  final List<UserModel2> listUser;
  final void Function()? onPressed2;
  @override
  MatchOfrecimientoAtendidosScreenState createState() =>
      MatchOfrecimientoAtendidosScreenState();
}

class MatchOfrecimientoAtendidosScreenState
    extends ConsumerState<MatchOfrecimientoAtendidosScreen> {
  List<RequestModel> matchList2 = []; //= widget.matchList.toSet().toList();

  Future<List<RequestModel>> initData() async {
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
                  return CardMatchRequetAtendidos(
                    model: matchList2[index],
                    listUser: widget.listUser,
                    dataOfert: widget.dataOfert,
                    onPressed: () {
                      setState(() {
                        matchList2.removeAt(index);
                      });
                      if (widget.onPressed2 != null) {
                        widget.onPressed2!();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
