import 'package:ch_v2_1/API/parsing.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
//mendukug pemrograman asinkron
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//bekerja pada file dan directory

//pubspec.yml

//kelass Dbhelper
class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'timer.db';

    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama contact
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE timer (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        time DATETIME,
        state TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('timer', orderBy: 'name');
    return mapList;
  }

//create databases
  Future<int> insert(SmartTimer object) async {
    Database db = await this.database;
    int count = await db.insert('timer', object.toMap());
    print(count);
    return count;
  }

//update databases
  Future<int> update(SmartTimer object) async {
    Database db = await this.database;
    int count = await db
        .update('timer', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('timer', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<SmartTimer>> getContactList() async {
    var timerlist = await select();
    int count = timerlist.length;
    List<SmartTimer> timerList = [];
    for (int i = 0; i < count; i++) {
      timerList.add(SmartTimer.fromMap(timerlist[i]));
    }
    return timerList;
  }
}
