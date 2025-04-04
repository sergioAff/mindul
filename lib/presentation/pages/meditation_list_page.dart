import 'package:flutter/material.dart';
import '../widgets/meditation_card.dart';
import 'meditation_detail_page.dart';

class MeditationListPage extends StatelessWidget {
  final String category;
  final Color categoryColor;

  const MeditationListPage({
    super.key,
    required this.category,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: categoryColor.withOpacity(0.1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header con información de la categoría
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: categoryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: categoryColor.withOpacity(0.2),
                  foregroundColor: categoryColor,
                  radius: 24,
                  child: _getCategoryIcon(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getCategoryDescription(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'Meditaciones en esta categoría',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          
          // Lista de meditaciones según la categoría
          ..._getMeditationsForCategory().map((meditation) => 
            MeditationCard(
              title: meditation['title']!,
              duration: meditation['duration']!,
              category: category,
              description: meditation['description']!,
              color: categoryColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationDetailPage(
                      title: meditation['title']!,
                      duration: meditation['duration']!,
                      category: category,
                      description: meditation['description']!,
                    ),
                  ),
                );
              },
            ),
          ).toList(),
        ],
      ),
    );
  }
  
  Icon _getCategoryIcon() {
    switch (category) {
      case 'Principiantes':
        return const Icon(Icons.star);
      case 'Reducción de estrés':
        return const Icon(Icons.spa);
      case 'Para dormir':
        return const Icon(Icons.bedtime);
      case 'Concentración':
        return const Icon(Icons.psychology);
      case 'Gratitud':
        return const Icon(Icons.favorite);
      case 'Confianza':
        return const Icon(Icons.shield);
      case 'Respiración':
        return const Icon(Icons.air);
      case 'Naturaleza':
        return const Icon(Icons.forest);
      default:
        return const Icon(Icons.category);
    }
  }
  
  String _getCategoryDescription() {
    switch (category) {
      case 'Principiantes':
        return 'Primeros pasos en la meditación';
      case 'Reducción de estrés':
        return 'Calma tu mente y libera la tensión';
      case 'Para dormir':
        return 'Concilia el sueño de forma natural';
      case 'Concentración':
        return 'Mejora tu atención y enfoque';
      case 'Gratitud':
        return 'Practica la gratitud diaria';
      case 'Confianza':
        return 'Fortalece tu autoestima';
      case 'Respiración':
        return 'Técnicas de respiración consciente';
      case 'Naturaleza':
        return 'Conecta con el mundo natural';
      default:
        return 'Explora estas meditaciones';
    }
  }
  
  List<Map<String, String>> _getMeditationsForCategory() {
    final List<Map<String, String>> meditations = [];
    
    // Aquí podríamos obtener los datos desde un repositorio real
    switch (category) {
      case 'Principiantes':
        meditations.addAll([
          {
            'title': 'Primeros pasos',
            'duration': '5 min',
            'description': 'Una introducción suave a la práctica de la meditación'
          },
          {
            'title': 'Atención a la respiración',
            'duration': '8 min',
            'description': 'Aprende a enfocar tu atención en la respiración'
          },
          {
            'title': 'Escaneo corporal básico',
            'duration': '10 min',
            'description': 'Técnica para tomar conciencia de tu cuerpo'
          },
          {
            'title': 'Mindfulness diario',
            'duration': '7 min',
            'description': 'Incorpora la atención plena a tu rutina diaria'
          },
          {
            'title': 'Superar obstáculos',
            'duration': '12 min',
            'description': 'Aprende a manejar las dificultades en la meditación'
          },
        ]);
        break;
      case 'Reducción de estrés':
        meditations.addAll([
          {
            'title': 'Calma inmediata',
            'duration': '3 min',
            'description': 'Técnica rápida para momentos de estrés agudo'
          },
          {
            'title': 'Liberación de tensión',
            'duration': '12 min',
            'description': 'Libera la tensión acumulada en tu cuerpo'
          },
          {
            'title': 'Visualización tranquilizante',
            'duration': '15 min',
            'description': 'Imagería guiada para reducir el estrés'
          },
          {
            'title': 'Descanso profundo',
            'duration': '20 min',
            'description': 'Meditación extendida para una relajación completa'
          },
          {
            'title': 'Pausa en el trabajo',
            'duration': '5 min',
            'description': 'Breve pausa para recargar energías durante la jornada laboral'
          },
        ]);
        break;
      case 'Para dormir':
        meditations.addAll([
          {
            'title': 'Preparación para dormir',
            'duration': '10 min',
            'description': 'Ayuda a tu mente a prepararse para el descanso'
          },
          {
            'title': 'Relajación profunda',
            'duration': '20 min',
            'description': 'Relaja tu cuerpo completamente antes de dormir'
          },
          {
            'title': 'Sonidos de la naturaleza',
            'duration': '30 min',
            'description': 'Sonidos relajantes para inducir el sueño'
          },
          {
            'title': 'Visualización nocturna',
            'duration': '15 min',
            'description': 'Imágenes tranquilizantes para conciliar el sueño'
          },
        ]);
        break;
      default:
        meditations.addAll([
          {
            'title': 'Meditación básica',
            'duration': '10 min',
            'description': 'Una meditación general para cualquier momento del día'
          },
          {
            'title': 'Práctica guiada',
            'duration': '15 min',
            'description': 'Meditación con instrucciones detalladas'
          },
        ]);
    }
    
    return meditations;
  }
} 