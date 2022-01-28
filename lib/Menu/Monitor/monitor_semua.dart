import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/API/parsingmonitoring.dart';
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

num ribuan;
String jenissensordetail;
int idalatdetail;
int idlokasidetail;
int idhubdetail;
bool load = true;
num datamin;
num datamean;
num datamax;
int idAlatChange;
String namaalat;
String dateonly;
String timeonly;
String imgtry;
int idalabef;
int idhubef;
int idlokasbef;
String nilailast;
String event;
List<String> nil = [];
String status;
String alias;
bool loading = false;
int idsensor;
int jum = 1;
bool notifikasitoogle;
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
int status2 = 0;
String convertedDateTime;
String tanggal1;
String jenissensor2;
String tanggal2;
String jnssensor;
double nilai2;
List<dynamic> list2 = [];
int alat = 0;
List<dynamic> idlokasi = [];
List<dynamic> idhub = [];
List<dynamic> idalat = [];
List<bool> noty = [];
int number;
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
int device;
int state;
String outputDate;
List<String> tempatlist = [];
List<int> idlist = [];
String tempat;
int id;
int i;
int panjangtempat;
bool refresh = false;
bool front = true;
bool loadingdata = true;
bool zerodata = false;

class Semua extends StatefulWidget {
  @override
  _SemuaState createState() => _SemuaState();
}

class _SemuaState extends State<Semua> {
  @override
  void dispose() {
    loadDevice2();
    super.dispose();
  }

