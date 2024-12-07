import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/screens/screens.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class OfferingScreen extends StatefulWidget {
  const OfferingScreen({super.key, required this.listOffering});
  final List<OfferCreateModel> listOffering;

  @override
  State<OfferingScreen> createState() => _OfferingScreenState();
}

class _OfferingScreenState extends State<OfferingScreen> {
  List<OfferCreateModel> newListOffering = [];

  @override
  void initState() {
    newListOffering = widget.listOffering;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ofrecimientos',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          height: size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
          child: ListView.builder(
            itemCount: newListOffering.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CardThing(
                model: newListOffering[index],
                onPressedUpdate: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateOffering(
                        model: newListOffering[index],
                      ),
                    ),
                  );
                },
                onPressed: () {
                  CustomDialogs.generalDialog(
                    context: context,
                    title: 'Eliminar Ofrecimiento',
                    content: '¿Desea eliminar este ofrecimiento?',
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('offering')
                          .doc(newListOffering[index].id)
                          .delete();
                      deleteImages(newListOffering[index].images ?? []);
                      setState(() {
                        newListOffering.removeAt(index);
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
