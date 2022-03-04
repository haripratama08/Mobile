
import 'dart:convert';

Grafik grafikFromJson(String str) => Grafik.fromJson(json.decode(str));

String grafikToJson(Grafik data) => json.encode(data.toJson());

class Grafik {
  Grafik({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory Grafik.fromJson(Map<String, dynamic> json) => Grafik(
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
    this.info,
    this.sensor,
  });

  Info info;
  Sensor sensor;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        info: Info.fromJson(json["info"]),
        sensor: Sensor.fromJson(json["sensor"]),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "sensor": sensor.toJson(),
      };
}

class Info {
  Info({
    this.lokasi,
    this.hub,
    this.alat,
  });

  Lokasi lokasi;
  Alat hub;
  Alat alat;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        lokasi: Lokasi.fromJson(json["lokasi"]),
        hub: Alat.fromJson(json["hub"]),
        alat: Alat.fromJson(json["alat"]),
      );

  Map<String, dynamic> toJson() => {
        "lokasi": lokasi.toJson(),
        "hub": hub.toJson(),
        "alat": alat.toJson(),
      };
}

class Alat {
  Alat({
    this.id,
    this.nama,
    this.alias,
  });

  int id;
  String nama;
  String alias;

  factory Alat.fromJson(Map<String, dynamic> json) => Alat(
        id: json["id"],
        nama: json["nama"],
        alias: json["alias"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alias": alias,
      };
}

class Lokasi {
  Lokasi({
    this.id,
    this.nama,
  });

  int id;
  String nama;

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}

class Sensor {
  Sensor({
    this.idSensor,
    this.satuan,
    this.jenisSensor,
    this.ikon,
    this.min,
    this.max,
    this.mean,
    this.dataRaw,
  });

  num idSensor;
  dynamic satuan;
  String jenisSensor;
  String ikon;
  num min;
  num max;
  num mean;
  List<DataRaw> dataRaw;

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
        idSensor: json["id_sensor"],
        satuan: json["satuan"],
        jenisSensor: json["jenis_sensor"],
        ikon: json["ikon"],
        min: json["min"],
        max: json["max"].toDouble(),
        mean: json["mean"].toDouble(),
        dataRaw: List<DataRaw>.from(
            json["data_raw"].map((x) => DataRaw.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_sensor": idSensor,
        "satuan": satuan,
        "jenis_sensor": jenisSensor,
        "ikon": ikon,
        "min": min,
        "max": max,
        "mean": mean,
        "data_raw": List<dynamic>.from(dataRaw.map((x) => x.toJson())),
      };
}

class DataRaw {
  DataRaw({
    this.tanggalSensor,
    this.tanggalUpdate,
    this.id,
    this.nilai,
  });

  String tanggalSensor;
  String tanggalUpdate;
  num id;
  num nilai;

  factory DataRaw.fromJson(Map<String, dynamic> json) => DataRaw(
        tanggalSensor: json["tanggal_sensor"],
        tanggalUpdate: json["tanggal_update"],
        id: json["id"],
        nilai: json["nilai"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_sensor": tanggalSensor,
        "tanggal_update": tanggalUpdate,
        "id": id,
        "nilai": nilai,
      };
}
