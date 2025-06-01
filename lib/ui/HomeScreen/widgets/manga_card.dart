import 'package:animelagoom/models/anime_model.dart';
import 'package:animelagoom/ui/DetailsScreen/anime_details_screen2.dart';
import 'package:flutter/material.dart';
import '../../../models/manga_model.dart';

class MangaCard extends StatelessWidget {
  final Manga manga;

  const MangaCard({super.key, required this.manga});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
            // Navigator.push(
      // context,
      // MaterialPageRoute(
        // builder: (_) => AnimeDetailsScreen2(anime:    ,),
      // ),
    // );
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
                  manga.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                  },
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              manga.title,
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
