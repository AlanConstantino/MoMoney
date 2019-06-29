import 'dart:io';

import 'package:momoney/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  // Create a singleton
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    // if there is an already existing database return the database
    // if (_database != null) {
    //   return _database;
    // }

    // if not database, initialize a database and return it
    _database = await _initDB();
    return _database;
  }

  // initialize method for databse
  _initDB() async {
    // Get the location of our app directory. This is where files for our app,
    // and only our app, are stored. Files in this directory are deleted
    // when the app is deleted.
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'user.db');

    return await openDatabase(path, version: 1, onOpen: (db) async {},
        onCreate: (Database db, int version) async {
      // Create the user table

      await db.execute('''
                CREATE TABLE user(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    firstName TEXT DEFAULT '',
                    lastName TEXT DEFAULT '',
                    goalTitle TEXT DEFAULT '',
                    goalAmount REAL DEFAULT NOT NULL,
                    monthlyIncome REAL DEFAULT NOT NULL,
                    monthlyExpense REAL DEFAULT NOT NULL
                )
            ''');
    });
  }

  addUserToDatabase(User user) async {
    final db = await database;
    var res = await db.insert('user', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return res;
  }

  updateUser(User user) async {
    final db = await database;
    var response = await db
        .update("user", user.toMap(), where: "id = ?", whereArgs: [user.id]);
    return response;
  }

  Future<User> getUserWithId(int id) async {
    final db = await database;
    var response = await db.query("user", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? User.fromMap(response.first) : null;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    var response = await db.query("user");
    List<User> list = response.map((c) => User.fromMap(c)).toList();
    return list;
  }

  deleteUserWithId(int id) async {
    final db = await database;
    return db.delete("user", where: "id = ?", whereArgs: [id]);
  }

  deleteAllUsers() async {
    final db = await database;
    db.delete("user");
  }
}
