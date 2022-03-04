import 'dart:io';
import 'dart:typed_data';

import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_auto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'dart:async';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart' as a;

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  var imagecap;
  String status;
  String telp;
  String email;
  String alamat;
  String foto;
  double size;
  String namas;

  void initState() {
    loadIdentitas();
    super.initState();
  }

  Future loadIdentitas() async {
    var url = Uri.parse('$endPoint/user/profile');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    print(jsonResponse);
    setState(() {
      size = MediaQuery.of(context).size.width / 2;
      status = jsonResponse['status'];
      namas = (jsonResponse['data'])['nama'];
      email = (jsonResponse['data'])['email'];
      telp = (jsonResponse['data'])['telp'];
      alamat = (jsonResponse['data'])['alamat'];
      foto = (jsonResponse['data'])['foto'];
    });
  }

  ImagePicker picker = ImagePicker();

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
              child: Text("Sedang dalam proses",
                  style: TextStyle(fontFamily: 'Kohi')),
            ),
          ],
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              pilihFoto();
            },
            child: CircleAvatar(
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.grey,
              radius: MediaQuery.of(context).size.height / 10,
              backgroundImage: NetworkImage(foto),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Nama Pemilik',
            style: TextStyle(
                fontFamily: 'Kohi', fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            '$namas',
            style: TextStyle(fontFamily: 'Kohi', fontSize: 18),
          ),
          SizedBox(
            height: 60,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 8),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.green[300],
                    size: 36,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '$email',
                    style: TextStyle(
                        fontFamily: 'Kohi',
                        color: Colors.green[900],
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 8),
              child: Row(
                children: [
                  Icon(
                    Icons.phone_android,
                    color: Colors.green[300],
                    size: 36,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '$telp',
                    style: TextStyle(
                        fontFamily: 'Kohi',
                        color: Colors.green[900],
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 8),
              child: Row(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.green[300],
                    size: 36,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '$alamat',
                    style: TextStyle(
                        fontFamily: 'Kohi',
                        color: Colors.green[900],
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          GestureDetector(
            onTap: () async {
              size = MediaQuery.of(context).size.width / 2;
              Navigator.pushReplacementNamed(
                context,
                '/login',
              );
              final pref = await SharedPreferences.getInstance();
              await pref.clear();

              token = null;
              uuid = null;
              //menghapus isi dari variabel yang ada di a
              a.items.clear();
              a.idlokasi.clear();
              a.idhub.clear();
              a.idalat.clear();
              a.items.clear();
              a.iditems.clear();
              a.itemsshadow.clear();
              a.listnama.clear();
              a.tempatlist.clear();
              a.loc.clear();
              a.huc.clear();
              a.dev.clear();

              //menghapus isi dari variabel yang ada di kontrol
              trial.clear();
              listname.clear();
              namaalatkontrol = null;
              listed.clear();
              selectedalat = null;
              pilihsensor = null;
              listsensor.clear();
              selectedkondisi = null;
              selectedstate = null;
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/img/Exit.png',
                  width: MediaQuery.of(context).size.width / 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Keluar',
                  style: TextStyle(
                      fontFamily: 'Kohi',
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      );
    }
  }

  Future fotopush(String imagename, String formater, String imagecap) async {
    var url = Uri.parse(
        'https://3tnguegmh6.execute-api.ap-southeast-1.amazonaws.com/dev/image?filename=$imagename&filetype=image/jpg');
    var response = await http.post(
      url,
      //  headers: {HttpHeaders.authorizationHeader: '$token'}
    );
    response.statusCode == 200
        ? setState(() {
            var _data = jsonDecode(response.body.toString());
            String endpoint = _data['url'];
            print('ep $endpoint');
            endpoint.isNotEmpty
                ? pushbinary(endpoint, imagecap)
                : print('error ketika upload gambar');
          })
        : print("error");
  }

  Future pushbinary(String endpoint, String imagecap) async {
    var url = Uri.parse('$endpoint');
    final bytes = File('$imagecap').readAsBytesSync();
    String base64(List<int> bytes) => base64Encode(bytes);
    setState(() {});
    Uint8List bytes2 = base64Decode(base64(bytes));
    // String jPEGPrefix = "data:image/jpeg;base64,";
    // final File file = File('$imagecap').readAsBytesSync();
    var response = await http.put(url, body: bytes2);
    print(response.statusCode);
    response.statusCode == 200
        ? showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Image.network(''),
              );
            })
        : print('error');
  }

  Future uploadFoto(ImageSource media) async {
    final XFile image = await picker.pickImage(source: media);
    setState(() {
      final myfile = File(image.name);
      print(myfile);
      if (image != null) {
        String imagename = image.name;
        String formater = image.mimeType;
        print('mimetype $formater');
        imagecap = image.path;
        print(imagecap);
        fotopush(imagename, formater, imagecap);

        print(imagecap);
      } else {}
    });
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
                  'Pilih sumber media',
                  style: TextStyle(fontFamily: 'Kohi'),
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
                        Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Foto dari galeri',
                          style: TextStyle(
                              fontFamily: 'Kohi', color: Colors.black),
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
                        Icon(
                          Icons.camera,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Foto dari kamera',
                          style: TextStyle(
                              fontFamily: 'Kohi', color: Colors.black),
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
