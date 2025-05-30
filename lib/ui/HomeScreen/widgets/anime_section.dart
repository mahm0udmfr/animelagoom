import 'package:animelagoom/Core/api/api_manager.dart';
import 'package:flutter/material.dart';
import '../../../models/anime_model.dart';
import '../../../services/anime_service.dart';
import 'anime_card.dart';

class AnimeSection extends StatefulWidget {
  final String title;
  final String category;

  const AnimeSection({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  State<AnimeSection> createState() => _AnimeSectionState();
}

class _AnimeSectionState extends State<AnimeSection> {
  late Future<List<Anime>> _animeFuture;

  @override
  void initState() {
    super.initState();
     final api = KitsuApiManager();
    final service = AnimeService(api);
    
    _animeFuture = switch (widget.category) {
      'trending' => service.fetchTrendingAnime(),
      'upcoming' => service.fetchUpcomingAnime(),
      'highestRated' => service.fetchHighestRatedAnime(),
      'mostPopular' => service.fetchMostPopularAnime(),
      _ => Future.value([]),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Anime>>(
            future: _animeFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final items = snapshot.data ?? [];
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return AnimeCard(anime: items[index]);
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
