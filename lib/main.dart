import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'core/services/audio_service.dart';
import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurar servicios
  await configureDependencies();
  
  // Establecer orientación de la aplicación
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MyApp());
}

Future<void> configureDependencies() async {
  // Registrar servicios
  final notificationService = NotificationService();
  await notificationService.init();
  GetIt.instance.registerSingleton<NotificationService>(notificationService);
  GetIt.instance.registerSingleton<AudioService>(AudioService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindful Moments',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: const Color(0xFF4A6572),
          secondary: const Color(0xFF84A9C0),
        ),
        useMaterial3: true,
      ),
      home: const MeditationSessionDemo(),
    );
  }
}

class MeditationSessionDemo extends StatefulWidget {
  const MeditationSessionDemo({super.key});

  @override
  State<MeditationSessionDemo> createState() => _MeditationSessionDemoState();
}

class _MeditationSessionDemoState extends State<MeditationSessionDemo> {
  final AudioService _audioService = GetIt.instance<AudioService>();
  final NotificationService _notificationService = GetIt.instance<NotificationService>();
  bool _isPlaying = false;
  bool _showVolumeSlider = false;
  int _selectedMeditationIndex = 0;
  final List<Map<String, dynamic>> _meditations = [
    {
      'title': 'Meditación de Calma',
      'type': MeditationType.calm,
      'duration': '10 min',
      'description': 'Una meditación para encontrar paz interior y tranquilidad'
    },
    {
      'title': 'Meditación para Dormir',
      'type': MeditationType.sleep,
      'duration': '15 min',
      'description': 'Te ayudará a conciliar el sueño más fácilmente'
    },
    {
      'title': 'Meditación Energizante',
      'type': MeditationType.energy,
      'duration': '8 min',
      'description': 'Recarga tu energía y vitalidad'
    },
    {
      'title': 'Reducción de Estrés',
      'type': MeditationType.stress,
      'duration': '12 min',
      'description': 'Disminuye la tensión y ansiedad'
    },
  ];

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      
      if (_isPlaying) {
        _audioService.playMeditationAudio(_meditations[_selectedMeditationIndex]['type']);
      } else {
        _audioService.pause();
      }
    });
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

  void _showEndNotification() {
    _notificationService.showMeditationCompletedNotification(
      title: '¡Meditación completada!',
      body: 'Has completado tu sesión de meditación "${_meditations[_selectedMeditationIndex]['title']}"',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Moments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: _showEndNotification,
          ),
        ],
      ),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selecciona una meditación',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Lista de meditaciones
                Expanded(
                  child: ListView.builder(
                    itemCount: _meditations.length,
                    itemBuilder: (context, index) {
                      final meditation = _meditations[index];
                      final isSelected = _selectedMeditationIndex == index;
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: isSelected ? 4 : 1,
                        color: isSelected 
                          ? Theme.of(context).colorScheme.primary 
                          : Theme.of(context).colorScheme.surface,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedMeditationIndex = index;
                              if (_isPlaying) {
                                _audioService.stop();
                                _audioService.playMeditationAudio(meditation['type']);
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meditation['title'],
                                  style: TextStyle(
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : null,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time, 
                                      size: 16, 
                                      color: isSelected ? Colors.white70 : Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      meditation['duration'],
                                      style: TextStyle(
                                        color: isSelected ? Colors.white70 : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  meditation['description'],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white70 : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Controles de reproducción
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Control de volumen
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
                          Expanded(
                            child: Slider(
                              value: _audioService.volume,
                              onChanged: _changeVolume,
                              activeColor: Colors.white,
                              inactiveColor: Colors.white30,
                            ),
                          ),
                        ],
                      ),
                      
                      // Botones de control
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            heroTag: 'btnPlay',
                            onPressed: _togglePlayPause,
                            backgroundColor: Colors.white,
                            child: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Theme.of(context).colorScheme.primary,
                              size: 36,
                            ),
                          ),
                        ],
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
}
