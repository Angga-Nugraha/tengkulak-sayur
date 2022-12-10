import 'package:flutter/cupertino.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tengkulak_sayur/data/models/product_cart_model.dart';
import 'package:tengkulak_sayur/data/common/utils/encrypt.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tableCart = 'Cart';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/cart.db';

    debugPrint(databasePath);

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('Your secure password'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableCart(
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT,
        price INTEGER,
        userId INTEGER,
        quantity INTEGER
      );
      ''');
  }

  Future<int> insertTocart(ProductCart product) async {
    final db = await database;
    return await db!.insert(_tableCart, product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeFromCart(ProductCart product) async {
    final db = await database;
    return await db!.delete(
      _tableCart,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<List<Map<String, dynamic>>> getListCart() async {
    final db = await database;
    final List<Map<String, dynamic>> cart = await db!.query(_tableCart);

    return cart;
  }
}

final databaseHelper = DatabaseHelper();
