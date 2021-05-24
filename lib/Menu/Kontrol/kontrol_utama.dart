import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_semua.dart';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_auto.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_manual.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:ch_v2_1/API/parsing.dart';

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
int panjang;
List<String> name = [];
List<Map<String, dynamic>> trial = [];
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
// List<dynamic> idlokasi = [];
// List<dynamic> idhub = [];
// List<dynamic> idalat = [];
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
  final int iDkontrol;
  const KontrolUtama({Key key, this.iDkontrol});

  @override
  _KontrolUtamaState createState() => _KontrolUtamaState();
}

class _KontrolUtamaState extends State<KontrolUtama>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  int value = 0;
  String status;
  List<int> listidlokasi = [];
  List<int> listidhub = [];
  List<int> listidalat = [];
  List<int> listidkontrol = [];
  List<dynamic> idl = [];
  List<dynamic> states = [];
  List<int> idh = [];
  List<int> ida = [];
  List<int> idk = [];
  int idlokasikontrol;
  List<String> listname = [];
  List<String> listkontrol = [];
  TabController _tabController;
  int _selectedIndex = 0;
  int index = 1;
  bool isSwitchedkelembapan = false;
  int panjanglokasi = 0;
  int panjangkontrol = 0;

  void change(int index) {
    status1 = index;
    iDkontrol = listidkontrol[index];
    loadState();
  }

  void data(int index) {
    if (index == null) {
      change(0);
    } else {
      change(index);
    }
  }

  Future loadKontrol() async {
    // print("idkontrol ${widget.iDkontrol}");
    var url = Uri.parse(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/kontrol?uuid=$uuid');
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
            //----------------------------------------------------------------------//
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
                  int idkontrol = ((((jsonResponse['data'])['lokasi'])[i]['hub']
                      [j]['alat'][k]['kontrol'][l])['id']);
                  listkontrol.contains(kontrol)
                      ? print("")
                      : listkontrol.add(kontrol);
                  listidkontrol.contains(idkontrol)
                      ? print("")
                      : listidkontrol.add(idkontrol);
                  //---------------------------------------------------------------------//
                  iDlokasi == null
                      ? iDlokasi = listidlokasi[0]
                      : iDlokasi = iDlokasi;
                  iDhub == null ? iDhub = listidhub[0] : iDhub = iDhub;
                  iDalat == null ? iDalat = listidalat[0] : iDalat = iDalat;
                  iDkontrol == null
                      ? iDkontrol = listidkontrol[0]
                      : iDkontrol = iDkontrol;
                  //---------------------------------------------------------------------//
                  states.length == listkontrol.length
                      ? print("state $state")
                      : states.add(status);
                  // print("panjang kontrol ${listkontrol.length}");
                  topic = "$iDlokasi/$iDkontrol/crophero/control";
                  var url = Uri.parse(
                      'http://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/kontrol/state?id=$iDkontrol');
                  var jsonString = http.get(url,
                      headers: {HttpHeaders.authorizationHeader: '$token'});
                  var jsonresp = json.decode(jsonString.toString());
                  if (this.mounted) {
                    setState(() {
                      // print(jsonresp);
                      status = jsonresp['state'];
                      // print("statuskontrol $status");
                    });
                  }
                }
              }
            }
          }
        } else {
          // print((jsonResponse['status']));
        }
      });
    }
    return loadKontrol();
  }

  Future loadMonitor() async {
    var url = Uri.parse(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/data?uuid=$uuid');
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
                // print("devname $dev");
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
                // print("trial $trial");
                // print("object ${trial[0]['idlokasi']}");
                // print("namaalat $namaalat");
                Looping looping = Looping.fromJson(data);
                // print("idlokasi ${looping.idalat}");
                // // print("trial idlokasi ${streetsList}");
                // print("namaalat $namaalat");
              }
              // list2.contains(list2)
              //     ? print(list2)
              //     : list2.add(('"data" : ["$trial"]'));
              // print("list2 $list2");
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

  Future loadSensor() async {
    var url = Uri.parse(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/mobile/sensorRev?lokasi=1&hub=1&alat=1');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    var data = jsonResponse['data'];
    // print("json resp new loadsensor: $data");
    if (this.mounted) {
      setState(() {
        panjang = ((jsonResponse['data']).length);
        // print("panjang $panjang");
        for (var i = 0; i < panjang; i++) {
          if (listsensor.length == panjang) {
            print(' panjang items sama dengan panjang ');
          } else if (listsensor.length > panjang) {
            setState(() {
              loading = true;
            });
            listsensor.clear();
          } else {
            sens = (((jsonResponse['data'])[i])["sensor"]);
            listsensor.add(sens);
            // print("listsensor $listsensor");
          }
        }
      });
      return loadSensor();
    }
  }

  Future loadState() async {
    print(iDkontrol);
    var url = Uri.parse(
        'http://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/kontrol/state?id=$iDkontrol');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      setState(() {
        // print(jsonResponse);
        status = jsonResponse['state'];
        // print("statuskontrol $status");
      });
    }
    return loadState();
  }

  @override
  void initState() {
    loadKontrol();
    loadState();
    loadMonitor();
    loadSensor();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    loadKontrol();
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
    print("status $topic $status");
    return DefaultTabController(
        initialIndex: 0,
        length: panjanglokasi + 1,
        child: Scaffold(
            body: (panjanglokasi == null ||
                    panjanglokasi == 0 ||
                    listkontrol == null)
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
                : Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.height / 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text("Pompa",
                                style: TextStyle(
                                    fontFamily: "Mont",
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            30)),
                          ),
                          Image.network(
                            'https://crophero.s3-ap-southeast-1.amazonaws.com/img/pump.png',
                            height: MediaQuery.of(context).size.height / 8,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          new Text(
                            "Status",
                            style: TextStyle(
                              fontFamily: 'Mont',
                              color: Colors.red,
                              fontSize: MediaQuery.of(context).size.height / 45,
                            ),
                          ),
                          status == null
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.width / 20,
                                  width: MediaQuery.of(context).size.width / 20,
                                  child:
                                      Image.asset("asset/img/loading-blog.gif"))
                              : new Text(
                                  "$status",
                                  style: TextStyle(
                                    fontFamily: 'Mont',
                                    fontSize:
                                        MediaQuery.of(context).size.height / 50,
                                  ),
                                ),
                          new Text(
                            "Pengaturan",
                            style: TextStyle(
                              fontFamily: 'Mont',
                              color: Colors.red,
                              fontSize: MediaQuery.of(context).size.height / 45,
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
                                  value: selectedalat,
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff186962),
                                    ),
                                  ),
                                  iconSize: 12,
                                  underline: SizedBox(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedalat = newValue;
                                      // print("selected alat $selectedalat");
                                      // print(newValue['idlokasi']);
                                      idlokasi = newValue['idlokasi'];
                                      idhub = newValue['idhub'];
                                      idalat = newValue[
                                          'idalat']; // idlocselected= newValue.id;
                                      listsensor.clear();
                                      // idhubselected = newValue.name;
                                      // idalatselected=newValue.name;
                                    });
                                    loadSensor();
                                  },
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Pilih Alat'),
                                  ),
                                  items: trial.map((alat) {
                                    return DropdownMenuItem(
                                      value: alat["nama"],
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          "${alat['nama']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Verdana",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                            ),
                          ),
                          selectedalat == null
                              ? Text('')
                              : Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      100.0, 10.0, 100.0, 5.0),
                                  child: Container(
                                    height: 32,
                                    width: 170,
                                    decoration: myBoxDecoration(),
                                    child: DropdownButton(
                                        value: selectedsensor,
                                        isExpanded: true,
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xff186962),
                                          ),
                                        ),
                                        iconSize: 12,
                                        underline: SizedBox(),
                                        onChanged: (newValue2) {
                                          setState(() {
                                            selectedsensor = newValue2;

                                            // idlocselected= newValue.id;
                                            // idhubselected = newValue.name;
                                            // idalatselected=newValue.name;
                                          });
                                        },
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Pilih Sensor'),
                                        ),
                                        items: listsensor.map((sensor) {
                                          return DropdownMenuItem(
                                            value: sensor,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                "$sensor",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "Verdana",
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
                              fontSize: MediaQuery.of(context).size.height / 45,
                            ),
                          ),
                          Center(
                            child: ToggleSwitch(
                              fontSize: MediaQuery.of(context).size.height / 50,
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
                                setState(() {
                                  value = index;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      value == 0 ? KontrolManual() : KontrolAuto(),
                      SizedBox(height: 10),
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
                                      MediaQuery.of(context).size.height / 67),
                              labelColor: Color(0xFFF7931E),
                              unselectedLabelColor: Colors.green[900],
                              indicatorColor: Colors.green[900],
                              tabs: [
                                Tab(
                                  text: "Semua",
                                ),
                                for (i = 0; i < panjanglokasi; i++)
                                  Tab(
                                    text: "${listname[i].substring(0, 12)}",
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
}
