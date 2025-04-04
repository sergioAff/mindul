// Interfaz para el repositorio de usuario
abstract class UserRepository {
  /// Obtiene los datos del usuario actual
  Future getCurrentUser();
  
  /// Actualiza los datos del usuario
  Future<bool> updateUser(dynamic user);
  
  /// Actualiza las estadísticas del usuario después de una sesión
  Future<bool> updateUserStats(int meditationMinutes, bool completedSession);
  
  /// Añade o elimina una meditación de favoritos
  Future<bool> toggleFavorite(String meditationId);
  
  /// Actualiza el progreso en una categoría
  Future<bool> updateCategoryProgress(String category, int completedSessions);
  
  /// Actualiza el tipo de suscripción del usuario
  Future<bool> updateSubscription(dynamic type, DateTime? expiryDate);
  
  /// Actualiza la racha (streak) de días consecutivos
  Future<bool> updateStreak(DateTime lastActiveDate);

  Future<bool> saveLastMeditationTime(DateTime? time);
  Future<DateTime?> getLastMeditationTime();
  Future<bool> incrementMeditationMinutes(int minutes);
  Future<bool> saveTotalMeditationMinutes(int minutes);
  Future<int> getTotalMeditationMinutes();
  Future<bool> incrementMeditationStreak();
  Future<bool> resetMeditationStreak();
  Future<int> getMeditationStreak();
}

// Implementación temporal para pruebas
class MockUserRepository implements UserRepository {
  int _streak = 0;
  int _totalMinutes = 0;
  DateTime? _lastMeditationTime;

  @override
  Future<DateTime?> getLastMeditationTime() async {
    return _lastMeditationTime;
  }

  @override
  Future<int> getMeditationStreak() async {
    return _streak;
  }

  @override
  Future<int> getTotalMeditationMinutes() async {
    return _totalMinutes;
  }

  @override
  Future<bool> incrementMeditationMinutes(int minutes) async {
    _totalMinutes += minutes;
    return true;
  }

  @override
  Future<bool> incrementMeditationStreak() async {
    _streak++;
    return true;
  }

  @override
  Future<bool> resetMeditationStreak() async {
    _streak = 0;
    return true;
  }

  @override
  Future<bool> saveLastMeditationTime(DateTime? time) async {
    _lastMeditationTime = time;
    return true;
  }

  @override
  Future<bool> saveTotalMeditationMinutes(int minutes) async {
    _totalMinutes = minutes;
    return true;
  }

  @override
  Future getCurrentUser() {
    return Future.value(null);
  }

  @override
  Future<bool> toggleFavorite(String meditationId) {
    return Future.value(true);
  }

  @override
  Future<bool> updateCategoryProgress(String category, int completedSessions) {
    return Future.value(true);
  }

  @override
  Future<bool> updateStreak(DateTime lastActiveDate) {
    return Future.value(true);
  }

  @override
  Future<bool> updateSubscription(type, DateTime? expiryDate) {
    return Future.value(true);
  }

  @override
  Future<bool> updateUser(user) {
    return Future.value(true);
  }

  @override
  Future<bool> updateUserStats(int meditationMinutes, bool completedSession) {
    return Future.value(true);
  }
} 