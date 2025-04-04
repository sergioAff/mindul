import '../repositories/meditation_repository.dart';
import '../repositories/user_repository.dart';

/// Caso de uso para registrar la finalización de una sesión de meditación
class CompleteMeditationSession {
  final MeditationRepository meditationRepository;
  final UserRepository userRepository;
  
  CompleteMeditationSession({
    required this.meditationRepository,
    required this.userRepository,
  });
  
  /// Ejecuta el caso de uso
  /// 
  /// Parámetros:
  /// [meditationId] - ID de la meditación completada
  /// [durationInMinutes] - Duración en minutos de la sesión completada
  /// [categoryName] - Nombre de la categoría para actualizar progreso
  Future<bool> call({
    required String meditationId,
    required int durationInMinutes,
    required String categoryName,
  }) async {
    // Registra la finalización en el repositorio de meditaciones
    final completedMeditation = await meditationRepository.completeMeditation(
      meditationId,
      durationInMinutes
    );
    
    if (!completedMeditation) {
      return false;
    }
    
    // Actualiza las estadísticas del usuario
    final statsUpdated = await userRepository.updateUserStats(
      durationInMinutes,
      true
    );
    
    // Actualiza el progreso de la categoría
    final categoryUpdated = await userRepository.updateCategoryProgress(
      categoryName,
      1
    );
    
    // Actualiza la racha (streak) del usuario
    final streakUpdated = await userRepository.updateStreak(DateTime.now());
    
    return statsUpdated && categoryUpdated && streakUpdated;
  }
} 