// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider db = DBProvider();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, 'DB.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) async {
    // await db.execute('''
    // CREATE TABLE IF NOT EXISTS taskTable (
    //   tasks INT)
    // ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS deskTable (
      newTime TEXT,
      title TEXT,
      slot TEXT,
      bgColor TEXT,
      tlColor TEXT,
      chap TEXT)
    ''');

        await db.execute('''
    CREATE TABLE IF NOT EXISTS taskTable (
      iconData INT,
      title TEXT,
      bgColor TEXT,
      iconColor TEXT,
      btnColor TEXT,
      left INT,
      done INT,
      isLast INT NOT NULL)
    ''');
  }

  // void addTask(Database db, int i) async {
  //   await db.execute('''
  //   CREATE TABLE IF NOT EXISTS taskTable$i (
  //     id TEXT,
  //     iconData INT,
  //     title TEXT,
  //     bgColor TEXT,
  //     iconColor TEXT,
  //     btnColor TEXT,
  //     left INT,
  //     done INT,
  //     isLast INT NOT NULL)
  //   ''');

  //   await db.execute('''
  //   CREATE TABLE IF NOT EXISTS deskTable$i (
  //     id TEXT,
  //     newTime TEXT,
  //     title TEXT,
  //     slot TEXT,
  //     bgColor TEXT,
  //     tlColor TEXT,
  //     chap TEXT)
  //   ''');
  // }
}
