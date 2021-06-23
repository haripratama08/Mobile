import 'dart:async';
import 'dart:convert';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';
import 'package:ch_v2_1/Validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KontrolAuto extends StatefulWidget {
  @override
  _KontrolAutoState createState() => _KontrolAutoState();
}

String state;
bool loading = false;
int value;
String maxvalue;
String minvalue;

class _KontrolAutoState extends State<KontrolAuto> with Validation {
  TextEditingController max = new TextEditingController(text: maxvalue);
  TextEditingController min = new TextEditingController(text: minvalue);
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future publish(String mode, String atas, String bawah, String state) async {
      setState(() {
        maxvalue = max.text;
        minvalue = min.text;
      });
      print("$mode $atas $topic $bawah $state");
      var url = Uri.parse(
          'http://ec2-18-139-101-44.ap-southeast-1.compute.amazonaws.com:2000/control?topic=$topic&message={"mode": "$mode","atas": "$atas","bawah": "$bawah","manual": "$state","id_sensor": "$idsensor"}');
      var jsonString = await http.get(url);
      final jsonResponse = json.decode(jsonString.body);
      if (this.mounted) {
        setState(() {
          msg = jsonResponse['success'];
          loading = false;
        });
        liststate.clear();
        if (msg == "1") {
          print(
              "message: mode: $mode,atas: $atas,bawah: $bawah , manual: $state , id_sensor : $idsensor");
          print("Published to $topic");
          setState(() {
            loading = false;
            maxvalue = max.text;
            minvalue = min.text;
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
          });
        }
      }
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
            child: loading == true
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xffF03E45)),
                    ),
                  )
                : SingleChildScrollView(
                    physics: ClampingScrollPhysics(
                        parent: NeverScrollableScrollPhysics()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    height:
                                        MediaQuery.of(context).size.height / 22,
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 10, 5),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return ' tolong masukan nilai maximal';
                                            }
                                          },
                                          controller: max,
                                          keyboardType: TextInputType.number,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            prefixIcon: Image(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  300,
                                              image: AssetImage(
                                                  'asset/img/max.png'),
                                              color: Colors.green[900],
                                            ),
                                            hintText: 'Maksimal',
                                            labelStyle: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat"),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0, 5.0, 0, 5.0),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.green[900])),
                                          ),
                                        )),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    height:
                                        MediaQuery.of(context).size.height / 22,
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 10, 5),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return ' tolong masukan nilai minimal';
                                            }
                                          },
                                          controller: min,
                                          keyboardType: TextInputType.number,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            prefixIcon: Image(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    300,
                                                image: AssetImage(
                                                    'asset/img/min.png'),
                                                color: Colors.green[900]),
                                            hintText: 'Minimal',
                                            labelStyle: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat"),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                0, 5.0, 0, 5.0),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.green[900])),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              // userField(
                              //   max,
                              //   'Nilai Maksimal',
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 100,
                        ),
                        loading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color(0xffC1272D)),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  publish(
                                      "auto", max.text, min.text, statesend);
                                },
                                child: Container(
                                    child: Center(
                                      child: Text("Kirim",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Mont',
                                              fontSize: 15)),
                                    ),
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.red[900],
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                      ],
                    ),
                  )),
      ),
    );
  }

  Widget userField(
    TextEditingController cont,
    String hint,
  ) {
    return ListTile(
        contentPadding: EdgeInsets.fromLTRB(40, 2.5, 40.0, 2.5),
        title: TextFormField(
          keyboardType: TextInputType.number,
          controller: cont,
          obscureText: false,
          autofocus: false,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            filled: true,
            hintText: hint,
            contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return ' please enter value';
            }
          },
        ));
  }
}
