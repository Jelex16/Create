import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/screens/screens.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

class MatchsPage extends ConsumerStatefulWidget {
  const MatchsPage({super.key});

  @override
  MatchsPageState createState() => MatchsPageState();
}

class MatchsPageState extends ConsumerState<MatchsPage> {
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
          title: const Text('Publicaciones',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {
                isUpdateOfferingNotifier.setIsUpdateOffering();
                isUpdateRequestNotifier.setIsUpdateRequest();
                isUpdateuserNotifier.change();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
          //automaticallyImplyLeading: false,
        ),
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
                  if (data.isEmpty) {
                    return CustomButtonG(
                      onTap: null,
                      text: 'Ofrecimientos',
                      colorText: Colors.blue,
                      color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                      number: '0',
                    );
                  }
                  return CustomButtonG(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OfferingScreen(
                                    listOffering: data,
                                  )));
                    },
                    text: 'Ofrecimientos',
                    colorText: Colors.blue,
                    color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                    number: data.length.toString(),
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
                  if (data.isEmpty) {
                    return CustomButtonG(
                      onTap: null,
                      text: 'Requerimientos',
                      colorText: Colors.blue,
                      color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                      number: '0',
                    );
                  }
                  return CustomButtonG(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestScreen(
                                    data: data,
                                  )));
                    },
                    text: 'Requerimientos',
                    colorText: Colors.blue,
                    color: Colors.white.withOpacity(0.9), //Colors.blue[400]!,
                    number: data.length.toString(),
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
            ],
          ),
        ));
  }
}
