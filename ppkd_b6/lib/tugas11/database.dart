import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'peserta.db');

    return await openDatabase(
      path,

      version: 2,

      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE peserta(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL,
            nomor_hp TEXT
          )
        ''');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE peserta ADD COLUMN nomor_hp TEXT');
        }
      },
    );
  }

  // CREATE
  Future<int> insertPeserta(Peserta peserta) async {
    final db = await database;
    return await db.insert('peserta', peserta.toMap());
  }

  Future<List<Peserta>> getPeserta() async {
    final db = await database;
    final result = await db.query('peserta');
    return result.map((e) => Peserta.fromMap(e)).toList();
  }

  Future<int> updatePeserta(Peserta peserta) async {
    final db = await database;
    return await db.update(
      'peserta',
      peserta.toMap(),
      where: 'id = ?',
      whereArgs: [peserta.id],
    );
  }

  Future<int> deletePeserta(int id) async {
    final db = await database;
    return await db.delete('peserta', where: 'id = ?', whereArgs: [id]);
  }
}
