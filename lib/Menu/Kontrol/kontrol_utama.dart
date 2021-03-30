import 'package:ch_v2_1/Menu/Kontrol/kontrol_auto.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_manual.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_timer.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class KontrolUtama extends StatefulWidget {
  @override
  _KontrolUtamaState createState() => _KontrolUtamaState();
}

class _KontrolUtamaState extends State<KontrolUtama>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  int value = 0;
  TabController _tabController;
  int _selectedIndex = 0;
  int index = 1;
  bool isSwitchedkelembapan = false;

  @override
  void initState() {
    print(_selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    print(_selectedIndex);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: new FloatingActionButton(
          focusColor: Colors.green,
          focusElevation: 5,
          highlightElevation: 5,
          hoverColor: Colors.white,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green[900],
          onPressed: () {
            print("tap");
          },
          tooltip: 'tambah alat',
          child: new Icon(Icons.add),
        ),
        body: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
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
                          new Text(
                            "ON",
                            style: TextStyle(
                              fontFamily: 'Mont',
                              fontSize: MediaQuery.of(context).size.height / 50,
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
                              labels: ['Manual', 'Auto', 'Timer'],
                              onToggle: (index) {
                                setState(() {
                                  value = index;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 5),
                          value == 0
                              ? KontrolManual()
                              : value == 1
                                  ? KontrolAuto()
                                  : KontrolTimer(),
                          SizedBox(height: 10),
                          Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * 5 / 6,
                            color: Colors.green[900],
                          ),
                          SizedBox(height: 20),
                          Center(
                              child: GestureDetector(
                            onTap: () {
                              print("tap");
                            },
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
                                      width: 70,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text(
                                          "CHC-018",
                                          style: TextStyle(
                                              fontFamily: 'Mont', fontSize: 15),
                                        ),
                                        new Text(
                                          "Bogor",
                                          style: TextStyle(
                                              fontFamily: 'Mont', fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Container(
                                      child: Center(
                                          child: Icon(Icons.border_color)),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    )
                                  ],
                                )),
                                height: 80,
                                width: 350,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 2.0),
                                    borderRadius: BorderRadius.circular(10))),
                          ))
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ])));
  }
}
