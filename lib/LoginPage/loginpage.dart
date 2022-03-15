import 'dart:convert';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/API/parsing.dart';
import 'package:ch_v2_1/LoginPage/registerpage.dart';
import 'package:ch_v2_1/Menu/menu.dart';
import 'package:ch_v2_1/dialogbox/custom_dialog_box.dart';
import 'package:ch_v2_1/process/size_config.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

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
        getPref();
      }
    } on SocketException catch (_) {
      print(_);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Internet Tidak Tersedia",
              text: "Perbarui",
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
        var rs = await apiLogin.doLogin(username.text, password.text);
        var jsonRes = json.decode(rs.body);
        print(jsonRes);
        data = (jsonRes["data"]);
        if (jsonRes['status'] == 'OK') {
          print(jsonRes);
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
      } catch (error) {}
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
        radius: (112 + 103) / 4,
        child: Image.asset('asset/img/ch.png'),
      ),
    );

    final usernameForm = Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfigs.screenHeight * 0.05),
        child: TextFormField(
          style: TextStyle(fontFamily: "kohi", fontSize: getHeight(13)),
          validator: (value) {
            if (value.isEmpty) {
              return ' please enter username';
            }
            return null;
          },
          controller: username,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: Colors.green[900]),
            hintText: 'Username / email',
            hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: "kohi",
                fontSize: getHeight(13)),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));

    final passwordForm = Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfigs.screenHeight * 0.05),
        child: TextFormField(
          style: TextStyle(fontFamily: "kohi", fontSize: getHeight(13)),
          validator: (value) {
            if (value.isEmpty) {
              return 'please enter password';
            }
            return null;
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
            hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: "kohi",
                fontSize: getHeight(13)),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));

    final loginButton = Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfigs.screenHeight * 0.05),
      child: Material(
        color: Colors.green[900],
        borderRadius: BorderRadius.circular(10.0),
        elevation: 5.0,
        child: MaterialButton(
          height: SizeConfigs.screenHeight * 0.055,
          minWidth: MediaQuery.of(context).size.width * 0.9,
          onPressed: () {
            msg = '';
            FocusScope.of(context).requestFocus(FocusNode());
            doLogin();
            check();
          },
          child: Text('Masuk',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "kohi",
                  fontSize: getHeight(15))),
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
                style: TextStyle(fontFamily: "kohi", color: Colors.black)),
            SizedBox(
              width: 5,
            ),
            Text(
              "Daftar",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "kohi",
                  fontWeight: FontWeight.bold),
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
                SizedBox(
                  height: 25,
                ),
                usernameForm,
                SizedBox(height: 24.0),
                passwordForm,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    msg,
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: "kohi",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
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
                SizedBox(height: 20.0),
                registerPage,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
