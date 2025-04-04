import '../../domain/entities/meditation.dart';

/// Modelo para la entidad Meditation con funcionalidades adicionales
/// para serialización/deserialización
class MeditationModel extends Meditation {
  const MeditationModel({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required String audioUrl,
    required int durationInMinutes,
    required MeditationCategory category,
    required MeditationDifficulty difficulty,
    bool isPremium = false,
    bool isFavorite = false,
    int completionCount = 0,
    DateTime? lastCompletedAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          imageUrl: imageUrl,
          audioUrl: audioUrl,
          durationInMinutes: durationInMinutes,
          category: category,
          difficulty: difficulty,
          isPremium: isPremium,
          isFavorite: isFavorite,
          completionCount: completionCount,
          lastCompletedAt: lastCompletedAt,
        );

  /// Crea un modelo desde un mapa (para JSON)
  factory MeditationModel.fromJson(Map<String, dynamic> json) {
    return MeditationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      audioUrl: json['audioUrl'] as String,
      durationInMinutes: json['durationInMinutes'] as int,
      category: _categoryFromString(json['category'] as String),
      difficulty: _difficultyFromString(json['difficulty'] as String),
      isPremium: json['isPremium'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      completionCount: json['completionCount'] as int? ?? 0,
      lastCompletedAt: json['lastCompletedAt'] != null
          ? DateTime.parse(json['lastCompletedAt'] as String)
          : null,
    );
  }

  /// Convierte el modelo a un mapa (para JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'durationInMinutes': durationInMinutes,
      'category': category.toString().split('.').last,
      'difficulty': difficulty.toString().split('.').last,
      'isPremium': isPremium,
      'isFavorite': isFavorite,
      'completionCount': completionCount,
      'lastCompletedAt': lastCompletedAt?.toIso8601String(),
    };
  }

  /// Crea un modelo desde la entidad del dominio
  factory MeditationModel.fromEntity(Meditation meditation) {
    return MeditationModel(
      id: meditation.id,
      title: meditation.title,
      description: meditation.description,
      imageUrl: meditation.imageUrl,
      audioUrl: meditation.audioUrl,
      durationInMinutes: meditation.durationInMinutes,
      category: meditation.category,
      difficulty: meditation.difficulty,
      isPremium: meditation.isPremium,
      isFavorite: meditation.isFavorite,
      completionCount: meditation.completionCount,
      lastCompletedAt: meditation.lastCompletedAt,
    );
  }
  
  /// Convierte un string a MeditationCategory
  static MeditationCategory _categoryFromString(String category) {
    return MeditationCategory.values.firstWhere(
      (e) => e.toString().split('.').last == category,
      orElse: () => MeditationCategory.mindfulness,
    );
  }

  /// Convierte un string a MeditationDifficulty
  static MeditationDifficulty _difficultyFromString(String difficulty) {
    return MeditationDifficulty.values.firstWhere(
      (e) => e.toString().split('.').last == difficulty,
      orElse: () => MeditationDifficulty.beginner,
    );
  }
} 