import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Semua extends StatefulWidget {
  @override
  _SemuaState createState() => _SemuaState();
}

class _SemuaState extends State<Semua> {
  void initState() {
    loadKontrol();
    super.initState();
  }

  String state;
  int idkontrol;
  List<String> listname = [];
  List<String> listkontrol = [];
  int idlokasikontrol;
  List<int> listidlokasi = [];
  List<int> listidhub = [];
  List<int> listidalat = [];
  List<int> listidkontrol = [];
  int panjanglokasi = 0;
  int panjangkontrol = 0;

  Future loadKontrol() async {
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
            // print(listname);
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
                  // print("panjang kontrol ${listkontrol.length}");
                  topic = "$iDlokasi/$iDkontrol/crophero/control";
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

  void change(int index) {
    status1 = index;
    iDkontrol = listidkontrol[index];
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
                  void statusa(int ins) {
                    if (status1 == ins) {
                      warna = Colors.green[100];
                    } else {
                      warna = Color(0x098765);
                    }
                  }

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
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            data(status1);
                            change(index);
                            statusa(index);
                            print("list id kontrol $listidkontrol");
                            KontrolUtama(iDkontrol: listidkontrol[index]);
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
}
