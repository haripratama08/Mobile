import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:flutter/material.dart';

int status1 = 0;
int i;
int j;
int k;
int l;
int iDlokasi;
int iDhub;
int iDalat;
int iDkontrol;
var warna;

class KontrolSemua extends StatefulWidget {
  @override
  _KontrolSemuaState createState() => _KontrolSemuaState();
}

class _KontrolSemuaState extends State<KontrolSemua> {
  bool loading = false;
  int value = 0;
  String status;
  List<int> listidlokasi = [];
  List<int> listidhub = [];
  List<int> listidalat = [];
  List<int> listidkontrol = [];
  int idlokasikontrol;
  List<String> listname = [];
  List<String> listkontrol = [];
  int index = 1;
  bool isSwitchedkelembapan = false;
  int panjanglokasi = 0;
  int panjangkontrol = 0;
  String msg = '';
  Future loadDeviceKontrol() async {
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
                  status = ((((jsonResponse['data'])['lokasi'])[i]['hub'][j]
                      ['alat'][k]['kontrol'][l])['state']);
                  int idkontrol = ((((jsonResponse['data'])['lokasi'])[i]['hub']
                      [j]['alat'][k]['kontrol'][l])['id']);
                  listkontrol.length == panjangkontrol
                      ? print("")
                      : listkontrol.add(kontrol);
                  listidkontrol.length == panjangkontrol
                      ? print("")
                      : listidkontrol.add(idkontrol);
                }
              }
            }
          }
        } else {
          print((jsonResponse['status']));
        }
      });
    }
    return loadDeviceKontrol();
  }

  Future doGanti() async {
    // listnama.clear();
    try {
      // var rs = await ganti.doGanti(alias.text, idala, uuid, token);
      // var jsonRes = json.decode(rs.body);
      // listnama.clear();
      setState(() {
        loadDeviceKontrol();
        // print(jsonRes);
      });
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new KontrolUtama()));
    } catch (e) {}
  }

  void change(int index) {
    status1 = index;
  }

  void data(int index) {
    if (index == null) {
      change(0);
    } else {
      change(index);
    }
  }

  void initState() {
    loadDeviceKontrol();
    super.initState();
  }

  void dispose() {
    loadDeviceKontrol();
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
                itemCount: panjangkontrol == null ? 0 : panjangkontrol,
                itemBuilder: (BuildContext context, int index) {
                  void status(int ins) {
                    if (status1 == ins) {
                      warna = Colors.green[100];
                    } else {
                      warna = Color(0x098765);
                    }
                  }

                  status(index);
                  if (panjangkontrol == null) {
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
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            loading = true;

                            data(status1);
                            change(index);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'asset/img/ghico.png',
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 12,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        '${listkontrol[index]}',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                            fontFamily: 'Mont', fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 12,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      dialog();
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Icon(Icons.border_color)),
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.5, color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  )
                                ],
                              )),
                              height: MediaQuery.of(context).size.height / 11,
                              width:
                                  MediaQuery.of(context).size.width * 4.5 / 5,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: warna,
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.black,
                                  ),
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
            Column(
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
                      // controller: alias,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: nama,
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
                      ),
                      // validator: validateall,
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 15),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      doGanti();

                      loadDeviceKontrol();
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
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
        );
      },
    );
  }
}
