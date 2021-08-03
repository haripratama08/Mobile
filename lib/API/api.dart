import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

String endPoint =

    //development
    'https://ep5iozludi.execute-api.ap-southeast-1.amazonaws.com/dev/api';

//production
// 'https://hx7jt0d4pd.execute-api.ap-southeast-1.amazonaws.com/v1/api';

//download
// 'https://1a47p0lyxl.execute-api.ap-southeast-1.amazonaws.com/v1';

class ApiLogin {
  Future<http.Response> doLogin(String username, String password) async {
    var url = Uri.parse('$endPoint/user/login');
    var body = {"username": username, "password": password};
    return http.post(url, body: body);
  }
}

class Gantinotif {
  Future<http.Response> gantinotif(int sets, int idsensor, String token) async {
    var url =
        Uri.parse('$endPoint/sensor/notifikasi?set=$sets&id_sensor=$idsensor');
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
    var url = Uri.parse('$endPoint/notifikasi/create');
    var body = {
      "uuid_user": uuid,
      "id_sensor": idsensor,
      "min": min,
      "max": max
    };
    return http.post(url,
        body: body, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}

class PutSetParameter {
  Future<http.Response> putsetparameter(
      String idsensor, String min, String max, String token) async {
    var url = Uri.parse('$endPoint/notifikasi/update?id=$idsensor');
    var body = {"terkirim": "100", "min": min, "max": max};
    return http.put(url,
        body: body, headers: {HttpHeaders.authorizationHeader: '$token'});
  }
}
