import 'dart:async';
import 'package:ch_v2_1/API/jenismonitoring.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart';
import 'package:ch_v2_1/process/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'dart:io';
import 'package:ch_v2_1/Validator/validation.dart';
import 'package:ch_v2_1/API/api.dart';

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
              }
            }
          }
          return new Row(
            children: list,
          );
        }
      });
    }
  }

  void change(int index) {
    items.clear();
    status1 = index;
    idlokas = idlokasi[index];
    idhu = idhub[index];
    idala = idalat[index];
    print(idlokas);
    print(idala);
    print(idhu);
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
                          print("ganti");
                          nama = listnama[index];
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
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        'asset/img/monitor.png',
                                        height: SizeConfigs.screenHeight * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: eventdev[index] == 'disconnected'
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                                new Text(
                                                  '${listnama[index]}',
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: TextStyle(
                                                      fontFamily: 'kohi',
                                                      fontSize: getHeight(14),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                // new Text(
                                                //   '${reasondev[index]}',
                                                //   style: TextStyle(
                                                //     fontSize: getHeight(10),
                                                //   ),
                                                // )
                                              ])
                                        : Align(
                                            alignment: Alignment.center,
                                            child: new Text(
                                              '${listnama[index]}',
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(
                                                  fontFamily: 'kohi',
                                                  fontSize: getHeight(14),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (eventdev[index] == 'disconnected') {
                                        AlertDialog alert = AlertDialog(
                                          contentPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height:
                                                SizeConfigs.screenHeight * 0.12,
                                            width:
                                                SizeConfigs.screenWidth * 0.65,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'asset/img/Koneksi.png',
                                                          ))),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "Waktu terkoneksi terakhir dengan sensor",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    getHeight(
                                                                        15),
                                                                fontFamily:
                                                                    'Kohi')),
                                                        SizedBox(height: 30),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "${timeevent[index]}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Kohi',
                                                                  fontSize:
                                                                      getHeight(
                                                                          15),
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      } else {
                                        AlertDialog alert = AlertDialog(
                                          contentPadding: EdgeInsets.all(0),
                                          content: Container(
                                            height:
                                                SizeConfigs.screenHeight * 0.12,
                                            width:
                                                SizeConfigs.screenWidth * 0.65,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                            'asset/img/Koneksi.png',
                                                          ))),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "Waktu terkoneksi terakhir dengan sensor",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    getHeight(
                                                                        15),
                                                                fontFamily:
                                                                    'Kohi')),
                                                        SizedBox(height: 30),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                                "${timeevent[index]}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Kohi',
                                                                  fontSize:
                                                                      getHeight(
                                                                          15),
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: eventdev[index] == 'disconnected'
                                            ? Image.asset(
                                                'asset/img/disconnected.png',
                                                height:
                                                    SizeConfigs.screenHeight *
                                                        0.03,
                                              )
                                            : Image.asset(
                                                'asset/img/connected.png',
                                                height:
                                                    SizeConfigs.screenHeight *
                                                        0.02,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            height: MediaQuery.of(context).size.height / 11,
                            width: MediaQuery.of(context).size.width * 4 / 5,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xB1AFAF).withOpacity(0.3),
                                    spreadRadius: 1,
                                    offset: Offset(0, 2),
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
}
