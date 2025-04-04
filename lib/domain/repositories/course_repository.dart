import '../entities/course.dart';
import '../entities/meditation.dart';

/// Repositorio para gestionar los cursos de meditación
abstract class CourseRepository {
  /// Obtiene todos los cursos disponibles
  Future<List<Course>> getAllCourses();
  
  /// Obtiene los cursos filtrados por categoría
  Future<List<Course>> getCoursesByCategory(MeditationCategory category);
  
  /// Obtiene los cursos destacados o recomendados
  Future<List<Course>> getFeaturedCourses();
  
  /// Obtiene un curso por su ID
  Future<Course?> getCourseById(String id);
  
  /// Obtiene las meditaciones que pertenecen a un curso
  Future<List<Meditation>> getMeditationsByCourseId(String courseId);
  
  /// Actualiza el progreso de un curso
  Future<bool> updateCourseProgress(String courseId, int progressPercentage);
  
  /// Marca un curso como completado
  Future<bool> markCourseAsCompleted(String courseId);
} 