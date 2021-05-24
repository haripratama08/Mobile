import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String endPoint =
    'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api';

class ApiLogin {
  Future<http.Response> doLogin(String username, String password) async {
    var url = Uri.parse('$endPoint/user/login');
    // String url = '$endPoint/user/login';
    var body = {"username": username, "password": password};
    return http.post(url, body: body);
  }
}

class Gantinotif {
  Future<http.Response> gantinotif(int sets, int idsensor, String token) async {
    var url =
        Uri.parse('$endPoint/sensor/notifikasi?set=$sets&id_sensor=$idsensor');
    // String url = '$endPoint/sensor/notifikasi?set=$sets&id_sensor=$idsensor';
    print('set $sets');
    print('idsensor $idsensor');
    print(token);
    return http.put(url, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}

class ApiRegister {
  Future<http.Response> doRegis(String username, String password, String nama,
      String email, String telp, String alamat, String foto) async {
    var url = Uri.parse('$endPoint/user/register');
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
    var url = Uri.parse('$endPoint/alat/edit?uuid=$uuid&id_alat=$idalat');
    // String url = '$endPoint/alat/edit?uuid=$uuid&id_alat=$idalat';
    var body = {
      "alias": alias,
    };
    return http.put(url,
        body: body, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}

class GantiAliasKontrol {
  Future<http.Response> doGantiAliasKontrol(
      String alias, int idkontrol, String uuid, String token) async {
    var url =
        Uri.parse('$endPoint/kontrol/edit?uuid=$uuid&id_kontrol=$idkontrol');
    // String url = '$endPoint/kontrol/edit?uuid=$uuid&id_kontrol=$idkontrol';
    var body = {
      "alias": alias,
    };
    return http.put(url,
        body: body, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}

class PostSetParameter {
  Future<http.Response> dosetparameter(String uuid, String idsensor, String min,
      String max, String token) async {
    var url = Uri.parse(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/notifikasi/create');
    // String url =
    //     'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/notifikasi/create';
    var body = {
      "uuid_user": uuid,
      "id_sensor": idsensor,
      "min": min,
      "max": max
    };
    print("masuk api");
    print(uuid);
    print(min);
    print(max);
    return http.post(url,
        body: body, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}

class PutSetParameter {
  Future<http.Response> putsetparameter(
      String idsensor, String min, String max, String token) async {
    var url = Uri.parse(
        'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/notifikasi/update?id=$idsensor');
    // String url =
    //     'https://ydtmch9j99.execute-api.us-east-1.amazonaws.com/dev/api/notifikasi/create';
    var body = {"terkirim": "100", "min": min, "max": max};
    print("masuk api");
    print(min);
    print(max);
    return http.put(url,
        body: body, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}
