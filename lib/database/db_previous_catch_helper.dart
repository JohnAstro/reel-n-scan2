import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:reel_n_scan/database/previousCatch.dart';
import 'package:sqflite/sqflite.dart';

class PreviousLogDataBaseHelper {
  late Database _db;

  initDatabase() async {
    _db = await openDatabase('assets/Previous_catch.db');
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'Previous_catch.db');

    //Check if DB exists
    var exists = await databaseExists(path);

    if (!exists) {
      print('Create a new copy from assets');

      //Check if parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      //Copy from assets
      ByteData data =
          await rootBundle.load(join("assets", "Previous_catch.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //Write and flush the bytes
      await File(path).writeAsBytes(bytes, flush: true);
    }

    //Open the database
    _db = await openDatabase(path, readOnly: true);
  }

  Future<List<PreviousCatch>> getLogs() async {
    await initDatabase();
    List<Map> list = await _db.rawQuery('SELECT * FROM Log');
    return list.map((fish) => PreviousCatch.fromJson(fish)).toList();
  }

  Future<List<PreviousCatch>> getOnlySpecies(String keyword) async {
    await initDatabase();
    List<Map> list = await _db
        .query('Log', where: 'Species LIKE ?', whereArgs: ['%$keyword%']);
    return list.map((fish) => PreviousCatch.fromJson(fish)).toList();
  }

  Future<List<PreviousCatch>> getOnlyLocation(String keyword) async {
    await initDatabase();
    List<Map> list = await _db
        .query('Log', where: 'Location LIKE ?', whereArgs: ['%$keyword%']);
    return list.map((fish) => PreviousCatch.fromJson(fish)).toList();
  }

  Future<List<PreviousCatch>> getOnlyDate(String keyword) async {
    await initDatabase();
    List<Map> list =
        await _db.query('Log', where: 'Date LIKE ?', whereArgs: ['%$keyword%']);
    return list.map((fish) => PreviousCatch.fromJson(fish)).toList();
  }

  dispose() {
    _db.close();
  }
}
