import 'dart:convert';
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
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../process/size_config.dart';

String imagedetail;
List<String> tanggaltable = [];
List<num> nilaiTable = [];
num batasmin;
num batasmax;
bool dropdownplot = false;
String pesan;
bool refreshfilter = false;
String startdatesave;
String enddatesave;
String startdate;
String enddate;
bool dropdownkey = false;
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
bool dropdown = false;
int idlokas;
int idhu;
int idala;

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
        start = '${DateFormat('yyyy/MM/dd').format(args.value.startDate)}';
        end =
            '${DateFormat('yyyy/MM/dd').format(args.value.endDate ?? args.value.startDate)}';
        range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
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
    indexpage = 1;
    loadDevice2();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future hitungminmaxmean(int idlokasidetail, int idhubdetail, int idalatdetail,
      int idsensordetail, String jenissensordetails, String img) async {
    imagedetail = null;
    var jsonString = await http.get(
        Uri.parse(
            '$endPoint/monitoring/mobile/minmaxmean?lokasi=$idlokasidetail&hub=$idhubdetail&alat=$idalatdetail&sensor=$idsensordetail'),
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      jsonResponse["status"] == 'OK'
          ? setState(() {
              imagedetail = img;
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
        loadDevice2();
        refresh = true;
        items.clear();
        iditems.clear();
        itemsshadow.clear();
        FocusScope.of(context).requestFocus(FocusNode());
      });
    }
    Future.delayed(Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          refresh = false;
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
    print('lokasi=$idlokas&hub=$idhu&alat=$idala');
    if (idlokas == null) {
      var jsonString = await http.get(
          Uri.parse(
              '$endPoint/monitoring/mobile/sensorRev?lokasi=${loc[0]}&hub=${huc[0]}&alat=${dev[0]}'),
          headers: {HttpHeaders.authorizationHeader: '$token'});
      var jsonResponse = json.decode(jsonString.body);
      print(jsonResponse);
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
      }
    } else {
      var jsonString = await http.get(
          Uri.parse(
              '$endPoint/monitoring/mobile/sensorRev?lokasi=$idlokas&hub=$idhu&alat=$idala'),
          headers: {HttpHeaders.authorizationHeader: '$token'});
      var jsonResponse = json.decode(jsonString.body);
      print(jsonResponse);
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
      }
    }
  }

  TextEditingController min = new TextEditingController();
  TextEditingController max = new TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    print(idala == idalabef);
    if (idlokas != idlokasbef || idala != idalabef || idhu != idhubef) {
      items.clear();
      loadSensor();
      setState(() {
        idalabef = idala;
        idhubef = idhu;
        idlokasbef = idlokas;
      });
    } else {}
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
                                          ),
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
                                      dataminmaxmean(i, jenissensor, img);
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

  dataminmaxmean(int idsensordetail, String jenissensordetail, String img) {
    idlokas == null ? idlokasidetail = loc[0] : idlokasidetail = idlokas;
    idhu == null ? idhubdetail = huc[0] : idhubdetail = idhu;
    idala == null ? idalatdetail = dev[0] : idalatdetail = idala;
    hitungminmaxmean(idlokasidetail, idhubdetail, idalatdetail, idsensordetail,
        jenissensordetail, img);
  }

  Future getTableData(int idlokasidetail, int idhubdetail, idalatdetail,
      int idsensorgrafik) async {
    datasensor.clear();
    var jsonString = await http.get(
        Uri.parse(
            '$endPoint/monitoring/sensor?mode=grafik&lokasi=$idlokasidetail&hub=$idhubdetail&alat=$idalatdetail&sensor=$idsensorgrafik'),
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    jsonResponse["status"] == "OK"
        ? setState(() {
            Grafik table = Grafik.fromJson(jsonResponse);
            for (int i = 0; i < table.data.sensor.dataRaw.length; i++) {
              num nilai = table.data.sensor.dataRaw[i].nilai;
              String waktu = table.data.sensor.dataRaw[i].tanggalSensor;
              String namaalat = table.data.info.alat.alias;
              String namasensor = table.data.sensor.jenisSensor;
              tanggaltable.length <= table.data.sensor.dataRaw.length
                  ? tanggaltable.add(waktu)
                  : tanggaltable.length > table.data.sensor.dataRaw.length
                      ? tanggaltable.clear()
                      : print(tanggaltable);

              nilaiTable.length <= table.data.sensor.dataRaw.length
                  ? nilaiTable.add(nilai)
                  : nilaiTable.length > table.data.sensor.dataRaw.length
                      ? nilaiTable.clear()
                      : print(nilaiTable);

              tanggaltable.length == table.data.sensor.dataRaw.length
                  ? loadtable(tanggaltable, nilaiTable, namaalat, namasensor)
                  : print("");
            }
          })
        : setState(() {
            refreshfilter = false;
            pesan = jsonResponse["message"];
            getGraph(" ", "", datasensor);
          });
  }

  loadtable(List<String> tanggalTable, List<num> nilaiTable, String namaalat,
      String namasensor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            color: Colors.green[600],
            height: SizeConfigs.screenHeight * 0.03,
          ),
          content: Container(
            height: SizeConfigs.screenHeight * 0.15,
            child: Center(
              child: Text(
                "tabel data $namasensor pada $namaalat",
                style: TextStyle(
                  fontFamily: 'Kohi',
                  fontWeight: FontWeight.bold,
                  fontSize: getHeight(20),
                ),
              ),
            ),
          ),
          actions: [
            Container(
              height: SizeConfigs.screenHeight * 0.75,
              width: SizeConfigs.screenWidth * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('No.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Kohi',
                                  fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text(
                            'Nilai',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Kohi',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tanggal update',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Kohi',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        for (i = 0; i < nilaiTable.length; i++)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(Text(
                                '${i + 1}',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Kohi',
                                    fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                '${nilaiTable[i]}',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Kohi'),
                              )),
                              DataCell(Text(
                                '${tanggalTable[i]}',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Kohi'),
                              )),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  loaddialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.all(0),
          content: Container(
            height: SizeConfigs.screenHeight * 0.45,
            width: SizeConfigs.screenWidth * 0.6,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/img/backgroundDetail.png'),
                          fit: BoxFit.cover)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: getHeight(60),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Detail",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Kohi',
                                    fontSize: getHeight(20),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "$jenissensordetail",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Kohi',
                                    fontWeight: FontWeight.bold,
                                    fontSize: getHeight(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfigs.screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 2, bottom: 15),
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'asset/img/elips.png',
                                    height: 115,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: imagedetail == '0'
                                  ? Positioned(
                                      width: MediaQuery.of(context).size.width,
                                      top: MediaQuery.of(context).size.width *
                                          0.30,
                                      child: Container(
                                        height: SizeConfigs.screenHeight * 0.12,
                                      ),
                                    )
                                  : Positioned(
                                      width: MediaQuery.of(context).size.width,
                                      top: MediaQuery.of(context).size.width *
                                          0.30,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Center(
                                          child: Container(
                                              height: SizeConfigs.screenHeight *
                                                  0.12,
                                              child: Image.network(
                                                  '$imagedetail')),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth * 0.05,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(children: [
                              Container(
                                // decoration: BoxDecoration(color: Colors.grey),
                                height: SizeConfigs.screenHeight * 0.075,
                                child: Image.asset('asset/img/max.png'),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height:
                                        SizeConfigs.screenHeight * 0.075 / 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      '$datamax'.length >= 4
                                          ? Container(
                                              width: SizeConfigs.screenWidth *
                                                  0.05)
                                          : Container(
                                              width: SizeConfigs.screenWidth *
                                                  0.075),
                                      Text(
                                        '$datamax',
                                        style: TextStyle(
                                          fontFamily: 'Kohi',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: getHeight(18),
                                        ),
                                      ),
                                      Container(),
                                    ],
                                  ),
                                  Container(),
                                ],
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Stack(children: [
                              Container(
                                // decoration: BoxDecoration(color: Colors.grey),
                                height: SizeConfigs.screenHeight * 0.075,
                                child: Image.asset('asset/img/mean.png'),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height:
                                        SizeConfigs.screenHeight * 0.075 / 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      '$datamean'.length >= 4
                                          ? Container(
                                              width: SizeConfigs.screenWidth *
                                                  0.05)
                                          : Container(
                                              width: SizeConfigs.screenWidth *
                                                  0.075),
                                      Text(
                                        '$datamean',
                                        style: TextStyle(
                                          fontFamily: 'Kohi',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: getHeight(18),
                                        ),
                                      ),
                                      Container(),
                                    ],
                                  ),
                                  Container(),
                                ],
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Stack(children: [
                              Container(
                                height: SizeConfigs.screenHeight * 0.075,
                                child: Image.asset('asset/img/min.png'),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height:
                                        SizeConfigs.screenHeight * 0.075 / 3,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      '$datamin'.length >= 4
                                          ? Container(
                                              width: SizeConfigs.screenWidth *
                                                  0.05)
                                          : Container(
                                              width: SizeConfigs.screenWidth *
                                                  0.075),
                                      Text(
                                        '$datamin',
                                        style: TextStyle(
                                          fontFamily: 'Kohi',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: getHeight(18),
                                        ),
                                      ),
                                      Container(),
                                    ],
                                  ),
                                  Container(),
                                ],
                              ),
                            ]),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfigs.screenHeight * 0.01,
                    ),
                    // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    //   GestureDetector(
                    //       onTap: (() {
                    //         getGraphData(idlokasidetail, idhubdetail,
                    //             idalatdetail, idsensorgrafik, null, null);
                    //         print('masuk graph');
                    //       }),
                    //       child: Image.asset(
                    //         'asset/img/graph.png',
                    //         height: SizeConfigs.screenHeight * 0.05,
                    //       )),
                    //   SizedBox(width: SizeConfigs.screenWidth * 0.05),
                    //   GestureDetector(
                    //       onTap: (() {
                    //         getTableData(idlokasidetail, idhubdetail,
                    //             idalatdetail, idsensorgrafik);
                    //       }),
                    //       child: Image.asset(
                    //         'asset/img/table.png',
                    //         height: SizeConfigs.screenHeight * 0.03,
                    //       )),
                    // ])
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future getGraphData(int idlokasidetail, int idhubdetail, idalatdetail,
      int idsensorgrafik, String startdate, String enddate) async {
    datasensor.clear();
    var jsonString = startdate == null && enddate == null
        ? await http.get(
            Uri.parse(
                '$endPoint/monitoring/sensor?mode=grafik&lokasi=$idlokasidetail&hub=$idhubdetail&alat=$idalatdetail&sensor=$idsensorgrafik'),
            headers: {
                HttpHeaders.authorizationHeader: '$token'
              })
        : await http.get(
            Uri.parse(
                '$endPoint/monitoring/sensor?mode=grafikone&lokasi=$idlokasidetail&hub=$idhubdetail&alat=$idalatdetail&sensor=$idsensorgrafik&startDate=$startdate&endDate=$enddate'),
            headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    startdate == null ? print(startdate) : print(jsonResponse);
    jsonResponse["status"] == "OK"
        ? setState(() {
            Grafik grafik = Grafik.fromJson(jsonResponse);
            refreshfilter = false;
            startdatesave = startdate;
            enddatesave = enddate;
            for (int i = 0; i < 10; i++) {
              num nilai = grafik.data.sensor.dataRaw[i].nilai;
              String waktu = grafik.data.sensor.dataRaw[i].tanggalSensor;
              String namaalat = grafik.data.info.alat.alias;
              String namasensor = grafik.data.sensor.jenisSensor;
              datasensor.length <= 10
                  ? datasensor.add(_SensorData(waktu, nilai))
                  : datasensor.length > 10
                      ? datasensor.clear()
                      : print(datasensor);
              datasensor.length == 10
                  ? getGraph(namaalat, namasensor, datasensor)
                  : print("");
            }
          })
        : setState(() {
            refreshfilter = false;
            pesan = jsonResponse["message"];
            getGraph(" ", "", datasensor);
          });
  }

  getGraph(String namaalat, String namasensor, List<_SensorData> datasensor) {
    AlertDialog alert = AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.green[600],
          height: SizeConfigs.screenHeight * 0.03,
        ),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: dropdown == true
                ? SizeConfigs.screenHeight * 0.9
                : SizeConfigs.screenHeight * 0.55,
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
                  height: SizeConfigs.screenHeight * 0.005,
                ),
                pesan == null
                    ? refreshfilter == true
                        ? Container(
                            height: SizeConfigs.screenHeight * 0.25,
                            width: SizeConfigs.screenWidth,
                            child: Container(
                              child: Image.asset(
                                'asset/img/loading.gif',
                                width: getHeight(5),
                              ),
                              height: SizeConfigs.screenHeight * 0.05,
                              width: SizeConfigs.screenWidth * 0.5,
                            ),
                          )
                        : Container(
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
                                  labelRotation: 45,
                                ),
                                primaryYAxis: batasmin == null
                                    ? NumericAxis()
                                    : NumericAxis(
                                        anchorRangeToVisiblePoints: false,
                                        plotBands: <PlotBand>[
                                            PlotBand(
                                                color: Colors.white,
                                                isVisible: true,
                                                verticalTextPadding: '5%',
                                                horizontalTextPadding: '5%',
                                                text: '',
                                                textStyle: TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'Kohi',
                                                    fontSize: getHeight(10)),
                                                textAngle: 0,
                                                start: batasmin,
                                                end: batasmax,
                                                borderColor: Colors.red,
                                                borderWidth: 1),
                                          ]),
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <ChartSeries<_SensorData, String>>[
                                  LineSeries<_SensorData, String>(
                                      dataSource: datasensor,
                                      xValueMapper: (_SensorData data, _) =>
                                          data.waktu,
                                      yValueMapper: (_SensorData data, _) =>
                                          data.nilai,
                                      markerSettings:
                                          MarkerSettings(isVisible: true),
                                      name: '$namasensor',
                                      dataLabelSettings:
                                          DataLabelSettings(angle: 0))
                                ]),
                          )
                    : Container(
                        child: Center(
                          child: Text(
                            "$pesan",
                            style: TextStyle(
                                fontFamily: 'Kohi', color: Colors.red),
                          ),
                        ),
                        height: SizeConfigs.screenHeight * 0.25,
                        width: SizeConfigs.screenWidth,
                      ),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.005,
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
                          width: SizeConfigs.screenWidth * 0.03,
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth * 0.03,
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth * 0.03,
                        ),
                        GestureDetector(
                          onTap: (() {
                            setState(() {
                              dropdown == false
                                  ? dropdown = true
                                  : dropdown = false;
                            });
                            print(dropdown);
                          }),
                          child: Icon(
                            dropdown == false
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: Colors.black,
                            size: getHeight(20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.005,
                ),
                dropdown == true
                    ? Row(
                        children: [
                          Center(
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
                                  border: Border.all(
                                      color: Colors.black, width: 0.5),
                                  borderRadius: BorderRadius.circular(5.0)),
                              height: SizeConfigs.screenHeight * 0.28,
                              width: SizeConfigs.screenWidth * 0.5,
                              child: SfDateRangePicker(
                                onSelectionChanged: _onSelectionChanged,
                                maxDate: DateTime.now(),
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                                initialSelectedRange: PickerDateRange(
                                    DateTime.now(), DateTime.now()),
                              ),
                            ),
                          ),
                          SizedBox(width: SizeConfigs.screenWidth * 0.03),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                pesan = null;
                                refreshfilter = true;
                                dropdown = false;
                                dropdownplot = false;
                                startdate = start;
                                enddate = end;
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
                              });
                            }),
                            child: Icon(Icons.refresh,
                                color: Colors.black, size: getHeight(20)),
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.005,
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
                                child: Text("Plot Data  ",
                                    style: TextStyle(
                                        fontFamily: 'Kohi',
                                        fontWeight: FontWeight.w900,
                                        fontSize: getHeight(15))))),
                        SizedBox(
                          width: SizeConfigs.screenWidth * 0.03,
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth * 0.03,
                        ),
                        SizedBox(
                          width: SizeConfigs.screenWidth * 0.03,
                        ),
                        GestureDetector(
                          onTap: (() {
                            setState(() {
                              dropdownplot == false
                                  ? dropdownplot = true
                                  : dropdownplot = false;
                            });
                          }),
                          child: Icon(
                            dropdownplot == false
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: Colors.black,
                            size: getHeight(20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.005,
                ),
                // Plot Data
                dropdownplot == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                  child: Text("Aktifkan ",
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
                                    indexPlot == 0
                                        ? batasmin = null
                                        : batasmin = batasmin;
                                    indexPlot == 0
                                        ? batasmax = null
                                        : batasmax = batasmax;
                                  });
                              },
                            ),
                          ),
                          SizedBox(
                            height: SizeConfigs.screenHeight * 0.05,
                          ),
                        ],
                      )
                    : SizedBox(),
                indexPlot == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(
                              child: TextFormField(
                                autofocus: false,
                                controller: min,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Kohi',
                                      fontSize: getHeight(12)),
                                  hintText: 'min',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Kohi',
                                      fontSize: getHeight(12)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      borderSide:
                                          BorderSide(color: Colors.green[900])),
                                ),
                              ),
                            ),
                            height: SizeConfigs.screenHeight * 0.03,
                            width: SizeConfigs.screenWidth * 0.17,
                          ),
                          SizedBox(width: SizeConfigs.screenWidth * 0.01),
                          Container(
                            child: Center(
                              child: TextFormField(
                                autofocus: false,
                                controller: max,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Kohi',
                                      fontSize: getHeight(12)),
                                  hintText: 'max',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Kohi',
                                      fontSize: getHeight(12)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                      borderSide:
                                          BorderSide(color: Colors.green[900])),
                                ),
                              ),
                            ),
                            height: SizeConfigs.screenHeight * 0.03,
                            width: SizeConfigs.screenWidth * 0.17,
                          ),
                          SizedBox(width: SizeConfigs.screenWidth * 0.01),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                batasmin = num.tryParse(min.text) ?? 0;
                                batasmax = num.tryParse(max.text) ?? 0;
                              });
                            }),
                            child: Icon(Icons.refresh,
                                color: Colors.black, size: getHeight(20)),
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(
                  height: SizeConfigs.screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: SizeConfigs.screenWidth * 0.35,
                    ),
                    GestureDetector(
                      onTap: (() {
                        Navigator.pop(context);
                      }),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Center(
                          child: Text("Kembali",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Kohi',
                                  fontSize: getHeight(15))),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(5)),
                        height: SizeConfigs.screenHeight * 0.04,
                        width: SizeConfigs.screenWidth * 0.2,
                      ),
                    ),
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
