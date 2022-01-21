import 'dart:async';
import 'package:ch_v2_1/API/jenismonitoring.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'dart:io';
import 'package:ch_v2_1/Validator/validation.dart';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Menu/menu.dart';

String eventalat;
String time;
String reason;
List<dynamic> list2 = [];
int status1 = 0;
List<dynamic> idlokasi = [];
List<dynamic> idhub = [];
List<dynamic> idalat = [];
List<dynamic> eventdev = [];
List<dynamic> reasondev = [];
List<dynamic> timeevent = [];
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
    var url = Uri.parse('$endPoint/user/data');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    Jenismonitoring data2 = Jenismonitoring.fromJson(jsonResponse);
    if (this.mounted) {
      setState(() {
        alat = 1;
        if (alat == listnama.length) {
          setState(() {
            loading = false;
          });
        } else {
          List<Widget> list = [];
          for (int i = 0; i < data2.data.lokasi.length; i++) {
            for (int j = 0; j < data2.data.lokasi[i].hub.length; j++) {
              for (int k = 0;
                  k < data2.data.lokasi[i].hub[j].alat.length;
                  k++) {
                eventalat = data2.data.lokasi[i].hub[j].alat[k].event;
                reason = data2.data.lokasi[i].hub[j].alat[k].reason;
                alat = data2.data.lokasi[i].hub[j].alat.length;
                data1 = data2.data.lokasi[i].id;
                data3 = data2.data.lokasi[i].hub[j].id;
                data4 = data2.data.lokasi[i].hub[j].alat[k].id;
                data5 = data2.data.lokasi[i].hub[j].alat[k].alias;
                time = data2.data.lokasi[i].hub[j].alat[k].time;
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
                if (idalat.length == eventdev.length) {
                } else {
                  eventdev.add(eventalat);
                }
                if (idalat.length == reasondev.length) {
                } else {
                  reasondev.add(reason);
                }
                if (idalat.length == timeevent.length) {
                } else {
                  timeevent.add(time);
                }
                print(timeevent);
                list2.add(
                    ('{ "idlokasi" : $data1,  "idhub" : $data3,  "idalat" : $data4, "nama" : $data5}'));
              }
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
    listnama.clear();
    try {
      var rs = await ganti.doGanti(alias.text, idala, uuid, token);
      var jsonRes = json.decode(rs.body);
      listnama.clear();
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
    } catch (e) {}
  }

  void change(int index) {
    items.clear();
    status1 = index;
    idlokas = idlokasi[index];
    idhu = idhub[index];
    idala = idalat[index];
    loadDevice();
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
    eventdev.clear();
    reasondev.clear();
    listnama.clear();
    idalat.clear();
    idhub.clear();
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
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          nama = listnama[index];
                          loading = true;
                          itemsshadow.clear();
                          items.clear();
                          zerodata = false;
                          data(status1);
                          change(index);
                          items = items;
                          itemsshadow = itemsshadow;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        child: Container(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        'asset/img/monitor.png',
                                        height: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text(
                                          '${listnama[index]}',
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                              fontFamily: 'kohi',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        eventdev[index] == 'disconnected'
                                            ? new Text(
                                                '${reasondev[index]}',
                                                style: TextStyle(fontSize: 10),
                                              )
                                            : new Text(''),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (eventdev[index] == 'disconnected') {
                                        AlertDialog alert = AlertDialog(
                                          title: Text(
                                              "Terkoneksi terakhir pada",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Kohi')),
                                          content: Text("${timeevent[index]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Kohi',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          actions: [],
                                        );
                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      } else {
                                        AlertDialog alert = AlertDialog(
                                          title: Text(
                                            "Terhubung kembali pada",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(fontFamily: 'Kohi'),
                                          ),
                                          content: Text("${timeevent[index]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Kohi',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          actions: [],
                                        );
                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      }

                                      // set up the AlertDialog
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: eventdev[index] == 'disconnected'
                                            ? Image.asset(
                                                'asset/img/disconnected.png',
                                                height: 25,
                                              )
                                            : Image.asset(
                                                'asset/img/connected.png',
                                                height: 25,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            height: MediaQuery.of(context).size.height / 11.5,
                            width: MediaQuery.of(context).size.width * 4 / 5,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xB1AFAF).withOpacity(0.3),
                                    spreadRadius: 1,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                                color: warna,
                                borderRadius: BorderRadius.circular(10))),
                      ));
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
                      style: TextStyle(fontFamily: 'kohi', fontSize: 15),
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
                      setState(() {
                        loading = true;
                        listnama.clear();
                      });
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
                                  color: Colors.white, fontFamily: 'kohi'))),
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
