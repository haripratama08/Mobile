import 'package:flutter/material.dart';

class KontrolAuto extends StatefulWidget {
  @override
  _KontrolAutoState createState() => _KontrolAutoState();
}

bool loading = false;
int value = 0;

class _KontrolAutoState extends State<KontrolAuto> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        child: loading == true
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xffF03E45)),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15.0, 0, 10, 0),
                                  child: new DropdownButton<String>(
                                    hint: Text(
                                      "Alat Monitoring",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    items: <String>['A', 'B', 'C', 'D']
                                        .map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30.0, 0, 10, 0),
                                  child: new DropdownButton<String>(
                                    hint: Text(
                                      "ON Ketika",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    items: <String>['A', 'B', 'C', 'D']
                                        .map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30.0, 0, 10, 0),
                                  child: new DropdownButton<String>(
                                    hint: Text(
                                      "Parameter",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    items: <String>['A', 'B', 'C', 'D']
                                        .map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30.0, 0, 10, 0),
                                  child: new DropdownButton<String>(
                                    hint: Text(
                                      "OFF Ketika",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    items: <String>['A', 'B', 'C', 'D']
                                        .map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),

                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    height: 120,
                    width: 340,
                    // color: Colors.black,
                  )),
                  SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        print("tap");
                      },
                      child: Container(
                          child: Center(
                            child: Text("Terapkan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Mont',
                                    fontSize: 15)),
                          ),
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.red[900],
                              borderRadius: BorderRadius.circular(10)))),
                ],
              ),
      ),
    );
  }
}
