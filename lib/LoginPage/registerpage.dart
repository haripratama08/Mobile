import 'dart:convert';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Validation {
  final picker = ImagePicker();
  File _image;
  String url = 'http://18.139.101.44:4040/api/user/register';

  TextEditingController username = new TextEditingController();
  TextEditingController passwordreal = new TextEditingController();
  TextEditingController passwordtype = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController telp = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  TextEditingController foto = new TextEditingController();
  String msg = '';
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  void initState() {
    loading = false;
    super.initState();
  }

// registrasi ke API
  Future<int> submitSubscription(
      {File image,
      String username,
      String pass,
      String nama,
      String email,
      String telp,
      String alamat}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://18.139.101.44:4040/api/user/register"),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'foto',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll({
      "username": "$username",
      "password": "$pass",
      "nama": "$nama",
      "email": "$email",
      "telp": "$telp",
      "alamat": "$alamat"
    });
    print("request: " + request.toString());
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    print("This is response:" + response.body.toString());
    var _data = jsonDecode(response.body.toString());
    print(_data);
    if (_data['status'] == 'Created') {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new LoginPage()));
      print("masuk");
    } else {
      msg = _data['message'];
      print("$msg");
    }
    return response.statusCode;
  }

// untuk mendapat gambar dari Device
  Future uploadFoto(ImageSource media) async {
    final pickedFile = await picker.getImage(source: media);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(top: 80.0),
        ),
        _image == null
            ? GestureDetector(
                onTap: () {
                  pilihFoto();
                },
                child: CircleAvatar(
                    backgroundColor: Colors.green[900],
                    foregroundColor: Color(0XFFFFFF),
                    radius: 48.0,
                    child: CircleAvatar(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      radius: 47,
                      backgroundImage: AssetImage('asset/img/pngwing.com.png'),
                    )),
              )
            : GestureDetector(
                onTap: () {
                  pilihFoto();
                },
                child: CircleAvatar(
                    backgroundColor: Colors.green[900],
                    foregroundColor: Color(0XFFFFFF),
                    radius: 48.0,
                    child: CircleAvatar(
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      radius: 47,
                      backgroundImage: FileImage(_image),
                    )),
              ),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: new Container(
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    userField(),
                    SizedBox(height: 10),
                    passwordField(),
                    SizedBox(height: 10),
                    retypeField(),
                    SizedBox(height: 10),
                    nameField(),
                    SizedBox(height: 10),
                    emailField(),
                    SizedBox(height: 10),
                    telpField(),
                    SizedBox(height: 10),
                    addressField(),
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
        )
      ],
    ));
  }

  Widget userField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
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
            contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget emailField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return ' email';
            }
          },
          controller: email,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email, color: Colors.green[900]),
            hintText: 'Email',
            labelStyle:
                TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget passwordField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return ' password';
            }
          },
          controller: passwordreal,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Colors.green[900]),
            hintText: 'Password',
            labelStyle:
                TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget retypeField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'password';
            }
          },
          controller: passwordtype,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Colors.green[900]),
            hintText: 'Pasword Retype',
            labelStyle:
                TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget nameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'nama lengkap';
            }
          },
          controller: nama,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_pin, color: Colors.green[900]),
            hintText: 'Nama Lengkap',
            labelStyle:
                TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget addressField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Alamat';
            }
          },
          controller: alamat,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.home, color: Colors.green[900]),
            hintText: 'Alamat',
            labelStyle:
                TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget telpField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Nomor Telpon';
            }
          },
          controller: telp,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone, color: Colors.green[900]),
            hintText: 'Nomor Telpon',
            labelStyle:
                TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(color: Colors.green[900])),
          ),
        ));
  }

  Widget registerButton() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Material(
          color: Colors.green[900],
          borderRadius: BorderRadius.circular(20.0),
          child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              submitSubscription(
                  image: _image,
                  username: username.text,
                  pass: passwordreal.text,
                  nama: nama.text,
                  email: email.text,
                  telp: telp.text,
                  alamat: alamat.text);
            },
            child: Text(
              "Daftar",
              style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            ),
          ),
        ));
  }

  void pilihFoto() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pilih Sumber Media',
                  style: TextStyle(fontFamily: 'Mont'),
                ),
              ],
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      uploadFoto(ImageSource.gallery);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.image),
                        Text(
                          'Foto dari galeri',
                          style: TextStyle(
                              fontFamily: 'Mont', color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      uploadFoto(ImageSource.camera);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text(
                          'Foto dari kamera',
                          style: TextStyle(
                              fontFamily: 'Mont', color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
