import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:http/http.dart' as http;
import '../../API/api.dart';

class KontrolManual extends StatefulWidget {
  @override
  _KontrolManualState createState() => _KontrolManualState();
}

bool loading = false;
int value = 0;

class _KontrolManualState extends State<KontrolManual> {
  @override
  Widget build(BuildContext context) {
    Future<http.Response> publish(
        String mode, String atas, String bawah, String state) async {
      setState(() {
        loading = true;
      });
      loading = false;
      var message = jsonEncode({
        "mode": "$mode",
        "threshold": "0",
        "status": "null",
        "manual": "$state",
        "id_sensor": "null",
      });
      var url = Uri.parse('$kontrol');
      var body = {"topic": topic, "message": message};
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        status = null;
        liststate.clear();
        setState(() {
          loading = false;
          showDialog(
            context: context,
            builder: (ctxt) {
<<<<<<< HEAD
              Future.delayed(Duration(seconds: 1), () {
                // Navigator.pop(context);
                // Navigator.of(context).pop(true);
              });
=======
              Future.delayed(Duration(seconds: 1), () {});
>>>>>>> c45977631a0546afa898457c561e7afb8723a97e
              return new AlertDialog(
                title: Column(
                  children: <Widget>[
                    Center(child: Image.asset("asset/img/datasent.png")),
                  ],
                ),
              );
            },
          );
        });
      }
      return response;
    }
    return Container(
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
                  Widget cancelButton = TextButton(
                    child: Text(
                      "Tidak",
                      style: TextStyle(
                          fontFamily: 'Kohi',
                          color: Colors.green[300],
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                  Widget continueButton = TextButton(
                    child: Text("Ya",
                        style: TextStyle(
                            fontFamily: 'Kohi',
                            color: Colors.green[300],
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      liststate.clear();
                      FocusScope.of(context).requestFocus(FocusNode());
                      publish("manual", "0", "0", statesend);
                    },
                  );
                  AlertDialog alert = AlertDialog(
                    content: Text(
                      "Apakah Anda Yakin?",
                      style: TextStyle(fontFamily: 'Kohi'),
                    ),
                    actions: [
                      continueButton,
                      cancelButton,
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: Container(
                    child: Center(
                      child: Text("$statesend",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kohi',
                              fontSize: 15)),
                    ),
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(10)))),
      ),
    );
  }
}
