import 'package:ch_v2_1/Menu/Monitor/semua.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/API/parsing.dart';
import 'dart:convert';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'dart:io';
import 'package:ch_v2_1/Validator/validation.dart';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Menu/menu.dart';

List<dynamic> list2 = [];
int status1 = 0;
List<dynamic> idlokasi = [];
List<dynamic> idhub = [];
List<dynamic> idalat = [];
int number;
int data1;
int data3;
int data4;
String data5;
int alat = 0;
String nama;
String nama1;
String nama2;
List<String> listnama = [];
var warna;
int index;
int location;
int hub;
int device;
int idhu;
int idala;
int idlokas;
int idalate;

class MonitorIndoor extends StatefulWidget {
  @override
  _MonitorIndoorState createState() => _MonitorIndoorState();
}

bool loading = false;

class _MonitorIndoorState extends State<MonitorIndoor> with Validation {
  TextEditingController alias = new TextEditingController();
  String msg = '';
  final formKey = GlobalKey<FormState>();
  GantiAlias ganti = GantiAlias();
  Future loadDevice() async {
    var jsonString = await http.get(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/data?uuid=$uuid',
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    Data2 data2 = Data2.fromJson(jsonResponse);
    if (this.mounted) {
      setState(() {
        listnama.clear();
        List<Widget> list = [];
        for (int i = 0; i < data2.data.lokasi.length; i++) {
          for (int j = 0; j < data2.data.lokasi[i].hub.length; j++) {
            for (int k = 0; k < data2.data.lokasi[i].hub[j].alat.length; k++) {
              alat = data2.data.lokasi[i].hub[j].alat.length;
              data1 = data2.data.lokasi[i].id;
              data3 = data2.data.lokasi[i].hub[j].id;
              data4 = data2.data.lokasi[i].hub[j].alat[k].id;
              data5 = data2.data.lokasi[i].hub[j].alat[k].alias;
              if (listnama.contains(data5)) {
              } else {
                listnama.add('$data5');
              }
              number = listnama.length;
              if (idlokasi.length == number) {
              } else {
                idlokasi.add(data1);
              }
              if (idhub.length == number) {
              } else {
                idhub.add(data3);
              }
              if (idalat.length == number) {
              } else {
                idalat.add(data4);
              }
              list2.add(
                  ('{ "idlokasi" : $data1,  "idhub" : $data3,  "idalat" : $data4, "nama" : $data5}'));
            }
          }
        }
        return new Row(
          children: list,
        );
      });
    }
    return loadDevice();
  }

  Future doGanti() async {
    print(listnama);
    listnama.clear();
    print(listnama);
    try {
      var rs = await ganti.doGanti(alias.text, idala, uuid, token);
      var jsonRes = json.decode(rs.body);
      listnama.clear();
      print("abis post $listnama");
      setState(() {
        loadDevice();
        print(jsonRes);
      });
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => new Menu()));
      print("abis itu $listnama");
    } catch (e) {}
  }

  void change(int index) {
    items.clear();
    status1 = index;
    idlokas = idlokasi[index];
    idhu = idhub[index];
    idala = idalat[index];
  }

  void data(int index) {
    if (index == null) {
      change(0);
      items.clear();
      idlokas = idlokasi[0];
      idhu = idhub[0];
      idala = idalat[0];
    } else {
      change(index);
      items.clear();
      idlokas = idlokasi[index];
      idhu = idhub[index];
      idala = idalat[index];
    }
  }

  void initState() {
    loadDevice();
    super.initState();
  }

  void dispose() {
    loadDevice();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height / 4.5,
        child: ListView(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: alat == null ? 0 : alat,
                itemBuilder: (BuildContext context, int index) {
                  void status(int ins) {
                    if (status1 == ins) {
                      warna = Colors.green[100];
                    } else {
                      warna = Color(0x098765);
                    }
                  }

                  status(index);
                  if (listnama.length != alat) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.width / 5,
                              width: MediaQuery.of(context).size.width / 5,
                              child: Image.asset("asset/img/loading-blog.gif")),
                        ],
                      )),
                    );
                  } else {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            loading = true;
                            itemsshadow.clear();
                            items.clear();
                            data(status1);
                            change(index);
                            Semua(
                                loading: true,
                                idlokas: idlokas,
                                idhu: idhu,
                                idala: idala,
                                items: []);
                            items = items;
                            itemsshadow = itemsshadow;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'asset/img/ghico.png',
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        '${listnama[index]}',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontFamily: 'Mont', fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 12,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        idalate = idala;
                                        nama = listnama[index];
                                      });
                                      dialog();
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Icon(Icons.border_color)),
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.5, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  )
                                ],
                              )),
                              height: MediaQuery.of(context).size.height / 11,
                              width:
                                  MediaQuery.of(context).size.width * 4.5 / 5,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: warna,
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10))),
                        ));
                  }
                }),
          ],
        ),
      ),
    );
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                    child: new Text(
                      "Nama Baru",
                      style: TextStyle(fontFamily: 'Mont', fontSize: 15),
                    )),
                Container(
                    width: 150,
                    height: 50,
                    child: TextFormField(
                      controller: alias,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: nama,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      ),
                      validator: validateall,
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 15),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      doGanti();
                      listnama.clear();
                      loadDevice();
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.green[900],
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text("Terapkan",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Mont'))),
                    ),
                  ),
                )
              ],
            ),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
        );
      },
    );
  }
}
