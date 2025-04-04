import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<bool> saveMeditationStreak(int streak);
  Future<int> getMeditationStreak();
  Future<bool> saveTotalMeditationMinutes(int minutes);
  Future<int> getTotalMeditationMinutes();
  Future<bool> saveLastMeditationTime(DateTime? time);
  Future<DateTime?> getLastMeditationTime();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences _sharedPreferences;
  
  // Keys para SharedPreferences
  static const String _meditationStreakKey = 'meditation_streak';
  static const String _totalMeditationMinutesKey = 'total_meditation_minutes';
  static const String _lastMeditationTimeKey = 'last_meditation_time';
  
  UserLocalDataSourceImpl(this._sharedPreferences);
  
  @override
  Future<bool> saveMeditationStreak(int streak) async {
    return _sharedPreferences.setInt(_meditationStreakKey, streak);
  }
  
  @override
  Future<int> getMeditationStreak() async {
    return _sharedPreferences.getInt(_meditationStreakKey) ?? 0;
  }
  
  @override
  Future<bool> saveTotalMeditationMinutes(int minutes) async {
    return _sharedPreferences.setInt(_totalMeditationMinutesKey, minutes);
  }
  
  @override
  Future<int> getTotalMeditationMinutes() async {
    return _sharedPreferences.getInt(_totalMeditationMinutesKey) ?? 0;
  }
  
  @override
  Future<bool> saveLastMeditationTime(DateTime? time) async {
    if (time == null) {
      return _sharedPreferences.remove(_lastMeditationTimeKey);
    }
    return _sharedPreferences.setString(_lastMeditationTimeKey, time.toIso8601String());
  }
  
  @override
  Future<DateTime?> getLastMeditationTime() async {
    final timeString = _sharedPreferences.getString(_lastMeditationTimeKey);
    if (timeString == null) {
      return null;
    }
    return DateTime.parse(timeString);
  }
} 