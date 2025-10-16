import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [Colors.white,Colors.greenAccent],radius: 0.7)),
              child:Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/profile.jpg"),
                    radius: 50,
                  )
              )
          ),
          // accueil button
          ListTile(
            title: Text("accueil",style: TextStyle(color: Colors.black,fontSize: 20)),
            leading: Icon(Icons.home,color: Colors.green,size: 22),
            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.greenAccent,),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          // map button
          ListTile(
            title: Text("pays",style: TextStyle(color: Colors.black,fontSize: 20)),
            leading: Icon(Icons.map_outlined,color: Colors.green,size: 22),
            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.greenAccent,),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/pays');
            }
          ),
          // meteo button
          ListTile(
            title: Text("meteo",style: TextStyle(color: Colors.black,fontSize: 20)),
            leading: Icon(Icons.cloud_circle_outlined,color: Colors.green,size: 22),
            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.greenAccent,),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/meteo');
            },
          ),
          // Gallerie button
          ListTile(
            title: Text("Gallerie",style: TextStyle(color: Colors.black,fontSize: 20)),
            leading: Icon(Icons.image_outlined,color: Colors.green,size: 22),
            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.greenAccent,),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/gallerie');
            },
          ),

          // setting button
          ListTile(
            title: Text("parametre",style: TextStyle(color: Colors.black,fontSize: 20)),
            leading: Icon(Icons.settings_outlined,color: Colors.green,size: 22),
            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.greenAccent,),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/parametres');
            },
          ),
          // contact button
          ListTile(
            title: Text("contact",style: TextStyle(color: Colors.black,fontSize: 20)),
            leading: Icon(Icons.phone_in_talk_outlined,color: Colors.green,size: 22),
            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.greenAccent,),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
          ),
          // desconnect button
          ListTile(
            title: Text("quitter",style: TextStyle(color: Colors.black,fontSize: 20)),
            leading: Icon(Icons.exit_to_app_outlined,color: Colors.green,size: 22),
            trailing: Icon(Icons.keyboard_arrow_right,color: Colors.greenAccent,),
            onTap: () {
              Navigator.pop(context);
              _onDesconnection(context);
            }

          ),
        ],

      ),
    );
  }
  Future<void> _onDesconnection(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('connected', false);
    Navigator.pushNamedAndRemoveUntil(context, '/connection', (route) => false);
  }
}
