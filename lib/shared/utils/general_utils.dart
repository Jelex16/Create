import 'package:intl/intl.dart';
import 'package:match_home_client/shared/services/key_values_impl.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralUtils {
  static Future<void> setUid(String uid) async {
    final keyValueStorage = KeyValuesImplementation();
    await keyValueStorage.setKeyValue('uidMatchClient', uid);
  }

  static Future<String?> getUid() async {
    final keyValueStorage = KeyValuesImplementation();
    return await keyValueStorage.getValue<String>('uidMatchClient');
  }

  static Future<void> removeUid() async {
    final keyValueStorage = KeyValuesImplementation();
    await keyValueStorage.removeKey('uidMatchClient');
  }

  //set password
  static Future<void> setPassword(String password) async {
    final keyValueStorage = KeyValuesImplementation();
    await keyValueStorage.setKeyValue('passwordMatchClient', password);
  }

  static Future<String?> getPassword() async {
    final keyValueStorage = KeyValuesImplementation();
    return await keyValueStorage.getValue<String>('passwordMatchClient');
  }

  static Future<void> removePassword() async {
    final keyValueStorage = KeyValuesImplementation();
    await keyValueStorage.removeKey('passwordMatchClient');
  }

  static String formatearPrecio(String precioString) {
    // Convierte el precio a un valor numérico (double)
    double precio = double.tryParse(precioString) ?? 0.0;

    // Crea un objeto NumberFormat para el formato de moneda en pesos mexicanos
    final formatoMoneda = NumberFormat.currency(
      locale: 'es_MX',
      symbol: '',
      decimalDigits: 2,
    );

    // Formatea el precio y agrega el símbolo $ al principio y MXN al final
    return '\$ ${formatoMoneda.format(precio)} MXN';
  }

  static Future<void> openWhatsApp(
      String phoneNumber, String nombre, String estado) async {
    final uri = Uri.parse(
      'https://api.whatsapp.com/send?phone=$phoneNumber&text=Hola $nombre, me comunico contigo ya que hicimos match en la APP Match Home en referencia a tu requerimiento de una Casa en $estado',
    );
    launchUrl(uri);
  }
}
