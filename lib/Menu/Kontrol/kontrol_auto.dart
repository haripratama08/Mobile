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

List<String> statee = ['ON', 'OFF'];
String selectedstate;
String state;
bool loading = false;
int value;
String maxvalue;
String minvalue;
String thresholdvalue;
String namakondisi;

class _KontrolAutoState extends State<KontrolAuto> with Validation {
  TextEditingController max = new TextEditingController(text: maxvalue);
  TextEditingController min = new TextEditingController(text: minvalue);
  TextEditingController threshold =
      new TextEditingController(text: thresholdvalue);

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<http.Response> publish(
        String mode, String threshold, String state) async {
      setState(() {
        selectedkondisi == '>' ? namakondisi = 'atas' : namakondisi = 'bawah';
        thresholdvalue = threshold;
      });
      var message = jsonEncode({
        "tm": "$devname",
        "mode": "$mode",
        "threshold": "$threshold",
        "status": "$state:$namakondisi",
        "manual": "$state",
        "id_sensor": "$idsensor"
      });
      var url = Uri.parse(
          'https://cohkc2p9jb.execute-api.ap-southeast-1.amazonaws.com/v1/control');
      var body = {"topic": topic, "message": message};
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        liststate.clear();
        setState(() {
          loading = false;
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (ctxt) {
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.pop(context);
                  Future.delayed(Duration(seconds: 0), () {
                    Navigator.pop(context, true);
                  });
                });
                return new AlertDialog(
                  title: Column(
                    children: <Widget>[
                      Center(child: Image.asset("asset/img/datasent.png")),
                    ],
                  ),
                );
              });
        });
      }
      return response;
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Status",
                                        style: TextStyle(
                                          fontFamily: 'Kohi',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[900],
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              30,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          height: 32,
                                          width: 85 * 3 / 2,
                                          decoration: myBoxDecoration(),
                                          child: DropdownButton(
                                              value: selectedstate,
                                              isExpanded: true,
                                              icon: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color(0xff186962),
                                                ),
                                              ),
                                              iconSize: 13,
                                              underline: SizedBox(),
                                              onChanged: (newValue) {
                                                if (mounted)
                                                  setState(() {
                                                    selectedstate = newValue;
                                                  });
                                              },
                                              hint: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Pilih Kondisi',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily: 'Kohi'),
                                                ),
                                              ),
                                              items: statee.map((state) {
                                                return DropdownMenuItem(
                                                  value: state,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Text(
                                                      "$state",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontFamily: "Kohi",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Batas",
                                        style: TextStyle(
                                          fontFamily: 'Kohi',
                                          color: Colors.green[900],
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              30,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 32,
                                          width: 85 * 3 / 2,
                                          decoration: myBoxDecoration(),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'isikan batas';
                                              }
                                              return null;
                                            },
                                            controller: threshold,
                                            keyboardType: TextInputType.number,
                                            autofocus: false,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: 'Batas',
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Kohi"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 70,
                        ),
                        loading == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color(0xffC1272D)),
                                ),
                              )
                            : ((selectedalat?.isEmpty ?? true) ||
                                    (pilihsensor?.isEmpty ?? true) ||
                                    (threshold.text?.isEmpty ?? true))
                                ? GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        child: Center(
                                          child: Text(" Kirim",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Kohi',
                                                  fontSize: 15)),
                                        ),
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10))))
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
                                          Navigator.pop(context, true);
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
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          publish("auto", threshold.text,
                                              selectedstate);
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
                                      // FocusScope.of(context)
                                      //     .requestFocus(FocusNode());
                                      // publish("auto", threshold.text,
                                      //     selectedstate);
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
                                            color: Colors.green[300],
                                            borderRadius:
                                                BorderRadius.circular(10))))
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
              return ' masukan nilai';
            }
            return null;
          },
        ));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)));
  }
}
