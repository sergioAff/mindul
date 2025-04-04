import 'package:equatable/equatable.dart';
import 'meditation.dart';

/// Representa un curso de meditación en la aplicación
class Course extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String authorName;
  final bool isPremium;
  final List<String> meditationIds;
  final int totalDurationInMinutes;
  final MeditationCategory category;
  final MeditationDifficulty difficulty;
  final bool isCompleted;
  final int progressPercentage;
  
  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.authorName,
    this.isPremium = false,
    required this.meditationIds,
    required this.totalDurationInMinutes,
    required this.category,
    required this.difficulty,
    this.isCompleted = false,
    this.progressPercentage = 0,
  });
  
  @override
  List<Object> get props => [
    id, title, description, imageUrl, authorName,
    isPremium, meditationIds, totalDurationInMinutes,
    category, difficulty, isCompleted, progressPercentage
  ];
  
  /// Crea una copia del curso con algunos campos modificados
  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? authorName,
    bool? isPremium,
    List<String>? meditationIds,
    int? totalDurationInMinutes,
    MeditationCategory? category,
    MeditationDifficulty? difficulty,
    bool? isCompleted,
    int? progressPercentage,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      authorName: authorName ?? this.authorName,
      isPremium: isPremium ?? this.isPremium,
      meditationIds: meditationIds ?? this.meditationIds,
      totalDurationInMinutes: totalDurationInMinutes ?? this.totalDurationInMinutes,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
      progressPercentage: progressPercentage ?? this.progressPercentage,
    );
  }
} 