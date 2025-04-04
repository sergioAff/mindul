import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/notification_service.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../widgets/countdown_timer.dart';

class MeditationSessionPage extends StatefulWidget {
  final String title;
  final int duration; // en minutos

  const MeditationSessionPage({
    super.key,
    required this.title,
    required this.duration,
  });

  @override
  State<MeditationSessionPage> createState() => _MeditationSessionPageState();
}

class _MeditationSessionPageState extends State<MeditationSessionPage> {
  bool _isPlaying = false;
  bool _isCompleted = false;
  int _secondsRemaining = 0;
  Timer? _timer;
  final AudioService _audioService = GetIt.instance<AudioService>();
  final NotificationService _notificationService = GetIt.instance<NotificationService>();
  late MeditationType _meditationType;
  bool _showVolumeSlider = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.duration * 60;
    _meditationType = _audioService.getMeditationTypeFromTitle(widget.title);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioService.stop();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startTimer();
        _audioService.playMeditationAudio(_meditationType);
      } else {
        _timer?.cancel();
        _audioService.pause();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
          _isPlaying = false;
          _isCompleted = true;
          _updateUserStats();
          _audioService.stop();
          _showCompletionNotification();
        }
      });
    });
  }

  void _showCompletionNotification() {
    _notificationService.showMeditationCompletedNotification(
      title: '¡Meditación completada!',
      body: 'Has completado tu sesión de ${widget.duration} minutos de "${widget.title}"',
    );
  }

  void _updateUserStats() {
    // Actualizar las estadísticas del usuario
    context.read<UserBloc>().add(UpdateMeditationTime(widget.duration));
    context.read<UserBloc>().add(const UpdateMeditationStreak());
  }

  void _resetSession() {
    setState(() {
      _secondsRemaining = widget.duration * 60;
      _isPlaying = false;
      _isCompleted = false;
      _timer?.cancel();
      _audioService.stop();
    });
  }

  void _onSessionComplete() {
    if (!_isCompleted) {
      setState(() {
        _isCompleted = true;
        _isPlaying = false;
        _secondsRemaining = 0;
        _timer?.cancel();
      });
      _audioService.stop();
      _updateUserStats();
      _showCompletionNotification();
    }
  }

  void _toggleMute() {
    setState(() {
      _audioService.toggleMute();
    });
  }

  void _changeVolume(double value) {
    setState(() {
      _audioService.setVolume(value);
    });
  }

  void _toggleVolumeSlider() {
    setState(() {
      _showVolumeSlider = !_showVolumeSlider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Mostrar diálogo de confirmación si la meditación está en progreso
        if (_isPlaying) {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('¿Interrumpir meditación?'),
              content: const Text('¿Estás seguro de que deseas salir? El progreso no se guardará.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Salir'),
                ),
              ],
            ),
          );
          return shouldPop ?? false;
        }
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          if (_isPlaying) {
                            _togglePlayPause();
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              _audioService.isMuted
                                  ? Icons.volume_off
                                  : Icons.volume_up,
                              color: Colors.white,
                            ),
                            onPressed: _toggleMute,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            onPressed: _toggleVolumeSlider,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_showVolumeSlider)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.volume_down, color: Colors.white),
                          Expanded(
                            child: Slider(
                              value: _audioService.volume,
                              onChanged: _changeVolume,
                              activeColor: Colors.white,
                              inactiveColor: Colors.white30,
                            ),
                          ),
                          const Icon(Icons.volume_up, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: _isCompleted
                        ? _buildCompletionView()
                        : CountdownTimer(
                            secondsRemaining: _secondsRemaining,
                            isPlaying: _isPlaying,
                            onComplete: _onSessionComplete,
                          ),
                  ),
                ),
                if (!_isCompleted)
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white.withOpacity(0.8),
                            size: 32,
                          ),
                          onPressed: _resetSession,
                        ),
                        const SizedBox(width: 32),
                        FloatingActionButton(
                          onPressed: _togglePlayPause,
                          backgroundColor: Colors.white,
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Theme.of(context).colorScheme.primary,
                            size: 36,
                          ),
                        ),
                        const SizedBox(width: 32),
                        IconButton(
                          icon: Icon(
                            Icons.skip_next,
                            color: Colors.white.withOpacity(0.8),
                            size: 32,
                          ),
                          onPressed: _onSessionComplete,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
          size: 100,
        ),
        const SizedBox(height: 24),
        const Text(
          '¡Felicidades!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Has completado ${widget.duration} minutos de meditación',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text('Volver al inicio'),
        ),
      ],
    );
  }
} 