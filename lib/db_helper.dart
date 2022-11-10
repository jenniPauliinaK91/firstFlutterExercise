import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'package:mobiili1/shoe.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, 'shoes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shoes(
          id INTEGER PRIMARY KEY,
          name TEXT,
          date TEXT,
          kms INTEGER
      )
      ''');
  }

  Future<List<Shoe>> getShoes() async {
    Database db = await instance.database;
    var shoes = await db.query('shoes', orderBy: 'name');
    List<Shoe> shoeList =
        shoes.isNotEmpty ? shoes.map((s) => Shoe.fromMap(s)).toList() : [];
    return shoeList;
  }

  Future<int> add(Shoe shoe) async {
    Database db = await instance.database;
    return await db.insert('shoes', shoe.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('shoes', where: 'id=?', whereArgs: [id]);
  }

  Future<int> update(Shoe shoe) async {
    Database db = await instance.database;
    return await db
        .update('shoes', shoe.toMap(), where: 'id=?', whereArgs: [shoe.id]);
  }
}
