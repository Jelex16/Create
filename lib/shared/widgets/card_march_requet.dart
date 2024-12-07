import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/general_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/providers.dart';
import 'widgets.dart';

class CardMatchRequet extends ConsumerStatefulWidget {
  const CardMatchRequet(
      {super.key,
      required this.model,
      required this.listUser,
      required this.dataOfert,
      this.onPressed});
  final RequestModel model;
  final List<UserModel2> listUser;
  final OfferCreateModel dataOfert;
  final void Function()? onPressed;
  @override
  CardMatchRequetState createState() => CardMatchRequetState();
}

class CardMatchRequetState extends ConsumerState<CardMatchRequet> {
  @override
  Widget build(BuildContext context) {
    final isUpdateOfferingNotifier =
        ref.watch(isUpdateOfferingProvider.notifier);
    final isUpdateuserNotifier = ref.watch(updateUserProvider.notifier);
    final size = MediaQuery.of(context).size;
    final UserModel2 user = usurio(widget.model.uidUser!, widget.listUser);
    return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            )),
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: 10), // altura del container
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(children: [
                    SizedBox(height: size.height * 0.02),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: size.width * 0.22,
                        child: CarouselSliderWidget(
                          images: widget.dataOfert.images!,
                          height: 15,
                          width: size.width * 0.22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.urlProfile!),
                      backgroundColor: Colors.transparent,
                    ),
                  ]),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Column(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(user.name!),
                        const Text("Hizo Mach con tu propiedad\nCONTACTALO!"),
                        Text(
                            'Estupenda: ${widget.model.category} en ${widget.model.isSale! ? 'Venta' : 'Renta'} \n ${GeneralUtils.formatearPrecio(widget.dataOfert.precio!.value)}'),
                        Text('Estado: ${widget.model.estado!}'),
                        const Text('Municipios:'),
                        _municipios(),
                        const Text('Colonias:'),
                        _colonias(),
                      ],
                    ),
                  ]),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: GestureDetector(
                            onTap: () async {
                              List<String> listUpdate =
                                  widget.dataOfert.atendidos ?? [];
                              listUpdate.add(widget.model.id!);
                              await FirebaseFirestore.instance
                                  .collection('offering')
                                  .doc('${widget.dataOfert.id}')
                                  .update({
                                'atendidos': listUpdate,
                              });
                              GeneralUtils.openWhatsApp('+52${user.phone!}',
                                  user.name!, widget.model.estado!);

                              isUpdateOfferingNotifier.setIsUpdateOffering();
                              isUpdateuserNotifier.change();
                              if (mounted) {
                                widget.onPressed!();
                              }
                            },
                            child: Image.asset(CustomAssets.iconWhats)),
                      ),
                      const SizedBox(width: 10),
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
              ),
            ],
          ),
        )
        /*ListTile(
        leading: Column(
          children: [
        ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: size.width * 0.18,
                  child: CarouselSliderWidget(
                    images: widget.dataOfert.images!,
                    height: 15,
                    width: size.width * 0.18,
                  ),
                ),
              ),    
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(user.urlAvatar!),
          backgroundColor: Colors.transparent,
        ),
          ]
        ),
        
        title: Text(user.name!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hizo Mach con tu propiedad\nCONTACTALO!"),
            Text(
                'Estupenda: ${widget.model.category} en ${widget.model.isSale! ? 'Venta' : 'Renta'} \n ${GeneralUtils.formatearPrecio(widget.dataOfert.precio!.value)}'),
            Text('Estado: ${widget.model.estado!}'),
            const Text('Municipios:'),
            _municipios(),
            const Text('Colonias:'),
            _colonias(),
          ],
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        GeneralUtils.openWhatsApp('+52${user.phone!}',
                            user.name!, widget.model.estado!);
                      },
                      icon: const ImageIcon(
                        AssetImage(CustomAssets.iconWhats),
                        color: Colors.white,
                        size: 20,
                      )),
                ),
              ),
              const Spacer(),
              Container(
                height: 40,
                width: 40,
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
                        size: 20,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),*/
        );
  }

  Widget _municipios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.model.municipios!
          .map((e) => Row(
                children: [
                  const Icon(
                    Icons.circle,
                    color: Colors.blue,
                    size: 12,
                  ),
                  const SizedBox(width: 5),
                  Text(e)
                ],
              ))
          .toList(),
    );
  }

  Widget _colonias() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.model.colonias!
          .map((e) => Row(
                children: [
                  const Icon(
                    Icons.circle,
                    color: Colors.blue,
                    size: 12,
                  ),
                  const SizedBox(width: 5),
                  Text(e)
                ],
              ))
          .toList(),
    );
  }
}
