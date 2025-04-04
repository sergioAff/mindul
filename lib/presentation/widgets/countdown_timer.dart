import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  final int secondsRemaining;
  final bool isPlaying;
  final Function onComplete;

  const CountdownTimer({
    super.key,
    required this.secondsRemaining,
    required this.isPlaying,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = (secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 220,
              child: CircularProgressIndicator(
                value: secondsRemaining > 0 
                    ? 1 - (secondsRemaining / (int.parse(minutes) * 60 + int.parse(seconds) + 1)) 
                    : 1.0,
                strokeWidth: 8,
                backgroundColor: Colors.white.withOpacity(0.2),
                color: Colors.white,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$minutes:$seconds',
                  style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isPlaying ? 'Meditando...' : 'Pausado',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 48),
        const Text(
          'Respira profundamente y permite que tu mente se calme. Si te distraes, regresa suavemente tu atención a la respiración.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
} 