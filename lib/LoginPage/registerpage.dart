import 'dart:convert';
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

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = new TextEditingController();
  TextEditingController passwordreal = new TextEditingController();
  TextEditingController passwordtype = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController telp = new TextEditingController();
  TextEditingController alamat = new TextEditingController();
  String msg = '';

  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    loading = false;
    super.initState();
  }

  ApiRegister apiRegis = ApiRegister();
  Future doRegis() async {
    // print(username.text);
    // print(
    //   passwordreal.text,
    // );
    // print(
    //   email.text,
    // );
    // print(
    //   telp.text,
    // );
    // print(
    //   alamat.text,
    // );

    if (formKey.currentState.validate()) {
      // setState(() {
      //   loading = true;
      // });
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
        // print(jsonRes);
        setState(() {
          msg = jsonRes['message'];
          // print(msg);
        });
        if (jsonRes['status'] == 'Created') {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new LoginPage()));
        } else {}
      } catch (e) {}
    } else {
      // print("tidak validasi");
    }
    formKey.currentState.save();
    setState(() {
      loading = false;
    });
  }

// registrasi ke API
  // Future<int> submitSubscription(
  //     {File image,
  //     String username,
  //     String pass,
  //     String nama,
  //     String email,
  //     String telp,
  //     String alamat}) async {
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse("http://18.139.101.44:4040/api/user/register"),
  //   );
  //   Map<String, String> headers = {"Content-type": "multipart/form-data"};
  //   request.files.add(
  //     http.MultipartFile(
  //       'foto',
  //       image.readAsBytes().asStream(),
  //       image.lengthSync(),
  //       filename: image.path,
  //       contentType: MediaType('image', 'jpeg'),
  //     ),
  //   );
  //   request.headers.addAll(headers);
  //   request.fields.addAll({
  //     "username": "$username",
  //     "password": "$pass",
  //     "nama": "$nama",
  //     "email": "$email",
  //     "telp": "$telp",
  //     "alamat": "$alamat"
  //   });
  //   print("request: " + request.toString());
  //   var streamedResponse = await request.send();
  //   var response = await http.Response.fromStream(streamedResponse);
  //   print("This is response:" + response.body.toString());
  //   var _data = jsonDecode(response.body.toString());
  //   print(_data);
  //   if (_data['status'] == 'Created') {
  //     Navigator.push(context,
  //         new MaterialPageRoute(builder: (context) => new LoginPage()));
  //     print("masuk");
  //   } else {
  //     msg = _data['message'];
  //     print("$msg");
  //   }
  //   return response.statusCode;
  // }
// untuk mendapat gambar dari Device
  // Future uploadFoto(ImageSource media) async {
  //   final pickedFile = await picker.getImage(source: media);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {}
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print(username.text?.isEmpty ?? true);
    print(passwordreal.text?.isEmpty ?? true);
    print(passwordtype.text?.isEmpty ?? true);
    print(nama.text?.isEmpty ?? true);
    print(email.text?.isEmpty ?? true);
    print(telp.text?.isEmpty ?? true);
    print(alamat.text?.isEmpty ?? true);
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
                            fontFamily: "Mont",
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
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'masukan username';
            }
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
          ],
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
              return ' masukan email';
            } else if (!value.contains('@')) {
              return ' masukan email dengan benar';
            }
            return null;
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
              return 'masukan password';
            } else if (!value.contains(RegExp(r"(\w+)"))) {
              return 'perbaiki kombinasi password untuk keamanan anda';
            }
            return null;
          },
          controller: passwordreal,
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
  }

  Widget retypeField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
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
              return 'masukan nama lengkap';
            }
            return null;
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
              return 'masukan alamat';
            }
            return null;
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
              return 'masukan nomor telpon';
            }
            return null;
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
              if (nama.text.isEmpty ||
                  username.text.isEmpty ||
                  passwordreal.text.isEmpty ||
                  passwordtype.text.isEmpty ||
                  email.text.isEmpty ||
                  telp.text.isEmpty ||
                  alamat.text.isEmpty) {
                msg = 'mohon lengkapi isian terlebih dahulu';
              } else {
                msg = '';
                FocusScope.of(context).requestFocus(FocusNode());
                doRegis();
              }

              // submitSubscription(
              //     image: _image,
              //     username: username.text,
              //     pass: passwordreal.text,
              //     nama: nama.text,
              //     email: email.text,
              //     telp: telp.text,
              //     alamat: alamat.text);
            },
            child: Text(
              "Daftar",
              style: TextStyle(color: Colors.white, fontFamily: "Montserrat"),
            ),
          ),
        ));
  }

  // void pilihFoto() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           title: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 'Pilih Sumber Media',
  //                 style: TextStyle(fontFamily: 'Mont'),
  //               ),
  //             ],
  //           ),
  //           content: Container(
  //             height: MediaQuery.of(context).size.height / 7,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     uploadFoto(ImageSource.gallery);
  //                   },
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Icon(Icons.image),
  //                       Text(
  //                         'Foto dari galeri',
  //                         style: TextStyle(
  //                             fontFamily: 'Mont', color: Colors.black),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     uploadFoto(ImageSource.camera);
  //                   },
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Icon(Icons.camera),
  //                       Text(
  //                         'Foto dari kamera',
  //                         style: TextStyle(
  //                             fontFamily: 'Mont', color: Colors.black),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}
