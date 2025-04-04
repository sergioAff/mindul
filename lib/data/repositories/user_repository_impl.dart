import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl(this._localDataSource);

  @override
  Future<DateTime?> getLastMeditationTime() {
    return _localDataSource.getLastMeditationTime();
  }

  @override
  Future<int> getMeditationStreak() {
    return _localDataSource.getMeditationStreak();
  }

  @override
  Future<int> getTotalMeditationMinutes() {
    return _localDataSource.getTotalMeditationMinutes();
  }

  @override
  Future<bool> incrementMeditationMinutes(int minutes) async {
    final currentMinutes = await _localDataSource.getTotalMeditationMinutes();
    return _localDataSource.saveTotalMeditationMinutes(currentMinutes + minutes);
  }

  @override
  Future<bool> incrementMeditationStreak() async {
    final currentStreak = await _localDataSource.getMeditationStreak();
    return _localDataSource.saveMeditationStreak(currentStreak + 1);
  }

  @override
  Future<bool> resetMeditationStreak() {
    return _localDataSource.saveMeditationStreak(0);
  }

  @override
  Future<bool> saveLastMeditationTime(DateTime? time) {
    return _localDataSource.saveLastMeditationTime(time);
  }

  @override
  Future<bool> saveTotalMeditationMinutes(int minutes) {
    return _localDataSource.saveTotalMeditationMinutes(minutes);
  }
  
  // Implementaciones temporales para los métodos que ya no usamos
  @override
  Future<dynamic> getCurrentUser() async {
    return null;
  }

  @override
  Future<bool> toggleFavorite(String meditationId) async {
    return true;
  }

  @override
  Future<bool> updateCategoryProgress(String category, int completedSessions) async {
    return true;
  }

  @override
  Future<bool> updateStreak(DateTime lastActiveDate) async {
    return true;
  }

  @override
  Future<bool> updateSubscription(dynamic type, DateTime? expiryDate) async {
    return true;
  }

  @override
  Future<bool> updateUser(dynamic user) async {
    return true;
  }

  @override
  Future<bool> updateUserStats(int meditationMinutes, bool completedSession) async {
    return true;
  }
} 