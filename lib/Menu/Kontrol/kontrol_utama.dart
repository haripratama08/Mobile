import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_semua.dart';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_auto.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_manual.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:ch_v2_1/API/parsing.dart';

String selectedkondisi;
String namaalatkontrol;
List<String> liststate = [];
String pilihsensor;
int idsensor;
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

class KontrolUtama extends StatefulWidget {
  @override
  _KontrolUtamaState createState() => _KontrolUtamaState();
}

class _KontrolUtamaState extends State<KontrolUtama>
    with SingleTickerProviderStateMixin {
  Repository repo = Repository();
  RepositorySensor rep = RepositorySensor();
  bool loading = false;
  int value = 0;
  String status;
  List<int> listidlokasi = [];
  List<int> listidhub = [];
  List<int> listidalat = [];
  List<int> listidkontrol = [];
  List<dynamic> idl = [];
  List<dynamic> states = [];
  int idlokasikontrol;
  List<String> listname = [];
  List<String> listkontrol = [];
  TabController _tabController;
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
    var url = Uri.parse('$endPoint/kontrol?uuid=$uuid');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      setState(() {
        if ((jsonResponse['status']) == 'OK') {
          panjanglokasi = (((jsonResponse['data'])['lokasi']).length);
          for (int i = 0; i < panjanglokasi; i++) {
            String hub = (((jsonResponse['data'])['lokasi'])[i]['nama']);
            idlokasikontrol = (((jsonResponse['data'])['lokasi'])[i]['id']);
            listname.length == panjanglokasi ? print("") : listname.add(hub);
            print(listname);
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
                      ? print("list state $liststate")
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

//                       {
//   "mode":"auto",
//   "threshold":"1-1000",
//   "status":"OFF:bawah",
//   "manual":"OFF",
//   "id_sensor":"1-1000"
// }

                  topic = "200/10/crophero/control/testing";
                }
              }
            }
          }
        } else {}
      });
    }
    return loadKontrol();
  }

  Future loadMonitor() async {
    var url = Uri.parse('$endPoint/data?uuid=$uuid');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    Data2 data2 = Data2.fromJson(jsonResponse);
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
              data5 = data2.data.lokasi[i].hub[j].alat[k].alias;
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
              if (namaalat.length == number) {
              } else {
                namaalat.add(data5);
                Map<String, dynamic> data = {
                  'idlokasi': data1,
                  'idhub': data3,
                  'idalat': data4,
                  'nama': data5
                };
                trial.add(data);
              }
            }
          }
        }
        return new Row(
          children: list,
        );
      });
    }
    return loadMonitor();
  }

  Future loadSensor(int idlokasienter, int idhubenter, int idalatenter) async {
    var url = Uri.parse(
        '$endPoint/mobile/sensor?lokasi=$idlokasienter&hub=$idhubenter&alat=$idalatenter');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      setState(() {
        panjang = ((jsonResponse["data"])["data"].length);
        for (var i = 0; i < panjang; i++) {
          if (listsensors.length == panjang) {
          } else if (listsensors.length > panjang && listed.length > panjang) {
            listsensors.clear();
            listed.clear();
          } else {
            idjns = (((jsonResponse["data"])["data"])[i])["id"];
            jnssensor = (((jsonResponse["data"])["data"])[i])["jenis"];
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

  Future loadState() async {
    var url2 = Uri.parse('$endPoint/kontrol/state?id=$iDkontrol');
    var jsonString = await http
        .get(url2, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      setState(() {
        status = jsonResponse['state'];
      });
    }
    return loadState();
  }

//counter times
  int _counter = 10;
  Timer _timer;
  void _startTimer() {
    _counter = 10;
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
  void initState() {
    _startTimer();
    loadKontrol();
    loadMonitor();
    loadState();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    loadKontrol();
    loadMonitor();
    loadState();
    super.dispose();
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
    print("-------");
    print(statesend);
    print("-------");
    return DefaultTabController(
        initialIndex: 0,
        length: panjanglokasi + 1,
        child: Scaffold(
            body: (panjanglokasi == null && _counter != 0 ||
                    panjanglokasi == 0 && _counter != 0 ||
                    listkontrol == null && _counter != 0)
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
                              child: Text("Silahkan Menunggu",
                                  style: TextStyle(fontFamily: 'Mont')),
                            ),
                          ],
                        )),
                  )
                : (panjanglokasi == null && _counter == 0 ||
                        panjanglokasi == 0 && _counter == 0 ||
                        listkontrol == null && _counter == 0)
                    ? Center(
                        child: Container(
                            height:
                                (MediaQuery.of(context).size.width * 7.5 / 9) +
                                    30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height:
                                        MediaQuery.of(context).size.width / 5,
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child:
                                        Image.asset("asset/img/loading.gif")),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Silahkan Menunggu",
                                      style: TextStyle(fontFamily: 'Mont')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text("Data tidak tersedia ",
                                      style: TextStyle(fontFamily: 'Mont')),
                                )
                              ],
                            )),
                      )
                    : Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.52,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                value == 0
                                    ? Column(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Text("$namaalatkontrol",
                                                    style: TextStyle(
                                                        fontFamily: "Mont",
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20)),
                                              ),
                                              Image.network(
                                                'https://crophero.s3-ap-southeast-1.amazonaws.com/img/pump.png',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    200,
                                              ),
                                              new Text(
                                                "Status",
                                                style: TextStyle(
                                                  fontFamily: 'Mont',
                                                  color: Colors.red,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          23,
                                                ),
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
                                                        fontFamily: 'Mont',
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            23,
                                                      ),
                                                    ),
                                              value == 1
                                                  ? Column(
                                                      children: [
                                                        new Text(
                                                          "Pengaturan",
                                                          style: TextStyle(
                                                            fontFamily: 'Mont',
                                                            color: Colors.red,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                23,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  100.0,
                                                                  5.0,
                                                                  100.0,
                                                                  5.0),
                                                          child: Container(
                                                            height: 40,
                                                            width: 170,
                                                            decoration:
                                                                myBoxDecoration(),
                                                            child:
                                                                DropdownButton(
                                                                    value:
                                                                        selectedalat,
                                                                    isExpanded:
                                                                        true,
                                                                    icon:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              15.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        color: Color(
                                                                            0xff186962),
                                                                      ),
                                                                    ),
                                                                    iconSize:
                                                                        14,
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
                                                                      _startTimer();
                                                                      listed
                                                                          .clear();
                                                                      if (mounted)
                                                                        setState(
                                                                            () {
                                                                          pilihsensor =
                                                                              null;
                                                                          listsensors
                                                                              .clear();
                                                                          selectedalat =
                                                                              newValue;
                                                                        });
                                                                    },
                                                                    hint:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'Pilih Alat',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                      ),
                                                                    ),
                                                                    items: trial
                                                                        .map(
                                                                            (alat) {
                                                                      return DropdownMenuItem(
                                                                        value: alat[
                                                                            'nama'],
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 10.0),
                                                                          child:
                                                                              Text(
                                                                            "${alat['nama']}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: "Verdana",
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }).toList()),
                                                          ),
                                                        ),
                                                        (selectedalat == null &&
                                                                _counter != 0)
                                                            ? Text('')
                                                            : (selectedalat !=
                                                                        null &&
                                                                    _counter !=
                                                                        0)
                                                                ? Text('')
                                                                : (selectedalat ==
                                                                            null &&
                                                                        _counter ==
                                                                            0)
                                                                    ? Text('')
                                                                    : Padding(
                                                                        padding: const EdgeInsets.fromLTRB(
                                                                            100.0,
                                                                            5.0,
                                                                            100.0,
                                                                            5.0),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              170,
                                                                          decoration:
                                                                              myBoxDecoration(),
                                                                          child: DropdownButton(
                                                                              value: pilihsensor,
                                                                              isExpanded: true,
                                                                              icon: Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0),
                                                                                child: Icon(
                                                                                  Icons.arrow_drop_down,
                                                                                  color: Color(0xff186962),
                                                                                ),
                                                                              ),
                                                                              iconSize: 14,
                                                                              underline: SizedBox(),
                                                                              onChanged: (String val) {
                                                                                _selectedsensor(val);
                                                                                if (mounted)
                                                                                  setState(() {
                                                                                    pilihsensor = val;
                                                                                    print("pilihansensor $val");
                                                                                  });
                                                                              },
                                                                              hint: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  'Pilih Sensor',
                                                                                  style: TextStyle(fontSize: 14),
                                                                                ),
                                                                              ),
                                                                              items: listed.map((detail) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: detail,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(left: 10.0),
                                                                                    child: Text(
                                                                                      "$detail",
                                                                                      style: TextStyle(
                                                                                        fontSize: 14,
                                                                                        fontFamily: "Verdana",
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }).toList()),
                                                                        ),
                                                                      )
                                                      ],
                                                    )
                                                  : SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              200),
                                              new Text(
                                                "Mode",
                                                style: TextStyle(
                                                  fontFamily: 'Mont',
                                                  color: Colors.red,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          23,
                                                ),
                                              ),
                                              Center(
                                                child: ToggleSwitch(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          27,
                                                  minHeight: 30,
                                                  initialLabelIndex: value,
                                                  changeOnTap: true,
                                                  minWidth: 85.0,
                                                  cornerRadius: 25.0,
                                                  activeBgColor:
                                                      Colors.green[900],
                                                  activeFgColor: Colors.white,
                                                  inactiveBgColor: Colors.grey,
                                                  inactiveFgColor: Colors.white,
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
                                      )
                                    : Column(
                                        children: [
                                          value == 1
                                              ? Column(
                                                  children: [
                                                    new Text(
                                                      "Pengaturan",
                                                      style: TextStyle(
                                                        fontFamily: 'Mont',
                                                        color: Colors.red,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            23,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(100.0,
                                                          10.0, 100.0, 5.0),
                                                      child: Container(
                                                        height: 32,
                                                        width: 170,
                                                        decoration:
                                                            myBoxDecoration(),
                                                        child: DropdownButton(
                                                            value: selectedalat,
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
                                                              _startTimer();
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
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Pilih Alat',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                            ),
                                                            items: trial
                                                                .map((alat) {
                                                              return DropdownMenuItem(
                                                                value: alat[
                                                                    'nama'],
                                                                child: Padding(
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
                                                                          "Verdana",
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList()),
                                                      ),
                                                    ),
                                                    (selectedalat == null &&
                                                            _counter != 0)
                                                        ? Text('')
                                                        : (selectedalat !=
                                                                    null &&
                                                                _counter != 0)
                                                            ? Text('')
                                                            : (selectedalat ==
                                                                        null &&
                                                                    _counter ==
                                                                        0)
                                                                ? Text('')
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                            .fromLTRB(
                                                                        100.0,
                                                                        10.0,
                                                                        100.0,
                                                                        5.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          32,
                                                                      width:
                                                                          170,
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
                                                                              color: Color(0xff186962),
                                                                            ),
                                                                          ),
                                                                          iconSize: 13,
                                                                          underline: SizedBox(),
                                                                          onChanged: (String val) {
                                                                            _selectedsensor(val);
                                                                            if (mounted)
                                                                              setState(() {
                                                                                pilihsensor = val;
                                                                                print("pilihansensor $val");
                                                                              });
                                                                          },
                                                                          hint: Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'Pilih Sensor',
                                                                              style: TextStyle(fontSize: 13),
                                                                            ),
                                                                          ),
                                                                          items: listed.map((detail) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: detail,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 10.0),
                                                                                child: Text(
                                                                                  "$detail",
                                                                                  style: TextStyle(
                                                                                    fontSize: 13,
                                                                                    fontFamily: "Verdana",
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }).toList()),
                                                                    ),
                                                                  )
                                                  ],
                                                )
                                              : SizedBox(height: 5),
                                          new Text(
                                            "Kondisi",
                                            style: TextStyle(
                                              fontFamily: 'Mont',
                                              color: Colors.red,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  23,
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
                                                    print(newValue);
                                                    if (mounted)
                                                      setState(() {
                                                        pilihsensor = null;
                                                        listsensors.clear();
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
                                                            fontFamily:
                                                                "Verdana",
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList()),
                                            ),
                                          ),
                                          new Text(
                                            "Mode",
                                            style: TextStyle(
                                              fontFamily: 'Mont',
                                              color: Colors.red,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  23,
                                            ),
                                          ),
                                          Center(
                                            child: ToggleSwitch(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  27,
                                              minHeight: 30,
                                              initialLabelIndex: value,
                                              changeOnTap: true,
                                              minWidth: 85.0,
                                              cornerRadius: 25.0,
                                              activeBgColor: Colors.green[900],
                                              activeFgColor: Colors.white,
                                              inactiveBgColor: Colors.grey,
                                              inactiveFgColor: Colors.white,
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
                          SizedBox(height: 5),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                            child: Container(
                              height: 20,
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
                                          MediaQuery.of(context).size.height /
                                              67),
                                  labelColor: Color(0xFFF7931E),
                                  unselectedLabelColor: Colors.green[900],
                                  indicatorColor: Colors.green[900],
                                  tabs: [
                                    Tab(
                                      text: "Semua",
                                    ),
                                    for (i = 0; i < panjanglokasi; i++)
                                      (listname[i].length == 0 ||
                                              listname[i].length == null)
                                          ? Container(
                                              child: Image.asset(
                                                  "asset/img/loading-blog.gif"))
                                          : (listname[i].length > 12)
                                              ? Tab(
                                                  text:
                                                      "${listname[i].substring(0, 12)}")
                                              : Tab(text: "${listname[i]}")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 100),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Semua(),
                                Semua(),
                              ],
                            ),
                          ),
                        ],
                      )));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.green[900],
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)));
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
}
