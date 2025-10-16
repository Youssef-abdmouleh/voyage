import 'package:flutter/material.dart';

import 'menu/drawer.widger.dart';

class ParametresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Page parametre", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(children: [Text("paramertre page")]),
    );
  }
}
