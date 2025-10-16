import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/connection.page.dart';
import 'pages/inscription.page.dart';
import 'pages/home.page.dart';
import 'pages/gallerie.page.dart';
import 'pages/contact.page.dart';
import 'pages/meteo.page.dart';
import 'pages/authentification.page.dart';
import 'pages/parametres.page.dart';
import 'pages/pays.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.data?.getBool('connected') == true) {
            return HomePage();
          } else {
            return ConnectionPage();
          }
        },
      ),
      routes: routes,
    );
  }

  final routes = {
    '/home': (context) => HomePage(),
    '/inscription': (context) => InscriptionPage(),
    '/connection': (context) => ConnectionPage(),
    '/gallerie': (context) => GalleriePage(),
    '/contact': (context) => ContactPage(),
    '/meteo': (context) => MeteoPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/parametres': (context) => ParametresPage(),
    '/pays': (context) => PaysPage(),
  };
}
