import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // database info
  static final _databaseName = "database.db";
  static final _databaseVersion = 1;

  // income table
  static final tableIncome = 'income';

  static final incomeColumnId = '_id';
  static final incomeColumnIncomeAmount = 'incomeAmount';

  // expense table
  static final tableExpense = 'expense';

  static final expenseColumnId = '_id';
  static final expenseColumnExpenseAmount = 'expenseAmount';
  static final expenseColumnDescription = 'description';
  static final expenseColumnCategory = 'category';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableIncome (
            $incomeColumnId INTEGER PRIMARY KEY,
            $incomeColumnIncomeAmount REAL NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableExpense (
            $expenseColumnId INTEGER PRIMARY KEY,
            $expenseColumnExpenseAmount REAL NOT NULL,
            $expenseColumnDescription TEXT NOT NULL,
            $expenseColumnCategory TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['_id'];
    return await db.update(tableName, row, where: '_id = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String tableName, int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '_id = ?', whereArgs: [id]);
  }
}
