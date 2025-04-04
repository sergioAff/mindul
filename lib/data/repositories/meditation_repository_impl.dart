import '../../domain/entities/meditation.dart';
import '../../domain/repositories/meditation_repository.dart';
import '../datasources/meditation_local_datasource.dart';
import '../models/meditation_model.dart';

class MeditationRepositoryImpl implements MeditationRepository {
  final MeditationLocalDataSource localDataSource;
  
  MeditationRepositoryImpl(this.localDataSource);
  
  @override
  Future<List<Meditation>> getAllMeditations() async {
    try {
      final meditationModels = await localDataSource.getAllMeditations();
      return meditationModels;
    } catch (e) {
      // En una aplicación real, aquí manejaríamos el error adecuadamente
      // Por ejemplo, registrándolo o devolviendo un mensaje específico
      return [];
    }
  }
  
  @override
  Future<List<Meditation>> getMeditationsByCategory(MeditationCategory category) async {
    try {
      final meditationModels = await localDataSource.getMeditationsByCategory(category);
      return meditationModels;
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<List<Meditation>> getMeditationsByDifficulty(MeditationDifficulty difficulty) async {
    try {
      final meditationModels = await localDataSource.getMeditationsByDifficulty(difficulty);
      return meditationModels;
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<List<Meditation>> getFavoriteMeditations() async {
    try {
      final meditationModels = await localDataSource.getFavoriteMeditations();
      return meditationModels;
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<List<Meditation>> getRecommendedMeditations() async {
    // En una implementación real, aquí tendríamos lógica para recomendar
    // meditaciones basadas en el historial del usuario, preferencias, etc.
    // Por ahora, simplemente devolvemos todas las meditaciones como "recomendadas"
    return await getAllMeditations();
  }
  
  @override
  Future<Meditation?> getMeditationById(String id) async {
    try {
      return await localDataSource.getMeditationById(id);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<bool> toggleFavorite(String id, bool isFavorite) async {
    try {
      return await localDataSource.toggleFavorite(id, isFavorite);
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<bool> completeMeditation(String id, int durationInMinutes) async {
    try {
      return await localDataSource.completeMeditation(id, durationInMinutes);
    } catch (e) {
      return false;
    }
  }
  
  // Método adicional para guardar meditaciones en la base de datos local
  // (Útil para precarga de datos o sincronización desde un servidor)
  Future<void> saveMeditations(List<Meditation> meditations) async {
    try {
      final meditationModels = meditations
          .map((meditation) => MeditationModel.fromEntity(meditation))
          .toList();
      
      await localDataSource.saveMeditations(meditationModels);
    } catch (e) {
      // Manejo de error
    }
  }
} 