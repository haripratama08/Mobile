import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_indoor_route.dart';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/API/parsing.dart';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/tambahan/stringcap.dart';
import 'package:ch_v2_1/Menu/menu.dart';

bool loading = false;
int idsensor;
int jum = 1;
bool notifikasitoogle;
String namaalat;
String img;
int idsens;
int kucing;
String satuan;
String max;
String mean;
String min;
int idjns;
int before = 0;
int panjang;
List<String> name = [];
List<Widget> items = [];
List<String> itemsshadow = [];
List<int> iditems = [];
Map<String, dynamic> sensor;
List<dynamic> loc = [];
List<dynamic> huc = [];
List<int> idloka = [];
List<dynamic> dev = [];
String jenissensor1;
int status1 = 0;
String nilai1;
int lokas;
int hu;
int ala = 0;
String convertedDateTime;
String tanggal1;
String jenissensor2;
String tanggal2;
String jnssensor;
double nilai2;
int idalatsebelum;
List<dynamic> list2 = [];
int alat = 0;
List<dynamic> idlokasi = [];
List<dynamic> idhub = [];
List<dynamic> idalat = [];
List<bool> noty = [];
int number;
String nilaisebelum;
int itemsbefore;
int data1;
int data3;
int data4;
String data5;
String nama;
String success;
String nama1;
String nama2;
int notif;
bool notify;
List<String> listnama = [];
var warna;
int index;
int location;
int hub;
String message;
int device;
int state;
String outputDate;
List<String> tempatlist = [];
String tempat;
int i;
int panjangtempat;
bool refresh = false;

class Semua extends StatefulWidget {
  final bool loading;
  final List items;
  final int idlokas;
  final int idhu;
  final int idala;
  const Semua(
      {Key key, this.idlokas, this.idhu, this.idala, this.items, this.loading});
  @override
  _SemuaState createState() => _SemuaState();
}

