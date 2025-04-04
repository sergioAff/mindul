import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/meditation.dart';
import '../models/meditation_model.dart';

abstract class MeditationLocalDataSource {
  /// Obtiene todas las meditaciones almacenadas localmente
  Future<List<MeditationModel>> getAllMeditations();

  /// Obtiene una meditación por su ID
  Future<MeditationModel?> getMeditationById(String id);

  /// Guarda una lista de meditaciones localmente
  Future<void> saveMeditations(List<MeditationModel> meditations);

  /// Actualiza el estado de favorito de una meditación
  Future<bool> toggleFavorite(String id, bool isFavorite);

  /// Registra la finalización de una meditación
  Future<bool> completeMeditation(String id, int durationInMinutes);

  /// Obtiene las meditaciones por categoría
  Future<List<MeditationModel>> getMeditationsByCategory(
      MeditationCategory category);

  /// Obtiene las meditaciones por dificultad
  Future<List<MeditationModel>> getMeditationsByDifficulty(
      MeditationDifficulty difficulty);

  /// Obtiene las meditaciones favoritas
  Future<List<MeditationModel>> getFavoriteMeditations();

  /// Obtiene las meditaciones recomendadas
  Future<List<MeditationModel>> getRecommendedMeditations();

  /// Actualiza el contador de completado de una meditación
  Future<bool> updateCompletionCount(String id);
}

class MeditationLocalDataSourceImpl implements MeditationLocalDataSource {
  final SharedPreferences sharedPreferences;

  MeditationLocalDataSourceImpl(this.sharedPreferences);

  static const String tableName = 'meditations';
  static const String meditationsKey = 'MEDITATIONS_DATA';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'mindful_moments.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tableName(
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          imageUrl TEXT NOT NULL,
          audioUrl TEXT NOT NULL,
          durationInMinutes INTEGER NOT NULL,
          category TEXT NOT NULL,
          difficulty TEXT NOT NULL,
          isPremium INTEGER NOT NULL,
          isFavorite INTEGER NOT NULL,
          completionCount INTEGER NOT NULL,
          lastCompletedAt TEXT
        )
        ''');
      },
    );
  }

  @override
  Future<List<MeditationModel>> getAllMeditations() async {
    final db = await database;
    final maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return MeditationModel.fromJson(_convertMapToJson(maps[i]));
    });
  }

  @override
  Future<MeditationModel?> getMeditationById(String id) async {
    final db = await database;
    final maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MeditationModel.fromJson(_convertMapToJson(maps.first));
    }
    return null;
  }

  @override
  Future<void> saveMeditations(List<MeditationModel> meditations) async {
    final db = await database;
    final batch = db.batch();

    for (var meditation in meditations) {
      final map = _convertJsonToMap(meditation.toJson());
      batch.insert(
        tableName,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<bool> toggleFavorite(String id, bool isFavorite) async {
    final db = await database;
    final result = await db.update(
      tableName,
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );

    return result > 0;
  }

  @override
  Future<bool> completeMeditation(String id, int durationInMinutes) async {
    final meditation = await getMeditationById(id);
    if (meditation == null) return false;

    final db = await database;
    final result = await db.update(
      tableName,
      {
        'completionCount': meditation.completionCount + 1,
        'lastCompletedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    return result > 0;
  }

  @override
  Future<List<MeditationModel>> getMeditationsByCategory(
      MeditationCategory category) async {
    final db = await database;
    final categoryString = category.toString().split('.').last;

    final maps = await db.query(
      tableName,
      where: 'category = ?',
      whereArgs: [categoryString],
    );

    return List.generate(maps.length, (i) {
      return MeditationModel.fromJson(_convertMapToJson(maps[i]));
    });
  }

  @override
  Future<List<MeditationModel>> getMeditationsByDifficulty(
      MeditationDifficulty difficulty) async {
    final db = await database;
    final difficultyString = difficulty.toString().split('.').last;

    final maps = await db.query(
      tableName,
      where: 'difficulty = ?',
      whereArgs: [difficultyString],
    );

    return List.generate(maps.length, (i) {
      return MeditationModel.fromJson(_convertMapToJson(maps[i]));
    });
  }

  @override
  Future<List<MeditationModel>> getFavoriteMeditations() async {
    final db = await database;

    final maps = await db.query(
      tableName,
      where: 'isFavorite = ?',
      whereArgs: [1],
    );

    return List.generate(maps.length, (i) {
      return MeditationModel.fromJson(_convertMapToJson(maps[i]));
    });
  }

  @override
  Future<List<MeditationModel>> getRecommendedMeditations() async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<bool> updateCompletionCount(String id) async {
    // Implementation needed
    throw UnimplementedError();
  }

  // Convierte un mapa de SQLite a un mapa JSON
  Map<String, dynamic> _convertMapToJson(Map<String, dynamic> map) {
    final jsonMap = Map<String, dynamic>.from(map);

    // Convertir 0/1 a boolean
    jsonMap['isPremium'] = map['isPremium'] == 1;
    jsonMap['isFavorite'] = map['isFavorite'] == 1;

    return jsonMap;
  }

  // Convierte un mapa JSON a un mapa para SQLite
  Map<String, dynamic> _convertJsonToMap(Map<String, dynamic> json) {
    final sqliteMap = Map<String, dynamic>.from(json);

    // Convertir boolean a 0/1
    sqliteMap['isPremium'] = json['isPremium'] ? 1 : 0;
    sqliteMap['isFavorite'] = json['isFavorite'] ? 1 : 0;

    return sqliteMap;
  }
}
