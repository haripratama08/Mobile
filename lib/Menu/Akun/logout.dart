import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:ch_v2_1/dialogbox/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'dart:async';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  String status;
  String telp;
  String email;
  String alamat;
  String foto;
  double size;
  String namas;
  void initState() {
    loadSensor();
    super.initState();
  }

  Future loadSensor() async {
    var url = Uri.parse('$endPoint/profile');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    print(jsonResponse);
    print(token);
    setState(() {
      size = MediaQuery.of(context).size.width / 2;
      status = jsonResponse['status'];
      namas = (jsonResponse['data'])['nama'];
      email = (jsonResponse['data'])['email'];
      telp = (jsonResponse['data'])['telp'];
      alamat = (jsonResponse['data'])['alamat'];
      foto = (jsonResponse['data'])['foto'];
      print(namas);
      print(email);
      print(telp);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (foto == null || namas == null || email == null || alamat == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                child: Image.asset("asset/img/loading.gif")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Silahkan Menunggu",
                  style: TextStyle(fontFamily: 'Mont')),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Constants.padding,
                    top: Constants.avatarRadius + Constants.padding,
                    right: Constants.padding,
                    bottom: Constants.padding),
                child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.green[900])),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.green[900],
                              ),
                              SizedBox(width: 10),
                              Text(
                                "$namas",
                                style: new TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              Icon(
                                Icons.mail,
                                color: Colors.green[900],
                              ),
                              SizedBox(width: 10),
                              Text(
                                "$email",
                                style: new TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.green[900],
                              ),
                              SizedBox(width: 10),
                              Text(
                                "$telp",
                                style: new TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.green[900],
                              ),
                              SizedBox(width: 10),
                              Text(
                                "$alamat",
                                style: new TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    )),
              ),
              Positioned(
                top: Constants.padding,
                left: Constants.padding,
                right: Constants.padding,
                child: CircleAvatar(
                  backgroundColor: Colors.green[900],
                  radius: Constants.avatarRadius,
                  child: CircleAvatar(
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    radius: Constants.avatarRadius - 2,
                    backgroundImage: NetworkImage(foto),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: ListTile(
              leading: IconButton(
                color: Colors.green[900],
                iconSize: 30.0,
                icon: Icon(Icons.close),
                onPressed: () async {
                  size = MediaQuery.of(context).size.width / 2;
                  Navigator.pushReplacementNamed(
                    context,
                    '/login',
                  );
                  final pref = await SharedPreferences.getInstance();
                  await pref.clear();
                  trial.clear();
                  items.clear();
                  iditems.clear();
                  itemsshadow.clear();
                  listnama.clear();
                  // tempatlist.clear();
                },
              ),
              title: new Text(
                "Keluar",
                style: new TextStyle(
                  color: Colors.black,
                  // fontFamily: "Mont",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 4),
          //   child: ListTile(
          //     leading: IconButton(
          //       color: Colors.green[900],
          //       iconSize: 30.0,
          //       icon: Icon(Icons.edit),
          //       onPressed: () async {
          //         size = MediaQuery.of(context).size.width / 2;
          //         Navigator.pushReplacementNamed(
          //           context,
          //           '/login',
          //         );
          //         final pref = await SharedPreferences.getInstance();
          //         await pref.clear();
          //         items.clear();
          //         iditems.clear();
          //         itemsshadow.clear();
          //         listnama.clear();
          //         tempatlist.clear();
          //       },
          //     ),
          //     title: new Text(
          //       "Edit",
          //       style: new TextStyle(
          //         color: Colors.black,
          //         fontFamily: "Mont",
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );
    }
  }
}
