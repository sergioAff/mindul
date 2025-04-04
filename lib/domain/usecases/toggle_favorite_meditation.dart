import '../repositories/meditation_repository.dart';
import '../repositories/user_repository.dart';

/// Caso de uso para marcar o desmarcar una meditación como favorita
class ToggleFavoriteMeditation {
  final MeditationRepository repository;
  final UserRepository userRepository;
  
  ToggleFavoriteMeditation(this.repository, this.userRepository);
  
  /// Ejecuta el caso de uso
  /// 
  /// Toma el ID de la meditación y el estado actual de favorito
  Future<bool> call(String id, bool currentFavoriteStatus) async {
    // Actualiza en ambos repositorios para mantener la consistencia
    final updatedInMeditation = await repository.toggleFavorite(id, !currentFavoriteStatus);
    final updatedInUser = await userRepository.toggleFavorite(id);
    
    // Si ambas operaciones tuvieron éxito, retornamos true
    return updatedInMeditation && updatedInUser;
  }
} 