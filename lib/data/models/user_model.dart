import '../../domain/entities/user.dart';

/// Modelo para la entidad User con funcionalidades adicionales
/// para serialización/deserialización
class UserModel extends User {
  const UserModel({
    required String id,
    String? name,
    String? email,
    SubscriptionType subscriptionType = SubscriptionType.free,
    bool isSubscribed = false,
    DateTime? subscriptionExpiryDate,
    int meditationMinutes = 0,
    int sessionsCompleted = 0,
    int streakDays = 0,
    required DateTime lastActiveDate,
    List<String> favoriteIds = const [],
    Map<String, int> categoryProgress = const {},
  }) : super(
          id: id,
          name: name,
          email: email,
          subscriptionType: subscriptionType,
          isSubscribed: isSubscribed,
          subscriptionExpiryDate: subscriptionExpiryDate,
          meditationMinutes: meditationMinutes,
          sessionsCompleted: sessionsCompleted,
          streakDays: streakDays,
          lastActiveDate: lastActiveDate,
          favoriteIds: favoriteIds,
          categoryProgress: categoryProgress,
        );

  /// Crea un modelo desde un mapa (para JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      subscriptionType: _subscriptionTypeFromString(json['subscriptionType'] as String? ?? 'free'),
      isSubscribed: json['isSubscribed'] as bool? ?? false,
      subscriptionExpiryDate: json['subscriptionExpiryDate'] != null
          ? DateTime.parse(json['subscriptionExpiryDate'] as String)
          : null,
      meditationMinutes: json['meditationMinutes'] as int? ?? 0,
      sessionsCompleted: json['sessionsCompleted'] as int? ?? 0,
      streakDays: json['streakDays'] as int? ?? 0,
      lastActiveDate: DateTime.parse(json['lastActiveDate'] as String),
      favoriteIds: (json['favoriteIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      categoryProgress: (json['categoryProgress'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, value as int),
          ) ??
          {},
    );
  }

  /// Convierte el modelo a un mapa (para JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'subscriptionType': subscriptionType.toString().split('.').last,
      'isSubscribed': isSubscribed,
      'subscriptionExpiryDate': subscriptionExpiryDate?.toIso8601String(),
      'meditationMinutes': meditationMinutes,
      'sessionsCompleted': sessionsCompleted,
      'streakDays': streakDays,
      'lastActiveDate': lastActiveDate.toIso8601String(),
      'favoriteIds': favoriteIds,
      'categoryProgress': categoryProgress,
    };
  }

  /// Crea un modelo desde la entidad del dominio
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      subscriptionType: user.subscriptionType,
      isSubscribed: user.isSubscribed,
      subscriptionExpiryDate: user.subscriptionExpiryDate,
      meditationMinutes: user.meditationMinutes,
      sessionsCompleted: user.sessionsCompleted,
      streakDays: user.streakDays,
      lastActiveDate: user.lastActiveDate,
      favoriteIds: user.favoriteIds,
      categoryProgress: user.categoryProgress,
    );
  }

  /// Convierte un string a SubscriptionType
  static SubscriptionType _subscriptionTypeFromString(String type) {
    return SubscriptionType.values.firstWhere(
      (e) => e.toString().split('.').last == type,
      orElse: () => SubscriptionType.free,
    );
  }
} 