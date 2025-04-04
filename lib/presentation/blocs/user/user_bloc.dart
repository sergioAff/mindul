import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/user_repository.dart';

// Events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserStats extends UserEvent {
  const LoadUserStats();
}

class UpdateMeditationTime extends UserEvent {
  final int minutes;

  const UpdateMeditationTime(this.minutes);

  @override
  List<Object?> get props => [minutes];
}

class UpdateMeditationStreak extends UserEvent {
  const UpdateMeditationStreak();
}

class ResetUserStats extends UserEvent {
  const ResetUserStats();
}

// States
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final int totalMinutes;
  final int streak;
  final DateTime? lastMeditationTime;

  const UserLoaded({
    required this.totalMinutes,
    required this.streak,
    this.lastMeditationTime,
  });

  @override
  List<Object?> get props => [totalMinutes, streak, lastMeditationTime];

  UserLoaded copyWith({
    int? totalMinutes,
    int? streak,
    DateTime? lastMeditationTime,
  }) {
    return UserLoaded(
      totalMinutes: totalMinutes ?? this.totalMinutes,
      streak: streak ?? this.streak,
      lastMeditationTime: lastMeditationTime ?? this.lastMeditationTime,
    );
  }
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserInitial()) {
    on<LoadUserStats>(_onLoadUserStats);
    on<UpdateMeditationTime>(_onUpdateMeditationTime);
    on<UpdateMeditationStreak>(_onUpdateMeditationStreak);
    on<ResetUserStats>(_onResetUserStats);
  }

  void _onLoadUserStats(LoadUserStats event, Emitter<UserState> emit) async {
    emit(const UserLoading());

    try {
      // En un caso real, obtendríamos los datos del repositorio
      final totalMinutes = await userRepository.getTotalMeditationMinutes();
      final streak = await userRepository.getMeditationStreak();
      final lastMeditationTime = await userRepository.getLastMeditationTime();

      emit(UserLoaded(
        totalMinutes: totalMinutes,
        streak: streak,
        lastMeditationTime: lastMeditationTime,
      ));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void _onUpdateMeditationTime(
      UpdateMeditationTime event, Emitter<UserState> emit) async {
    final currentState = state;
    if (currentState is UserLoaded) {
      try {
        await userRepository.incrementMeditationMinutes(event.minutes);
        await userRepository.saveLastMeditationTime(DateTime.now());
        
        final totalMinutes = await userRepository.getTotalMeditationMinutes();
        
        emit(currentState.copyWith(
          totalMinutes: totalMinutes,
          lastMeditationTime: DateTime.now(),
        ));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    }
  }

  void _onUpdateMeditationStreak(
      UpdateMeditationStreak event, Emitter<UserState> emit) async {
    final currentState = state;
    if (currentState is UserLoaded) {
      try {
        await userRepository.incrementMeditationStreak();
        final updatedStreak = await userRepository.getMeditationStreak();
        
        emit(currentState.copyWith(
          streak: updatedStreak,
        ));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    }
  }

  void _onResetUserStats(ResetUserStats event, Emitter<UserState> emit) async {
    emit(const UserLoading());

    try {
      await userRepository.resetMeditationStreak();
      await userRepository.saveTotalMeditationMinutes(0);
      await userRepository.saveLastMeditationTime(null);
      
      emit(const UserLoaded(
        totalMinutes: 0,
        streak: 0,
        lastMeditationTime: null,
      ));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
