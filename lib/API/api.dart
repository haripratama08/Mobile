import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String endPoint =
    'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api';

class ApiLogin {
  Future<http.Response> doLogin(String username, String password) async {
    String url = '$endPoint/user/login';
    var body = {"username": username, "password": password};
    return http.post(url, body: body);
  }
}

class Gantinotif {
  Future<http.Response> gantinotif(int sets, int idsensor, String token) async {
    String url = '$endPoint/sensor/notifikasi?set=$sets&id_sensor=$idsensor';
    print('set $sets');
    print('idsensor $idsensor');
    print(token);
    return http.put(url, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}

class ApiRegister {
  Future<http.Response> doRegis(String username, String password, String nama,
      String email, String telp, String alamat, String foto) async {
    String url = '$endPoint/user/register';
    var body = {
      "username": username,
      "password": password,
      "nama": nama,
      "email": email,
      "telp": telp,
      "alamat": alamat,
      "foto": foto,
    };
    return http.post(url, body: body);
  }
}

class GantiAlias {
  Future<http.Response> doGanti(
      String alias, int idalat, String uuid, String token) async {
    String url = '$endPoint/alat/edit?uuid=$uuid&id_alat=$idalat';
    var body = {
      "alias": alias,
    };
    return http.put(url,
        body: body, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}
