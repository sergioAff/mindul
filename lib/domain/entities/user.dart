import 'package:equatable/equatable.dart';

enum SubscriptionType {
  free,
  monthly,
  yearly,
  lifetime,
}

/// Representa un usuario en la aplicación
class User extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final SubscriptionType subscriptionType;
  final bool isSubscribed;
  final DateTime? subscriptionExpiryDate;
  final int meditationMinutes;
  final int sessionsCompleted;
  final int streakDays;
  final DateTime lastActiveDate;
  final List<String> favoriteIds;
  final Map<String, int> categoryProgress;
  
  const User({
    required this.id,
    this.name,
    this.email,
    this.subscriptionType = SubscriptionType.free,
    this.isSubscribed = false,
    this.subscriptionExpiryDate,
    this.meditationMinutes = 0,
    this.sessionsCompleted = 0,
    this.streakDays = 0,
    required this.lastActiveDate,
    this.favoriteIds = const [],
    this.categoryProgress = const {},
  });
  
  @override
  List<Object?> get props => [
    id, name, email, subscriptionType, isSubscribed, 
    subscriptionExpiryDate, meditationMinutes, sessionsCompleted, 
    streakDays, lastActiveDate, favoriteIds, categoryProgress
  ];
  
  /// Crea una copia del usuario con algunos campos modificados
  User copyWith({
    String? id,
    String? name,
    String? email,
    SubscriptionType? subscriptionType,
    bool? isSubscribed,
    DateTime? subscriptionExpiryDate,
    int? meditationMinutes,
    int? sessionsCompleted,
    int? streakDays,
    DateTime? lastActiveDate,
    List<String>? favoriteIds,
    Map<String, int>? categoryProgress,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      subscriptionExpiryDate: subscriptionExpiryDate ?? this.subscriptionExpiryDate,
      meditationMinutes: meditationMinutes ?? this.meditationMinutes,
      sessionsCompleted: sessionsCompleted ?? this.sessionsCompleted,
      streakDays: streakDays ?? this.streakDays,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      categoryProgress: categoryProgress ?? this.categoryProgress,
    );
  }
} 