class _SemuaState extends State<Semua> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  void dispose() {
    loadDevice2();
    _scaffoldKey?.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadDevice2();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      items.clear();
      itemsshadow.clear();
      iditems.clear();
      Semua(idlokas: idlokas, idhu: idhu, idala: idala, items: []);
      loadSensor();
    });
  }

  void refreshData() {
    setState(() {
      refresh = true;
      FocusScope.of(context).requestFocus(FocusNode());
      Semua(idlokas: idlokas, idhu: idhu, idala: idala, items: []);
    });
    print("Refreshing");
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        refresh = false;
        print("Refreshed");
      });
    });
  }

  Future loadDevice2() async {
    var jsonString = await http.get(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/data?uuid=$uuid',
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    Data2 data2 = Data2.fromJson(jsonResponse);
    print("jsonresp: $jsonResponse");
    if (this.mounted) {
      setState(() {
        List<Widget> list = [];
        for (int i = 0; i < data2.data.lokasi.length; i++) {
          panjangtempat = data2.data.lokasi.length;
          if (tempatlist.length == panjangtempat) {
          } else {
            tempat = data2.data.lokasi[i].nama;
            tempatlist.add(tempat);
          }
          for (int j = 0; j < data2.data.lokasi[i].hub.length; j++) {
            for (int k = 0; k < data2.data.lokasi[i].hub[j].alat.length; k++) {
              alat = data2.data.lokasi[i].hub[j].alat.length;
              data1 = data2.data.lokasi[i].id;
              data3 = data2.data.lokasi[i].hub[j].id;
              data4 = data2.data.lokasi[i].hub[j].alat[k].id;
              data5 = data2.data.lokasi[i].hub[j].alat[k].nama;
              //logic untuk membuat sudah ada pada list tidak masuk kembali
              if (name.contains(data5)) {
              } else {
                name.add('$data5');
              }
              number = name.length;
              if (loc.length == number) {
              } else {
                loc.add(data1);
              }
              if (huc.length == number) {
              } else {
                huc.add(data3);
              }
              if (dev.length == number) {
              } else {
                dev.add(data4);
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
    return loadSensor();
  }

  Future gantinotif(int sets, int idsensor, String token) async {
    setState(() {
      loadSensor();
      loading = true;
    });
    var jsonString = await http.put(
        '$endPoint/sensor/notifikasi?set=$sets&id_sensor=$idsensor',
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    items.clear();
    itemsshadow.clear();
    iditems.clear();
    if (this.mounted) {
      setState(() {
        success = jsonResponse['status'];
        loadSensor();
      });
      if (success == "OK") {
        setState(() {
          loading = false;
        });
        showDialog(
          context: context,
          builder: (ctxt) => new AlertDialog(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: Image.asset("asset/img/datasent1.png")),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Telah terganti",
                      style: TextStyle(fontFamily: 'Mont', fontSize: 20)),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Menu()));
                      },
                      child: Text(
                        'kembali',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Mont',
                            color: Colors.black),
                      )),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  Future loadSensor() async {
    if (idlokas == null) {
      print("idlokasi noll");
      print("${loc[0]}, ${huc[0]}, ${dev[0]}");
      var jsonString = await http.get(
          '$endPoint/mobile/sensor?lokasi=1&hub=1&alat=1',
          headers: {HttpHeaders.authorizationHeader: '$token'});
      var jsonResponse = json.decode(jsonString.body);
      print("jsonresp: $jsonResponse");
      if (this.mounted) {
        setState(() {
          idalatsebelum = dev[0];
          panjang = ((jsonResponse["data"])["data"].length);
          print("panjang $panjang");
          for (var i = 0; i < panjang; i++) {
            if (items.length == panjang) {
            } else if (items.length > panjang) {
              items.clear();
              iditems.clear();
              itemsshadow.clear();
            } else {
              nilai1 = ((((jsonResponse["data"])["data"])[i])["data"])
                  .toStringAsFixed(1);
              idjns = (((jsonResponse["data"])["data"])[i])["id"];
              tanggal1 =
                  ((((jsonResponse["data"])["data"])[i])["tanggal_sensor"]);
              DateTime parseDate =
                  new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                      .parse(tanggal1);
              var inputDate = DateTime.parse(parseDate.toString());
              var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
              var outputDate = outputFormat.format(inputDate);
              notif = ((((jsonResponse["data"])["data"])[i])["notifikasi"]);
              mean = ((((jsonResponse["data"])["data"])[i])["mean"])
                  .toStringAsFixed(1);
              max = ((((jsonResponse["data"])["data"])[i])["max"])
                  .toStringAsFixed(1);
              min = ((((jsonResponse["data"])["data"])[i])["min"])
                  .toStringAsFixed(1);
              jnssensor = (((jsonResponse["data"])["data"])[i])["jenis"];
              if (itemsshadow.contains(jnssensor) &&
                  itemsbefore == items.length) {
                items.clear();
                iditems.clear();
                itemsshadow.clear();
              } else {
                if (jnssensor == "kelembaban") {
                  img = "asset/img/rh.png";
                  satuan = "%";
                } else if (jnssensor == "suhu udara") {
                  img = "asset/img/temp.png";
                  satuan = "\u00B0C";
                } else if (jnssensor == "ph") {
                  img = "asset/img/temp.png";
                  satuan = "";
                } else if (jnssensor == "ec") {
                  img = "asset/img/Tph.png";
                  satuan = "ppm";
                } else {
                  img = "asset/img/Ttanah.png";
                  satuan = "\u00B0C";
                }
                print("notifikasi $i adalah $notif");
                //notif
                if (notif == 0) {
                  notifikasitoogle = false;
                } else if (notif == 1) {
                  notifikasitoogle = true;
                }
                setState(() {
                  noty.add(notifikasitoogle);
                  iditems.add(notif);
                  itemsshadow.add(jnssensor);
                  nilaisebelum = nilai1;
                  items.add(
                    parameter(jnssensor, satuan, img, nilai1, min, max, mean,
                        outputDate, notifikasitoogle, idjns, i),
                  );
                });
              }
            }
          }
          itemsbefore = items.length;
        });
        return loadSensor();
      }
    } else {
      print("idalat $idala");
      print("idhub $idhu");
      print("idlokasi $idlokas");
      if (idala != idalatsebelum) {
        setState(() {
          loading = true;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
      var jsonString = await http.get(
          '$endPoint/mobile/sensor?lokasi=$idlokas&hub=$idhu&alat=$idala',
          headers: {HttpHeaders.authorizationHeader: '$token'});
      var jsonResponse = json.decode(jsonString.body);
      if (this.mounted) {
        setState(() {
          loading = false;
          panjang = ((jsonResponse["data"])["data"].length);
          print("panjang $panjang");
          for (var i = 0; i < panjang; i++) {
            if (items.length == panjang) {
            } else if (items.length > panjang) {
              setState(() {
                loading = true;
              });
              items.clear();
              iditems.clear();
              itemsshadow.clear();
            } else {
              if (nilai1 != nilaisebelum) {
                items.clear();
                iditems.clear();
                itemsshadow.clear();
              } else {}
              nilai1 = ((((jsonResponse["data"])["data"])[i])["data"])
                  .toStringAsFixed(1);
              idjns = (((jsonResponse["data"])["data"])[i])["id"];
              tanggal1 =
                  ((((jsonResponse["data"])["data"])[i])["tanggal_sensor"]);
              DateTime parseDate =
                  new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                      .parse(tanggal1);
              var inputDate = DateTime.parse(parseDate.toString());
              var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
              var outputDate = outputFormat.format(inputDate);
              notif = ((((jsonResponse["data"])["data"])[i])["notifikasi"]);
              mean = ((((jsonResponse["data"])["data"])[i])["mean"])
                  .toStringAsFixed(1);
              max = ((((jsonResponse["data"])["data"])[i])["max"])
                  .toStringAsFixed(1);
              min = ((((jsonResponse["data"])["data"])[i])["min"])
                  .toStringAsFixed(1);
              jnssensor = (((jsonResponse["data"])["data"])[i])["jenis"];
              if (itemsshadow.contains(jnssensor) &&
                  itemsbefore == items.length) {
                setState(() {
                  loading = true;
                });
                items.clear();
                iditems.clear();
                itemsshadow.clear();
              } else {
                if (jnssensor == "kelembaban") {
                  img = "asset/img/rh.png";
                  satuan = "%";
                } else if (jnssensor == "suhu udara") {
                  img = "asset/img/temp.png";
                  satuan = "\u00B0C";
                } else if (jnssensor == "ph") {
                  img = "asset/img/temp.png";
                  satuan = "";
                } else if (jnssensor == "ec") {
                  img = "asset/img/Tph.png";
                  satuan = "ppm";
                } else {
                  img = "asset/img/Ttanah.png";
                  satuan = "\u00B0C";
                }
                //notif
                print("notifikasi $i adalah $notif");
                if (notif == 0) {
                  notifikasitoogle = false;
                } else if (notif == 1) {
                  notifikasitoogle = true;
                }
                print(" height ${MediaQuery.of(context).size.height}");
                print(" width ${MediaQuery.of(context).size.width}");
                print(
                    " width ${MediaQuery.of(context).size.height / MediaQuery.of(context).size.width}");
                setState(() {
                  noty.add(notifikasitoogle);
                  iditems.add(notif);
                  itemsshadow.add(jnssensor);
                  items.add(
                    parameter(jnssensor, satuan, img, nilai1, min, max, mean,
                        outputDate, notifikasitoogle, idjns, i),
                  );
                  idalatsebelum = idala;
                  nilaisebelum = nilai1;
                  loading = false;
                });
              }
            }
          }
          itemsbefore = items.length;
        });
        return loadSensor();
      }
    }
  }

  TextEditingController alias = new TextEditingController();
  String msg = '';
  final formKey = GlobalKey<FormState>();
  GantiAlias ganti = GantiAlias();
  Future doGanti() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        var rs = await ganti.doGanti(uuid, index, uuid, token);
        var jsonRes = json.decode(rs.body);
        setState(() {
          msg = jsonRes['message'];
        });
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Menu()));
      } catch (e) {}
    }
  }

  void change(int index) {
    items.clear();
    status1 = index;
    idlokas = idlokasi[index];
    idhu = idhub[index];
    idala = idalat[index];
    loadSensor();
  }

  void data(int index) {
    if (index == null) {
      change(0);
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

  double bot;
  int status1 = 0;
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    if (panjangtempat == null ||
        panjangtempat == 0 ||
        panjangtempat.isNaN ||
        refresh == true) {
      return

          // AlertDialog(
          //     content: SingleChildScrollView(
          //         child:
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.width / 5,
                child: Image.asset("asset/img/loading.gif")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Silahkan Menunggu",
                  style: TextStyle(fontFamily: 'Mont')),
            ),
          ],
        ),
      );
      // ));
    } else {
      return DefaultTabController(
        initialIndex: 0,
        length: panjangtempat + 1,
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                  () {
                    setState(() {
                      Menu();
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                );
              },
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      (loading == true)
                          ? Container(
                              height: (MediaQuery.of(context).size.width *
                                      7.5 /
                                      9) +
                                  30,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.width / 5,
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: Image.asset(
                                          "asset/img/loading-blog.gif")),
                                ],
                              ))
                          : panjang == null
                              ? GestureDetector(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    7.5 /
                                                    9) +
                                                30,
                                            child: Center(
                                                child: Text(
                                                    "Tidak ada data sensor yang tersedia",
                                                    style: TextStyle(
                                                        fontFamily: "Mont")))),
                                      ],
                                    ),
                                  ),
                                  onVerticalDragUpdate:
                                      (DragUpdateDetails details) {
                                    if (details.globalPosition.direction < 1 &&
                                        (details.globalPosition.dy > 100 &&
                                            details.globalPosition.dy < 500)) {
                                      refreshData();
                                    }
                                  },
                                )
                              : GestureDetector(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CarouselSlider(
                                          items: items,
                                          options: CarouselOptions(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  7.5 /
                                                  9,
                                              aspectRatio: 7 / 9,
                                              viewportFraction: 0.8,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  Duration(seconds: 8),
                                              autoPlayAnimationDuration:
                                                  Duration(milliseconds: 800),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              enlargeCenterPage: true,
                                              scrollDirection: Axis.horizontal,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  bot = MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      9;
                                                  _current = index;
                                                });
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: items.map((url) {
                                              int index = items.indexOf(url);
                                              return Container(
                                                width: 8.0,
                                                height: 8.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 2.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: _current == index
                                                      ? Colors.green[900]
                                                      : Color.fromRGBO(
                                                          0, 0, 0, 0.4),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onVerticalDragUpdate:
                                      (DragUpdateDetails details) {
                                    if (details.globalPosition.direction < 1 &&
                                        (details.globalPosition.dy > 100 &&
                                            details.globalPosition.dy < 500)) {
                                      refreshData();
                                    }
                                  },
                                )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 1.5,
                            color: Colors.green[900],
                          ),
                        ],
                      ),
                      child: AppBar(
                        backgroundColor: Colors.white,
                        bottom: TabBar(
                          labelStyle: TextStyle(
                              fontFamily: "Mont",
                              fontSize:
                                  MediaQuery.of(context).size.height / 67),
                          labelColor: Color(0xFFF7931E),
                          unselectedLabelColor: Colors.green[900],
                          indicatorColor: Colors.green[900],
                          tabs: [
                            Tab(
                              text: "Semua",
                            ),
                            for (i = 0; i < panjangtempat; i++)
                              Tab(
                                text: "${tempatlist[i].substring(0, 12)}",
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                      children: [
                        MonitorIndoor(),
                        for (i = 0; i < panjangtempat; i++)
                          MonitorIndoorRoute(
                            ind: i,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget parameter(
      String jenissensor,
      String satuan,
      String img,
      String nilai,
      String min,
      String max,
      String mean,
      String time,
      bool toogle,
      int i,
      int jum) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Text(
                    jenissensor.inCaps,
                    style: TextStyle(
                        fontFamily: 'Mont',
                        fontSize: MediaQuery.of(context).size.height / 35),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Image.asset(
                      img,
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: <Widget>[
                            new Text(
                              "$nilai",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 20,
                                  fontFamily: "Mont"),
                            ),
                            new Text(
                              satuan,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 20,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Min",
                            style: TextStyle(
                              fontFamily: "Mont",
                              fontSize: MediaQuery.of(context).size.height / 60,
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.green[900],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text("$min",
                                      style: TextStyle(
                                          fontFamily: 'Mont',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              60,
                                          color: Colors.white))),
                              height: 40,
                              width: 50)
                        ],
                      ),
                      SizedBox(width: 5),
                      Column(
                        children: <Widget>[
                          Text("Mean",
                              style: TextStyle(
                                fontFamily: "Mont",
                                fontSize:
                                    MediaQuery.of(context).size.height / 60,
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.green[900],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text("$mean",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              60,
                                          fontFamily: 'Mont',
                                          color: Colors.white))),
                              height: 40,
                              width: 50)
                        ],
                      ),
                      SizedBox(width: 5),
                      Column(
                        children: <Widget>[
                          Text("Max",
                              style: TextStyle(
                                fontFamily: "Mont",
                                fontSize:
                                    MediaQuery.of(context).size.height / 60,
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.green[900],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text("$max",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              60,
                                          fontFamily: 'Mont',
                                          color: Colors.white))),
                              height: 40,
                              width: 50)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: new Text(
                      time,
                      style: TextStyle(fontFamily: "Mont"),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      return AlertDialog(
                        actions: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      100, 10, 100, 10),
                                  child: new Text(
                                    "Set Parameter",
                                    style: TextStyle(
                                        fontFamily: 'Mont', fontSize: 18),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(100, 5, 100, 5),
                                  child: new Text(
                                    "Batas Atas",
                                    style: TextStyle(
                                        fontFamily: 'Mont', fontSize: 15),
                                  )),
                              Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(100, 5, 100, 5),
                                  child: new Text(
                                    "Batas Bawah",
                                    style: TextStyle(
                                        fontFamily: 'Mont', fontSize: 15),
                                  )),
                              Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 20, 50, 15),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    doGanti();
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
                                                color: Colors.white,
                                                fontFamily: 'Mont'))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0))),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        print("tap pada atur notifikasi");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actions: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              50, 10, 50, 10),
                                          child: new Text(
                                            "Atur $jenissensor",
                                            style: TextStyle(
                                                fontFamily: 'Mont',
                                                fontSize: 18),
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              100, 5, 100, 5),
                                          child: new Text(
                                            "Batas Atas",
                                            style: TextStyle(
                                                fontFamily: 'Mont',
                                                fontSize: 15),
                                          )),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              100, 5, 100, 5),
                                          child: new Text(
                                            "Batas Bawah",
                                            style: TextStyle(
                                                fontFamily: 'Mont',
                                                fontSize: 15),
                                          )),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 20, 50, 15),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            doGanti();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.green[900],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                                child: Text("Terapkan",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Mont'))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(32.0))),
                              );
                            });
                      },
                      child: Container(
                          height: MediaQuery.of(context).size.height / 20,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      'Atur',
                                      style: TextStyle(
                                          fontFamily: 'Mont', fontSize: 11),
                                    ),
                                    new Text(
                                      'Notifikasi',
                                      style: TextStyle(
                                          fontFamily: 'Mont', fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Switch(
                                  value: toogle,
                                  onChanged: (value) {
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      Semua(
                                          idlokas: idlokas,
                                          idhu: idhu,
                                          idala: idala,
                                          items: []);
                                      loadSensor();
                                      jum = jum;
                                      idsens = i;
                                      if (value == false) {
                                        state = 0;
                                      } else {
                                        state = 1;
                                      }
                                      kucing = iditems[jum];
                                      gantinotif(state, idsens, token);
                                    });
                                  },
                                  activeTrackColor: Colors.green[900],
                                  activeColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }

  void tambahAlat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: new Text(
                      "Ganti Nama",
                      style: TextStyle(fontFamily: 'Mont', fontSize: 18),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                    child: new Text(
                      "Nama Baru",
                      style: TextStyle(fontFamily: 'Mont', fontSize: 15),
                    )),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                    child: new Text(
                      "Tempat Baru",
                      style: TextStyle(fontFamily: 'Mont', fontSize: 15),
                    )),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 15),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      doGanti();
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
                ),
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
