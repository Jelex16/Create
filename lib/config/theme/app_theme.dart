import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        // colorSchemeSeed: seedColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          primary: Colors.red,
          secondary: Colors.red,
        ),
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        listTileTheme: const ListTileThemeData(
            // iconColor: seedColor,
            iconColor: Colors.black),
        appBarTheme: const AppBarTheme(
          color: Colors.white, // fondo blanco
          iconTheme: IconThemeData(color: Colors.black), // íconos negros
          titleTextStyle:
              TextStyle(color: Colors.black, fontSize: 20), // texto negro
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFFFFFFFF), // button white color
          textTheme: ButtonTextTheme.primary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            // primary: const Color(0xFF000000), // button text black color
            foregroundColor: const Color(0xFF000000),
            backgroundColor: const Color(0xFFFFFFFF), // button white color
          ),
        ),
      );

  Widget scaffoldBackground(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/aca.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
