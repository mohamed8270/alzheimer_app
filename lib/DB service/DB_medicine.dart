// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper2 extends GetxController {
  static final DatabaseHelper2 instance = DatabaseHelper2();
  static Database? _database2;
  DatabaseHelper2();

  Future<Database> get database2 async {
    if (_database2 != null) return _database2!;

    _database2 = await _initdatabase();
    return _database2!;
  }

  Future<Database> _initdatabase() async {
    Directory data_directory = await getApplicationDocumentsDirectory();
    print('DB Location:' + data_directory.path);
    final String path = join(await getDatabasesPath(), 'medicine_file.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _CreateDatabase,
    );
  }

  Future<void> _CreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medicine_table (
        id INTEGER PRIMARY KEY,
        medicinename TEXT,
        medicinetype TEXT,
        medicinedose TEXT,
        medicinedatetime TEXT
      )
    ''');
  }

  Future<int> insertmedicine(Map<String, dynamic> row) async {
    Database db = await instance.database2;
    return await db.insert('medicine_table', row);
  }

  Future<List<Map<String, dynamic>>> getallmedicine() async {
    Database db = await instance.database2;
    return await db.query('medicine_table');
  }

  Future<int> updatemedicine(Map<String, dynamic> row) async {
    Database db = await instance.database2;
    int id = row['id'];
    return await db
        .update('medicine_table', row, where: 'id=?', whereArgs: [id]);
  }

  Future<int> deletemedicine(int id) async {
    Database db = await instance.database2;

    return await db.delete('medicine_table', where: 'id=?', whereArgs: [id]);
  }
}
