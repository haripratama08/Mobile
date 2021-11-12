import 'dart:io';
import 'package:ch_v2_1/API/api.dart';
import 'package:ch_v2_1/LoginPage/loginpage.dart';
import 'package:http/http.dart' as http;

class LoadMonitoring {
  Future monitor(int idlokasi, int idhub, int idalat) async {
    print("masuk loadMonitor");
    return http.get(
        Uri.parse(
            '$endPoint/mobile/sensor?lokasi=$idlokasi&hub=$idhub&alat=$idalat'),
        headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}
