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
    if (_database != null) {
      return _database;
    }

    // if not database, initialize a database and return it
    _database = await initDB();
    return _database;
  }

  // initialize method for databse
  initDB() async {
    // Get the location of our app directory. This is where files for our app,
    // and only our app, are stored. Files in this directory are deleted
    // when the app is deleted.
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'app.db');

    return await openDatabase(path, version: 1, onOpen: (db) async {},
        onCreate: (Database db, int version) async {
      // Create the user table
      await db.execute('''
                CREATE TABLE user(
                    id INTEGER PRIMARY KEY,
                    firstName TEXT DEFAULT '',
                    lastName TEXT DEFAULT '',
                    monthlyIncome REAL DEFAULT '',
                    monthlyExpense REAL DEFAULT ''
                )
            ''');
    });
  }

  insertNewUser(User user) async {
    // await for databse
    final db = await database;
    // await to insert a user into the database as JSON
    var res = await db.insert('user', user.toJson());

    return res;
  }

  getUsers() async {
    final db = await database;
    // query the database for a 'user'
    var res = await db.query('user');
    List<User> users =
        res.isNotEmpty ? res.map((user) => User.fromJson(user)).toList() : [];

    return users;
  }

  getUser(int id) async {
    final db = await database;
    var res = await db.query('user', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? User.fromJson(res.first) : null;
  }

  updateUser(User user) async {
    final db = await database;
    var res = await db
        .update('user', user.toJson(), where: 'id = ?', whereArgs: [user.id]);

    return res;
  }

  deleteUser(int id) async {
    final db = await database;

    db.delete('user', where: 'id = ?', whereArgs: [id]);
  }
}
