import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;

  const AchievementCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isUnlocked ? 2 : 0,
      color: isUnlocked 
          ? Theme.of(context).colorScheme.secondaryContainer
          : Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isUnlocked 
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                    : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: isUnlocked 
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey[500],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? Colors.black87 : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isUnlocked ? Colors.black54 : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            if (isUnlocked)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24,
              )
            else
              const Icon(
                Icons.lock,
                color: Colors.grey,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
} 