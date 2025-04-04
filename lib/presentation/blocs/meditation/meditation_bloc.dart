import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Eventos
abstract class MeditationEvent extends Equatable {
  const MeditationEvent();

  @override
  List<Object?> get props => [];
}

class LoadMeditations extends MeditationEvent {
  const LoadMeditations();
}

class LoadMeditationById extends MeditationEvent {
  final String id;

  const LoadMeditationById(this.id);

  @override
  List<Object?> get props => [id];
}

// Estados
abstract class MeditationState extends Equatable {
  const MeditationState();

  @override
  List<Object?> get props => [];
}

class MeditationInitial extends MeditationState {
  const MeditationInitial();
}

class MeditationLoading extends MeditationState {
  const MeditationLoading();
}

class MeditationsLoaded extends MeditationState {
  const MeditationsLoaded();

  @override
  List<Object?> get props => [];
}

class MeditationError extends MeditationState {
  final String message;

  const MeditationError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class MeditationBloc extends Bloc<MeditationEvent, MeditationState> {
  MeditationBloc() : super(const MeditationInitial()) {
    on<LoadMeditations>(_onLoadMeditations);
    on<LoadMeditationById>(_onLoadMeditationById);
  }

  void _onLoadMeditations(
      LoadMeditations event, Emitter<MeditationState> emit) async {
    emit(const MeditationLoading());

    try {
      // Simular carga de datos
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const MeditationsLoaded());
    } catch (e) {
      emit(MeditationError(e.toString()));
    }
  }

  void _onLoadMeditationById(
      LoadMeditationById event, Emitter<MeditationState> emit) async {
    emit(const MeditationLoading());

    try {
      // Simular carga de datos
      await Future.delayed(const Duration(milliseconds: 300));
      emit(const MeditationsLoaded());
    } catch (e) {
      emit(MeditationError(e.toString()));
    }
  }
}
