import 'dart:async';
import 'dart:convert';
import 'package:ch_v2_1/Menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:http/http.dart' as http;

class KontrolManual extends StatefulWidget {
  @override
  _KontrolManualState createState() => _KontrolManualState();
}

bool loading = false;
int value = 0;

class _KontrolManualState extends State<KontrolManual> {
  @override
  Widget build(BuildContext context) {
    Future publish(String mode, String atas, String bawah, String state) async {
      setState(() {
        loading = true;
      });
      loading = false;
      print("$mode $atas $topic $bawah $state");
      var url = Uri.parse(
          'http://ec2-18-139-101-44.ap-southeast-1.compute.amazonaws.com:2000/control?topic=$topic&message={"mode": "$mode","atas": "$atas","bawah": "$bawah","manual": "$state"}');
      var jsonString = await http.get(url);
      final jsonResponse = json.decode(jsonString.body);
      if (this.mounted) {
        setState(() {
          msg = jsonResponse['success'];
          loading = false;
        });
        if (msg == "1") {
          print("Published to $topic");
          setState(() {
            loading = false;
            showDialog(
              context: context,
              builder: (ctxt) => new AlertDialog(
                title: Column(
                  children: <Widget>[
                    Center(child: Image.asset("asset/img/datasent.png")),
                  ],
                ),
              ),
            );
            Timer(Duration(seconds: 1), () {
              FocusScope.of(context).requestFocus(FocusNode());
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (context) => new Menu(
              //               index: 1,
              //             )));
              // Navigator.pop(context);
              // Navigator.pop(context);
            });
          });
        }
      }
    }

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
                  publish("manual", "0", "0", statesend);
                },
                child: Container(
                    child: Center(
                      child: Text("$statesend",
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
