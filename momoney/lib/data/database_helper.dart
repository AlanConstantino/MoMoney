import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // database info
  static final _databaseName = "data.db";
  static final _databaseVersion = 1;

  // income table
  static final tableIncome = 'income';

  static final incomeColumnId = '_id';
  static final incomeColumnIncomeAmount = 'incomeAmount';
  static final incomeColumnDateAdded = 'dateAdded';

  // expense table
  static final tableExpense = 'expense';

  static final expenseColumnId = '_id';
  static final expenseColumnExpenseAmount = 'expenseAmount';
  static final expenseColumnDescription = 'description';
  static final expenseColumnCategory = 'category';
  static final expenseColumnDateAdded = 'dateAdded';

  // singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (creates database if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // uncomment the following line to delete all the .db files in the documentsDirectory

    // documentsDirectory.deleteSync(recursive: true);

    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableIncome (
            $incomeColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $incomeColumnIncomeAmount REAL NOT NULL,
            $incomeColumnDateAdded TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableExpense (
            $expenseColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $expenseColumnExpenseAmount REAL NOT NULL,
            $expenseColumnDescription TEXT NOT NULL,
            $expenseColumnCategory TEXT NOT NULL,
            $expenseColumnDateAdded TEXT NOT NULL
          )
          ''');
  }

  // Inserts a row in the database
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // All of the rows are returned as a list of maps in descending order
  Future<List<Map<String, dynamic>>> queryAllRowsByDescending(String tableName) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $tableName ORDER BY _id DESC');
  }

  // A raw query to give the row count
  Future<int> queryRowCount(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // Update an item in the database
  Future<int> update(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['_id'];
    return await db.update(tableName, row, where: '_id = ?', whereArgs: [id]);
  }

  // Deletes a row specified by the id
  Future<int> delete(String tableName, int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '_id = ?', whereArgs: [id]);
  }

  // Deletes all the rows from the specified tableName.
  Future<int> deleteAllRows(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('DELETE FROM $tableName'));
  }
}
