import 'package:animelagoom/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:animelagoom/core/api/api_manager.dart';
import 'package:animelagoom/services/anime_service.dart';
import 'package:animelagoom/services/manga_service.dart';

import 'char_card.dart';

class CharactersScreen extends StatelessWidget {
  final String mediaId;
  final bool isAnime; // true for anime, false for manga

  const CharactersScreen({
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

    final Future<List<Character>> charactersFuture = isAnime
        ? animeService.fetchAnimeCharacters(mediaId)
        : mangaService.fetchMangaCharacters(mediaId);

    return FutureBuilder<List<Character>>(
      future: charactersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final characters = snapshot.data ?? [];
        if (characters.isEmpty) {
          return const Center(child: Text('No characters found.'));
        }
        return ListView.builder(
          itemCount: characters.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final character = characters[index];
            return CharacterCard(
              imageUrl: character.imageUrl ?? 'https://via.placeholder.com/150',
              name: character.name,
            );
            //   ListTile(
            //   leading: character.imageUrl != null
            //       ? Image.network(
            //           character.imageUrl!,
            //           width: 100,
            //           height: 100,
            //           fit: BoxFit.cover,
            //         )
            //       : const Icon(Icons.person),
            //   title: Text(character.name ),
            //   subtitle: Text(character.description ?? ''),
            //   onTap: () {
            //     // Handle tap, e.g., navigate to character detail screen
            //   },
            // );
          },
        );
      },
    );
  }
}
