import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/API/parsingmonitoring.dart';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_detail.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_semua.dart';
import 'package:ch_v2_1/process/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_auto.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_manual.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:ch_v2_1/API/parsing.dart';

bool refresh = false;
List<String> listname = [];
String selectedkondisi;
String namaalatkontrol;
List<String> liststate = [];
String pilihsensor;
String namaalata;
int idsensor;
String devname;
int itemsbefore;
int idjns;
String jnssensor;
String namas;
int idlokasi;
int idhub;
int idalat;
int idhubselected;
int idlocselected;
int idalatselected;
String selectedalat;
String selectedsensor;
List<String> listsensor = [];
List<String> listed = [];
int panjang;
List<String> name = [];
List<Map<String, dynamic>> trial = [];
List<Map<String, dynamic>> listsensors = [];
List<dynamic> namaalat = [];
List<dynamic> loc = [];
List<dynamic> huc = [];
List<int> idloka = [];
List<dynamic> dev = [];
String sens;
String nilai1;
int lokas;
int hu;
List<dynamic> list2 = [];
int alat = 0;
int number;
int data1;
int data3;
int data4;
String data5;
String data6;
String nama;
String success;
String nama1;
String nama2;
List<String> tempatlist = [];
List<String> kondisi = ['>', '<'];
int panjangtempat;
int i;
int j;
int k;
int l;
int iDlokasi;
int iDhub;
int iDalat;
int iDkontrol;
int status1 = 0;
var warna;
var statesend;
String topic;
String msg;
String tempat;
String status;

class KontrolUtama extends StatefulWidget {
  @override
  _KontrolUtamaState createState() => _KontrolUtamaState();
}

