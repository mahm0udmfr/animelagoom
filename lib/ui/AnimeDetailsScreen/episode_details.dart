import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

class EpisodeDetailsCard extends StatefulWidget {
  final String imageUrl;
  final String episodeNumber;
  final String title;
  final String duration;
  final String airDate;
  final String description;

  const EpisodeDetailsCard({
    super.key,
    required this.imageUrl,
    required this.episodeNumber,
    required this.title,
    required this.duration,
    required this.airDate,
    required this.description,
  });

  @override
  State<EpisodeDetailsCard> createState() => _EpisodeDetailsCardState();
}

class _EpisodeDetailsCardState extends State<EpisodeDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.imageUrl,
                width: 100,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(width: 12),

            // Info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.episodeNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.duration,
                    style: AppStyles.regular16greyRoboto,
                  ),
                  Text(
                    'Aired: ${widget.airDate}',
                    style: AppStyles.regular16greyRoboto,
                  ),
                  const SizedBox(height: 8),
                  // Show full description without truncation or read more
                  Text(
                    widget.description,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
