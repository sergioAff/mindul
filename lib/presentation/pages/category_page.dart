import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import 'meditation_list_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explora por categoría',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Encuentra meditaciones adaptadas a tus necesidades',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildCategoryCard(
                    context,
                    title: 'Principiantes',
                    icon: Icons.star,
                    color: Colors.blue,
                    count: 5,
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Reducción de estrés',
                    icon: Icons.spa,
                    color: Colors.purple,
                    count: 8,
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Para dormir',
                    icon: Icons.bedtime,
                    color: Colors.indigo,
                    count: 6,
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Concentración',
                    icon: Icons.psychology,
                    color: Colors.orange,
                    count: 4,
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Gratitud',
                    icon: Icons.favorite,
                    color: Colors.red,
                    count: 3,
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Confianza',
                    icon: Icons.shield,
                    color: Colors.green,
                    count: 5,
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Respiración',
                    icon: Icons.air,
                    color: Colors.cyan,
                    count: 7,
                  ),
                  _buildCategoryCard(
                    context,
                    title: 'Naturaleza',
                    icon: Icons.forest,
                    color: Colors.teal,
                    count: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required int count,
  }) {
    return CategoryCard(
      title: title,
      icon: icon,
      color: color,
      count: count,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeditationListPage(
              category: title,
              categoryColor: color,
            ),
          ),
        );
      },
    );
  }
} 