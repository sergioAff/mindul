import '../entities/meditation.dart';

/// Repositorio para gestionar las meditaciones
abstract class MeditationRepository {
  /// Obtiene todas las meditaciones disponibles
  Future<List<Meditation>> getAllMeditations();
  
  /// Obtiene las meditaciones filtradas por categoría
  Future<List<Meditation>> getMeditationsByCategory(MeditationCategory category);
  
  /// Obtiene las meditaciones filtradas por dificultad
  Future<List<Meditation>> getMeditationsByDifficulty(MeditationDifficulty difficulty);
  
  /// Obtiene las meditaciones favoritas del usuario
  Future<List<Meditation>> getFavoriteMeditations();
  
  /// Obtiene las meditaciones recomendadas personalizadas para el usuario
  Future<List<Meditation>> getRecommendedMeditations();
  
  /// Obtiene una meditación por su ID
  Future<Meditation?> getMeditationById(String id);
  
  /// Marca o desmarca una meditación como favorita
  Future<bool> toggleFavorite(String id, bool isFavorite);
  
  /// Registra la finalización de una sesión de meditación
  Future<bool> completeMeditation(String id, int durationInMinutes);
} 