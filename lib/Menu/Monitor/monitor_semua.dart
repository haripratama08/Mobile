import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:io';
import 'package:ch_v2_1/API/parsinggrafik.dart';
import 'package:ch_v2_1/API/parsingmonitoring.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_indoor_route.dart';
import 'package:ch_v2_1/process/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/API/parsing.dart';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/tambahan/stringcap.dart';
import 'package:ch_v2_1/Menu/menu.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

int indexFilter = 0;
int indexPlot = 0;
List<_SensorData> datasensor = [];
List<int> ni = [];
num ribuan;
int idsensorgrafik;
String jenissensordetail;
int idsensordetail;
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
  String selectedDate;
  String dateCount;
  String range;
  String rangeCount;
  String start;
  String end;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        start = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)}';
        end =
            '${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        print(args.value.startDate);
        print(args.value.endDate);
        range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'

            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        // _dateCount = args.value.length.toString();
      } else {
        rangeCount = args.value.length.toString();
      }
    });
  }

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
    var jsonString = await http.get(
        Uri.parse(
            '$endPoint/monitoring/mobile/minmaxmean?lokasi=$idlokasidetail&hub=$idhubdetail&alat=$idalatdetail&sensor=$idsensordetail'),
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      jsonResponse["status"] == 'OK'
          ? setState(() {
              idsensorgrafik = idsensordetail;
              jenissensordetails = jenissensordetails;
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
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
                      "Sedang dalam proses",
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
                                          child: Text("Sedang dalam proses",
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
                                                      fontFamily: 'Kohi')),
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
                                                                          getHeight(
                                                                              19),
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
                                                                  width:
                                                                      getHeight(
                                                                          25),
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
                    height: MediaQuery.of(context).size.height * 0.055,
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
                          height: SizeConfigs.screenHeight / 50,
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
                                                    fontSize:
                                                        getHeight(15)))))),
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
                                                      fontSize:
                                                          getHeight(15)))))),
                              ])),
                    ),
                  ),
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
                              fontSize: getHeight(17),
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
                              fontSize: getHeight(17),
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
            height: getHeight(20),
            child: Center(
              child: Text(
                "Detail data $jenissensordetail",
                style: TextStyle(
                  fontFamily: 'Kohi',
                  fontWeight: FontWeight.bold,
                  fontSize: getHeight(20),
                ),
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
            Center(
              child: GestureDetector(
                  onTap: (() {
                    getGraphData(idlokasidetail, idhubdetail, idalatdetail,
                        idsensorgrafik, null, null);
                    print('masuk graph');
                  }),
                  child: Image.asset(
                    'asset/img/graph.png',
                    height: SizeConfigs.screenHeight * 0.05,
                  )),
            )
          ],
        );
      },
    );
  }

  Future getGraphData(int idlokasidetail, int idhubdetail, idalatdetail,
      int idsensorgrafik, String startdate, String enddate) async {
    print(startdate);
    var jsonString = startdate == null && enddate == null
        ? await http.get(
            Uri.parse(
                '$endPoint/monitoring/sensor?mode=grafik&lokasi=$idlokasidetail&hub=$idhubdetail&alat=$idalatdetail&sensor=$idsensorgrafik'),
            headers: {
                HttpHeaders.authorizationHeader: '$token'
              })
        : await http.get(
            Uri.parse(
                '$endPoint/monitoring/sensor?mode=grafik&lokasi=$idlokasidetail&hub=$idhubdetail&alat=$idalatdetail&sensor=$idsensorgrafik&startDate=$startdate&endDate=$enddate'),
            headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    Grafik grafik = Grafik.fromJson(jsonResponse);
    grafik.status == "OK"
        ? setState(() {
            for (int i = 99; i > 89; i--) {
              num nilai = grafik.data.sensor.dataRaw[i].nilai;
              String waktu = grafik.data.sensor.dataRaw[i].tanggalSensor;
              String namaalat = grafik.data.info.alat.alias;
              String namasensor = grafik.data.sensor.jenisSensor;
              datasensor.length <= 10
                  ? datasensor.add(_SensorData(waktu, nilai))
                  : datasensor.length > 10
                      ? datasensor.clear()
                      : print(datasensor);
              print(datasensor[0].nilai);
              datasensor.length == 10
                  ? getGraph(namaalat, namasensor, datasensor)
                  : print("");
            }
          })
        : print("data tidak ada");
  }

  getGraph(String namaalat, String namasensor, List<_SensorData> datasensor) {
    AlertDialog alert = AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.green[600],
          height: SizeConfigs.screenHeight * 0.04,
        ),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          print(indexFilter);
          print(indexPlot);
          return Container(
            height: indexFilter == 1
                ? SizeConfigs.screenHeight * 0.7
                : SizeConfigs.screenHeight * 0.45,
            width: SizeConfigs.screenWidth * 0.9,
            child: Column(
              children: [
                Text(
                  'Grafik sensor $namasensor pada alat $namaalat',
                  style: TextStyle(
                      fontFamily: 'Kohi',
                      fontSize: getHeight(18),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.01,
                ),
                Container(
                  height: SizeConfigs.screenHeight * 0.25,
                  width: SizeConfigs.screenWidth,
                  child: SfCartesianChart(
                      enableAxisAnimation: true,
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true,
                        enableDoubleTapZooming: true,
                      ),
                      crosshairBehavior: CrosshairBehavior(
                          enable: true,
                          lineType: CrosshairLineType.both,
                          activationMode: ActivationMode.longPress),
                      primaryXAxis: CategoryAxis(
                        labelRotation: 90,
                        minimum: 5,
                        maximum: 10,
                      ),
                      primaryYAxis: NumericAxis(
                          anchorRangeToVisiblePoints: false,
                          plotBands: <PlotBand>[
                            PlotBand(
                                verticalTextPadding: '5%',
                                horizontalTextPadding: '5%',
                                text: 'Average',
                                textAngle: 0,
                                start: 30,
                                end: 31,
                                textStyle: TextStyle(
                                    color: Colors.deepOrange, fontSize: 16),
                                borderColor: Colors.red,
                                borderWidth: 2)
                          ]),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<_SensorData, String>>[
                        LineSeries<_SensorData, String>(
                            dataSource: datasensor,
                            xValueMapper: (_SensorData data, _) =>
                                data.waktu.substring(0, 5),
                            yValueMapper: (_SensorData data, _) => data.nilai,
                            markerSettings: MarkerSettings(isVisible: true),
                            name: '$namasensor',
                            dataLabelSettings: DataLabelSettings(angle: 0))
                      ]),
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.01,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Text("Filter Data",
                                    style: TextStyle(
                                        fontFamily: 'Kohi',
                                        fontWeight: FontWeight.w900,
                                        fontSize: getHeight(15))))),
                        SizedBox(
                          width: SizeConfigs.screenWidth * 0.05,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ToggleSwitch(
                            totalSwitches: 2,
                            fontSize: getHeight(12),
                            minHeight: SizeConfigs.screenHeight * 0.03,
                            initialLabelIndex: indexFilter,
                            changeOnTap: true,
                            minWidth: SizeConfigs.screenWidth * 0.15,
                            cornerRadius: 5.0,
                            borderWidth: 0.5,
                            borderColor: [Colors.black],
                            activeBgColor: [Colors.green[900]],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.white,
                            inactiveFgColor: Colors.green[900],
                            labels: [
                              'OFF',
                              'ON',
                            ],
                            onToggle: (index) {
                              if (mounted)
                                setState(() {
                                  indexFilter = index;
                                  print(indexFilter);
                                });
                            },
                          ),
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth * 0.05,
                        ),
                        GestureDetector(
                          onTap: (() {
                             Navigator.pop(context);
                            String startdate = start;
                            String enddate = end;
                            print(start);
                            datasensor.clear();
                            print(end);
                            getGraphData(
                                idlokasidetail,
                                idhubdetail,
                                idalatdetail,
                                idsensorgrafik,
                                startdate,
                                enddate);
                          }),
                          child: Icon(Icons.refresh,
                              color:
                                  indexFilter == 1 ? Colors.black : Colors.grey,
                              size: getHeight(20)),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.01,
                ),
                indexFilter == 1
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: Offset(4, 8),
                                ),
                              ],
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0)),
                          height: SizeConfigs.screenHeight * 0.25,
                          width: SizeConfigs.screenWidth * 0.5,
                          child: SfDateRangePicker(
                            onSelectionChanged: _onSelectionChanged,
                            selectionMode: DateRangePickerSelectionMode.range,
                            initialSelectedRange: PickerDateRange(
                                DateTime.now(),
                                // .subtract(const Duration(days: 4)),
                                DateTime.now()
                                // .add(const Duration(days: 3))
                                ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Center(
                            child: Text("Plot Data  ",
                                style: TextStyle(
                                    fontFamily: 'Kohi',
                                    fontWeight: FontWeight.w900,
                                    fontSize: getHeight(15))))),
                    SizedBox(
                      width: SizeConfigs.screenWidth * 0.05,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ToggleSwitch(
                        totalSwitches: 2,
                        fontSize: getHeight(12),
                        minHeight: SizeConfigs.screenHeight * 0.03,
                        initialLabelIndex: indexPlot,
                        changeOnTap: true,
                        minWidth: SizeConfigs.screenWidth * 0.15,
                        cornerRadius: 5.0,
                        borderWidth: 0.5,
                        borderColor: [Colors.black],
                        activeBgColor: [Colors.green[900]],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.white,
                        inactiveFgColor: Colors.green[900],
                        labels: [
                          'OFF',
                          'ON',
                        ],
                        onToggle: (index) {
                          if (mounted)
                            setState(() {
                              indexPlot = index;
                            });
                        },
                      ),
                    ),
                    SizedBox(
                      width: SizeConfigs.screenWidth * 0.05,
                    ),
                    Container(
                      child: Icon(Icons.refresh,
                          color: Colors.grey, size: getHeight(20)),
                    )
                  ],
                ),
              ],
            ),
          );
        }));
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  changeName() {
    print(idAlatChange);
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Column(
        children: [
          Container(
            color: Colors.green[600],
            height: SizeConfigs.screenHeight * 0.04,
          ),
          SizedBox(height: 15),
          Text(
            "Ganti Nama Alat",
            style: TextStyle(
                fontSize: getHeight(14),
                fontFamily: 'Kohi',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      titlePadding: const EdgeInsets.all(0),
      content: Container(
        height: SizeConfigs.screenHeight * 0.08,
        width: SizeConfigs.screenWidth * 0.3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                  child: Container(
                height: SizeConfigs.screenHeight * 0.05,
                width: SizeConfigs.screenWidth * 0.47,
                child: Center(
                  child: TextFormField(
                    autofocus: false,
                    controller: cName,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: 'Kohi', fontSize: getHeight(12)),
                      hintText: '$namaalat',
                      hintStyle: TextStyle(
                          fontFamily: 'Kohi', fontSize: getHeight(12)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.green[900])),
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(bottom: SizeConfigs.screenHeight * 0.03),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: SizeConfigs.screenWidth * 0.2,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              height: SizeConfigs.screenHeight * 0.04,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: SizeConfigs.screenWidth * 0.07,
                  height: SizeConfigs.screenHeight * 0.01,
                  child: Center(
                    child: Text(
                      'Batalkan',
                      style: TextStyle(
                          fontFamily: 'Kohi',
                          fontSize: getHeight(12),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: SizeConfigs.screenWidth * 0.04),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(5)),
              width: SizeConfigs.screenWidth * 0.2,
              height: SizeConfigs.screenHeight * 0.04,
              child: GestureDetector(
                onTap: () {
                  gantiAliasAlat(idAlatChange, cName.text, token);
                },
                child: Container(
                  width: SizeConfigs.screenWidth * 0.03,
                  height: SizeConfigs.screenHeight * 0.01,
                  child: Center(
                    child: Text(
                      'Ubah',
                      style: TextStyle(
                          fontFamily: 'Kohi',
                          fontSize: getHeight(12),
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
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

class _SensorData {
  _SensorData(this.waktu, this.nilai);

  String waktu;
  num nilai;
}
