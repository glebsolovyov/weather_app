import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/city.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        "/Users/glebsolovyov/flutter_projects/weather_app/weather_app.sqlite");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE City ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "isSelected INTEGER)");
    });
  }

  newCity(String name) async {
    final db = await database;

    var table = await db?.rawQuery("SELECT MAX(id)+1 as id FROM City");
    Object? id = table!.first["id"];
    Object? isSelected = 0;
    //insert to the table using the new id
    var raw = await db!.rawInsert(
        "INSERT Into City (id,name,isSelected)"
        " VALUES (?,?,?)",
        [id, name, isSelected]);
    return raw;
  }

  Future<List<City>> getAllCities() async {
    final db = await database;
    var res = await db?.query("City");
    List<City> list =
        res!.isNotEmpty ? res.map((c) => City.fromJson(c)).toList() : [];
    return list;
  }

  Future<bool> isContainsCity(String cityName) async {
    final db = await database;
    var res = await db?.query("City");
    if (res!.isNotEmpty) {
      for (var item in res) {
        String name = item["name"]!.toString().toLowerCase();
        if (name == cityName.toLowerCase()) {
          return true;
        }
      }
    }
    return false;
  }

  Future<int> getCityIdByName(String cityName) async {
    final db = await database;
    var res = await db?.query("City");
    if (res!.isNotEmpty) {
      for (var item in res) {
        String name = item["name"]!.toString().toLowerCase();
        if (name == cityName.toLowerCase()) {
          return int.parse(item["id"].toString());
        }
      }
    }
    return 0;
  }

  Future<City?> getSelectedCity() async {
    final db = await database;
    var res = await db?.query("City", where: "isSelected = ?", whereArgs: [1]);
    return res!.isNotEmpty ? City.fromJson(res.first) : null;
  }

  deleteCity(int id) async {
    final db = await database;
    return db!.delete("City", where: "id = ?", whereArgs: [id]);
  }
}
