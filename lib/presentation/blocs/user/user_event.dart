import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar los datos del usuario
class LoadUser extends UserEvent {
  const LoadUser();
}

/// Evento para actualizar los datos del usuario
class UpdateUser extends UserEvent {
  final User user;

  const UpdateUser(this.user);

  @override
  List<Object?> get props => [user];
}

/// Evento para actualizar las estadísticas del usuario después de una sesión
class UpdateUserStats extends UserEvent {
  final int meditationMinutes;
  final bool completedSession;

  const UpdateUserStats({
    required this.meditationMinutes,
    required this.completedSession,
  });

  @override
  List<Object?> get props => [meditationMinutes, completedSession];
}

/// Evento para actualizar el progreso de una categoría
class UpdateCategoryProgress extends UserEvent {
  final String category;
  final int completedSessions;

  const UpdateCategoryProgress({
    required this.category,
    required this.completedSessions,
  });

  @override
  List<Object?> get props => [category, completedSessions];
}

/// Evento para actualizar la suscripción del usuario
class UpdateSubscription extends UserEvent {
  final SubscriptionType type;
  final DateTime? expiryDate;

  const UpdateSubscription({
    required this.type,
    this.expiryDate,
  });

  @override
  List<Object?> get props => [type, expiryDate];
}

/// Evento para actualizar la racha (streak) de días consecutivos
class UpdateStreak extends UserEvent {
  final DateTime lastActiveDate;

  const UpdateStreak(this.lastActiveDate);

  @override
  List<Object?> get props => [lastActiveDate];
} 