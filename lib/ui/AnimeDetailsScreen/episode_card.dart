import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    super.key,
    required this.imageUrl,
    required this.episodeNumber,
    required this.episodeTitle,
  });

  final String imageUrl;
  final int episodeNumber;
  final String episodeTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                width: double.infinity,
                height: 120,
                child: Center(
                  child: Icon(Icons.image_not_supported_outlined),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Episode $episodeNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  episodeTitle,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}