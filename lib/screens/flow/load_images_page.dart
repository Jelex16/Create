import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:match_home_client/api/api.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/providers/providers.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import 'package:match_home_client/shared/utils/utils.dart';
import 'package:match_home_client/shared/widgets/widgets.dart';

import '../../config/notifications/push_notifications.dart';
import '../../models/models.dart';

class LoadImagesPage extends ConsumerStatefulWidget {
  const LoadImagesPage({super.key});

  @override
  LoadImagesPageState createState() => LoadImagesPageState();
}

class LoadImagesPageState extends ConsumerState<LoadImagesPage> {
  late LoadingButtonController _btnController;

  @override
  void initState() {
    _btnController = LoadingButtonController();
    initData();
    super.initState();
  }

  List<RequestModel> listRequest = [];
  Future<List<RequestModel>> getRequest() {
    final api = ApiRequest();
    return api.getRequest(allData: true);
  }

  Future<List<UserModel2>> getUsers() {
    final api = ApiUser();
    return api.getUsers();
  }

  // List<UserModel2> _users = [];
  List<UserModel2> _user = [];

  Future<List<UserModel2>> getUser() {
    final api = ApiUser();
    return api.getUser();
  }

  void initData() async {
    listRequest = await getRequest();
    _user = await getUser();
    // _users = await getUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final listImagesInstance = ref.watch(loadImagesProvider.notifier);
    final listImages = ref.watch(loadImagesProvider);
    final offerCreateNotifier = ref.watch(offerCreateProvider.notifier);
    final isUpdateOfferingNotifier =
        ref.watch(isUpdateOfferingProvider.notifier);
    final isUpdateuserNotifier = ref.watch(updateUserProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(CustomAssets.imgWorld), fit: BoxFit.cover)),
        child: Column(
          children: [
            const WidgetLogo(),
            const WidgetCard(text: 'IMAGENES', isRed: true),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () async {
                      if (listImages != null && listImages.length >= 10) {
                        CustomSnackbar.showSnackBar(
                            'No se pueden agregar mas de 10 imagenes', context,
                            isSuccess: false);
                        return;
                      }
                      const imageSource = ImageSource.camera;
                      final image =
                          await ImageUpload.selectImage(imageSource, context);
                      if (image != null) {
                        listImagesInstance.addImage(image);
                      }
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 45,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () async {
                      if (listImages != null && listImages.length >= 10) {
                        CustomSnackbar.showSnackBar(
                            'No se pueden agregar mas de 10 imagenes', context,
                            isSuccess: false);
                        return;
                      }
                      final images =
                          await ImageUploadMultiple.selectImages(context);
                      if (images != null) {
                        listImagesInstance.addImages(images);
                      }
                    },
                    icon: const Icon(
                      Icons.photo,
                      size: 45,
                      color: Colors.white,
                    )),
              ],
            ),
            const SizedBox(height: 10),
            ViewImages(
              imageFiles: listImages,
            ),
            const SizedBox(height: 20),
            CustomLoadingButton(
                primaryColor: Colors.blue,
                text: 'GUARDAR',
                //icon: Icons.save,
                btnController: _btnController,
                onPressed: () async {
                  if (listImages == null || listImages.isEmpty) {
                    CustomSnackbar.showSnackBar(
                        'Debe subir al menos una imagen',
                        // ignore: use_build_context_synchronously
                        context,
                        isSuccess: false);
                    _btnController.success();
                    _btnController.reset();
                    return;
                  }
                  final apiImages = ApiLoadImages();
                  final images = await apiImages.uploadImages(listImages);
                  await offerCreateNotifier.createOffert(images, listRequest);
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc('${_user[0].id}')
                      .update({
                    'numberAdvertisement': _user[0].numberAdvertisement! - 1,
                  });
                  List<UserModel2> users = await getUsers();
                  List<UserModel2> listUserMarch = listUserMachtOffer(
                      addMatchRequit(
                          listRequest, offerCreateNotifier.getState()),
                      users,
                      listRequest);
                  final notifications = PushNotifications();
                  final user = UserModel.instance();
                  if (listUserMarch.isNotEmpty) {
                    for (var element in listUserMarch) {
                      await notifications.sendNotifications(
                        name: user.name!,
                        token: element.token!,
                      );
                      await notifications.sendNotifications(
                        name: element.name!,
                        token: user.token!,
                      );
                    }
                  }
                  CustomSnackbar.showSnackBar(
                      'Oferta creada con exito',
                      // ignore: use_build_context_synchronously
                      context,
                      isSuccess: true);
                  listImagesInstance.clear();
                  isUpdateOfferingNotifier.setIsUpdateOffering();
                  isUpdateuserNotifier.change();
                  // ignore: use_build_context_synchronously
                  context.go(PathRouter.home);
                  _btnController.success();
                  _btnController.reset();
                }),
          ],
        ),
      ),
    );
  }
}
