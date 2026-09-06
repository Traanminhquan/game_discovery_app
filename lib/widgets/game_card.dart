import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String genre;
  final String platform;
  final String thumbnail;
  final VoidCallback? onTap;

  const GameCard({
    super.key,
    required this.title,
    required this.genre,
    required this.platform,
    required this.thumbnail,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  thumbnail,
                  width: 90,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      width: 90,
                      height: 70,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.sports_esports,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(genre),

                    const SizedBox(height: 4),

                    Text(
                      platform,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}