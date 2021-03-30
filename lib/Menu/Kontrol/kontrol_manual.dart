import 'package:flutter/material.dart';

class KontrolManual extends StatefulWidget {
  @override
  _KontrolManualState createState() => _KontrolManualState();
}

bool loading = false;
int value = 0;

class _KontrolManualState extends State<KontrolManual> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Container(
        child: loading == true
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xffF03E45)),
                ),
              )
            : GestureDetector(
                onTap: () {
                  print("tap");
                },
                child: Container(
                    child: Center(
                      child: Text("OFF",
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
      ),
    );
  }
}
