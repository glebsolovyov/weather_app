import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/city.dart';
import '../models/user.dart';

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
    print(documentsDirectory);
    String path = join(documentsDirectory.path, "weather_app.sqlite");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE User("
          "id INTEGER PRIMARY KEY,"
          "email TEXT,"
          "password TEXT,"
          "name TEXT,"
          "surname TEXT,"
          "isLogin INTEGER);");
      await db.execute("CREATE TABLE City ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "isSelected INTEGER,"
          "userId INTEGER,"
          "FOREIGN KEY (userId) REFERENCES User (id));");
    });
  }

  newCity(String name) async {
    final db = await database;

    var table = await db?.rawQuery("SELECT MAX(id)+1 as id FROM City");
    Object? id = table!.first["id"];
    Object? isSelected = 0;
    var loginUser = await getLoginUser();
    var raw = await db!.rawInsert(
        "INSERT Into City (id,name,isSelected,userId)"
        " VALUES (?,?,?,?)",
        [id, name, isSelected, loginUser.id]);
    return raw;
  }

  Future<List<City>> getAllCities() async {
    final db = await database;
    var loginUser = await getLoginUser();
    var res =
        await db?.query("City", where: "userId = ?", whereArgs: [loginUser.id]);
    List<City> list =
        res!.isNotEmpty ? res.map((c) => City.fromJson(c)).toList() : [];
    return list;
  }

  Future<bool> isContainsCity(String cityName) async {
    final db = await database;

    var loginUser = await getLoginUser();
    var res =
        await db?.query("City", where: "userId = ?", whereArgs: [loginUser.id]);
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
    var loginUser = await getLoginUser();

    var res =
        await db?.query("City", where: "userId = ?", whereArgs: [loginUser.id]);
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
    var loginUser = await getLoginUser();

    var res = await db?.query("City",
        where: "isSelected = ? AND userId = ?", whereArgs: [1, loginUser.id]);
    return res!.isNotEmpty ? City.fromJson(res.first) : null;
  }

  setSelected(City city) async {
    final db = await database;

    var lastSelectedCity = await getSelectedCity();

    if (lastSelectedCity != null) {
      City lastSelected = City(
          id: lastSelectedCity.id, name: lastSelectedCity.name, isSelected: 0);

      await db!.update("City", lastSelected.toJson(),
          where: "id = ?", whereArgs: [lastSelected.id]);
    }
    City selected = City(id: city.id, name: city.name, isSelected: 1);
    var res = await db!.update("City", selected.toJson(),
        where: "id = ?", whereArgs: [city.id]);
    return res;
  }

  Future<bool> isCitySelected(City city) async {
    if (city.isSelected == 1) return true;
    return false;
  }

  deleteCity(int id) async {
    final db = await database;
    return db!.delete("City", where: "id = ?", whereArgs: [id]);
  }

  newUser(String email, String password, String name, String surname) async {
    final db = await database;

    var table = await db?.rawQuery("SELECT MAX(id)+1 as id FROM User");
    Object? id = table!.first["id"];
    Object? isLogin = 1;

    var raw = await db!.rawInsert(
        "INSERT Into User (id,email,password,name,surname,isLogin)"
        "VALUES (?,?,?,?,?,?)",
        [id, email, password, name, surname, isLogin]);

    return raw;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;

    var res = await db!.query("User");
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];

    return list;
  }

  Future<bool> isUserExist(String email) async {
    var usersList = await getAllUsers();
    if (usersList != []) {
      for (var user in usersList) {
        if (user.email == email) {
          return true;
        }
      }
    }
    return false;
  }

  getUserByEmail(String email) async {
    var usersList = await getAllUsers();

    if (usersList != []) {
      for (var user in usersList) {
        if (user.email == email) {
          return user;
        }
      }
    }
    return null;
  }

  loginUser(User user) async {
    final db = await database;
    User login = User(
        id: user.id,
        email: user.email, 
        password: user.password, 
        name: user.name, 
        surname: user.surname, 
        isLogin: 1);

    var res = await db!
        .update("User", login.toJson(), where: "id = ?", whereArgs: [user.id]);
    return res;
  }

  Future<User> getLoginUser() async {
    var usersList = await getAllUsers();
    late User loginUser;
    for (var user in usersList) {
      if (user.isLogin == 1) {
        loginUser = user;
      }
    }
    return loginUser;
  }

  logoutUser() async {
    final db = await database;
    var user = await getLoginUser();

    User logoutUser = User(
      id: user.id,
      email: user.email,
      password: user.password,
      name: user.name,
      surname: user.surname,
      isLogin: 0
    );

    await db!.update("User", logoutUser.toJson(), where: "id = ?", whereArgs: [user.id]);
  }
} 
