import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('nurutouch.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    // Core Tables
    await db.execute('''
      CREATE TABLE learner_profiles (
        id $idType,
        name $textType,
        age $integerType,
        created_at $textType,
        preferences $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE settings (
        id $idType,
        learner_id $integerType,
        haptic_enabled $boolType,
        audio_speed $realType,
        language $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE consent_records (
        id $idType,
        parent_name $textType,
        consent_given $boolType,
        timestamp $textType,
        signature_path $textType
      )
    ''');

    // Learning & Session Tables
    await db.execute('''
      CREATE TABLE lesson_sessions (
        id $idType,
        learner_id $integerType,
        lesson_id $textType,
        start_time $textType,
        end_time $textType,
        completed $boolType
      )
    ''');

    await db.execute('''
      CREATE TABLE lesson_attempts (
        id $idType,
        session_id $integerType,
        phase $textType,
        is_correct $boolType,
        response_time_ms $integerType,
        timestamp $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE progress (
        id $idType,
        learner_id $integerType,
        lesson_id $textType,
        mastery_score $integerType,
        attempts $integerType,
        last_reviewed $textType
      )
    ''');

    // Adaptive Engine Tables
    await db.execute('''
      CREATE TABLE adaptive_state (
        id $idType,
        learner_id $integerType,
        concept_id $textType,
        q_value $realType,
        last_updated $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE q_table (
        id $idType,
        letter $textType,
        state $integerType,
        action $integerType,
        q_value $realType
      )
    ''');

    // Analytics & Research
    await db.execute('''
      CREATE TABLE analytics_events (
        id $idType,
        event_name $textType,
        payload $textType,
        timestamp $textType,
        session_id $integerType,
        learner_id $integerType
      )
    ''');

    await db.execute('''
      CREATE TABLE research_exports (
        id $idType,
        export_date $textType,
        data_hash $textType,
        synced $boolType
      )
    ''');

    // Gamification
    await db.execute('''
      CREATE TABLE achievements (
        id $idType,
        learner_id $integerType,
        badge_id $textType,
        earned_at $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE garden_state (
        id $idType,
        learner_id $integerType,
        item_id $textType,
        position_x $integerType,
        position_y $integerType,
        planted_at $textType
      )
    ''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
