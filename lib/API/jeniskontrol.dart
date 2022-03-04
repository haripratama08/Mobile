import 'dart:convert';

Jeniskontrol jeniskontrolFromJson(String str) =>
    Jeniskontrol.fromJson(json.decode(str));

String jeniskontrolToJson(Jeniskontrol data) => json.encode(data.toJson());

class Jeniskontrol {
  Jeniskontrol({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory Jeniskontrol.fromJson(Map<String, dynamic> json) => Jeniskontrol(
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
  List<Lokasi2> lokasi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uuid: json["uuid"],
        lokasi:
            List<Lokasi2>.from(json["lokasi"].map((x) => Lokasi2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "lokasi": List<dynamic>.from(lokasi.map((x) => x.toJson())),
      };
}

class Lokasi2 {
  Lokasi2({
    this.id,
    this.nama,
    this.hub,
  });

  int id;
  String nama;
  List<Hub> hub;

  factory Lokasi2.fromJson(Map<String, dynamic> json) => Lokasi2(
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
    this.kontrol,
  });

  int id;
  String nama;
  List<Kontrol> kontrol;

  factory Alat.fromJson(Map<String, dynamic> json) => Alat(
        id: json["id"],
        nama: json["nama"],
        kontrol:
            List<Kontrol>.from(json["kontrol"].map((x) => Kontrol.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "kontrol": List<dynamic>.from(kontrol.map((x) => x.toJson())),
      };
}

class Kontrol {
  Kontrol({
    this.time,
    this.id,
    this.nama,
    this.alias,
    this.state,
    this.event,
    this.reason,
    this.idAlat,
  });

  String time;
  int id;
  String nama;
  String alias;
  String state;
  String event;
  String reason;
  int idAlat;

  factory Kontrol.fromJson(Map<String, dynamic> json) => Kontrol(
        time: json["time"],
        id: json["id"],
        nama: json["nama"],
        alias: json["alias"],
        state: json["state"],
        event: json["event"],
        reason: json["reason"] == null ? null : json["reason"],
        idAlat: json["id_alat"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "id": id,
        "nama": nama,
        "alias": alias,
        "state": state,
        "event": event,
        "reason": reason == null ? null : reason,
        "id_alat": idAlat,
      };
}
