import 'dart:convert';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/API/parsing.dart';
import 'package:ch_v2_1/LoginPage/registerpage.dart';
import 'package:ch_v2_1/Menu/menu.dart';
import 'package:ch_v2_1/dialogbox/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

String uuid;
String nama = '';
String email = '';
String user = '';
bool loading;
String token;
Map<String, dynamic> other;
Map<String, dynamic> data;

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  ApiLogin apiLogin = ApiLogin();
  final _formkey = GlobalKey<FormState>();
  String msg = '';
  String status;
  List lokasi;
  int data1;
  int data2;
  int data3;
  int data4;
  String namaalat;
  String namalokasi;
  String namahub;
  String local;
  String log;
  int nilai;
  int panjanglokasi;
  bool _passwordVisible = true;

//check internet
  Future check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        getPref();
      }
    } on SocketException catch (_) {
      print('not connected');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Internet Tidak Tersedia",
              text: "Reload",
            );
          });
      LoginPage();
    }
  }

// fungsi post login
  Future doLogin() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        print(username.text);
        print(password.text);
        var rs = await apiLogin.doLogin(username.text, password.text);
        var jsonRes = json.decode(rs.body);
        print("jsonres :$jsonRes");
        data = (jsonRes["data"]);
        if (jsonRes['status'] == 'OK') {
          setState(() {
            Login login = Login.fromJson(jsonRes);
            status = login.status;
            uuid = login.data.uuid;
            nama = login.data.nama;
            user = login.data.username;
            token = login.accessToken;
          });
          savePref();
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new Menu()));
        } else {
          setState(() {
            msg = jsonRes['message'];
          });
        }
      } catch (error) {
        print(error);
      }
    }
    setState(() {
      loading = false;
    });
  }

// menyimpan preferences
  savePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString("uuid", uuid);
      pref.setString("nama", nama);
      pref.setString("token", token);
      pref.setString("user", user);
      print("uuid di savePref $uuid");
    });
  }

// mangambil preferences
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      uuid = pref.getString("uuid");
      nama = pref.getString("nama");
      token = pref.getString("token");
      user = pref.getString("user");
      uuid == null
          ? MaterialPageRoute(builder: (context) => LoginPage())
          : Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new Menu()));
    });
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      msg = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('asset/img/ch.png'),
      ),
    );
    final usernameForm = Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return ' please enter username';
            }
          },
          controller: username,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: Colors.green[900]),
            hintText: 'Username',
            labelStyle:
                TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));

    final passwordForm = Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return ' please enter password';
            }
          },
          controller: password,
          autofocus: false,
          obscureText: _passwordVisible,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility),
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green[900],
            ),
            hintText: 'Password',
            labelStyle:
                TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Material(
        color: Colors.green[900],
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            msg = '';
            FocusScope.of(context).requestFocus(FocusNode());
            doLogin();
            check();
          },
          child: Text('Masuk',
              style: TextStyle(color: Colors.white, fontFamily: "Montserrat")),
        ),
      ),
    );
    final registerPage = TextButton(
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new RegisterPage()));
        },
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Jika belum memiliki akun?",
                style:
                    TextStyle(fontFamily: "Montserrat", color: Colors.black)),
            Text(
              "Daftar",
              textAlign: TextAlign.left,
              style:
                  TextStyle(color: Color(0xFF17451A), fontFamily: "Montserrat"),
            ),
          ],
        )));
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          msg = '';
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logo,
                usernameForm,
                SizedBox(height: 24.0),
                passwordForm,
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    msg,
                    style: TextStyle(
                        color: Colors.red, fontFamily: "Mont", fontSize: 12),
                  ),
                ),
                loading == true
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.green[900]),
                          ),
                        ),
                      )
                    : loginButton,
                registerPage,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