class _KontrolUtamaState extends State<KontrolUtama>
    with SingleTickerProviderStateMixin {
  TextEditingController cName = new TextEditingController();
  Repository repo = Repository();
  RepositorySensor rep = RepositorySensor();
  bool loading = false;
  int value = 0;

  List<int> listidlokasi = [];
  List<int> listidhub = [];
  List<String> listhub = [];
  List<int> listidalat = [];
  List<int> listidkontrol = [];
  List<dynamic> idl = [];
  List<dynamic> states = [];
  int idlokasikontrol;

  List<String> listkontrol = [];
  int index = 1;
  bool isSwitchedkelembapan = false;
  int panjanglokasi = 0;
  int panjangkontrol = 0;

  void change(int index) {
    status1 = index;
    iDkontrol = listidkontrol[index];
    namaalatkontrol = listkontrol[index];
  }

  void data(int index) {
    if (index == null) {
      change(0);
    } else {
      change(index);
    }
  }

  Future loadKontrol() async {
    var url = Uri.parse('$endPoint/alat/kontrol');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      setState(() {
        print(jsonResponse);
        if ((jsonResponse['status']) == 'OK') {
          panjanglokasi = (((jsonResponse['data'])['lokasi']).length);
          for (int i = 0; i < panjanglokasi; i++) {
            String hub = (((jsonResponse['data'])['lokasi'])[i]['nama']);
            idlokasikontrol = (((jsonResponse['data'])['lokasi'])[i]['id']);
            listname.length == panjanglokasi ? print("") : listname.add(hub);
            listidlokasi.length == panjanglokasi
                ? print("")
                : listidlokasi.add(idlokasikontrol);
            var panjanghub =
                (((jsonResponse['data'])['lokasi'])[i]['hub'].length);
            for (int j = 0; j < panjanghub; j++) {
              var panjangalat = ((((jsonResponse['data'])['lokasi'])[i]['hub']
                      [j]['alat']
                  .length));
              int idhubkontrol =
                  ((((jsonResponse['data'])['lokasi'])[i]['hub'][j]['id']));
              listidhub.length == panjanghub
                  ? print("")
                  : listidhub.add(idhubkontrol);
              //----------------------------------------------------------------------//
              for (int k = 0; k < panjangalat; k++) {
                panjangkontrol = ((((jsonResponse['data'])['lokasi'])[i]['hub']
                        [j]['alat'][k]['kontrol']
                    .length));
                int idalatkontrol = ((((jsonResponse['data'])['lokasi'])[i]
                    ['hub'][j]['alat'][k]['id']));
                listidalat.length == panjangalat
                    ? print("")
                    : listidalat.add(idalatkontrol);
                //---------------------------------------------------------------------//
                for (int l = 0; l < panjangkontrol; l++) {
                  String kontrol = ((((jsonResponse['data'])['lokasi'])[i]
                      ['hub'][j]['alat'][k]['kontrol'][l])['alias']);
                  String statusaaaa = ((((jsonResponse['data'])['lokasi'])[i]
                      ['hub'][j]['alat'][k]['kontrol'][l])['state']);
                  int idkontrol = ((((jsonResponse['data'])['lokasi'])[i]['hub']
                      [j]['alat'][k]['kontrol'][l])['id']);
                  listkontrol.contains(kontrol)
                      ? print("$listkontrol")
                      : listkontrol.add(kontrol);
                  listidkontrol.contains(idkontrol)
                      ? print("")
                      : listidkontrol.add(idkontrol);
                  liststate.length == panjangalat
                      ? print("")
                      : liststate.add(statusaaaa);
                  //---------------------------------------------------------------------//
                  iDlokasi == null
                      ? iDlokasi = listidlokasi[0]
                      : iDlokasi = iDlokasi;
                  namaalatkontrol == null
                      ? namaalatkontrol = listkontrol[0]
                      : namaalatkontrol = namaalatkontrol;
                  iDhub == null ? iDhub = listidhub[0] : iDhub = iDhub;
                  iDalat == null ? iDalat = listidalat[0] : iDalat = iDalat;
                  iDkontrol == null
                      ? iDkontrol = listidkontrol[0]
                      : iDkontrol = iDkontrol;
                }
              }
            }
          }
        } else {}
      });
    }
  }

  Future loadState() async {
    var url2 = Uri.parse('$endPoint/alat/kontrol/state?id=$iDkontrol');
    var jsonString = await http
        .get(url2, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      try {
        setState(() {
          status = jsonResponse['state'];
        });
      } on Exception catch (error) {
        print(error);
      }
    }
    Future.delayed(const Duration(seconds: 10), () {
      return loadState();
    });
  }

  Future loadMonitor() async {
    var url = Uri.parse('$endPoint/user/data');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
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
              tempatlist.add(tempat);
            }
            for (int j = 0; j < data2.data.lokasi[i].hub.length; j++) {
              for (int k = 0;
                  k < data2.data.lokasi[i].hub[j].alat.length;
                  k++) {
                alat = data2.data.lokasi[i].hub[j].alat.length;
                data1 = data2.data.lokasi[i].id;
                data3 = data2.data.lokasi[i].hub[j].id;
                data4 = data2.data.lokasi[i].hub[j].alat[k].id;
                data5 = data2.data.lokasi[i].hub[j].alat[k].alias;
                data6 = data2.data.lokasi[i].hub[j].alat[k].nama;
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
                if (namaalat.length == number) {
                } else {
                  namaalat.add(data5);
                  Map<String, dynamic> data = {
                    'idlokasi': data1,
                    'idhub': data3,
                    'idalat': data4,
                    'nama': data5,
                    'devname': data6
                  };
                  trial.add(data);
                }
              }
            }
          }
          return new Row(
            children: list,
          );
        } on Exception catch (_) {
          print(_);
        }
      });
    }
  }

  Future loadSensor(int idlokasienter, int idhubenter, int idalatenter) async {
    var url = Uri.parse(
        '$endPoint/monitoring/mobile/sensorRev?lokasi=$idlokasienter&hub=$idhubenter&alat=$idalatenter');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    MonitoringParse dataparsing = MonitoringParse.fromJson(jsonResponse);
    if (this.mounted) {
      setState(() {
        panjang = dataparsing.data.data.length;
        for (var i = 0; i < panjang; i++) {
          if (listsensors.length == panjang) {
          } else if (listsensors.length > panjang && listed.length > panjang) {
            listsensors.clear();
            listed.clear();
          } else {
            idjns = dataparsing.data.data[i].id;
            jnssensor = dataparsing.data.data[i].jenisSensor.jenis;
            if (listsensors.contains(jnssensor) &&
                itemsbefore == listsensors.length) {
              listsensors.clear();
              listsensor.clear();
            } else {
              Map<String, dynamic> senss = {
                'idsensor': idjns,
                'nama': jnssensor,
              };
              listsensors.add(senss);
              listed.add(jnssensor);
              listsensor.add(jnssensor);
            }
          }
        }
        itemsbefore = listsensors.length;
      });
    }
  }

  @override
  void initState() {
    namaalatkontrol = null;
    status1 = 0;
    loadKontrol();
    loadMonitor();
    loadState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void state(String status) {
      if (status == "OFF") {
        statesend = "ON";
      } else {
        statesend = "OFF";
      }
    }

    state(status);
    return DefaultTabController(
        initialIndex: 0,
        length: listname.length + 1,
        child: Scaffold(
            body: (panjanglokasi == null ||
                    panjanglokasi == 0 ||
                    listkontrol == null ||
                    refresh == true)
                ? Center(
                    child: Container(
                        height:
                            (MediaQuery.of(context).size.width * 7.5 / 9) + 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.width / 5,
                                width: MediaQuery.of(context).size.width / 5,
                                child: Image.asset("asset/img/loading.gif")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Sedang dalam proses",
                                  style: TextStyle(
                                      fontFamily: 'Kohi',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[900])),
                            ),
                          ],
                        )),
                  )
                : (panjanglokasi == null ||
                        panjanglokasi == 0 ||
                        listkontrol == null)
                    ? Center(
                        child: Container(
                            height:
                                (MediaQuery.of(context).size.width * 7.5 / 9) +
                                    30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text("Data tidak tersedia ",
                                      style: TextStyle(fontFamily: 'Kohi')),
                                )
                              ],
                            )),
                      )
                    : Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.525,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                value == 0
                                    ? Column(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("$namaalatkontrol",
                                                        style: TextStyle(
                                                            fontFamily: "Kohi",
                                                            fontSize:
                                                                getHeight(19))),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        print("ganti nama");
                                                        try {
                                                          setState(() {});
                                                        } on Exception catch (e) {
                                                          print(e);
                                                        }
                                                        changeName();
                                                      },
                                                      child: Image.asset(
                                                        'asset/img/changeSign.png',
                                                        width: getHeight(25),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'asset/img/kontrol.png',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            children: [
                                              new Text(
                                                "Status",
                                                style: TextStyle(
                                                  fontFamily: 'Kohi',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green[300],
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          23,
                                                ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    200,
                                              ),
                                              status == null
                                                  ? Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              23,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              23,
                                                      child: Image.asset(
                                                          "asset/img/loading-blog.gif"))
                                                  : new Text(
                                                      "$status",
                                                      style: TextStyle(
                                                        fontFamily: 'Kohi',
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            23,
                                                      ),
                                                    ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      200),
                                              new Text(
                                                "Mode",
                                                style: TextStyle(
                                                  fontFamily: 'Kohi',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green[300],
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          23,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Center(
                                                child: ToggleSwitch(
                                                  totalSwitches: 2,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30,
                                                  minHeight: 30,
                                                  initialLabelIndex: value,
                                                  changeOnTap: true,
                                                  minWidth: 85.0,
                                                  cornerRadius: 10.0,
                                                  borderWidth: 1.0,
                                                  borderColor: [Colors.black],
                                                  activeBgColor: [
                                                    Colors.green[900]
                                                  ],
                                                  activeFgColor: Colors.white,
                                                  inactiveBgColor: Colors.white,
                                                  inactiveFgColor:
                                                      Colors.green[900],
                                                  labels: [
                                                    'Manual',
                                                    'Auto',
                                                  ],
                                                  onToggle: (index) {
                                                    if (mounted)
                                                      setState(() {
                                                        value = index;
                                                      });
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              value == 0
                                                  ? KontrolManual()
                                                  : KontrolAuto(),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          value == 1
                                              ? SingleChildScrollView(
                                                  physics: ScrollPhysics(),
                                                  child: Column(
                                                    children: [
                                                      new Text(
                                                        "Pengaturan",
                                                        style: TextStyle(
                                                          fontFamily: 'Kohi',
                                                          color:
                                                              Colors.green[900],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              30,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                100.0,
                                                                5,
                                                                100.0,
                                                                5.0),
                                                        child: Container(
                                                          height: 32,
                                                          width: 170,
                                                          decoration:
                                                              myBoxDecoration(),
                                                          child: DropdownButton(
                                                              value:
                                                                  selectedalat,
                                                              isExpanded: true,
                                                              icon: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  color: Color(
                                                                      0xff186962),
                                                                ),
                                                              ),
                                                              iconSize: 13,
                                                              underline:
                                                                  SizedBox(),
                                                              onChanged:
                                                                  (newValue) {
                                                                _selectedmonitor(
                                                                    newValue);
                                                                loadSensor(
                                                                    idlokasi,
                                                                    idhub,
                                                                    idalat);
                                                                listed.clear();
                                                                if (mounted)
                                                                  setState(() {
                                                                    pilihsensor =
                                                                        null;
                                                                    listsensors
                                                                        .clear();
                                                                    selectedalat =
                                                                        newValue;
                                                                  });
                                                              },
                                                              hint: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'Pilih Alat',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Kohi',
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                              ),
                                                              items: trial
                                                                  .map((alat) {
                                                                return DropdownMenuItem(
                                                                  value: alat[
                                                                      'nama'],
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10.0),
                                                                    child: Text(
                                                                      "${alat['nama']}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            "Kohi",
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList()),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      (selectedalat == null &&
                                                              listed.isEmpty)
                                                          ? Text('')
                                                          : (selectedalat ==
                                                                      null &&
                                                                  listed
                                                                      .isNotEmpty)
                                                              ? Text('')
                                                              : Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          100.0,
                                                                          10.0,
                                                                          100.0,
                                                                          5.0),
                                                                  child:
                                                                      Container(
                                                                    height: 32,
                                                                    width: 170,
                                                                    decoration:
                                                                        myBoxDecoration(),
                                                                    child: DropdownButton(
                                                                        value: pilihsensor,
                                                                        isExpanded: true,
                                                                        icon: Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 15.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.arrow_drop_down,
                                                                            color:
                                                                                Color(0xff186962),
                                                                          ),
                                                                        ),
                                                                        iconSize: 13,
                                                                        underline: SizedBox(),
                                                                        onChanged: (String val) {
                                                                          _selectedsensor(
                                                                              val);
                                                                          if (mounted)
                                                                            setState(() {
                                                                              pilihsensor = val;
                                                                            });
                                                                        },
                                                                        hint: Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Pilih Sensor',
                                                                            style:
                                                                                TextStyle(fontSize: 13, fontFamily: 'Kohi'),
                                                                          ),
                                                                        ),
                                                                        items: listed.map((detail) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                detail,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(left: 10.0),
                                                                              child: Text(
                                                                                "$detail",
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                  fontFamily: "Kohi",
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }).toList()),
                                                                  ),
                                                                )
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(height: 5),
                                          new Text(
                                            "Kondisi",
                                            style: TextStyle(
                                              fontFamily: 'Kohi',
                                              color: Colors.green[900],
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                100.0, 10.0, 100.0, 5.0),
                                            child: Container(
                                              height: 32,
                                              width: 170,
                                              decoration: myBoxDecoration(),
                                              child: DropdownButton(
                                                  value: selectedkondisi,
                                                  isExpanded: true,
                                                  icon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Color(0xff186962),
                                                    ),
                                                  ),
                                                  iconSize: 13,
                                                  underline: SizedBox(),
                                                  onChanged: (newValue) {
                                                    if (mounted)
                                                      setState(() {
                                                        selectedkondisi =
                                                            newValue;
                                                      });
                                                  },
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Pilih Kondisi',
                                                      style: TextStyle(
                                                          fontFamily: 'Kohi',
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  items: kondisi
                                                      .map((kondisiterkini) {
                                                    return DropdownMenuItem(
                                                      value: kondisiterkini,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: Text(
                                                          "$kondisiterkini",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily: "Kohi",
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList()),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          new Text(
                                            "Mode",
                                            style: TextStyle(
                                              fontFamily: 'Kohi',
                                              color: Colors.green[900],
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: ToggleSwitch(
                                              totalSwitches: 2,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30,
                                              minHeight: 30,
                                              initialLabelIndex: value,
                                              changeOnTap: true,
                                              minWidth: 85.0,
                                              cornerRadius: 10.0,
                                              borderWidth: 1.0,
                                              borderColor: [Colors.black],
                                              activeBgColor: [
                                                Colors.green[900]
                                              ],
                                              activeFgColor: Colors.white,
                                              inactiveBgColor: Colors.white,
                                              inactiveFgColor:
                                                  Colors.green[900],
                                              labels: [
                                                'Manual',
                                                'Auto',
                                              ],
                                              onToggle: (index) {
                                                if (mounted)
                                                  setState(() {
                                                    value = index;
                                                  });
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          value == 0
                                              ? KontrolManual()
                                              : KontrolAuto(),
                                        ],
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.435,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                child: Center(
                                                    child: Text("Semua",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: 'kohi',
                                                            fontSize: getHeight(
                                                                15)))))),
                                        for (i = 0; i < listname.length; i++)
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
                                                      child: Text(
                                                          "${listname[i]}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Kohi',
                                                              fontSize: getHeight(15)))))),
                                      ])),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Semua(),
                                for (i = 0; i < listname.length; i++)
                                  Detail(ind: i),
                              ],
                            ),
                          ),
                        ],
                      )));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)));
  }

  void _selectedmonitor(String value) {
    if (mounted)
      setState(() {
        var prin = repo.getidlokasibynama(value);
        idlokasi = prin[0];
        var prin2 = repo.getidhubbynama(value);
        idhub = prin2[0];
        var prin3 = repo.getidalatbynama(value);
        idalat = prin3[0];
        var prin4 = repo.getnamaalat(value);
        devname = prin4[0];
        loadSensor(prin[0], prin2[0], prin3[0]);
      });
  }

  void _selectedsensor(String value) {
    if (mounted)
      setState(() {
        var prin = rep.getidsensorbynama(value);
        idsensor = prin[0];
      });
  }

  changeName() {
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
                      hintText: '$namaalatkontrol',
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
            SizedBox(width: SizeConfigs.screenWidth * 0.07),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(5)),
              width: SizeConfigs.screenWidth * 0.2,
              height: SizeConfigs.screenHeight * 0.04,
              child: GestureDetector(
                onTap: () {
                  gantiAliasAlat(iDkontrol, cName.text, token);
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
    var jsonString = await http.put(
        Uri.parse('$endPoint/alat/kontrol/edit?id_kontrol=$idAlatChange'),
        body: {"alias": "$namaganti"},
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    print(jsonResponse);

    jsonResponse["status"] == "OK"
        ? setState(() {
            listkontrol.clear();
            refresh = true;
            namaalatkontrol = null;
            Future.delayed(Duration(seconds: 2), () {
              if (this.mounted) {
                setState(() {
                  panjangkontrol = null;
                  Navigator.pop(context);
                  refresh = false;
                });
              }
            });
          })
        : setState(() {});
  }
}
