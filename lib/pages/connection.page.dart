import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionPage extends StatelessWidget {
  TextEditingController txtUser =  TextEditingController();
  TextEditingController txtPassword =  TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page de connection',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: txtUser,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_2_outlined),
                hint: Text('User', style: TextStyle(color: Colors.green)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: txtPassword,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outlined),
                hint: Text('Password', style: TextStyle(color: Colors.green)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                _onConnection(context);
              },
              child: Text("connect", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size.fromHeight(50),
              ),
            ),
          ),
          // TextButton(onPressed: (){}, child: Text("Mot de passe oublié ?",style: TextStyle(color: Colors.green),)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/inscription');
            },
            child: Text("new User ?", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  static const snackBar = SnackBar(
    content: Text(
      'id ou mot de pass est invalid',
      style: TextStyle(color: Colors.red),
    ),
  );

  Future<void> _onConnection(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var password = prefs.getString('password');
    var user = prefs.getString('user');
    if (txtUser.text == user && txtPassword.text == password) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
      prefs.setBool('connected', true);
    } else {
      const snackBar = SnackBar(
        content: Text(
          'id ou mot de pass est invalid',
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
