import 'package:flutter/material.dart';
import 'package:match_home_client/screens/add_card_pague.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';
import '../api/api.dart';
import '../providers/providers.dart';
import '../models/models.dart';
import '../shared/utils/utils.dart';
import '../shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/api_payment_handler.dart';
import 'package:go_router/go_router.dart';
import 'package:match_home_client/config/config.dart';

class PakeguesScreen extends ConsumerStatefulWidget {
  const PakeguesScreen({super.key, this.title, required this.suscricion});
  final SuscribeModel suscricion;
  final String? title;

  @override
  ConsumerState<PakeguesScreen> createState() => PakeguesScreenState();
}

class PakeguesScreenState extends ConsumerState<PakeguesScreen> {
  List<UserModel2> _user = [];
  List<SuscribeModel> _suscriciones = [];
  int _indice = -1;

  Future<List<UserModel2>> getUser() {
    final api = ApiUser();
    return api.getUser();
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    try {
      _user = await getUser();
      setState(() {});
      _suscriciones = await SuscribeApi().getSuscribes();
      setState(() {});
    } catch (e) {
      print("Error al cargar las suscripciones: $e");
    }
  }

  Future<void> updatePackage(SuscribeModel selectedSuscription) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${_user[0].id}')
          .update({
        'numberAdvertisement': _user[0].numberAdvertisement! +
            int.parse(selectedSuscription.cantidad.toString()),
        'nameAdvertisement': selectedSuscription.name
      });

      setState(() {
        _user[0].numberAdvertisement = _user[0].numberAdvertisement! +
            int.parse(selectedSuscription.cantidad.toString());
        _user[0].nameAdvertisement = selectedSuscription.name;
      });

      final container = ProviderScope.containerOf(context);
      container.refresh(updateUserProvider);

      if (!context.mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Paquete actualizado correctamente!'),
          backgroundColor: Color.fromARGB(255, 35, 185, 70),
        ),
      );

      // Esperar un momento para que el usuario vea el mensaje
      await Future.delayed(const Duration(seconds: 1));
      
      if (!context.mounted) return;
      context.push(PathRouter.home);
      
    } catch (e) {
      print("Error actualizando Firebase: $e");
      if (!context.mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar el paquete: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> handleStripePayment(SuscribeModel selectedSuscription) async {
    try {
      final price = double.parse(selectedSuscription.price ?? '0');
      final success = await StripeApi.processPayment(
        price,
        selectedSuscription.name ?? 'Package',
      );

      if (success) {
        if (!context.mounted) return;
        await updatePackage(selectedSuscription);
      } else {
        if (!context.mounted) return;
      }
    } catch (e) {
      print('Error en el proceso de pago: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error en el proceso de pago: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPaymentMethodBottomSheet() {
    if (_indice == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona un paquete de anuncios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final selectedSuscription = _suscriciones[_indice];

    // Si es el paquete gratuito, ejecutar directamente
    if (_indice == 0) {
      updatePackage(selectedSuscription);
      return;
    }

    // Mostrar bottom sheet para selección de método de pago
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 210,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Selecciona un método de pago',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Cerrar el bottom sheet
                  Navigator.of(context).pop();
                  
                  // Ejecutar pago con Stripe
                  handleStripePayment(selectedSuscription);
                },
                child: const Text('Stripe'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchHomeCardScreen(),
                    ),
                  );
                },
                child: const Text('Oxxo Pay'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CustomAssets.imgWorld),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const WidgetLogo(size: 150),
                const SizedBox(height: 20),
                SizedBox(
                  height: 500,
                  width: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _suscriciones.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _indice = index;
                          });
                        },
                        child: CardPakeguesScreen(
                          suscricion: _suscriciones[index],
                          index: index,
                          indexSeleccionado: _indice,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 205, 24, 221),
        onPressed: _showPaymentMethodBottomSheet,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}