import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:go_router/go_router.dart';
//import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../shared/utils/custom_assets.dart';
import '../../shared/utils/utils.dart';
import '../screens.dart';
//import '../../shared/utils/utils.dart';

class AttendedPage extends ConsumerStatefulWidget {
  const AttendedPage({super.key});

  @override
  AttendedPageState createState() => AttendedPageState();
}

class AttendedPageState extends ConsumerState<AttendedPage> {
  @override
  Widget build(BuildContext context) {
    final isUpdateOffering = ref.watch(isUpdateOfferingProvider);
    final isUpdateRequest = ref.watch(isUpdateRequestProvider);
    final isUpdateOfferingNotifier =
        ref.watch(isUpdateOfferingProvider.notifier);
    final isUpdateRequestNotifier = ref.watch(isUpdateRequestProvider.notifier);
    final isUpdateuserNotifier = ref.watch(updateUserProvider.notifier);
    final getOfferingRef =
        ref.watch(getOfferingProvider(isUpdate: isUpdateOffering));
    final getRequestRef =
        ref.watch(getRequestProvider(isUpdate: isUpdateRequest));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          //titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
          title: const Text('ATENDIDOS', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  isUpdateOfferingNotifier.setIsUpdateOffering();
                  isUpdateRequestNotifier.setIsUpdateRequest();
                  isUpdateuserNotifier.change();
                })
          ]),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const WidgetLogo(size: 150),
            const SizedBox(height: 20),
            getOfferingRef.when(
              data: (data) {
                List<OfferCreateModel> data2 = [];
                for (var eleme in data) {
                  if (eleme.atendidos != null) {
                    data2.add(eleme);
                  }
                }
                data = data2;
                if (data.isEmpty) {
                  return CustomButtonG(
                    onTap: (){
                      CustomSnackbar.showSnackBar(
                            'No tiene ofrecimientos atendidos', context,
                            isSuccess: false);
                            /*setState(() {
                              //nose si le pongas esto, ya es desicion tuya 
                            });*/
                    },
                    text: 'Mis Ofrecimientos',
                    colorText: Colors.blue,
                    color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                    //number: '0',
                  );
                }
                return CustomButtonG(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfferingAtendidosScreen(
                                  listOffering: data,
                                )));
                  },
                  text: 'Ofrecimientos',
                  colorText: Colors.blue,
                  color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                  //number: data.length.toString(),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(
              height: 20,
            ),
            getRequestRef.when(
              data: (data) {
                List<RequestModel> data2 = [];
                for (var eleme in data) {
                  if (eleme.atendidos != null) {
                    data2.add(eleme);
                  }
                }
                data = data2;
                if (data.isEmpty) {
                  return CustomButtonG(
                    onTap: (){
                      CustomSnackbar.showSnackBar(
                            'No tiene requiquimientos atendidos', context,
                            isSuccess: false);
                            /*setState(() {
                              //nose si le pongas esto, ya es desicion tuya 
                            });*/
                    },
                    text: 'Mis Requerimientos',
                    colorText: Colors.blue,
                    color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                    //number: '0',
                  );
                }
                return CustomButtonG(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestAtendidosScreen(
                                  data: data,
                                )));
                  },
                  text: 'Requerimientos',
                  colorText: Colors.blue,
                  color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                  //number: data.length.toString(),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
