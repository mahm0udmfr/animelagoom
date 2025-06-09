import 'package:animelagoom/models/reaction_model.dart';
import 'package:flutter/material.dart';
import 'package:animelagoom/core/api/api_manager.dart';
import 'package:animelagoom/services/anime_service.dart';
import 'package:animelagoom/services/manga_service.dart';

class ReactionScreen extends StatelessWidget {
  final String mediaId;
  final bool isAnime; // true for anime, false for manga

  const ReactionScreen({
    required this.mediaId,
    required this.isAnime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize services directly in build, or better, pass them in if possible
    final KitsuApiManager apiManager = KitsuApiManager();
    final AnimeService animeService = AnimeService(apiManager);
    final MangaService mangaService = MangaService(apiManager);

    final Future<List<Reaction>> reactionsFuture = isAnime
        ? animeService.fetchAnimeReactions(mediaId)
        : mangaService.fetchMangaReactions(mediaId);

    return FutureBuilder<List<Reaction>>(
      future: reactionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final reactions = snapshot.data ?? [];
        if (reactions.isEmpty) {
          return const Center(child: Text('No characters found.'));
        }
        return ListView.builder(
          itemCount: reactions.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final reaction = reactions[index];
            return ListTile(
              leading: reaction.reactionText != null
                  ? Image.network(
                      reaction.userAvatar!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.person),
              title: Text(reaction.userName ?? 'Unknown User'),
              subtitle: Text(reaction.createdAt ?? ''),
              onTap: () {
                // Handle tap, e.g., navigate to character detail screen
              },
            );
          },
        );
      },
    );
  }
}