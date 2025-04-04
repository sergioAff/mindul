import 'package:equatable/equatable.dart';

enum MeditationCategory {
  sleep,
  stress,
  anxiety,
  focus,
  gratitude,
  mindfulness,
  selfLove,
  beginners,
  morning,
  evening,
}

enum MeditationDifficulty {
  beginner,
  intermediate,
  advanced,
}

/// Representa una meditación en la aplicación
class Meditation extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String audioUrl;
  final int durationInMinutes;
  final MeditationCategory category;
  final MeditationDifficulty difficulty;
  final bool isPremium;
  final bool isFavorite;
  final int completionCount;
  final DateTime? lastCompletedAt;
  
  const Meditation({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.audioUrl,
    required this.durationInMinutes,
    required this.category,
    required this.difficulty,
    this.isPremium = false,
    this.isFavorite = false,
    this.completionCount = 0,
    this.lastCompletedAt,
  });

  @override
  List<Object?> get props => [
    id, title, description, imageUrl, audioUrl, 
    durationInMinutes, category, difficulty, 
    isPremium, isFavorite, completionCount, lastCompletedAt
  ];
  
  /// Crea una copia de la meditación con algunos campos modificados
  Meditation copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? audioUrl,
    int? durationInMinutes,
    MeditationCategory? category,
    MeditationDifficulty? difficulty,
    bool? isPremium,
    bool? isFavorite,
    int? completionCount,
    DateTime? lastCompletedAt,
  }) {
    return Meditation(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      durationInMinutes: durationInMinutes ?? this.durationInMinutes,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      isPremium: isPremium ?? this.isPremium,
      isFavorite: isFavorite ?? this.isFavorite,
      completionCount: completionCount ?? this.completionCount,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
    );
  }
} 