class Login {
  Login({
    this.status,
    this.accessToken,
    this.tokenType,
    this.message,
    this.data,
  });

  String status;
  String accessToken;
  String tokenType;
  String message;
  Data data;

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
  Data({
    this.username,
    this.email,
    this.nama,
    this.uuid,
  });

  String username;
  String email;
  String nama;
  String uuid;

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

// class Data2 {
//   Data2({
//     this.status,
//     this.data,
//   });

//   String status;
//   Data3 data;

//   factory Data2.fromJson(Map<String, dynamic> json) => Data2(
//         status: json["status"],
//         data: Data3.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data.toJson(),
//       };
// }

// class Data3 {
//   Data3({
//     this.uuid,
//     this.lokasi,
//   });

//   String uuid;
//   List<Lokasi> lokasi;

//   factory Data3.fromJson(Map<String, dynamic> json) => Data3(
//         uuid: json["uuid"],
//         lokasi:
//             List<Lokasi>.from(json["lokasi"].map((x) => Lokasi.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "uuid": uuid,
//         "lokasi": List<dynamic>.from(lokasi.map((x) => x.toJson())),
//       };
// }

// class Lokasi {
//   Lokasi({
//     this.id,
//     this.nama,
//     this.hub,
//   });

//   int id;
//   String nama;
//   List<Hub> hub;

//   factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
//         id: json["id"],
//         nama: json["nama"],
//         hub: List<Hub>.from(json["hub"].map((x) => Hub.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "nama": nama,
//         "hub": List<dynamic>.from(hub.map((x) => x.toJson())),
//       };
// }

// class Hub {
//   Hub({
//     this.id,
//     this.nama,
//     this.alat,
//   });

//   int id;
//   String nama;
//   List<Alat> alat;

//   factory Hub.fromJson(Map<String, dynamic> json) => Hub(
//         id: json["id"],
//         nama: json["nama"],
//         alat: List<Alat>.from(json["alat"].map((x) => Alat.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "nama": nama,
//         "alat": List<dynamic>.from(alat.map((x) => x.toJson())),
//       };
// }

// class Alat {
//   Alat({
//     this.id,
//     this.alias,
//     this.nama,
//     this.sensor,
//   });

//   int id;
//   String nama;
//   List<Sensor> sensor;
//   String alias;

//   factory Alat.fromJson(Map<String, dynamic> json) => Alat(
//         id: json["id"],
//         nama: json["nama"],
//         sensor:
//             List<Sensor>.from(json["sensor"].map((x) => Sensor.fromJson(x))),
//         alias: json["alias"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "nama": nama,
//         "sensor": List<dynamic>.from(sensor.map((x) => x.toJson())),
//         "alias": alias,
//       };
// }

// class Sensor {
//   Sensor({
//     this.id,
//     this.jenisSensor,
//   });

//   int id;
//   JenisSensor jenisSensor;

//   factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
//         id: json["id"],
//         jenisSensor: JenisSensor.fromJson(json["jenis_sensor"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "jenis_sensor": jenisSensor.toJson(),
//       };
// }

// class JenisSensor {
//   JenisSensor({
//     this.jenis,
//   });

//   String jenis;

//   factory JenisSensor.fromJson(Map<String, dynamic> json) => JenisSensor(
//         jenis: json["jenis"],
//       );

//   Map<String, dynamic> toJson() => {
//         "jenis": jenis,
//       };
// }

// class User {
//   User({
//     this.idlokasi,
//     this.idhub,
//     this.idalat,
//     this.idsensor,
//   });

//   int idlokasi;
//   int idhub;
//   int idalat;
//   int idsensor;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         idlokasi: json["idlokasi"],
//         idhub: json["idhub"],
//         idalat: json["idalat"],
//         idsensor: json["idsensor"],
//       );

//   Map<String, dynamic> toJson() => {
//         "idlokasi": idlokasi,
//         "idhub": idhub,
//         "idalat": idalat,
//         "idsensor": idsensor,
//       };
// }

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
