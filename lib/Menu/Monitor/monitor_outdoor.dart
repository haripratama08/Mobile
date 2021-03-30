import 'package:flutter/material.dart';

class MonitorOutdoor extends StatefulWidget {
  @override
  _MonitorOutdoorState createState() => _MonitorOutdoorState();
}

class _MonitorOutdoorState extends State<MonitorOutdoor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.all(8.0),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            "CHM-017",
                            style: TextStyle(fontFamily: 'Mont', fontSize: 15),
                          ),
                          new Text(
                            "Bogor",
                            style: TextStyle(fontFamily: 'Mont', fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      GestureDetector(
                        onTap: () {
                          dialog();
                          print("Tap Edit");
                        },
                        child: Container(
                          child: Center(child: Icon(Icons.border_color)),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      )
                    ],
                  )),
                  height: 80,
                  width: 380,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green[100],
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.circular(10))),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "CHM-018",
                        style: TextStyle(fontFamily: 'Mont', fontSize: 15),
                      ),
                      new Text(
                        "Bogor",
                        style: TextStyle(fontFamily: 'Mont', fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Container(
                    child: Center(child: Icon(Icons.border_color)),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              )),
              height: 80,
              width: 380,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2.0),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ],
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
