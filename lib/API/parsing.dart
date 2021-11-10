import 'dart:convert';
import 'package:ch_v2_1/Menu/Kontrol/kontrol_utama.dart';

class Login {
  String status;
  String accessToken;
  String tokenType;
  String message;
  Data data;
  Login({
    this.status,
    this.accessToken,
    this.tokenType,
    this.message,
    this.data,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: json["status"],
        accessToken: json["accessToken"],
        tokenType: json["tokenType"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "accessToken": accessToken,
        "tokenType": tokenType,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String username;
  String email;
  String nama;
  String uuid;

  Data({
    this.username,
    this.email,
    this.nama,
    this.uuid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        email: json["email"],
        nama: json["nama"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "nama": nama,
        "uuid": uuid,
      };
}

class Data2 {
  Data2({
    this.status,
    this.data,
  });

  String status;
  Data3 data;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        status: json["status"],
        data: Data3.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data3 {
  Data3({
    this.uuid,
    this.lokasi,
  });

  String uuid;
  List<Lokasi> lokasi;

  factory Data3.fromJson(Map<String, dynamic> json) => Data3(
        uuid: json["uuid"],
        lokasi:
            List<Lokasi>.from(json["lokasi"].map((x) => Lokasi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "lokasi": List<dynamic>.from(lokasi.map((x) => x.toJson())),
      };
}

class Lokasi {
  Lokasi({
    this.id,
    this.nama,
    this.hub,
  });

  int id;
  String nama;
  List<Hub> hub;

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        id: json["id"],
        nama: json["nama"],
        hub: List<Hub>.from(json["hub"].map((x) => Hub.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "hub": List<dynamic>.from(hub.map((x) => x.toJson())),
      };
}

class Hub {
  Hub({
    this.id,
    this.nama,
    this.alat,
  });

  int id;
  String nama;
  List<Alat> alat;

  factory Hub.fromJson(Map<String, dynamic> json) => Hub(
        id: json["id"],
        nama: json["nama"],
        alat: List<Alat>.from(json["alat"].map((x) => Alat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alat": List<dynamic>.from(alat.map((x) => x.toJson())),
      };
}

class Alat {
  Alat({
    this.id,
    this.nama,
    this.alias,
    this.sensor,
  });

  int id;
  String nama;
  String alias;
  List<Sensor> sensor;

  factory Alat.fromJson(Map<String, dynamic> json) => Alat(
        id: json["id"],
        nama: json["nama"],
        alias: json["alias"],
        sensor:
            List<Sensor>.from(json["sensor"].map((x) => Sensor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alias": alias,
        "sensor": List<dynamic>.from(sensor.map((x) => x.toJson())),
      };
}

class Sensor {
  Sensor({
    this.id,
    this.jenisSensor,
  });

  int id;
  JenisSensor jenisSensor;

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
        id: json["id"],
        jenisSensor: JenisSensor.fromJson(json["jenis_sensor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_sensor": jenisSensor.toJson(),
      };
}

class JenisSensor {
  JenisSensor({
    this.jenis,
  });

  String jenis;

  factory JenisSensor.fromJson(Map<String, dynamic> json) => JenisSensor(
        jenis: json["jenis"],
      );

  Map<String, dynamic> toJson() => {
        "jenis": jenis,
      };
}

class SmartTimer {
  int _id;
  String _name;
  String _time;
  String _state;

  // konstruktor versi 1
  SmartTimer(this._name, this._state, this._time);

  // konstruktor versi 2: konversi dari Map ke Contact
  SmartTimer.fromMap(Map<String, dynamic> map) {
    print("id $_id");
    print("name $_name");
    print("$_time");
    this._id = map['id'];
    this._name = map['name'];
    this._time = map['time'];
    this._state = map['state'];
  }
  // //getter dan setter (mengambil dan mengisi data kedalam object)
  // // getter
  // int get id => _id;
  // String get name => _name;
  // String get time => _time;
  // String get state => _state;

  // setter
  set name(String value) {
    _name = value;
  }

  set time(String value) {
    _time = value;
  }

  set state(String value) {
    state = value;
  }

  // konversi dari Contact ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = this._name;
    map['time'] = this._time;
    map['state'] = this._state;
    return map;
  }
}

class Alat2 {
  Alat2({
    this.status,
    this.data,
  });

  String status;
  Data10 data;

  factory Alat2.fromJson(Map<String, dynamic> json) => Alat2(
        status: json["status"],
        data: Data10.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data10 {
  Data10({
    this.info,
    this.data10,
  });

  Info info;
  List<Datum> data10;

  factory Data10.fromJson(Map<String, dynamic> json) => Data10(
        info: Info.fromJson(json["info"]),
        data10: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "data": List<Datum>.from(data10.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.jenis,
    this.data,
    this.min,
    this.max,
    this.mean,
    this.tanggalSensor,
    this.tanggalUpdate,
  });

  int id;
  String jenis;
  double data;
  double min;
  double max;
  double mean;
  String tanggalSensor;
  String tanggalUpdate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        jenis: json["jenis"],
        data: json["data"].toDouble(),
        min: json["min"].toDouble(),
        max: json["max"].toDouble(),
        mean: json["mean"].toDouble(),
        tanggalSensor: json["tanggal_sensor"],
        tanggalUpdate: json["tanggal_update"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis": jenis,
        "data": data,
        "min": min,
        "max": max,
        "mean": mean,
        "tanggal_sensor": tanggalSensor,
        "tanggal_update": tanggalUpdate,
      };
}

class Info {
  Info({
    this.lokasi,
    this.hub,
    this.alat,
  });

  Alat lokasi;
  Alat hub;
  Alat alat;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        lokasi: Alat.fromJson(json["lokasi"]),
        hub: Alat.fromJson(json["hub"]),
        alat: Alat.fromJson(json["alat"]),
      );

  Map<String, dynamic> toJson() => {
        "lokasi": lokasi.toJson(),
        "hub": hub.toJson(),
        "alat": alat.toJson(),
      };
}

class Alat3 {
  Alat3({
    this.id,
    this.nama,
  });

  int id;
  String nama;

  factory Alat3.fromJson(Map<String, dynamic> json) => Alat3(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}

List<Looping> loopingFromJson(String str) =>
    List<Looping>.from(json.decode(str).map((x) => Looping.fromJson(x)));
String loopingToJson(List<Looping> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Looping {
  Looping({
    this.idlokasi,
    this.idhub,
    this.idalat,
    this.nama,
  });

  int idlokasi;
  int idhub;
  int idalat;
  String nama;

  factory Looping.fromJson(Map<String, dynamic> json) => Looping(
        idlokasi: json["idlokasi"],
        idhub: json["idhub"],
        idalat: json["idalat"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "idlokasi": idlokasi,
        "idhub": idhub,
        "idalat": idalat,
        "nama": nama,
      };
}

class Loop {
  Loop({
    this.idsensor,
    this.nama,
  });

  int idsensor;
  String nama;

  factory Loop.fromJson(Map<String, dynamic> json) => Loop(
        idsensor: json["idsensor"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "idsensor": idsensor,
        "nama": nama,
      };
}

class Repository {
  List<Map> getAll() => trial;

  getidlokasibynama(String nama) => trial
      .map((map) => Looping.fromJson(map))
      .where((item) => item.nama == nama)
      .map((item) => item.idlokasi)
      .toList();

  getidhubbynama(String nama) => trial
      .map((map) => Looping.fromJson(map))
      .where((item) => item.nama == nama)
      .map((item) => item.idhub)
      .toList();

  getidalatbynama(String nama) => trial
      .map((map) => Looping.fromJson(map))
      .where((item) => item.nama == nama)
      .map((item) => item.idalat)
      .toList();

  List<String> getnama() => trial
      .map((map) => Looping.fromJson(map))
      .map((item) => item.nama)
      .toList();
}

class RepositorySensor {
  List<Map> getAll() => listsensors;

  getidsensorbynama(String nama) => listsensors
      .map((map) => Loop.fromJson(map))
      .where((item) => item.nama == nama)
      .map((item) => item.idsensor)
      .toList();

  List<String> getnama() => listsensors
      .map((map) => Loop.fromJson(map))
      .map((item) => item.nama)
      .toList();
}
