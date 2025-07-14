import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/learning_path_model.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'periodic_table.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE learning_paths (
            id INTEGER PRIMARY KEY,
            isCompleted INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE quiz_scores (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            score INTEGER
          )
        ''');
      },
    );
  }

  Future<List<LearningPathModel>> getLearningPaths() async {
    final db = await database;
    final maps = await db.query('learning_paths');
    return maps
        .map((map) => LearningPathModel(
              id: map['id'] as int,
              title: '',
              description: '',
              isCompleted: (map['isCompleted'] as int) == 1,
            ))
        .toList();
  }

  Future<void> updateLearningPathProgress(int id, bool isCompleted) async {
    final db = await database;
    await db.insert(
      'learning_paths',
      {'id': id, 'isCompleted': isCompleted ? 1 : 0},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> saveQuizScore(int score) async {
    final db = await database;
    await db.insert(
      'quiz_scores',
      {'score': score},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<int>> getQuizScores() async {
    final db = await database;
    final maps = await db.query('quiz_scores');
    return maps.map((map) => map['score'] as int).toList();
  }
}
