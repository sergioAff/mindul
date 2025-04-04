import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/meditation/meditation_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../widgets/meditation_card.dart';
import '../pages/meditation_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cargar los datos del usuario y meditaciones al construir la página
    context.read<UserBloc>().add(const LoadUserStats());
    context.read<MeditationBloc>().add(const LoadMeditations());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Moments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Búsqueda próximamente')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificaciones próximamente')),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Recargar datos
          context.read<UserBloc>().add(const LoadUserStats());
          return Future.delayed(const Duration(milliseconds: 800));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Saludo personalizado
              _buildGreeting(context),
              const SizedBox(height: 24),

              // Sección de estadísticas
              _buildStatsSection(context),
              const SizedBox(height: 32),

              // Continuar práctica
              _buildContinueSession(context),
              const SizedBox(height: 32),

              // Sección recomendada: título dinámico según la hora del día
              Text(
                _getRecommendedSectionTitle(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Lista de meditaciones recomendadas
              ..._getRecommendedMeditations(context)
                  .map(
                    (meditation) => MeditationCard(
                      title: meditation['title']!,
                      duration: meditation['duration']!,
                      category: meditation['category']!,
                      description: meditation['description']!,
                      color:
                          _getCategoryColor(context, meditation['category']!),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MeditationDetailPage(
                              title: meditation['title']!,
                              duration: meditation['duration']!,
                              category: meditation['category']!,
                              description: meditation['description']!,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),

              const SizedBox(height: 32),

              // Sección de relajación rápida
              Text(
                'Relajación rápida',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildQuickRelaxationSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Buenos días';
    } else if (hour < 18) {
      greeting = 'Buenas tardes';
    } else {
      greeting = 'Buenas noches';
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        String subtitle = 'Es un buen momento para meditar';

        if (state is UserLoaded && state.streak > 0) {
          subtitle = '¡Llevas ${state.streak} días de racha! ¡Sigue así!';
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        int minutes = 0;
        int streak = 0;

        if (state is UserLoaded) {
          minutes = state.totalMinutes;
          streak = state.streak;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.timer,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$minutes min',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Text('Meditados'),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$streak días',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Text('Racha'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContinueSession(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Continúa tu práctica',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
                Theme.of(context).colorScheme.secondary.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.self_improvement,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Mindfulness diario',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Continúa con tu rutina diaria de 10 minutos de meditación guiada',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '10 min',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeditationDetailPage(
                            title: 'Mindfulness diario',
                            duration: '10 min',
                            category: 'Práctica diaria',
                            description:
                                'Continúa con tu rutina diaria de meditación guiada para mantener y fortalecer tu práctica de mindfulness.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Continuar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickRelaxationSection(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildQuickRelaxationCard(
            context,
            title: 'Respiración',
            duration: '3 min',
            icon: Icons.air,
            color: Colors.blue,
            count: 5,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeditationDetailPage(
                    title: 'Meditación rápida: Respiración',
                    duration: '3 min',
                    category: 'Relajación rápida',
                    description:
                        'Una breve meditación para momentos en que necesitas un respiro rápido.',
                  ),
                ),
              );
            },
          ),
          _buildQuickRelaxationCard(
            context,
            title: 'Calma rápida',
            duration: '5 min',
            icon: Icons.spa,
            color: Colors.purple,
            count: 3,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeditationDetailPage(
                    title: 'Meditación rápida: Calma rápida',
                    duration: '5 min',
                    category: 'Relajación rápida',
                    description:
                        'Una breve meditación para momentos en que necesitas un respiro rápido.',
                  ),
                ),
              );
            },
          ),
          _buildQuickRelaxationCard(
            context,
            title: 'Relajación',
            duration: '7 min',
            icon: Icons.water_drop,
            color: Colors.teal,
            count: 4,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeditationDetailPage(
                    title: 'Meditación rápida: Relajación',
                    duration: '7 min',
                    category: 'Relajación rápida',
                    description:
                        'Una breve meditación para momentos en que necesitas un respiro rápido.',
                  ),
                ),
              );
            },
          ),
          _buildQuickRelaxationCard(
            context,
            title: 'Descanso',
            duration: '4 min',
            icon: Icons.nightlight,
            color: Colors.indigo,
            count: 2,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeditationDetailPage(
                    title: 'Meditación rápida: Descanso',
                    duration: '4 min',
                    category: 'Relajación rápida',
                    description:
                        'Una breve meditación para momentos en que necesitas un respiro rápido.',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickRelaxationCard(
    BuildContext context, {
    required String title,
    required String duration,
    required IconData icon,
    required Color color,
    required int count,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                duration,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRecommendedSectionTitle() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Meditaciones matutinas';
    } else if (hour < 17) {
      return 'Meditaciones para la tarde';
    } else if (hour < 21) {
      return 'Meditaciones para la noche';
    } else {
      return 'Meditaciones para dormir';
    }
  }

  List<Map<String, String>> _getRecommendedMeditations(BuildContext context) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      // Mañana
      return [
        {
          'title': 'Energía matutina',
          'duration': '10 min',
          'category': 'Energía',
          'description': 'Comienza tu día con energía y claridad mental',
        },
        {
          'title': 'Intención del día',
          'duration': '7 min',
          'category': 'Concentración',
          'description': 'Establece una intención clara para tu jornada',
        },
      ];
    } else if (hour < 17) {
      // Tarde
      return [
        {
          'title': 'Pausa en el trabajo',
          'duration': '5 min',
          'category': 'Reducción de estrés',
          'description': 'Toma un respiro en medio de tu jornada laboral',
        },
        {
          'title': 'Revitalización',
          'duration': '8 min',
          'category': 'Energía',
          'description': 'Recarga tu energía durante la tarde',
        },
      ];
    } else if (hour < 21) {
      // Noche
      return [
        {
          'title': 'Relajación post-trabajo',
          'duration': '12 min',
          'category': 'Descanso',
          'description': 'Desconecta después de un día intenso',
        },
        {
          'title': 'Transición nocturna',
          'duration': '10 min',
          'category': 'Calma',
          'description': 'Prepárate para una noche tranquila',
        },
      ];
    } else {
      // Noche tardía
      return [
        {
          'title': 'Guía para dormir',
          'duration': '15 min',
          'category': 'Para dormir',
          'description': 'Técnicas de relajación para conciliar el sueño',
        },
        {
          'title': 'Meditación nocturna',
          'duration': '20 min',
          'category': 'Para dormir',
          'description': 'Calma profunda para una noche de descanso',
        },
      ];
    }
  }

  Color _getCategoryColor(BuildContext context, String category) {
    switch (category) {
      case 'Energía':
        return Colors.orange;
      case 'Concentración':
        return Colors.blue;
      case 'Reducción de estrés':
        return Colors.purple;
      case 'Descanso':
        return Colors.teal;
      case 'Calma':
        return Colors.indigo;
      case 'Para dormir':
        return Colors.deepPurple;
      default:
        return Theme.of(context).primaryColor;
    }
  }
}
