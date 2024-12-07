import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_home_client/models/models.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class RequestAtendidosScreen extends ConsumerStatefulWidget {
  const RequestAtendidosScreen({super.key, required this.data});
  final List<RequestModel> data;

  @override
  RequestAtendidosScreenState createState() => RequestAtendidosScreenState();
}

class RequestAtendidosScreenState
    extends ConsumerState<RequestAtendidosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Requerimientos Atendidos',
              style: TextStyle(color: Colors.white)),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
          child: widget.data.isEmpty
              ? const Center(
                  child: Text('No hay requerimientos atendidos'),
                )
              : ListView.builder(
                  itemCount: widget.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CardMisRequestAtendidos(
                      model: widget.data[index],
                      onPressed2: () {
                        setState(() {});
                      },
                      onPressed: () {
                        CustomDialogs.generalDialog(
                          context: context,
                          title: 'Eliminar Requerimiento',
                          content: '¿Desea eliminar este requerimiento?',
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('request')
                                .doc(widget.data[index].id)
                                .delete();
                            setState(() {
                              widget.data.removeAt(index);
                            });
                            CustomSnackbar.showSnackBar(
                                'Requerimiento eliminado',
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
}
