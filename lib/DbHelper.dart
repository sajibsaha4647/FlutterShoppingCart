import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter_shopping_cart/Cartmodel.dart';

class BdHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "cart.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  // .execute('CREATE TABLE cart (id INTEGER PRIMARY KEY ,
  //                productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER,
  //                  productPrice INTEGER , quantity INTEGER, unitTag TEXT , image TEXT )');

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, initialPrice INTEGER,productPrice INTEGER, quantity INTEGER,unitTag TEXT, image TEXT)');
  }
}