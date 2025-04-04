import '../entities/meditation.dart';
import '../repositories/meditation_repository.dart';

/// Caso de uso para obtener meditaciones por categoría
class GetMeditationsByCategory {
  final MeditationRepository repository;
  
  GetMeditationsByCategory(this.repository);
  
  /// Ejecuta el caso de uso
  Future<List<Meditation>> call(MeditationCategory category) async {
    return await repository.getMeditationsByCategory(category);
  }
} 