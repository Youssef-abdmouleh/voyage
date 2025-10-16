import 'package:flutter/material.dart';

import 'menu/drawer.widger.dart';

class MeteoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Page meteo", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(children: [Text("meteo page")]),
    );
  }
}
