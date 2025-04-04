import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../widgets/stats_card.dart';
import '../widgets/achievement_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navegar a la página de configuración
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configuración próximamente')),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is UserLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar y nombre
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFF6B5BB5),
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Usuario de Mindfulness',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Miembro desde mayo 2024',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Estadísticas detalladas
                  Text(
                    'Tus estadísticas',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: StatsCard(
                          icon: Icons.timer,
                          value: '${state.totalMinutes}',
                          label: 'Minutos totales',
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: StatsCard(
                          icon: Icons.local_fire_department,
                          value: '${state.streak}',
                          label: 'Racha actual',
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: StatsCard(
                          icon: Icons.calendar_today,
                          value: state.lastMeditationTime != null 
                              ? _formatDate(state.lastMeditationTime!)
                              : 'Nunca',
                          label: 'Última sesión',
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: StatsCard(
                          icon: Icons.emoji_events,
                          value: (state.totalMinutes ~/ 60).toString(),
                          label: 'Horas totales',
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Logros
                  Text(
                    'Tus logros',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  AchievementCard(
                    title: 'Primera meditación',
                    description: 'Completaste tu primera sesión de meditación',
                    icon: Icons.star,
                    isUnlocked: state.totalMinutes > 0,
                  ),
                  
                  AchievementCard(
                    title: 'Una hora de paz',
                    description: 'Acumulaste 60 minutos de meditación',
                    icon: Icons.access_time_filled,
                    isUnlocked: state.totalMinutes >= 60,
                  ),
                  
                  AchievementCard(
                    title: 'Constancia',
                    description: 'Mantuviste una racha de 7 días consecutivos',
                    icon: Icons.calendar_month,
                    isUnlocked: state.streak >= 7,
                  ),
                  
                  AchievementCard(
                    title: 'Maestro Zen',
                    description: 'Completaste más de 30 sesiones de meditación',
                    icon: Icons.self_improvement,
                    isUnlocked: false, // Implementar cuando tengamos conteo de sesiones
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Botón de reinicio para pruebas
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Mostrar diálogo de confirmación
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Reiniciar estadísticas'),
                            content: const Text('¿Estás seguro? Esta acción no se puede deshacer.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Reiniciar estadísticas y cerrar diálogo
                                  context.read<UserBloc>().add(const ResetUserStats());
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Estadísticas reiniciadas')),
                                  );
                                },
                                child: const Text('Reiniciar'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reiniciar estadísticas'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        foregroundColor: Colors.red[800],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          
          return const Center(child: Text('Error al cargar el perfil'));
        },
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
} 