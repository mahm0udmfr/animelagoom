import 'package:animelagoom/models/anime_model.dart';
import 'package:flutter/material.dart';

class AnimeDetailsScreen2 extends StatelessWidget {
  final Anime anime;

  const AnimeDetailsScreen2({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(anime.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(anime.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(anime.title ),
            // Add images, ratings, genres, etc.
          ],
        ),
      ),
    );
  }
}
