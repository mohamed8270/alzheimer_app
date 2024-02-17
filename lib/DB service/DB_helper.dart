// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper extends GetxController {
  static final DatabaseHelper instance = DatabaseHelper();
  static Database? _database;
  DatabaseHelper();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initdatabase();
    return _database!;
  }

  Future<Database> _initdatabase() async {
    Directory data_directory = await getApplicationDocumentsDirectory();
    print('DB Location:' + data_directory.path);
    final String path = join(await getDatabasesPath(), 'reminder_file.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _CreateDatabase,
    );
  }

  Future<void> _CreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE reminder_table (
        id INTEGER PRIMARY KEY,
        name TEXT,
        relation TEXT,
        place TEXT,
        phonenumber TEXT,
        address TEXT
      )
    ''');
  }

  Future<int> insertdetail(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('reminder_table', row);
  }

  Future<List<Map<String, dynamic>>> getalldetails() async {
    Database db = await instance.database;
    return await db.query('reminder_table');
  }

  Future<int> updatedetails(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db
        .update('reminder_table', row, where: 'id=?', whereArgs: [id]);
  }

  Future<int> deletedetails(int id) async {
    Database db = await instance.database;
    return await db.delete('reminder_table', where: 'id=?', whereArgs: [id]);
  }
}
