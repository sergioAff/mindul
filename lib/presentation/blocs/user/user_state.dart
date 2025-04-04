import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class UserInitial extends UserState {
  const UserInitial();
}

/// Estado de carga
class UserLoading extends UserState {
  const UserLoading();
}

/// Estado cuando se ha cargado el usuario
class UserLoaded extends UserState {
  final User user;
  
  const UserLoaded(this.user);
  
  @override
  List<Object?> get props => [user];
}

/// Estado de error
class UserError extends UserState {
  final String message;
  
  const UserError(this.message);
  
  @override
  List<Object?> get props => [message];
}

/// Estado cuando las estadísticas del usuario han sido actualizadas
class UserStatsUpdated extends UserState {
  final User user;
  
  const UserStatsUpdated(this.user);
  
  @override
  List<Object?> get props => [user];
}

/// Estado cuando el progreso de una categoría ha sido actualizado
class UserCategoryProgressUpdated extends UserState {
  final User user;
  final String category;
  final int progress;
  
  const UserCategoryProgressUpdated({
    required this.user,
    required this.category,
    required this.progress,
  });
  
  @override
  List<Object?> get props => [user, category, progress];
}

/// Estado cuando la suscripción ha sido actualizada
class UserSubscriptionUpdated extends UserState {
  final User user;
  final SubscriptionType type;
  
  const UserSubscriptionUpdated({
    required this.user,
    required this.type,
  });
  
  @override
  List<Object?> get props => [user, type];
}

/// Estado cuando la racha (streak) ha sido actualizada
class UserStreakUpdated extends UserState {
  final User user;
  final int streakDays;
  
  const UserStreakUpdated({
    required this.user,
    required this.streakDays,
  });
  
  @override
  List<Object?> get props => [user, streakDays];
} 