import '../../domain/entities/course.dart';
import '../../domain/entities/meditation.dart';

/// Modelo para la entidad Course con funcionalidades adicionales
/// para serialización/deserialización
class CourseModel extends Course {
  const CourseModel({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required String authorName,
    bool isPremium = false,
    required List<String> meditationIds,
    required int totalDurationInMinutes,
    required MeditationCategory category,
    required MeditationDifficulty difficulty,
    bool isCompleted = false,
    int progressPercentage = 0,
  }) : super(
          id: id,
          title: title,
          description: description,
          imageUrl: imageUrl,
          authorName: authorName,
          isPremium: isPremium,
          meditationIds: meditationIds,
          totalDurationInMinutes: totalDurationInMinutes,
          category: category,
          difficulty: difficulty,
          isCompleted: isCompleted,
          progressPercentage: progressPercentage,
        );

  /// Crea un modelo desde un mapa (para JSON)
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      authorName: json['authorName'] as String,
      isPremium: json['isPremium'] as bool? ?? false,
      meditationIds: (json['meditationIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      totalDurationInMinutes: json['totalDurationInMinutes'] as int,
      category: _categoryFromString(json['category'] as String),
      difficulty: _difficultyFromString(json['difficulty'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      progressPercentage: json['progressPercentage'] as int? ?? 0,
    );
  }

  /// Convierte el modelo a un mapa (para JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'authorName': authorName,
      'isPremium': isPremium,
      'meditationIds': meditationIds,
      'totalDurationInMinutes': totalDurationInMinutes,
      'category': category.toString().split('.').last,
      'difficulty': difficulty.toString().split('.').last,
      'isCompleted': isCompleted,
      'progressPercentage': progressPercentage,
    };
  }

  /// Crea un modelo desde la entidad del dominio
  factory CourseModel.fromEntity(Course course) {
    return CourseModel(
      id: course.id,
      title: course.title,
      description: course.description,
      imageUrl: course.imageUrl,
      authorName: course.authorName,
      isPremium: course.isPremium,
      meditationIds: course.meditationIds,
      totalDurationInMinutes: course.totalDurationInMinutes,
      category: course.category,
      difficulty: course.difficulty,
      isCompleted: course.isCompleted,
      progressPercentage: course.progressPercentage,
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