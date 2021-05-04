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
    print("idkontrol ${widget.iDkontrol}");
    var jsonString = await http.get(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/kontrol?uuid=$uuid',
        headers: {HttpHeaders.authorizationHeader: '$token'});
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
                  print("panjang kontrol ${listkontrol.length}");
                  topic = "$iDlokasi/$iDkontrol/crophero/control";
                  var jsonString = http.get(
                      'http://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/kontrol/state?id=$iDkontrol',
                      headers: {HttpHeaders.authorizationHeader: '$token'});
                  var jsonresp = json.decode(jsonString.toString());
                  // print(jsonresp);
                  if (this.mounted) {
                    setState(() {
                      print(jsonresp);
                      status = jsonresp['state'];
                      print("statuskontrol $status");
                    });
                  }
                }
              }
            }
          }
        } else {
          print((jsonResponse['status']));
        }
      });
    }
    return loadKontrol();
  }

  Future loadState() async {
    print(iDkontrol);
    var jsonString = await http.get(
        'http://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/kontrol/state?id=$iDkontrol',
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    if (this.mounted) {
      setState(() {
        print(jsonResponse);
        status = jsonResponse['state'];
        print("statuskontrol $status");
      });
    }
    return loadState();
  }

  @override
  void initState() {
    print(_selectedIndex);
    loadKontrol();
    loadState();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    print(_selectedIndex);
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
}
