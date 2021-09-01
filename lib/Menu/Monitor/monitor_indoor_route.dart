import 'dart:async';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart';
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
int idhu2;
int idala2;
int idlokas2;
int idalate;
int ind;

class MonitorIndoorRoute extends StatefulWidget {
  final int ind;
  const MonitorIndoorRoute({Key key, this.ind});
  @override
  MonitorIndoorRouteState createState() => MonitorIndoorRouteState();
}

bool loading = false;

class MonitorIndoorRouteState extends State<MonitorIndoorRoute>
    with Validation {
  TextEditingController alias = new TextEditingController();
  String msg = '';
  final formKey = GlobalKey<FormState>();
  GantiAlias ganti = GantiAlias();

  Future loadDevice() async {
    var url = Uri.parse('$endPoint/data?uuid=$uuid');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    Data2 data2 = Data2.fromJson(jsonResponse);
    if (this.mounted) {
      setState(() {
        print("nilai i ${widget.ind}");
        List<Widget> list = [];
        if (data2.data.lokasi[widget.ind].hub.length == 0) {
          msg = "Tidak Ada Alat";
        } else {
          for (int j = 0; j < data2.data.lokasi[widget.ind].hub.length; j++) {
            for (int k = 0;
                k < data2.data.lokasi[widget.ind].hub[j].alat.length;
                k++) {
              alat = data2.data.lokasi[widget.ind].hub[j].alat.length;
              data1 = data2.data.lokasi[widget.ind].id;
              data3 = data2.data.lokasi[widget.ind].hub[j].id;
              data4 = data2.data.lokasi[widget.ind].hub[j].alat[k].id;
              data5 = data2.data.lokasi[widget.ind].hub[j].alat[k].alias;
              if (listnama.contains(data5)) {
              } else {
                listnama.add('$data5');
              }
              print('listnama length ${listnama.length}');
              print("number $number");
              print("listnama $listnama");
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
          return new Row(
            children: list,
          );
        }
      });
    }
    return loadDevice();
  }

  Future doGanti() async {
    print(listnama);
    listnama.clear();
    print(listnama);
    try {
      var rs = await ganti.doGanti(alias.text, idala2, uuid, token);
      var jsonRes = json.decode(rs.body);
      listnama.clear();
      print("abis post $listnama");
      setState(() {
        loadDevice();
        print(jsonRes);
      });
      jsonRes['status'] == "OK"
          ? Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new Menu(
                        index: 0,
                      )))
          : print("tidak ada");
      print("abis itu $listnama");
    } catch (e) {}
  }

  void change(int index) {
    items.clear();
    status1 = index;
    idlokas2 = idlokasi[index];
    idhu2 = idhub[index];
    idala2 = idalat[index];
  }

  void data(int index) {
    if (index == null) {
      change(0);
      items.clear();
      idlokas2 = idlokasi[0];
      idhu2 = idhub[0];
      idala2 = idalat[0];
    } else {
      change(index);
      items.clear();
      idlokas2 = idlokasi[index];
      idhu2 = idhub[index];
      idala2 = idalat[index];
    }
  }

  void initState() {
    loadDevice();
    listnama = [];
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
                itemCount: listnama.length,
                itemBuilder: (BuildContext context, int index) {
                  void status(int ins) {
                    if (status1 == ins) {
                      warna = Colors.green[100];
                    } else {
                      warna = Color(0x098765);
                    }
                  }

                  status(index);
                  if (listnama.length == 0) {
                    if (msg == "Tidak Ada Alat") {
                      return Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Tidak Ada Alat',
                                  style: TextStyle(
                                      fontFamily: 'Mont', fontSize: 12)),
                            ),
                          ],
                        )),
                      );
                    }
                  } else {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            loading = true;
                            itemsshadow.clear();
                            items.clear();
                            data(status1);
                            change(index);
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
                                        idalate = idala2;
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
                              height: MediaQuery.of(context).size.height / 11.5,
                              width: MediaQuery.of(context).size.width * 4 / 5,
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
