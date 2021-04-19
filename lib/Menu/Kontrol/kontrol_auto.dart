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
int value = 0;
String maxvalue = "0";
String minvalue = "0";

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
        // maxvalue = max.text;
        // minvalue = min.text;
        loading = true;
      });
      var jsonString = await http.get(
          'http://ec2-3-221-183-0.compute-1.amazonaws.com:2000/control?topic=$topic&message={"mode": "$mode","atas": "$atas","bawah": "$bawah","manual": "$state"}');
      final jsonResponse = json.decode(jsonString.body);
      if (this.mounted) {
        setState(() {
          msg = jsonResponse['success'];
        });
        if (msg == "1") {
          // print("Published to $topic");
          setState(() {
            loading = false;
            // maxvalue = max.text;
            // minvalue = min.text;
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
              Navigator.pop(context);
              Navigator.pop(context);
            });
          });
        }
      }
    }

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
              : Container(
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            userField(
                              max,
                              'Enter Max Value',
                            ),
                            userField(
                              min,
                              'Enter Min Value',
                            )
                          ],
                        ),
                      ),
                      loading == true
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xffC1272D)),
                              ),
                            )
                          : Material(
                              color: Color(0xffC1272D),
                              child: MaterialButton(
                                minWidth: 200.0,
                                height: 42.0,
                                onPressed: () {
                                  publish("auto", max.text, min.text, state);
                                },
                                child: Text("Send Data",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Tai")),
                              ),
                            ),
                    ],
                  ),
                )
          // Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       GestureDetector(
          //           child: Container(
          //         child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Container(
          //                     height: 35,
          //                     width: 130,
          //                     decoration: BoxDecoration(
          //                         border: Border.all(color: Colors.black),
          //                         borderRadius: BorderRadius.circular(5)),
          //                     child: Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(15.0, 0, 10, 0),
          //                       child: new DropdownButton<String>(
          //                         hint: Text(
          //                           "Alat Monitoring",
          //                           style: TextStyle(fontSize: 11),
          //                         ),
          //                         items: <String>['A', 'B', 'C', 'D']
          //                             .map((String value) {
          //                           return new DropdownMenuItem<String>(
          //                             value: value,
          //                             child: new Text(value),
          //                           );
          //                         }).toList(),
          //                         onChanged: (_) {},
          //                       ),
          //                     ),
          //                   ),
          //                   SizedBox(width: 20),
          //                   Container(
          //                     height: 35,
          //                     width: 130,
          //                     decoration: BoxDecoration(
          //                         border: Border.all(color: Colors.black),
          //                         borderRadius: BorderRadius.circular(5)),
          //                     child: Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(30.0, 0, 10, 0),
          //                       child: new DropdownButton<String>(
          //                         hint: Text(
          //                           "ON Ketika",
          //                           style: TextStyle(fontSize: 11),
          //                         ),
          //                         items: <String>['A', 'B', 'C', 'D']
          //                             .map((String value) {
          //                           return new DropdownMenuItem<String>(
          //                             value: value,
          //                             child: new Text(value),
          //                           );
          //                         }).toList(),
          //                         onChanged: (_) {},
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(height: 10),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Container(
          //                     height: 35,
          //                     width: 130,
          //                     decoration: BoxDecoration(
          //                         border: Border.all(color: Colors.black),
          //                         borderRadius: BorderRadius.circular(5)),
          //                     child: Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(30.0, 0, 10, 0),
          //                       child: new DropdownButton<String>(
          //                         hint: Text(
          //                           "Parameter",
          //                           style: TextStyle(fontSize: 11),
          //                         ),
          //                         items: <String>['A', 'B', 'C', 'D']
          //                             .map((String value) {
          //                           return new DropdownMenuItem<String>(
          //                             value: value,
          //                             child: new Text(value),
          //                           );
          //                         }).toList(),
          //                         onChanged: (_) {},
          //                       ),
          //                     ),
          //                   ),
          //                   SizedBox(width: 20),
          //                   Container(
          //                     height: 35,
          //                     width: 130,
          //                     decoration: BoxDecoration(
          //                         border: Border.all(color: Colors.black),
          //                         borderRadius: BorderRadius.circular(5)),
          //                     child: Padding(
          //                       padding:
          //                           const EdgeInsets.fromLTRB(30.0, 0, 10, 0),
          //                       child: new DropdownButton<String>(
          //                         hint: Text(
          //                           "OFF Ketika",
          //                           style: TextStyle(fontSize: 11),
          //                         ),
          //                         items: <String>['A', 'B', 'C', 'D']
          //                             .map((String value) {
          //                           return new DropdownMenuItem<String>(
          //                             value: value,
          //                             child: new Text(value),
          //                           );
          //                         }).toList(),
          //                         onChanged: (_) {},
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ]),

          //         decoration: BoxDecoration(
          //             border: Border.all(color: Colors.black),
          //             borderRadius: BorderRadius.circular(10)),
          //         height: 120,
          //         width: 340,
          //         // color: Colors.black,
          //       )),
          //       SizedBox(height: 20),
          //       GestureDetector(
          //           onTap: () {
          //             print("tap");
          //           },
          //           child: Container(
          //               child: Center(
          //                 child: Text("Terapkan",
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontFamily: 'Mont',
          //                         fontSize: 15)),
          //               ),
          //               height: 40,
          //               width: 120,
          //               decoration: BoxDecoration(
          //                   color: Colors.red[900],
          //                   borderRadius: BorderRadius.circular(10)))),
          //     ],
          //   ),
          ),
    );
  }

  Widget userField(
    TextEditingController cont,
    String hint,
  ) {
    return ListTile(
        contentPadding: EdgeInsets.fromLTRB(40, 5.0, 40.0, 5.0),
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
            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return ' please enter value';
            }
          },
        ));
  }
}
