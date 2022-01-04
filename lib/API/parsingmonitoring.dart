import 'dart:convert';

MonitoringParse monitoringParseFromJson(String str) =>
    MonitoringParse.fromJson(json.decode(str));

String monitoringParseToJson(MonitoringParse data) =>
    json.encode(data.toJson());

class MonitoringParse {
  MonitoringParse({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory MonitoringParse.fromJson(Map<String, dynamic> json) =>
      MonitoringParse(
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
    this.data,
  });

  Info info;
  List<DataDatum> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        info: Info.fromJson(json["info"]),
        data: List<DataDatum>.from(
            json["data"].map((x) => DataDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataDatum {
  DataDatum({
    this.id,
    this.allowNotifikasi,
    this.satuan,
    this.jenisSensor,
    this.data,
  });

  int id;
  int allowNotifikasi;
  String satuan;
  JenisSensor jenisSensor;
  List<DatumDatum> data;

  factory DataDatum.fromJson(Map<String, dynamic> json) => DataDatum(
        id: json["id"],
        allowNotifikasi: json["allow_notifikasi"],
        satuan: json["satuan"] == null ? null : json["satuan"],
        jenisSensor: JenisSensor.fromJson(json["jenis_sensor"]),
        data: List<DatumDatum>.from(
            json["data"].map((x) => DatumDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "allow_notifikasi": allowNotifikasi,
        "satuan": satuan == null ? null : satuan,
        "jenis_sensor": jenisSensor.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumDatum {
  DatumDatum({
    this.tanggalSensor,
    this.tanggalUpdate,
    this.nilai,
  });

  String tanggalSensor;
  String tanggalUpdate;
  double nilai;

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
        tanggalSensor: json["tanggal_sensor"],
        tanggalUpdate: json["tanggal_update"],
        nilai: json["nilai"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "tanggal_sensor": tanggalSensor,
        "tanggal_update": tanggalUpdate,
        "nilai": nilai,
      };
}

class JenisSensor {
  JenisSensor({
    this.jenis,
    this.ikon,
  });

  String jenis;
  dynamic ikon;

  factory JenisSensor.fromJson(Map<String, dynamic> json) => JenisSensor(
        jenis: json["jenis"],
        ikon: json["ikon"],
      );

  Map<String, dynamic> toJson() => {
        "jenis": jenis,
        "ikon": ikon,
      };
}

class Info {
  Info({
    this.namaLokasi,
    this.namaHub,
    this.namaAlat,
  });

  String namaLokasi;
  String namaHub;
  String namaAlat;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        namaLokasi: json["nama_lokasi"],
        namaHub: json["nama_hub"],
        namaAlat: json["nama_alat"],
      );

  Map<String, dynamic> toJson() => {
        "nama_lokasi": namaLokasi,
        "nama_hub": namaHub,
        "nama_alat": namaAlat,
      };
}