  @override
  void initState() {
    _startTimer();
    loadDevice2();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future hitungminmaxmean(int idlokasidetail, int idhubdetail, int idalatdetail,
      int idsensordetail, String jenissensordetails) async {
    print("masuk hitung");
    var jsonString = await http.get(
        Uri.parse(
            '$endPoint/monitoring/mobile/minmaxmean?lokasi=$idlokasidetail&hub=$idhubdetail&alat=$idalatdetail&sensor=$idsensordetail'),
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    print("done parse");
    if (this.mounted) {
      jsonResponse["status"] == 'OK'
          ? setState(() {
              load = false;
              try {
                jenissensordetail = jenissensordetails;
                datamin = (jsonResponse["data"])["min"];
                datamean = (jsonResponse["data"])["mean"];
                datamax = (jsonResponse["data"])["max"];
                loaddialog();
              } on Exception catch (_) {
                print('kosong');
              }
            })
          : setState(() {});
    }
  }

  Future loadDevice2() async {
    var jsonString = await http.get(Uri.parse('$endPoint/user/data'),
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    // print(jsonResponse);
    Data2 data2 = Data2.fromJson(jsonResponse);
    if (this.mounted) {
      setState(() {
        try {
          List<Widget> list = [];
          for (int i = 0; i < data2.data.lokasi.length; i++) {
            panjangtempat = data2.data.lokasi.length;
            if (tempatlist.length == panjangtempat) {
            } else {
              tempat = data2.data.lokasi[i].nama;
              id = data2.data.lokasi[i].id;
              tempatlist.add(tempat);
              idlist.add(id);
            }
            for (int j = 0; j < data2.data.lokasi[i].hub.length; j++) {
              for (int k = 0;
                  k < data2.data.lokasi[i].hub[j].alat.length;
                  k++) {
                alat = data2.data.lokasi[i].hub[j].alat.length;
                data1 = data2.data.lokasi[i].id;
                data3 = data2.data.lokasi[i].hub[j].id;
                data4 = data2.data.lokasi[i].hub[j].alat[k].id;
                data5 = data2.data.lokasi[i].hub[j].alat[k].nama;
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
        } on Exception catch (_) {
          print('kosong');
        }
      });
    }
    return loadSensor();
  }

  void refreshData() {
    if (this.mounted) {
      setState(() {
        refresh = true;
        items.clear();
        iditems.clear();
        itemsshadow.clear();
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }
    print("Refreshing");
    Future.delayed(Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          refresh = false;
          print("Refreshed");
        });
      }
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future loadSensor() async {
    if (idlokas == null) {
      var jsonString = await http.get(
          Uri.parse(
              '$endPoint/monitoring/mobile/sensorRev?lokasi=${loc[0]}&hub=${huc[0]}&alat=${dev[0]}'),
          headers: {HttpHeaders.authorizationHeader: '$token'});
      var jsonResponse = json.decode(jsonString.body);
      MonitoringParse dataparsing = MonitoringParse.fromJson(jsonResponse);
      if (this.mounted) {
        setState(() {
          try {
            panjang = dataparsing.data.data.length;
            namaalat = dataparsing.data.info.namaAlat;
            for (var i = 0; i < panjang; i++) {
              if (items.length == panjang) {
              } else if (items.length > panjang) {
                items.clear();
                iditems.clear();
                itemsshadow.clear();
              } else {
                nilai1 =
                    dataparsing.data.data[i].data[0].nilai.toStringAsFixed(1);
                idjns = dataparsing.data.data[i].id;
                tanggal1 = dataparsing.data.data[i].data[0].tanggalUpdate;
                notif = dataparsing.data.data[i].allowNotifikasi;
                jnssensor = dataparsing.data.data[i].jenisSensor.jenis;
                satuan = dataparsing.data.data[i].satuan;
                satuan == null ? satuan = "" : satuan = satuan;
                dateonly = dataparsing.data.data[i].data[0].dateOnly;
                timeonly = dataparsing.data.data[i].data[0].timeOnly;
                imgtry = dataparsing.data.data[i].jenisSensor.ikon;
                imgtry == '0'
                    ? img = '0'
                    : img =
                        'https://3tnguegmh6.execute-api.ap-southeast-1.amazonaws.com/dev/icon?icon_name=' +
                            '${dataparsing.data.data[i].jenisSensor.ikon}';
                if (notif == 0) {
                  notifikasitoogle = false;
                } else if (notif == 1) {
                  notifikasitoogle = true;
                }

                if (itemsshadow.contains(jnssensor) &&
                    itemsbefore == items.length) {
                  items.clear();
                  iditems.clear();
                  itemsshadow.clear();
                } else {
                  setState(() {
                    zerodata = false;
                    noty.add(notifikasitoogle);
                    iditems.add(notif);
                    itemsshadow.add(jnssensor);
                    items.add(
                      parameter(jnssensor, satuan, img, nilai1, timeonly,
                          dateonly, notifikasitoogle, idjns, i, namaalat),
                    );
                  });
                }
              }
            }
            itemsbefore = items.length;
          } on Exception catch (_) {
            print(_);
          }
        });
        Future.delayed(const Duration(minutes: 1), () {
          return loadSensor();
        });
      }
      // }
    } else {
      var jsonString = await http.get(
          Uri.parse(
              '$endPoint/monitoring/mobile/sensorRev?lokasi=$idlokas&hub=$idhu&alat=$idala'),
          headers: {HttpHeaders.authorizationHeader: '$token'});
      var jsonResponse = json.decode(jsonString.body);
      MonitoringParse dataparsing = MonitoringParse.fromJson(jsonResponse);
      if (this.mounted) {
        setState(() {
          try {
            panjang = dataparsing.data.data.length;
            namaalat = dataparsing.data.info.namaAlat;
            for (var i = 0; i < panjang; i++) {
              if (items.length == panjang) {
              } else if (items.length > panjang) {
                items.clear();
                iditems.clear();
                itemsshadow.clear();
              } else {
                dataparsing.data.data[i].data.isEmpty
                    ? dateonly = ''
                    : dateonly = dataparsing.data.data[i].data[0].dateOnly;

                dataparsing.data.data[i].data.isEmpty
                    ? timeonly = ''
                    : timeonly = dataparsing.data.data[i].data[0].timeOnly;
                dataparsing.data.data[i].data.isEmpty
                    ? nilai1 = ''
                    : nilai1 = dataparsing.data.data[i].data[0].nilai
                        .toStringAsFixed(1);
                idjns = dataparsing.data.data[i].id;

                notif = dataparsing.data.data[i].allowNotifikasi;
                jnssensor = dataparsing.data.data[i].jenisSensor.jenis;
                satuan = dataparsing.data.data[i].satuan;
                satuan == null ? satuan = "" : satuan = satuan;
                imgtry = dataparsing.data.data[i].jenisSensor.ikon;
                imgtry == '0'
                    ? img = '0'
                    : img =
                        'https://3tnguegmh6.execute-api.ap-southeast-1.amazonaws.com/dev/icon?icon_name=' +
                            '${dataparsing.data.data[i].jenisSensor.ikon}';
                if (notif == 0) {
                  notifikasitoogle = false;
                } else if (notif == 1) {
                  notifikasitoogle = true;
                }

                if (itemsshadow.contains(jnssensor) &&
                    itemsbefore == items.length) {
                  items.clear();
                  iditems.clear();
                  itemsshadow.clear();
                } else {
                  setState(() {
                    zerodata = false;
                    noty.add(notifikasitoogle);
                    iditems.add(notif);
                    itemsshadow.add(jnssensor);
                    items.add(
                      parameter(jnssensor, satuan, img, nilai1, timeonly,
                          dateonly, notifikasitoogle, idjns, i, namaalat),
                    );
                  });
                }
              }
            }
            itemsbefore = items.length;
          } on Exception catch (_) {
            print("kosong");
          }
        });
        Future.delayed(const Duration(minutes: 1), () {
          return loadSensor();
        });
      }
    }
  }

  TextEditingController cName = new TextEditingController();
  TextEditingController alias = new TextEditingController();
  TextEditingController maxvalue = new TextEditingController();
  TextEditingController minvalue = new TextEditingController();
  String msg = '';
  final formKey = GlobalKey<FormState>();

  double bot;
  int status1 = 0;
  int _current = 0;

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
        Navigator.pop(context);
      } catch (e) {}
    }
  }

  void flip() {
    setState(() {
      front = true;
    });
  }

  void changename(int index) {
    status2 = index;
    items.clear();
  }

  void dataname(int index) {
    if (index == null) {
      changename(0);
      items.clear();
    } else {
      changename(index);
      items.clear();
    }
  }

  void change(int index) {
    setState(() {
      status1 = index;
      idlokas = idlokasi[index];
      idhu = idhub[index];
      idala = idalat[index];
      loading = true;
    });
  }

  void data(int index) {
    if (index == null) {
      change(0);
      print("index null");
      idlokas = idlokasi[0];
      idhu = idhub[0];
      idala = idalat[0];
    } else {
      change(index);
      items.clear();
      print("index sama dengan $index");
      idlokas = idlokasi[index];
      idhu = idhub[index];
      idala = idalat[index];
    }
  }

  void statusname(int ins) {
    if (status2 == ins) {
      warna = Colors.green[100];
    } else {
      warna = Color(0x098765);
    }
  }

  int _counter;
  Timer _timer;
  void _startTimer() {
    _counter = 20;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted)
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _timer.cancel();
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (idlokas != idlokasbef && idala != idalabef && idhu != idhubef) {
      print("ganti ke idlokasi : $idlokas, idalat : $idala dan idhub $idhu");
      items.clear();
      loadSensor();
    } else {}
    setState(() {
      idalabef = idala;
      idhubef = idhu;
      idlokasbef = idlokas;
    });
    statusname(index);
    if (panjangtempat == null ||
        panjangtempat == 0 ||
        panjangtempat.isNaN ||
        refresh == true) {
      return Center(
        child: Container(
            height: (MediaQuery.of(context).size.width * 7.5 / 9) + 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.width / 5,
                    width: MediaQuery.of(context).size.width / 5,
                    child: Image.asset("asset/img/loading.gif")),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Silahkan Menunggu",
                      style: TextStyle(
                          fontFamily: 'Kohi',
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900]),
                    )),
              ],
            )),
      );
    } else {
      return DefaultTabController(
        initialIndex: 0,
        length: panjangtempat + 1,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: formKey,
          body: Container(
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                  () {
                    if (mounted)
                      setState(() {
                        Menu();
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                  },
                );
              },
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        items.length != panjang && zerodata == false
                            ? Center(
                                child: Container(
                                    height:
                                        (MediaQuery.of(context).size.height *
                                            0.525),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Image.asset(
                                                "asset/img/loading.gif")),
                                        Padding(
                                          padding: const EdgeInsets.all(25),
                                          child: Text("Silahkan Menunggu",
                                              style: TextStyle(
                                                  fontFamily: 'Kohi',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green[900])),
                                        ),
                                      ],
                                    )),
                              )
                            : items.length != panjang &&
                                    zerodata == false &&
                                    nama != namaalat
                                ? Center(
                                    child: Container(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.525),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Image.asset(
                                                    "asset/img/loading.gif")),
                                            Padding(
                                              padding: const EdgeInsets.all(25),
                                              child: Text("Silahkan Menunggu",
                                                  style: TextStyle(
                                                      fontFamily: 'Kohi',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.green[900])),
                                            ),
                                          ],
                                        )),
                                  )
                                : items.length == 0 && zerodata == true
                                    ? Center(
                                        child: Container(
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.525),
                                            child: Center(
                                              child: Text("Tidak Ada data",
                                                  style: TextStyle(
                                                      fontFamily: 'Mont')),
                                            )),
                                      )
                                    : panjang == null
                                        ? GestureDetector(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.52,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  )
                                                ],
                                              ),
                                            ),
                                            onVerticalDragUpdate:
                                                (DragUpdateDetails details) {
                                              if (details.globalPosition
                                                          .direction <
                                                      1 &&
                                                  (details.globalPosition.dy >
                                                          100 &&
                                                      details.globalPosition
                                                              .dy <
                                                          500)) {
                                                refreshData();
                                              }
                                            },
                                          )
                                        : GestureDetector(
                                            child: Column(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.525,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text('$namaalat',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Kohi',
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                              .green[
                                                                          900])),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  try {
                                                                    setState(
                                                                        () {
                                                                      idala ==
                                                                              null
                                                                          ? idAlatChange = dev[
                                                                              0]
                                                                          : idAlatChange =
                                                                              idala;
                                                                    });
                                                                  } on Exception catch (e) {
                                                                    print(e);
                                                                  }
                                                                  changeName();
                                                                },
                                                                child:
                                                                    Image.asset(
                                                                  'asset/img/changeSign.png',
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .devicePixelRatio *
                                                                      10,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          (MediaQuery.of(context)
                                                                          .size
                                                                          .height /
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width) >=
                                                                  2
                                                              ? CarouselSlider(
                                                                  items: items,
                                                                  options: CarouselOptions(
                                                                      height: MediaQuery.of(context).size.width * 7.7 / 9,
                                                                      aspectRatio: 7.7 / 9,
                                                                      viewportFraction: 0.8,
                                                                      initialPage: 0,
                                                                      enableInfiniteScroll: true,
                                                                      reverse: false,
                                                                      autoPlay: true,
                                                                      autoPlayInterval: Duration(seconds: 8),
                                                                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                                                                      autoPlayCurve: Curves.fastOutSlowIn,
                                                                      enlargeCenterPage: true,
                                                                      scrollDirection: Axis.horizontal,
                                                                      onPageChanged: (index, reason) {
                                                                        if (mounted)
                                                                          setState(
                                                                              () {
                                                                            bot =
                                                                                MediaQuery.of(context).size.width / 9;
                                                                            _current =
                                                                                index;
                                                                          });
                                                                      }),
                                                                )
                                                              : ((MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) >=
                                                                          1.67 &&
                                                                      (MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) <=
                                                                          1.85)
                                                                  ? CarouselSlider(
                                                                      items:
                                                                          items,
                                                                      options: CarouselOptions(
                                                                          height: MediaQuery.of(context).size.width * 6.5 / 9,
                                                                          aspectRatio: 6.5 / 9,
                                                                          viewportFraction: 0.8,
                                                                          initialPage: 0,
                                                                          enableInfiniteScroll: true,
                                                                          reverse: false,
                                                                          autoPlay: true,
                                                                          autoPlayInterval: Duration(seconds: 8),
                                                                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                                                                          autoPlayCurve: Curves.fastOutSlowIn,
                                                                          enlargeCenterPage: true,
                                                                          scrollDirection: Axis.horizontal,
                                                                          onPageChanged: (index, reason) {
                                                                            if (mounted)
                                                                              setState(() {
                                                                                bot = MediaQuery.of(context).size.width / 9;
                                                                                _current = index;
                                                                              });
                                                                          }),
                                                                    )
                                                                  : ((MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) >=
                                                                              1.85 &&
                                                                          (MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) <=
                                                                              2)
                                                                      ? CarouselSlider(
                                                                          items:
                                                                              items,
                                                                          options: CarouselOptions(
                                                                              height: MediaQuery.of(context).size.width * 7 / 9,
                                                                              aspectRatio: 7 / 9,
                                                                              viewportFraction: 0.8,
                                                                              initialPage: 0,
                                                                              enableInfiniteScroll: true,
                                                                              reverse: false,
                                                                              autoPlay: true,
                                                                              autoPlayInterval: Duration(seconds: 8),
                                                                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                                                                              autoPlayCurve: Curves.fastOutSlowIn,
                                                                              enlargeCenterPage: true,
                                                                              scrollDirection: Axis.horizontal,
                                                                              onPageChanged: (index, reason) {
                                                                                if (mounted)
                                                                                  setState(() {
                                                                                    bot = MediaQuery.of(context).size.width / 9;
                                                                                    _current = index;
                                                                                  });
                                                                              }),
                                                                        )
                                                                      : ((MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) >= 1.6 &&
                                                                              (MediaQuery.of(context).size.height / MediaQuery.of(context).size.width) <= 1.67)
                                                                          ? CarouselSlider(
                                                                              items: items,
                                                                              options: CarouselOptions(
                                                                                  height: MediaQuery.of(context).size.width * 6 / 9,
                                                                                  aspectRatio: 6 / 9,
                                                                                  viewportFraction: 0.8,
                                                                                  initialPage: 0,
                                                                                  enableInfiniteScroll: true,
                                                                                  reverse: false,
                                                                                  autoPlay: true,
                                                                                  autoPlayInterval: Duration(seconds: 8),
                                                                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                                                                  autoPlayCurve: Curves.fastOutSlowIn,
                                                                                  enlargeCenterPage: true,
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  onPageChanged: (index, reason) {
                                                                                    if (mounted)
                                                                                      setState(() {
                                                                                        bot = MediaQuery.of(context).size.width / 9;
                                                                                        _current = index;
                                                                                      });
                                                                                  }),
                                                                            )
                                                                          : CarouselSlider(
                                                                              items: items,
                                                                              options: CarouselOptions(
                                                                                  height: MediaQuery.of(context).size.width * 5.5 / 9,
                                                                                  aspectRatio: 5.5 / 9,
                                                                                  viewportFraction: 0.8,
                                                                                  initialPage: 0,
                                                                                  enableInfiniteScroll: true,
                                                                                  reverse: false,
                                                                                  autoPlay: true,
                                                                                  autoPlayInterval: Duration(seconds: 8),
                                                                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                                                                  autoPlayCurve: Curves.fastOutSlowIn,
                                                                                  enlargeCenterPage: true,
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  onPageChanged: (index, reason) {
                                                                                    if (mounted)
                                                                                      setState(() {
                                                                                        bot = MediaQuery.of(context).size.width / 9;
                                                                                        _current = index;
                                                                                      });
                                                                                  }),
                                                                            ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: items
                                                                .map((url) {
                                                              int index = items
                                                                  .indexOf(url);
                                                              return Container(
                                                                width: 8.0,
                                                                height: 8.0,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10.0,
                                                                        horizontal:
                                                                            2.0),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: _current ==
                                                                          index
                                                                      ? Colors.green[
                                                                          900]
                                                                      : Color.fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.4),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            onVerticalDragUpdate:
                                                (DragUpdateDetails details) {
                                              if (details.globalPosition
                                                          .direction <
                                                      1 &&
                                                  (details.globalPosition.dy >
                                                          100 &&
                                                      details.globalPosition
                                                              .dy <
                                                          500)) {
                                                refreshData();
                                              }
                                            },
                                          )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.060,
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
                      child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.lightGreen[50],
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 1.5,
                                color: Colors.green[900],
                              ),
                            ],
                          ),
                          child: TabBar(
                              physics: ScrollPhysics(),
                              labelColor: Colors.green[900],
                              isScrollable: true,
                              unselectedLabelColor: Colors.white,
                              indicatorColor: Colors.green[900],
                              tabs: [
                                Tab(
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.435,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: Center(
                                            child: Text("Semua",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'kohi',
                                                    fontSize: 15))))),
                                for (i = 0; i < panjangtempat; i++)
                                  Tab(
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.435,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: Center(
                                              child: Text("${tempatlist[i]}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontFamily: 'Kohi',
                                                      fontSize: 15))))),
                              ])),
                    ),
                  ),

                  // SizedBox(height: MediaQuery.of(context).size.height / 100),
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
      String timeonly,
      String dateonly,
      bool toogle,
      int i,
      int jum,
      String namaalat) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text('$namaalat',style:TextStyle(fontFamily: 'Kohi',fontSize: 20)),
                // SizedBox(height: 15,),
                img == "0"
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 140,
                        ),
                      )
                    : Center(
                        child: Image.network(
                          img,
                          height: MediaQuery.of(context).size.height / 9,
                        ),
                      ),
                SizedBox(height: 15),
                Text(
                  jenissensor.inCaps,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                    fontFamily: 'Kohi',
                    fontSize: MediaQuery.of(context).size.height / 35,
                  ),
                ),
                nilai.isEmpty
                    ? Center(
                        child: Text('Tidak ada data',
                            style: TextStyle(
                                fontFamily: 'Kohi',
                                color: Colors.red[900],
                                fontSize: 20)),
                      )
                    : Row(
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
                                          MediaQuery.of(context).size.height /
                                              15,
                                      fontFamily: "Kohi",
                                      fontWeight: FontWeight.bold),
                                ),
                                new Text(
                                  satuan,
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 20,
                                    fontFamily: 'Kohi',
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      print(i);
                                      dataminmaxmean(i, jenissensor);
                                    },
                                    child: Image.asset(
                                      'asset/img/help.png',
                                      width: 25,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                SizedBox(height: 5),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Column(
                //       children: <Widget>[
                //         Text(
                //           "Min",
                //           style: TextStyle(
                //             fontFamily: "Mont",
                //             fontSize: MediaQuery.of(context).size.height / 60,
                //           ),
                //         ),
                //         Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.green[900],
                //                 borderRadius: BorderRadius.circular(5)),
                //             child: Center(
                //                 child: Text("$min",
                //                     style: TextStyle(
                //                         fontFamily: 'Mont',
                //                         fontSize:
                //                             MediaQuery.of(context).size.height /
                //                                 60,
                //                         color: Colors.white))),
                //             height: 40,
                //             width: 50)
                //       ],
                //     ),
                //     SizedBox(width: 5),
                //     Column(
                //       children: <Widget>[
                //         Text("Mean",
                //             style: TextStyle(
                //               fontFamily: "Mont",
                //               fontSize: MediaQuery.of(context).size.height / 60,
                //             )),
                //         Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.green[900],
                //                 borderRadius: BorderRadius.circular(5)),
                //             child: Center(
                //                 child: Text("$mean",
                //                     style: TextStyle(
                //                         fontSize:
                //                             MediaQuery.of(context).size.height /
                //                                 60,
                //                         fontFamily: 'Mont',
                //                         color: Colors.white))),
                //             height: 40,
                //             width: 50)
                //       ],
                //     ),
                //     SizedBox(width: 5),
                //     Column(
                //       children: <Widget>[
                //         Text("Max",
                //             style: TextStyle(
                //               fontFamily: "Mont",
                //               fontSize: MediaQuery.of(context).size.height / 60,
                //             )),
                //         Container(
                //             decoration: BoxDecoration(
                //                 color: Colors.green[900],
                //                 borderRadius: BorderRadius.circular(5)),
                //             child: Center(
                //                 child: Text("$max",
                //                     style: TextStyle(
                //                         fontSize:
                //                             MediaQuery.of(context).size.height /
                //                                 60,
                //                         fontFamily: 'Mont',
                //                         color: Colors.white))),
                //             height: 40,
                //             width: 50)
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(height: 5),
                nilai.isEmpty
                    ? Center(
                        child: Text('',
                            style: TextStyle(
                                fontFamily: 'Kohi',
                                color: Colors.red[900],
                                fontSize: 25)),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateonly,
                            style: TextStyle(
                              fontFamily: 'Kohi',
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            height: 20,
                            width: 2,
                            decoration: BoxDecoration(color: Colors.green[300]),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "$timeonly WIB",
                            style: TextStyle(
                              fontFamily: 'Kohi',
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  dataminmaxmean(int idsensordetail, String jenissensordetail) {
    print(loc);
    print(huc);
    print(dev);

    idlokas == null ? idlokasidetail = loc[0] : idlokasidetail = idlokas;
    idhu == null ? idhubdetail = huc[0] : idhubdetail = idhu;
    idala == null ? idalatdetail = dev[0] : idalatdetail = idala;

    hitungminmaxmean(idlokasidetail, idhubdetail, idalatdetail, idsensordetail,
        jenissensordetail);
  }

  loaddialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).devicePixelRatio * 10,
            child: Center(
              child: Text(
                "Detail data $jenissensordetail",
                style:
                    TextStyle(fontFamily: 'Kohi', fontWeight: FontWeight.bold),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Min",
                        style: TextStyle(
                          fontFamily: "Kohi",
                          fontSize: MediaQuery.of(context).size.height / 60,
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text("$datamin",
                                  style: TextStyle(
                                      fontFamily: 'Kohi',
                                      fontSize:
                                          MediaQuery.of(context).size.height /
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
                            fontFamily: "Kohi",
                            fontSize: MediaQuery.of(context).size.height / 60,
                          )),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text("$datamean",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              60,
                                      fontFamily: 'Kohi',
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
                            fontFamily: "Kohi",
                            fontSize: MediaQuery.of(context).size.height / 60,
                          )),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text("$datamax",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              60,
                                      fontFamily: 'Kohi',
                                      color: Colors.white))),
                          height: 40,
                          width: 50)
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  changeName() {
    print(idAlatChange);
    AlertDialog alert = AlertDialog(
      title: Text(
        "Ganti nama alat",
        style: TextStyle(fontFamily: 'Kohi', fontWeight: FontWeight.bold),
      ),
      content: Container(
        height: MediaQuery.of(context).devicePixelRatio * 30,
        width: MediaQuery.of(context).devicePixelRatio * 50,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: Container(
                  height: MediaQuery.of(context).devicePixelRatio * 18,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.green[300], // set border color
                        width: 1.5), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // set rounded corner radius
                  ),
                  child: Center(
                    child: TextField(
                      controller: cName,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(fontFamily: 'Kohi', fontSize: 12),
                        hintText: '$namaalat',
                        hintStyle: TextStyle(fontFamily: 'Kohi', fontSize: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(5)),
            width: MediaQuery.of(context).devicePixelRatio * 35,
            height: MediaQuery.of(context).devicePixelRatio * 15,
            child: GestureDetector(
              onTap: () {
                gantiAliasAlat(idAlatChange, cName.text, token);
                print('id_alat = $idAlatChange dan namaganti ${cName.text}');
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Ubah',
                    style: TextStyle(
                        fontFamily: 'Kohi',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future gantiAliasAlat(
      int idAlatChange, String namaganti, String token) async {
    refresh = true;
    var jsonString = await http.put(
        Uri.parse('$endPoint/alat/edit?id_alat=$idAlatChange'),
        body: {"alias": "$namaganti"},
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    print(jsonResponse);

    jsonResponse["status"] == "OK"
        ? setState(() {
            listnama.clear();
            items.clear();
            itemsshadow.clear();
            iditems.clear();
            Future.delayed(Duration(seconds: 2), () {
              if (this.mounted) {
                setState(() {
                  refresh = false;
                  Navigator.pop(context);
                });
              }
            });
          })
        : setState(() {});
  }
}
