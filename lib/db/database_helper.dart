import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';

class DatabaseHelper {
  static const _databaseName = 'books_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'books';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance =
  DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        authors TEXT NOT NULL,
        publisher TEXT,
        publishedDate TEXT,
        description TEXT,
        pageCount INTEGER,
        language TEXT,
        imageLinks TEXT,
        previewLink TEXT,
        infoLink TEXT,
        isFavourite INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insert(Book book) async {
    final db = await database;
    return await db.insert(
      _tableName,
      book.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> readAllBooks() async {
    final db = await database;
    final result = await db.query(_tableName);
    return result.map((json) => Book.fromJson(json)).toList();
  }

  Future<List<Book>> readFavouriteBooks() async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'isFavourite = ?',
      whereArgs: [1],
    );
    return result.map((json) => Book.fromJson(json)).toList();
  }

  Future<int> markAsFavourite(String id) async {
    final db = await database;
    return await db.update(
      _tableName,
      {'isFavourite': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
