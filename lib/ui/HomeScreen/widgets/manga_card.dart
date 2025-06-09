import 'package:animelagoom/models/anime_and_manga_main_model.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/anime_details_screen.dart';
import 'package:flutter/material.dart';

class MangaCard extends StatelessWidget {
  final MediaItem manga;

  const MangaCard({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AnimeDetailsScreen(
              mediaItem: manga,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  manga.attributes.coverImage?.original ??
                      manga.attributes.posterImage?.original ??
                      '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.broken_image)),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2));
                  },
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              manga.attributes.canonicalTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
