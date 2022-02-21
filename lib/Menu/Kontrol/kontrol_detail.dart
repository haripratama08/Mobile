import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/API/jeniskontrol.dart';
import 'package:ch_v2_1/Menu/menu.dart';
import 'package:ch_v2_1/Validator/validation.dart';
import 'package:ch_v2_1/process/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final int ind;
  const Detail({this.ind});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with Validation {
  TextEditingController alias = new TextEditingController();
  String msg = '';
  final formKey = GlobalKey<FormState>();
  GantiAliasKontrol gantikontrol = GantiAliasKontrol();

  void initState() {
    loadKontrol();
    status1 = 0;
    super.initState();
  }

  String kontrolname;
  String state;
  int idkontrol;
  String kontrolnamechoosen;
  List<String> kontrolnamelist = [];
  List<String> timelist = [];
  List<String> eventlist = [];
  List<String> reasonlist = [];
  List<String> listname = [];
  List<String> listkontrol = [];
  int idlokasikontrol;
  List<int> listidlokasi = [];
  List<int> listidhub = [];
  List<int> listidalat = [];
  List<int> listidkontrol = [];
  int panjanglokasi = 0;
  int panjangkontrol = 0;
  bool loading = false;

  void statusa(int ins) {
    if (status1 == ins) {
      warna = Colors.green[100];
    } else {
      warna = Color(0x098765);
    }
  }

  Future loadKontrol() async {
    var url = Uri.parse('$endPoint/alat/kontrol');
    var jsonString = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    Jeniskontrol jeniskontrol = Jeniskontrol.fromJson(jsonResponse);
    if (this.mounted) {
      setState(() {
        if (jeniskontrol.status == 'OK') {
          panjanglokasi = jeniskontrol.data.lokasi[widget.ind].hub.length;
          print(jeniskontrol.data.lokasi[widget.ind].hub.length);
          if (jeniskontrol.data.lokasi[widget.ind].hub.length == 0) {
            msg = "Tidak Ada Alat";
          } else {
            String hub = jeniskontrol.data.lokasi[widget.ind].nama;
            print(hub);
            // idlokasikontrol = jeniskontrol.data.lokasi[widget.ind].id;
            // listname.length == panjanglokasi ? print("") : listname.add(hub);
            // listidlokasi.length == panjanglokasi
            //     ? print("")
            //     : listidlokasi.add(idlokasikontrol);
            var panjanghub = jeniskontrol.data.lokasi[widget.ind].hub.length;
            print(panjanghub);
//----------------------------------------------------------------------//
            for (int j = 0; j < panjanghub; j++) {
              var panjangalat =
                  jeniskontrol.data.lokasi[widget.ind].hub[j].alat.length;
              int idhubkontrol = jeniskontrol.data.lokasi[widget.ind].hub[j].id;
              listidhub.length == panjanghub
                  ? print("")
                  : listidhub.add(idhubkontrol);
//----------------------------------------------------------------------//
              for (int k = 0; k < panjangalat; k++) {
                panjangkontrol = jeniskontrol
                    .data.lokasi[widget.ind].hub[j].alat[k].kontrol.length;
                int idalatkontrol =
                    jeniskontrol.data.lokasi[widget.ind].hub[j].alat[k].id;
                listidalat.length == panjangalat
                    ? print("")
                    : listidalat.add(idalatkontrol);
//---------------------------------------------------------------------//
                for (int l = 0; l < panjangkontrol; l++) {
                  String kontrol = jeniskontrol
                      .data.lokasi[widget.ind].hub[j].alat[k].kontrol[l].alias;
                  String kontrolname = jeniskontrol
                      .data.lokasi[widget.ind].hub[j].alat[k].kontrol[l].nama;
                  String event = jeniskontrol
                      .data.lokasi[widget.ind].hub[j].alat[k].kontrol[l].event;
                  String reason = jeniskontrol
                      .data.lokasi[widget.ind].hub[j].alat[k].kontrol[l].reason;
                  String time = jeniskontrol
                      .data.lokasi[widget.ind].hub[j].alat[k].kontrol[l].time;
                  int idkontrol = jeniskontrol
                      .data.lokasi[widget.ind].hub[j].alat[k].kontrol[l].id;

                  eventlist.length == panjangkontrol
                      ? print("")
                      : eventlist.add(event);

                  timelist.length == panjangkontrol
                      ? print("")
                      : timelist.add(time);

                  reasonlist.length == panjangkontrol
                      ? print("")
                      : reasonlist.add(reason);

                  listkontrol.contains(kontrol)
                      ? print("")
                      : listkontrol.add(kontrol);

                  kontrolnamelist.contains(kontrolname)
                      ? print("")
                      : kontrolnamelist.add(kontrolname);

                  namaalatkontrol == null
                      ? namaalatkontrol = listkontrol[0]
                      : namaalatkontrol = namaalatkontrol;

                  listidkontrol.contains(idkontrol)
                      ? print("")
                      : listidkontrol.add(idkontrol);

                  kontrolnamechoosen == null
                      ? kontrolnamechoosen = kontrolnamelist[0]
                      : kontrolnamechoosen = kontrolnamechoosen;
                  topic = "$kontrolnamechoosen/crophero/control";
                }
              }
            }
          }
        } else {}
      });
    }
    return loadKontrol();
  }

  Future doGantiAliasKontrol() async {
    listkontrol.clear();
    try {
      var rs = await gantikontrol.doGantiAliasKontrol(
          alias.text, iDkontrol, uuid, token);
      var jsonRes = json.decode(rs.body);
      print(jsonRes);
      listkontrol.clear();
      setState(() {
        loadKontrol();
      });
      Timer(Duration(seconds: 1), () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Menu(
                      index: 1,
                    )));
      });
    } catch (e) {}
  }

  void change(int index) {
    status1 = index;
    iDkontrol = listidkontrol[index];
    namaalatkontrol = listkontrol[index];
    kontrolnamechoosen = kontrolnamelist[index];
  }

  void data(int index) {
    if (index == null) {
      change(0);
    } else {
      change(index);
    }
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
                itemCount: listkontrol.length == null ? 0 : listkontrol.length,
                itemBuilder: (BuildContext context, int index) {
                  statusa(index);
                  if (listkontrol.length == null) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.width / 5,
                              width: MediaQuery.of(context).size.width / 5,
                              child: Image.asset("asset/img/loading-blog.gif")),
                        ],
                      )),
                    );
                  } else {
                    return loading == true
                        ? Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Center(
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
                            )),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                data(status1);
                                change(index);
                                statusa(index);
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
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Image.asset(
                                              'asset/img/toogle.png',
                                              height: SizeConfigs.screenHeight *
                                                  0.04,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: eventlist[index] ==
                                                  'disconnected'
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                      new Text(
                                                        '${listkontrol[index]}',
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        style: TextStyle(
                                                            fontFamily: 'kohi',
                                                            fontSize:
                                                                getHeight(14),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      new Text(
                                                        '${reasonlist[index]}',
                                                        style: TextStyle(
                                                          fontSize:
                                                              getHeight(10),
                                                        ),
                                                      )
                                                    ])
                                              : new Text(
                                                  '${listkontrol[index]}',
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: TextStyle(
                                                      fontFamily: 'kohi',
                                                      fontSize: getHeight(14),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: GestureDetector(
                                          onTap: () {
                                            if (timelist[index].isEmpty) {
                                            } else {
                                              if (eventlist[index] ==
                                                  'disconnected') {
                                                AlertDialog alert = AlertDialog(
                                                  title: Text(
                                                      "Terkoneksi terakhir pada",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize:
                                                              getHeight(15),
                                                          fontFamily: 'Kohi')),
                                                  content: Text(
                                                      "${timelist[index]}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'Kohi',
                                                          fontSize:
                                                              getHeight(15),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  actions: [],
                                                );
                                                // show the dialog
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return alert;
                                                  },
                                                );
                                              } else {
                                                AlertDialog alert = AlertDialog(
                                                  title: Text(
                                                    "Terhubung kembali pada",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: getHeight(15),
                                                        fontFamily: 'Kohi'),
                                                  ),
                                                  content: Text(
                                                      "${timelist[index]}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'Kohi',
                                                          fontSize:
                                                              getHeight(15),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  actions: [],
                                                );
                                                // show the dialog
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return alert;
                                                  },
                                                );
                                              }
                                            }

                                            // set up the AlertDialog
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: eventlist[index] ==
                                                      'disconnected'
                                                  ? Image.asset(
                                                      'asset/img/disconnected.png',
                                                      height: SizeConfigs
                                                              .screenHeight *
                                                          0.03,
                                                    )
                                                  : Image.asset(
                                                      'asset/img/connected.png',
                                                      height: SizeConfigs
                                                              .screenHeight *
                                                          0.02,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 11.5,
                                  width:
                                      MediaQuery.of(context).size.width * 4 / 5,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color(0xB1AFAF).withOpacity(0.3),
                                          spreadRadius: 1,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      color: warna,
                                      borderRadius: BorderRadius.circular(10))),
                            ));
                  }
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                      child: new Text(
                        "Nama Baru",
                        style: TextStyle(fontFamily: 'Mont', fontSize: 15),
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
                          hintText: 'nama kontrol',
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
                        doGantiAliasKontrol();
                        listkontrol.clear();
                        loadKontrol();
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
                  )
                ],
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
        );
      },
    );
  }
}