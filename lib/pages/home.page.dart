import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu/drawer.widger.dart';

late SharedPreferences prefs;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Page Home", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Wrap(
          children: [
            InkWell(
              child: Ink.image(
                width: 100,
                height: 100,
                image: AssetImage('images/season.png'),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/meteo');
              },
            ),
            InkWell(
              child: Ink.image(
                height: 100,
                width: 100,
                image: AssetImage('images/gallerie.png'),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/gallerie');
              },
            ),
            InkWell(
              child: Ink.image(
                height: 100,
                width: 100,
                image: AssetImage('images/pays.png'),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/pays');
              },
            ),
            InkWell(
              child: Ink.image(
                height: 100,
                width: 100,
                image: AssetImage('images/add-user.png'),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Ink.image(
                height: 100,
                width: 100,
                image: AssetImage('images/settings.png'),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/parametres');
              },
            ),
            InkWell(
              child: Ink.image(
                height: 100,
                width: 100,
                image: AssetImage('images/logout.png'),
              ),
              onTap: () {
                _onDesconnection(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDesconnection(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('connected', false);
    Navigator.pushNamedAndRemoveUntil(context, '/connection', (route) => false);
  }
}
