import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

enum MeditationType {
  calm,
  focus,
  sleep,
  energy,
  stress,
  morning,
  evening
}

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isMuted = false;
  double _volume = 0.5;
  MeditationType? _currentType;
  
  bool get isMuted => _isMuted;
  double get volume => _volume;
  bool get isPlaying => _audioPlayer.playing;
  MeditationType? get currentType => _currentType;
  
  // Mapeo de tipo de meditación a ruta de audio
  final Map<MeditationType, String> _meditationSounds = {
    MeditationType.calm: 'assets/audio/calm_meditation.mp3',
    MeditationType.focus: 'assets/audio/focus_meditation.mp3',
    MeditationType.sleep: 'assets/audio/sleep_meditation.mp3',
    MeditationType.energy: 'assets/audio/energy_meditation.mp3',
    MeditationType.stress: 'assets/audio/stress_reduction.mp3',
    MeditationType.morning: 'assets/audio/morning_meditation.mp3',
    MeditationType.evening: 'assets/audio/evening_meditation.mp3',
  };
  
  // Iniciar reproducción de audio para un tipo específico de meditación
  Future<void> playMeditationAudio(MeditationType type) async {
    try {
      _currentType = type;
      
      if (_isMuted) {
        await _audioPlayer.setVolume(0);
      } else {
        await _audioPlayer.setVolume(_volume);
      }
      
      await _audioPlayer.setAsset(_meditationSounds[type]!);
      await _audioPlayer.setLoopMode(LoopMode.one); // Repetir continuamente
      await _audioPlayer.play();
    } catch (e) {
      if (kDebugMode) {
        print('Error al reproducir audio: $e');
      }
    }
  }
  
  // Pausar audio
  Future<void> pause() async {
    await _audioPlayer.pause();
  }
  
  // Reanudar audio
  Future<void> resume() async {
    await _audioPlayer.play();
  }
  
  // Detener audio
  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentType = null;
  }
  
  // Silenciar/desilenciar
  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    await _audioPlayer.setVolume(_isMuted ? 0 : _volume);
  }
  
  // Establecer volumen
  Future<void> setVolume(double volume) async {
    _volume = volume;
    if (!_isMuted) {
      await _audioPlayer.setVolume(_volume);
    }
  }
  
  // Al eliminar la instancia, liberar recursos
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
  
  // Obtener el tipo de meditación basado en el título
  MeditationType getMeditationTypeFromTitle(String title) {
    final titleLower = title.toLowerCase();
    
    if (titleLower.contains('calma') || titleLower.contains('tranquil')) {
      return MeditationType.calm;
    } else if (titleLower.contains('concentración') || titleLower.contains('focus')) {
      return MeditationType.focus;
    } else if (titleLower.contains('dormir') || titleLower.contains('noche') || titleLower.contains('sleep')) {
      return MeditationType.sleep;
    } else if (titleLower.contains('energía') || titleLower.contains('energy')) {
      return MeditationType.energy;
    } else if (titleLower.contains('estrés') || titleLower.contains('stress')) {
      return MeditationType.stress;
    } else if (titleLower.contains('mañana') || titleLower.contains('matutina') || titleLower.contains('morning')) {
      return MeditationType.morning;
    } else if (titleLower.contains('tarde') || titleLower.contains('noche') || titleLower.contains('evening')) {
      return MeditationType.evening;
    }
    
    // Predeterminado si no hay coincidencia
    return MeditationType.calm;
  }
} 