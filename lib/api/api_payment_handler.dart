import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class StripeApi {
  static const String _secretKey = 'sk_test_51PH72R2KMlDnsnzTgmfy0zcujP7yTCZU3NRrYbGdzGgv9PyO8MFEH3XFcKdhwHAkMMI11Hg7hByw8u2VPI54plhJ00f4ZMQnv1';
  static const String _publishableKey = 'pk_test_51PH72R2KMlDnsnzT8dxn230fC3DaXsXQOVgI7iMrdAo7AYIaXjAiJVeTjYUrNKMqKB6lXsbVTNge47aRf0yGjZSN00QFiDDSN6';
  static const String _baseUrl = 'https://api.stripe.com/v1';
  static bool _isInitialized = false;

  static Future<void> initStripe() async {
    if (!_isInitialized) {
      Stripe.publishableKey = _publishableKey;
      await Stripe.instance.applySettings();
      _isInitialized = true;
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
    double amount,
    String currency,
    String packageName,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/payment_intents'),
        headers: {
          'Authorization': 'Bearer $_secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': (amount * 100).round().toString(),
          'currency': currency,
          'payment_method_types[]': 'card',
          'description': 'Payment for $packageName'
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Error en la respuesta de Stripe: ${response.body}');
      }

      return json.decode(response.body);
    } catch (e) {
      print('Error creating PaymentIntent: $e');
      throw Exception(e.toString());
    }
  }

  static Future<bool> processPayment(
    double amount,
    String packageName,
  ) async {
    try {
      await initStripe();

      final paymentIntentData = await createPaymentIntent(
        amount,
        'mxn',
        packageName,
      );

      if (paymentIntentData['client_secret'] == null) {
        throw Exception('No se pudo obtener el client_secret');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Match Home',
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          customerId: paymentIntentData['customer'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
          // appearance: PaymentSheetAppearance(
          //   colors: PaymentSheetAppearanceColors(
          //     background: Colors.white, // Fondo principal
          //     primary: const Color(0xFF6200EA), // Color de acento
          //     componentBackground: Colors.grey[100], // Fondo de los componentes
          //     componentBorder: Colors.grey[300], // Bordes de los componentes
          //     componentDivider: Colors.grey[200], // Divisores
          //     primaryText: Colors.black, // Texto principal
          //     secondaryText: Colors.grey[600], // Texto secundario
          //     placeholderText: Colors.grey[700], // Texto de marcador de posición
          //     icon: const Color(0xFF6200EA), // Color de los íconos
          //   ),
          //   shapes: PaymentSheetShape(
          //     borderRadius: 12, // Bordes redondeados
          //     borderWidth: 0.5, // Ancho del borde
          //   ),
          // ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      return true;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        print('Pago cancelado por el usuario');
      } else {
        print('Error Stripe: ${e.error.message}');
      }
      return false;
    } catch (e) {
      print('Error general: $e');
      return false;
    }
  }
}