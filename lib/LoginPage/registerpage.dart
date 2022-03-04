import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:ch_v2_1/Validator/validation.dart';
import 'package:ch_v2_1/dialogbox/custom_dialog_box.dart';
import 'package:flutter/services.dart';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:flutter/material.dart';

String msg = '';
bool _passwordVisible = true;
bool _passwordVisible2 = true;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Validation {
  TextEditingController username = new TextEditingController();
  TextEditingController passwordreal = new TextEditingController();
  TextEditingController passwordtype = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController telp = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  String msg = '';
  bool isbutton = false;
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    var controller = TextEditingController();
    controller.addListener(() {
      setState(() {
        isbutton = true;
      });
    });
    check();
    print(username.text?.isEmpty ?? true);
    loading = false;
    super.initState();
  }

  Future check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
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

  ApiRegister apiRegis = ApiRegister();
  Future doRegis() async {
    if (formKey.currentState.validate()) {
      try {
        var rs = await apiRegis.doRegis(
          username.text,
          passwordreal.text,
          nama.text,
          email.text,
          telp.text,
          alamat.text,
        );
        var jsonRes = json.decode(rs.body);
        setState(() {
          msg = jsonRes['message'];
        });
        print(jsonRes);
        if (jsonRes['status'] == 'Created') {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new LoginPage()));
        } else {}
      } catch (e) {}
    } else {
      msg = 'mohon isi dengan benar';
      print(msg);
    }
    formKey.currentState.save();
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    username.dispose();
    nama.dispose();
    passwordreal.dispose();
    alamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(username.text?.isEmpty ?? true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundColor: Color(0XFFFFFF),
              radius: 48.0,
              child: CircleAvatar(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                radius: 47,
                backgroundImage: AssetImage('asset/img/ch.png'),
              )),
          SizedBox(height: 10),
          Container(
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    nameField(),
                    SizedBox(height: 10),
                    userField(),
                    SizedBox(height: 10),
                    passwordField(),
                    SizedBox(height: 10),
                    retypeField(),
                    SizedBox(height: 10),
                    emailField(),
                    SizedBox(height: 10),
                    telpField(),
                    SizedBox(height: 10),
                    addressField(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        msg,
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: "kohi",
                            fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    loading == true
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color((0xff186962))),
                              ),
                            ),
                          )
                        : registerButton(),
                    SizedBox(
                      height: 50,
                    )
                  ],
                )),
          ),
        ],
      )),
    );
  }

  Widget userField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'masukan username';
            } else if (value.length < 5) {
              return 'username harus lebih dari 5 karakter';
            } else if (value.contains(RegExp(r'\s\s*'))) {
              return 'username tidak boleh mengandung whitespace';
            } else {
              return null;
            }
          },
          inputFormatters: [
            FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
          ],
          controller: username,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle, color: Colors.green[900]),
            hintText: 'Username',
            hintStyle: TextStyle(
                color: Colors.black, fontFamily: "kohi", fontSize: 15),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget emailField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'masukan email';
            } else if (!value.contains('@')) {
              return 'masukan email dengan benar';
            } else if ((!value.contains('.com')) &&
                (!value.contains('.ac.id'))) {
              return 'masukan email dengan benar';
            } else if (value.length < 5) {
              return 'email harus lebih dari 5 karakter';
            } else {
              return null;
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: email,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email, color: Colors.green[900]),
            hintText: 'Email',
            hintStyle: TextStyle(
                color: Colors.black, fontFamily: "kohi", fontSize: 15),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget passwordField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'masukan password';
            } else if (!value.contains(RegExp(r"(\w+)"))) {
              return 'perbaiki kombinasi password untuk keamanan anda';
            }
            return null;
          },
          controller: passwordreal,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: _passwordVisible,
          keyboardType: TextInputType.text,
          autofocus: false,
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
              Icons.lock_open,
              color: Colors.green[900],
            ),
            hintText: 'Password',
            hintStyle: TextStyle(
                color: Colors.black, fontFamily: "kohi", fontSize: 15),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget retypeField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'masukan konfirmasi password';
            } else if (value != passwordreal.text) {
              return 'konfirmasi password tidak tepat';
            }
            return null;
          },
          controller: passwordtype,
          obscureText: _passwordVisible2,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _passwordVisible2 = !_passwordVisible2;
                });
              },
              child: Icon(
                  _passwordVisible2 ? Icons.visibility_off : Icons.visibility),
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green[900],
            ),
            hintText: 'Konfirmasi Password',
            hintStyle: TextStyle(
                color: Colors.black, fontFamily: "kohi", fontSize: 15),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget nameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'masukan nama lengkap';
            } else if (value.length < 5) {
              return 'nama harus lebih dari 5 karakter';
            } else {
              return null;
            }
          },
          controller: nama,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.perm_identity, color: Colors.green[900]),
            hintText: 'Nama Lengkap',
            hintStyle: TextStyle(
                color: Colors.black, fontFamily: "kohi", fontSize: 15),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget addressField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'masukan alamat';
            } else if (value.length < 5) {
              return 'alamat harus lebih dari 5 huruf';
            } else {
              return null;
            }
          },
          controller: alamat,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.home, color: Colors.green[900]),
            hintText: 'Alamat',
            hintStyle: TextStyle(
                color: Colors.black, fontFamily: "kohi", fontSize: 15),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget telpField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (value) {
            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
            RegExp regExp = new RegExp(patttern);
            if (value.isEmpty) {
              return 'masukan nomor telpon';
            } else if (value.length < 11 && !regExp.hasMatch(value)) {
              return 'masukan nomor telepon dengan benar';
            } else {
              return null;
            }
          },
          controller: telp,
          keyboardType: TextInputType.phone,
          autofocus: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone_android, color: Colors.green[900]),
            hintText: 'Nomor Telpon',
            hintStyle: TextStyle(
                color: Colors.black, fontFamily: "kohi", fontSize: 15),
            labelStyle: TextStyle(color: Colors.white, fontFamily: "kohi"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget registerButtonkosong() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Material(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20.0),
          child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              print(username.text?.isEmpty ?? true);
              print(passwordreal.text?.isEmpty ?? true);
              print(passwordtype.text?.isEmpty ?? true);
              print(nama.text?.isEmpty ?? true);
              print(email.text?.isEmpty ?? true);
              print(telp.text?.isEmpty ?? true);
              print(alamat.text?.isEmpty ?? true);
            },
            child: Text(
              "Daftar",
              style: TextStyle(color: Colors.white, fontFamily: "kohi"),
            ),
          ),
        ));
  }

  Widget registerButton() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Material(
          color: Colors.green[900],
          borderRadius: BorderRadius.circular(10.0),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width * 0.9,
            height: 42.0,
            onPressed: () {
              msg = '';
              FocusScope.of(context).requestFocus(FocusNode());
              doRegis();
            },
            child: Text(
              "Daftar",
              style: TextStyle(color: Colors.white, fontFamily: "kohi"),
            ),
          ),
        ));
  }
}
