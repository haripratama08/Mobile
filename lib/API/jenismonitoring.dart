import 'dart:convert';

Jenismonitoring jenismonitoringFromJson(String str) =>
    Jenismonitoring.fromJson(json.decode(str));

String jenismonitoringToJson(Jenismonitoring data) =>
    json.encode(data.toJson());

class Jenismonitoring {
  Jenismonitoring({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory Jenismonitoring.fromJson(Map<String, dynamic> json) =>
      Jenismonitoring(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.uuid,
    this.lokasi,
  });

  String uuid;
  List<Lokasi> lokasi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    this.alias,
    this.alat,
  });

  int id;
  String nama;
  String alias;
  List<Alat> alat;

  factory Hub.fromJson(Map<String, dynamic> json) => Hub(
        id: json["id"],
        nama: json["nama"],
        alias: json["alias"],
        alat: List<Alat>.from(json["alat"].map((x) => Alat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alias": alias,
        "alat": List<dynamic>.from(alat.map((x) => x.toJson())),
      };
}

class Alat {
  Alat({
    this.id,
    this.nama,
    this.alias,
    this.event,
    this.time,
    this.reason,
    this.sensor,
  });

  int id;
  String nama;
  String alias;
  String event;
  String time;
  String reason;
  List<Sensor> sensor;

  factory Alat.fromJson(Map<String, dynamic> json) => Alat(
        id: json["id"],
        nama: json["nama"],
        alias: json["alias"],
        event: json["event"],
        time: json["time"],
        reason: json["reason"],
        sensor:
            List<Sensor>.from(json["sensor"].map((x) => Sensor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alias": alias,
        "event": event,
        "time": time,
        "reason": reason,
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
