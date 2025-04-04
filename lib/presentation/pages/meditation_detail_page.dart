import 'package:flutter/material.dart';
import '../pages/meditation_session_page.dart';

class MeditationDetailPage extends StatelessWidget {
  final String title;
  final String duration;
  final String category;
  final String description;

  const MeditationDetailPage({
    super.key,
    required this.title,
    required this.duration,
    required this.category,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.self_improvement,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text(category),
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(duration),
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Descripción',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Beneficios',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  _buildBenefitItem(context, 'Reduce el estrés y la ansiedad'),
                  _buildBenefitItem(context, 'Mejora la concentración'),
                  _buildBenefitItem(context, 'Aumenta la conciencia plena'),
                  _buildBenefitItem(context, 'Promueve el bienestar emocional'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MeditationSessionPage(
                              title: title,
                              duration: _parseDuration(duration),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Comenzar meditación'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  int _parseDuration(String duration) {
    // Extraer el número de minutos del formato "X min"
    final regex = RegExp(r'(\d+)');
    final match = regex.firstMatch(duration);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    return 5; // valor predeterminado si no se puede analizar
  }
} 