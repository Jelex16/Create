import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class OfferingMachtScreen extends StatefulWidget {
  const OfferingMachtScreen({super.key, required this.listOffering});
  final List<OfferCreateModel> listOffering;

  @override
  State<OfferingMachtScreen> createState() => _OfferingMachtScreenState();
}

class _OfferingMachtScreenState extends State<OfferingMachtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Ofrecimientos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
          child: ListView.builder(
            itemCount: widget.listOffering.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CardThingMarchList(
                model: widget.listOffering[index],
                onPressed2: () {
                  setState(() {});
                },
                onPressed: () {
                  CustomDialogs.generalDialog(
                    context: context,
                    title: 'Eliminar Ofrecimiento',
                    content: '¿Desea eliminar este ofrecimiento?',
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('offering')
                          .doc(widget.listOffering[index].id)
                          .delete();

                      deleteImages(widget.listOffering[index].images ?? []);
                      setState(() {
                        widget.listOffering.removeAt(index);
                      });
                      CustomSnackbar.showSnackBar(
                          'Ofrecimiento eliminado',
                          // ignore: use_build_context_synchronously
                          context,
                          isSuccess: false);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
        ));
  }

  void deleteImages(List<String> imageUrls) async {
    if (imageUrls.isEmpty) {
      return;
    }
    for (String url in imageUrls) {
      Reference ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
    }
  }
}
