import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String genre;
  final String platform;

  const GameCard({
    super.key,
    required this.title,
    required this.genre,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              child: const Icon(
                Icons.sports_esports,
                size: 36,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    genre,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(
                        Icons.devices,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(platform),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}