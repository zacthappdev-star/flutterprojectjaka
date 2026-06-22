import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = "hikata_database.db";
  static const int _databaseVersion = 4;

  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // ─── PASSWORD HASHING ──────────────────────────────────────────────────────
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _onConfigure(Database db) async {
    // Enable foreign keys
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        "ALTER TABLE progress ADD COLUMN script_guide_level INTEGER DEFAULT 1",
      );
    }
    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE claimed_missions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          date TEXT NOT NULL,
          mission_type TEXT NOT NULL,
          xp_reward INTEGER NOT NULL,
          created_at TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
          UNIQUE(user_id, date, mission_type)
        )
      ''');
    }
    if (oldVersion < 4) {
      await db.execute("ALTER TABLE progress ADD COLUMN xp INTEGER DEFAULT 0");
      await db.execute(
        "ALTER TABLE progress ADD COLUMN level INTEGER DEFAULT 1",
      );
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create users table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        avatar TEXT DEFAULT '🐼',
        created_at TEXT NOT NULL
      )
    ''');

    // Create progress table
    await db.execute('''
      CREATE TABLE progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL UNIQUE,
        hiragana_percent REAL DEFAULT 0.0,
        katakana_percent REAL DEFAULT 0.0,
        hiragana_level INTEGER DEFAULT 1,
        katakana_level INTEGER DEFAULT 1,
        script_guide_level INTEGER DEFAULT 1,
        xp INTEGER DEFAULT 0,
        level INTEGER DEFAULT 1,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Create quiz_history table
    await db.execute('''
      CREATE TABLE quiz_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        quiz_type TEXT NOT NULL,
        score INTEGER NOT NULL,
        total INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Create study_streak table
    await db.execute('''
      CREATE TABLE study_streak (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL UNIQUE,
        last_study_date TEXT,
        current_streak INTEGER DEFAULT 0,
        best_streak INTEGER DEFAULT 0,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // Create learned_characters table
    await db.execute('''
      CREATE TABLE learned_characters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        character TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        UNIQUE(user_id, character)
      )
    ''');

    // Create claimed_missions table
    await db.execute('''
      CREATE TABLE claimed_missions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        mission_type TEXT NOT NULL,
        xp_reward INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        UNIQUE(user_id, date, mission_type)
      )
    ''');
  }

  // ─── USER HELPER METHODS ───────────────────────────────────────────────────

  Future<int> registerUser(String name, String email, String password) async {
    final db = await database;
    try {
      final nowStr = DateTime.now().toIso8601String();
      final userId = await db.insert('users', {
        'nama': name,
        'email': email.trim().toLowerCase(),
        'password': hashPassword(password),
        'avatar': '🐼',
        'created_at': nowStr,
      });

      // Initialize defaults for this user
      await db.insert('progress', {
        'user_id': userId,
        'hiragana_percent': 0.0,
        'katakana_percent': 0.0,
        'hiragana_level': 1,
        'katakana_level': 1,
        'script_guide_level': 1,
        'xp': 0,
        'level': 1,
        'updated_at': nowStr,
      });

      await db.insert('study_streak', {
        'user_id': userId,
        'last_study_date': '',
        'current_streak': 0,
        'best_streak': 0,
      });

      return userId;
    } catch (e) {
      // Typically UNIQUE constraint failed for email
      return -1;
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email.trim().toLowerCase(), hashPassword(password)],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUser(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<int> updateAvatar(int id, String avatar) async {
    final db = await database;
    return await db.update(
      'users',
      {'avatar': avatar},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> changePassword(int id, String oldPass, String newPass) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ? AND password = ?',
      whereArgs: [id, hashPassword(oldPass)],
    );

    if (maps.isEmpty) return false;

    await db.update(
      'users',
      {'password': hashPassword(newPass)},
      where: 'id = ?',
      whereArgs: [id],
    );
    return true;
  }

  Future<int> updateProfile(int id, String name, String email) async {
    final db = await database;
    return await db.update(
      'users',
      {'nama': name, 'email': email.trim().toLowerCase()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> deleteUser(int id) async {
    final db = await database;
    final count = await db.delete('users', where: 'id = ?', whereArgs: [id]);
    return count > 0;
  }

  // ─── PROGRESS HELPER METHODS ───────────────────────────────────────────────

  Future<Map<String, dynamic>?> getProgress(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'progress',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) return maps.first;
    return null;
  }

  int calculateLevel(int xp) {
    if (xp >= 1000) return 5;
    if (xp >= 500) return 4;
    if (xp >= 250) return 3;
    if (xp >= 100) return 2;
    return 1;
  }

  Future<void> addXp(int userId, int amount) async {
    if (amount <= 0) return;

    final db = await database;

    // Get current progress
    final currentProgress = await getProgress(userId);
    if (currentProgress == null) return;

    int currentXp = (currentProgress['xp'] as int?) ?? 0;
    int newXp = currentXp + amount;
    int newLevel = calculateLevel(newXp);

    await db.update(
      'progress',
      {
        'xp': newXp,
        'level': newLevel,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updateProgress(
    int userId,
    double hiraganaPercent,
    double katakanaPercent,
    int hiraganaLevel,
    int katakanaLevel,
  ) async {
    final db = await database;
    return await db.update(
      'progress',
      {
        'hiragana_percent': hiraganaPercent,
        'katakana_percent': katakanaPercent,
        'hiragana_level': hiraganaLevel,
        'katakana_level': katakanaLevel,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> unlockLevel(int userId, String mode, int nextLevel) async {
    final db = await database;
    final Map<String, dynamic> updates = {};
    if (mode == 'hiragana') {
      updates['hiragana_level'] = nextLevel;
    } else {
      updates['katakana_level'] = nextLevel;
    }
    updates['updated_at'] = DateTime.now().toIso8601String();

    await db.update(
      'progress',
      updates,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updateScriptGuideLevel(int userId, int newLevel) async {
    final db = await database;
    return await db.update(
      'progress',
      {
        'script_guide_level': newLevel,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // ─── QUIZ HISTORY HELPER METHODS ───────────────────────────────────────────

  Future<int> insertQuizHistory(
    int userId,
    String quizType,
    int score,
    int total,
  ) async {
    final db = await database;
    return await db.insert('quiz_history', {
      'user_id': userId,
      'quiz_type': quizType,
      'score': score,
      'total': total,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getQuizHistory(int userId) async {
    final db = await database;
    return await db.query(
      'quiz_history',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );
  }

  Future<Map<String, int>> getQuizStats(int userId) async {
    final db = await database;

    // Total quiz count
    final totalCountResult = await db.rawQuery(
      'SELECT COUNT(*) as cnt FROM quiz_history WHERE user_id = ?',
      [userId],
    );
    final totalCompleted = Sqflite.firstIntValue(totalCountResult) ?? 0;

    // High scores
    final hiraganaHighResult = await db.rawQuery(
      "SELECT MAX(score) as max_score FROM quiz_history WHERE user_id = ? AND quiz_type = 'hiragana'",
      [userId],
    );
    final hiraganaHigh = Sqflite.firstIntValue(hiraganaHighResult) ?? 0;

    final katakanaHighResult = await db.rawQuery(
      "SELECT MAX(score) as max_score FROM quiz_history WHERE user_id = ? AND quiz_type = 'katakana'",
      [userId],
    );
    final katakanaHigh = Sqflite.firstIntValue(katakanaHighResult) ?? 0;

    final mixedHighResult = await db.rawQuery(
      "SELECT MAX(score) as max_score FROM quiz_history WHERE user_id = ? AND quiz_type = 'mixed'",
      [userId],
    );
    final mixedHigh = Sqflite.firstIntValue(mixedHighResult) ?? 0;

    final overallHighResult = await db.rawQuery(
      "SELECT MAX(score) as max_score FROM quiz_history WHERE user_id = ?",
      [userId],
    );
    final overallHigh = Sqflite.firstIntValue(overallHighResult) ?? 0;

    return {
      'total_completed': totalCompleted,
      'hiragana_high': hiraganaHigh,
      'katakana_high': katakanaHigh,
      'mixed_high': mixedHigh,
      'overall_high': overallHigh,
    };
  }

  // ─── STREAK HELPER METHODS ─────────────────────────────────────────────────

  Future<Map<String, dynamic>?> getStreak(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'study_streak',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) return maps.first;
    return null;
  }

  Future<int> updateStreak(
    int userId,
    String lastStudyDate,
    int currentStreak,
    int bestStreak,
  ) async {
    final db = await database;
    return await db.update(
      'study_streak',
      {
        'last_study_date': lastStudyDate,
        'current_streak': currentStreak,
        'best_streak': bestStreak,
      },
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // ─── LEARNED CHARACTERS HELPER METHODS ─────────────────────────────────────

  Future<int> markCharacterAsLearned(int userId, String character) async {
    final db = await database;
    try {
      return await db.insert('learned_characters', {
        'user_id': userId,
        'character': character,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Already learned (UNIQUE constraint)
      return -1;
    }
  }

  Future<List<String>> getLearnedCharacters(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'learned_characters',
      columns: ['character'],
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return maps.map((row) => row['character'] as String).toList();
  }

  Future<bool> isCharacterLearned(int userId, String character) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'learned_characters',
      where: 'user_id = ? AND character = ?',
      whereArgs: [userId, character],
    );
    return maps.isNotEmpty;
  }

  // ─── DAILY MISSIONS HELPER METHODS ─────────────────────────────────────────

  Future<int> claimMission(
    int userId,
    String date,
    String missionType,
    int xpReward,
  ) async {
    final db = await database;
    try {
      final id = await db.insert('claimed_missions', {
        'user_id': userId,
        'date': date,
        'mission_type': missionType,
        'xp_reward': xpReward,
        'created_at': DateTime.now().toIso8601String(),
      });

      // Auto add XP
      if (id > 0) {
        await addXp(userId, xpReward);
      }

      return id;
    } catch (e) {
      // Already claimed for today
      return -1;
    }
  }

  Future<List<String>> getClaimedMissions(int userId, String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'claimed_missions',
      columns: ['mission_type'],
      where: 'user_id = ? AND date = ?',
      whereArgs: [userId, date],
    );
    return maps.map((row) => row['mission_type'] as String).toList();
  }

  Future<int> getTotalMissionXP(int userId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(xp_reward) as total_xp FROM claimed_missions WHERE user_id = ?',
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
