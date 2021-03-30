import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/Corousel/corousel_slider.dart';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ch_v2_1/API/parsing.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/tambahan/stringcap.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_indoor.dart';

String namaalat;
String img;
String satuan;
String max;
String mean;
String min;
int panjang;
List<String> name = new List<String>();
List<Widget> items = new List<Widget>();
Map<String, dynamic> sensor;
List<dynamic> loc = new List<dynamic>();
List<dynamic> huc = new List<dynamic>();
List<dynamic> dev = new List<dynamic>();
String jenissensor1;
double nilai1;
int lokas;
int hu;
int ala;
String convertedDateTime;
String tanggal1;
String jenissensor2;
String tanggal2;
String jnssensor;
double nilai2;

class SensorData extends StatefulWidget {
  final int idlokas;
  final int idhu;
  final int idala;
  const SensorData({Key key, this.idlokas, this.idhu, this.idala});
  @override
  _SensorState createState() => _SensorState();
}

class _SensorState extends State<SensorData> {
  Future loadDevice2() async {
    var jsonString = await http.get(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/data?uuid=$uuid',
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    Data2 data2 = Data2.fromJson(jsonResponse);
    if (this.mounted) {
      setState(() {
        List<Widget> list = new List<Widget>();
        for (int i = 0; i < data2.data.lokasi.length; i++) {
          for (int j = 0; j < data2.data.lokasi[i].hub.length; j++) {
            for (int k = 0; k < data2.data.lokasi[i].hub[j].alat.length; k++) {
              alat = data2.data.lokasi[i].hub[j].alat.length;
              data1 = data2.data.lokasi[i].id;
              data3 = data2.data.lokasi[i].hub[j].id;
              data4 = data2.data.lokasi[i].hub[j].alat[k].id;
              data5 = data2.data.lokasi[i].hub[j].alat[k].nama;
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
              list2.add(
                  ('{ "idlokasi" : $data1,  "idhub" : $data3,  "idalat" : $data4, "nama" : $data5}'));
            }
          }
        }
        return new Row(
          children: list,
        );
      });
    }
    return loadDevice2();
  }

  Future loadSensor() async {
    print("idlokasisensor1111 : $idlokas");
    // if (widget.idlokas == null || idlokas == null) {
    //   print("idlokasisensornullll : ${widget.idlokas}");
    //   var jsonString = await http.get(
    //       '$endPoint/mobile/sensor?lokasi=${idlokasi[0]}&hub=${idhub[0]}&alat=${idalat[0]}',
    //       headers: {HttpHeaders.authorizationHeader: '$token'});
    //   var jsonResponse = json.decode(jsonString.body);
    //   // print('json response : $jsonResponse');
    //   if (this.mounted) {
    //     setState(() {
    //       sensor = ((jsonResponse["data"])["data"])[0];
    //       jenissensor1 = (((jsonResponse["data"])["data"])[0])["jenis"];
    //       jenissensor2 = (((jsonResponse["data"])["data"])[1])["jenis"];
    //       tanggal2 = (((jsonResponse["data"])["data"])[1])["tanggal_sensor"];
    //       panjang = ((jsonResponse["data"])["data"].length);
    //       for (var i = 0; i < panjang; i++) {
    //         if (items.length == panjang) {
    //         } else {
    //           tanggal1 =
    //               ((((jsonResponse["data"])["data"])[i])["tanggal_sensor"]);
    //           DateTime parseDate =
    //               new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    //                   .parse(tanggal1);
    //           var inputDate = DateTime.parse(parseDate.toString());
    //           var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
    //           var outputDate = outputFormat.format(inputDate);
    //           mean = ((((jsonResponse["data"])["data"])[i])["mean"])
    //               .toStringAsFixed(1);
    //           max = ((((jsonResponse["data"])["data"])[i])["max"])
    //               .toStringAsFixed(1);
    //           min = ((((jsonResponse["data"])["data"])[i])["min"])
    //               .toStringAsFixed(1);
    //           jnssensor = (((jsonResponse["data"])["data"])[i])["jenis"];
    //           if (jnssensor == "kelembaban") {
    //             img = "asset/img/rh.png";
    //             satuan = "%";
    //           } else if (jnssensor == "suhu udara") {
    //             img = "asset/img/temp.png";
    //             satuan = "\u00B0C";
    //           } else if (jnssensor == "ph") {
    //             img = "asset/img/temp.png";
    //             satuan = "";
    //           } else if (jnssensor == "ec") {
    //             img = "asset/img/Tph.png";
    //             satuan = "ppm";
    //           } else {
    //             img = "asset/img/Ttanah.png";
    //             satuan = "\u00B0C";
    //           }
    //           nilai1 = (((jsonResponse["data"])["data"])[i])["data"];
    //           items.add(
    //             parameter(jnssensor, satuan, img, nilai1, min, max, mean,
    //                 outputDate, false),
    //           );
    //         }
    //       }
    //       sensor = ((jsonResponse["data"])["data"])[0];
    //       jenissensor1 = (((jsonResponse["data"])["data"])[0])["jenis"];
    //       nilai1 = (((jsonResponse["data"])["data"])[0])["data"];
    //       tanggal1 = ((((jsonResponse["data"])["data"])[0])["tanggal_sensor"]);
    //       jenissensor2 = (((jsonResponse["data"])["data"])[1])["jenis"];
    //       nilai2 = (((jsonResponse["data"])["data"])[1])["data"];
    //       tanggal2 = (((jsonResponse["data"])["data"])[1])["tanggal_sensor"];
    //     });
    //   }
    // } else
    {
      print("idalattt : $idala");
      var jsonString = await http.get(
          '$endPoint/mobile/sensor?lokasi=$idlokas&hub=$idhu&alat=$idala',
          headers: {HttpHeaders.authorizationHeader: '$token'});
      var jsonResponse = json.decode(jsonString.body);
      // print('json response : $jsonResponse');
      if (this.mounted) {
        setState(() {
          sensor = ((jsonResponse["data"])["data"])[0];
          jenissensor1 = (((jsonResponse["data"])["data"])[0])["jenis"];
          jenissensor2 = (((jsonResponse["data"])["data"])[1])["jenis"];
          tanggal2 = (((jsonResponse["data"])["data"])[1])["tanggal_sensor"];
          panjang = ((jsonResponse["data"])["data"].length);
          for (var i = 0; i < panjang; i++) {
            if (items.length == panjang) {
            } else if (items.length > panjang) {
              items.clear();
            } else {
              items.clear();
              tanggal1 =
                  ((((jsonResponse["data"])["data"])[i])["tanggal_sensor"]);
              DateTime parseDate =
                  new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                      .parse(tanggal1);
              var inputDate = DateTime.parse(parseDate.toString());
              var outputFormat = DateFormat('dd-MM-yyyy hh:mm a');
              var outputDate = outputFormat.format(inputDate);
              mean = ((((jsonResponse["data"])["data"])[i])["mean"])
                  .toStringAsFixed(1);
              max = ((((jsonResponse["data"])["data"])[i])["max"])
                  .toStringAsFixed(1);
              min = ((((jsonResponse["data"])["data"])[i])["min"])
                  .toStringAsFixed(1);
              jnssensor = (((jsonResponse["data"])["data"])[i])["jenis"];
              if (jnssensor == "kelembaban") {
                img = "asset/img/rh.png";
                satuan = "%";
              } else if (jnssensor == "suhu udara") {
                img = "asset/img/temp.png";
                satuan = "\u00B0C";
              } else if (jnssensor == "ph") {
                img = "asset/img/temp.png";
                satuan = "";
              } else if (jnssensor == "ec") {
                img = "asset/img/Tph.png";
                satuan = "ppm";
              } else {
                img = "asset/img/Ttanah.png";
                satuan = "\u00B0C";
              }
              nilai1 = (((jsonResponse["data"])["data"])[i])["data"];
              items.add(
                parameter(jnssensor, satuan, img, nilai1, min, max, mean,
                    outputDate, false),
              );
            }
          }
          sensor = ((jsonResponse["data"])["data"])[0];
          jenissensor1 = (((jsonResponse["data"])["data"])[0])["jenis"];
          nilai1 = (((jsonResponse["data"])["data"])[0])["data"];
          tanggal1 = ((((jsonResponse["data"])["data"])[0])["tanggal_sensor"]);
          jenissensor2 = (((jsonResponse["data"])["data"])[1])["jenis"];
          nilai2 = (((jsonResponse["data"])["data"])[1])["data"];
          tanggal2 = (((jsonResponse["data"])["data"])[1])["tanggal_sensor"];
        });
      }
      return loadSensor();
    }
  }

  @override
  void dispose() {
    loadDevice2();
    print("idlokasisensor : ${widget.idlokas}");
    print("idalatsensor : ${widget.idala}");
    loadSensor();
    super.dispose();
  }

  @override
  void initState() {
    loadDevice2();
    loadSensor();
    super.initState();
  }

  bool toogle;
  bool isSwitchedkelembapan = false;

  @override
  Widget build(BuildContext context) {
    if (panjang == null || panjang == 0 || panjang.isNaN) {
      new MonitorIndoor();
      loadSensor();
      loadDevice2();
      return Container(
          height: MediaQuery.of(context).size.width * 8 / 9,
          child: Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.green[900],
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
          )));
    } else {
      loadSensor();
      return Column(
        children: [
          Center(
            child: CarouselSlider(
                items: items,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width * 8 / 9,
                  aspectRatio: 7 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ],
      );
    }
  }

  Widget parameter(String jenissensor, String satuan, String img, double nilai,
      String min, String max, String mean, String time, bool toogle) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  jenissensor.inCaps,
                  style: TextStyle(
                      fontFamily: 'Mont',
                      fontSize: MediaQuery.of(context).size.height / 35),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Image.asset(
                    img,
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                ),
                SizedBox(height: 5),
                Row(
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
                                    MediaQuery.of(context).size.height / 20,
                                fontFamily: "Mont"),
                          ),
                          new Text(
                            satuan,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Min",
                          style: TextStyle(
                            fontFamily: "Mont",
                            fontSize: MediaQuery.of(context).size.height / 60,
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text("$min",
                                    style: TextStyle(
                                        fontFamily: 'Mont',
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
                              fontFamily: "Mont",
                              fontSize: MediaQuery.of(context).size.height / 60,
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text("$mean",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                60,
                                        fontFamily: 'Mont',
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
                              fontFamily: "Mont",
                              fontSize: MediaQuery.of(context).size.height / 60,
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text("$max",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                60,
                                        fontFamily: 'Mont',
                                        color: Colors.white))),
                            height: 40,
                            width: 50)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: new Text(
                    time,
                    style: TextStyle(fontFamily: "Mont"),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: <Widget>[
                                new Text(
                                  'Atur',
                                  style: TextStyle(
                                      fontFamily: 'Mont', fontSize: 12),
                                ),
                                new Text(
                                  'Notifikasi',
                                  style: TextStyle(
                                      fontFamily: 'Mont', fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Switch(
                              value: toogle,
                              onChanged: (value) {
                                setState(() {
                                  toogle = value;
                                  isSwitchedkelembapan = value;
                                  print(isSwitchedkelembapan);
                                });
                              },
                              activeTrackColor: Colors.green[900],
                              activeColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
