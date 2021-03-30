import 'package:ch_v2_1/Menu/Monitor/sensor.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_indoor.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_indoor2.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_outdoor.dart';

String namaalat;
String alat;
List<dynamic> lokasi;
List<dynamic> list2 = new List<dynamic>();
int data1;
int data3;
int data4;
int data5;

class Monitor extends StatefulWidget {
  final int idlokas;
  final int idhu;
  final int idala;
  const Monitor({Key key, this.idlokas, this.idhu, this.idala});
  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SensorData(
      idlokas: widget.idlokas,
      idala: widget.idala,
      idhu: widget.idhu,
    );
    MonitorIndoor();
    super.initState();
  }

  void dispose() {
    MonitorIndoor();
    SensorData(
      idlokas: widget.idlokas,
      idala: widget.idala,
      idhu: widget.idhu,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: new FloatingActionButton(
          focusColor: Colors.green,
          focusElevation: 5,
          highlightElevation: 5,
          hoverColor: Colors.white,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green[900],
          onPressed: () {
            tambahAlat();
            print("tap");
          },
          tooltip: 'Tambah Alat',
          child: new Icon(Icons.add),
        ),
        body: Container(
          child: Container(
            child: Column(
              children: <Widget>[
                SensorData(
                  idlokas: widget.idlokas,
                  idala: widget.idala,
                  idhu: widget.idhu,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
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
                    child: AppBar(
                      backgroundColor: Colors.white,
                      bottom: TabBar(
                        labelStyle: TextStyle(
                            fontFamily: "Mont",
                            fontSize: MediaQuery.of(context).size.height / 67),
                        labelColor: Color(0xFFF7931E),
                        unselectedLabelColor: Colors.green[900],
                        indicatorColor: Colors.green[900],
                        tabs: [
                          Tab(
                            text: "Semua",
                          ),
                          Tab(
                            text: "Indoor",
                          ),
                          Tab(
                            text: "Outdoor",
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
                      MonitorIndoor(),
                      MonitorIndoor2(),
                      MonitorOutdoor(),
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

  void tambahAlat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: new Text(
                      "Ganti Nama",
                      style: TextStyle(fontFamily: 'Mont', fontSize: 18),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                    child: new Text(
                      "Nama Baru",
                      style: TextStyle(fontFamily: 'Mont', fontSize: 15),
                    )),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                    child: new Text(
                      "Tempat Baru",
                      style: TextStyle(fontFamily: 'Mont', fontSize: 15),
                    )),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 15),
                  child: GestureDetector(
                    onTap: () {},
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
                ),
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
