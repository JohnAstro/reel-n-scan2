// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:reel_n_scan/database/fish.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseService {
//   late Database _db;

//   initDatabase() async {
//     _db = await openDatabase('assets/fishes.db');
//     var databasePath = await getDatabasesPath();
//     var path = join(databasePath, 'fishes.db');

//     //Check if DB exists
//     var exists = await databaseExists(path);

//     if (!exists) {
//       print('Create a new copy from assets');

//       //Check if parent directory exists
//       try {
//         await Directory(dirname(path)).create(recursive: true);
//       } catch (_) {}

//       //Copy from assets
//       ByteData data = await rootBundle.load(join("assets", "fishes.db"));
//       List<int> bytes =
//           data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

//       //Write and flush the bytes
//       await File(path).writeAsBytes(bytes, flush: true);
//     }

//     //Open the database
//     _db = await openDatabase(path, readOnly: true);
//   }

//   Future<List<Fish>> getFishes() async {
//     await initDatabase();
//     List<Map> list = await _db.rawQuery('SELECT * FROM Fishes');
//     return list.map((fish) => Fish.fromJson(fish)).toList();
//   }
//   Future<List<Fish>> searchFishes(String keyword) async {
//     await initDatabase();
//     List<Map> list = await _db.query('fishes', where: 'name LIKE ?', whereArgs: ['%$keyword%']);
//     return list.map((fish) => Fish.fromJson(fish)).toList();
//   }

//   dispose() {
//     _db.close();
//   }
// }
