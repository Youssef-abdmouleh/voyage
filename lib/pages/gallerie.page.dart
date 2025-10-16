import 'package:flutter/material.dart';

import 'menu/drawer.widger.dart';

class GalleriePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Page Gallerie", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(children: [Text("gallerie page")]),
    );
  }
}
