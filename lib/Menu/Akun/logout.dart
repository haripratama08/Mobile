import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: IconButton(
          color: Colors.green[900],
          iconSize: 30.0,
          icon: Icon(Icons.close),
          onPressed: () async {
            Navigator.pushReplacementNamed(
              context,
              '/login',
            );
            final pref = await SharedPreferences.getInstance();
            await pref.clear();
          },
        ),
        title: new Text(
          "Logout",
          style: new TextStyle(
            color: Colors.black,
            fontFamily: "Mont",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
