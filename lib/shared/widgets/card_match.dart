import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/providers.dart';

class CardMatch extends ConsumerStatefulWidget {
  const CardMatch(
      {super.key,
      required this.model,
      required this.listUser,
      required this.request,
      this.onPressed});
  final OfferCreateModel model;
  final List<UserModel2> listUser;
  final RequestModel request;
  final void Function()? onPressed;
  @override
  CardMatchState createState() => CardMatchState();
}

class CardMatchState extends ConsumerState<CardMatch> {
  @override
  Widget build(BuildContext context) {
    final isUpdateRequestNotifier = ref.watch(isUpdateRequestProvider.notifier);
    final isUpdateuserNotifier = ref.watch(updateUserProvider.notifier);
    final size = MediaQuery.of(context).size;
    final UserModel2 user = usurio(widget.model.uidUser!, widget.listUser);
    return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 10),
        padding:
            const EdgeInsets.only(bottom: 10, right: 30, left: 10, top: 10),
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
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: size.width * 0.30,
                    child: CarouselSliderWidget(
                      images: widget.model.images!,
                      height: 50,
                      width: size.width * 0.30,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                _data(user),
              ],
            ),
            /*const SizedBox(height: 10),
            Center(
              child: Text('Inmobiliaria: ${user.inmobiliario}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),*/
            const SizedBox(height: 10),
            ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.urlProfile!),
              ),
              title: const Text("" /*user.name!*/),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    SizedBox(
                        height: 40,
                        width: 40,
                        child: GestureDetector(
                            onTap: () async {
                              List<String> listUpdate =
                                  widget.request.atendidos ?? [];
                              listUpdate.add(widget.model.id!);

                              await FirebaseFirestore.instance
                                  .collection('request')
                                  .doc('${widget.request.id}')
                                  .update({
                                'atendidos': listUpdate,
                              });

                              isUpdateRequestNotifier.setIsUpdateRequest();
                              isUpdateuserNotifier.change();
                              widget.onPressed!();
                              GeneralUtils.openWhatsApp('+52${user.phone!}',
                                  user.name!, user.ciudad!);
                            },
                            child: Image.asset(CustomAssets.iconWhats))),
                    const SizedBox(width: 5),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              final Uri launchUri =
                                  Uri(scheme: 'tel', path: user.phone!);
                              launchUrl(launchUri);
                            },
                            icon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 15,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _data(UserModel2 user) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "${user.name!} \nde la inmobiliaria ${user.inmobiliario!} \nHizo Macht con tu requerimieno \nContactalo ",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text(
              "Ofrece ${widget.model.category!} a la ${widget.model.isSale! ? 'Venta' : 'Renta'}\na un precio de ${GeneralUtils.formatearPrecio(widget.model.precio!.value)}",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text(
              "En el Estado de ${widget.model.estado?.value} en el municipio de ${widget.model.municipio?.value} y en la colonia de ${widget.model.colonia?.value}",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          /*Text(widget.model.category!,
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
          ),*/
        ],
      ),
    );
  }
}
