import 'dart:convert';
import 'dart:io';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:ch_v2_1/Menu/Monitor/monitor_semua.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangeName {
  TextEditingController name = TextEditingController();
  changeName(context) {
    print(idAlatChange);
    AlertDialog alert = AlertDialog(
      title: Text(
        "Ganti nama alat",
        style: TextStyle(fontFamily: 'Kohi', fontWeight: FontWeight.bold),
      ),
      content: Container(
        height: MediaQuery.of(context).devicePixelRatio * 30,
        width: MediaQuery.of(context).devicePixelRatio * 50,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.green[300], width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    labelText: "Nama",
                  )),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(5)),
            width: MediaQuery.of(context).devicePixelRatio * 35,
            height: MediaQuery.of(context).devicePixelRatio * 15,
            child: GestureDetector(
              onTap: () {
                gantiAliasAlat(idAlatChange, name.text, token);
                print('id_alat = $idAlatChange dan namaganti ${name.text}');
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Ubah',
                    style: TextStyle(
                        fontFamily: 'Kohi',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future gantiAliasAlat(
      int idAlatChange, String namaganti, String token) async {
    var jsonString = await http.put(
        Uri.parse('$endPoint/alat/edit?id_alat=$idAlatChange'),
        body: {"alias": "$namaganti"},
        headers: {HttpHeaders.authorizationHeader: '$token'});
    var jsonResponse = json.decode(jsonString.body);
    print(jsonResponse);
    items.clear();
    itemsshadow.clear();
    iditems.clear();
  }
}
