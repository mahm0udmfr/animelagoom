import 'package:animelagoom/models/anime_and_manga_main_model.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/anime_details_screen.dart';
import 'package:flutter/material.dart';


class AnimeCard extends StatelessWidget {
  final MediaItem anime;

  const AnimeCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnimeDetailsScreen(mediaItem: anime,),
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
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  anime.attributes.posterImage?.original ?? anime.attributes.coverImage?.original?? '',
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                  },
                  fit: BoxFit.cover,
                  errorBuilder: (_, ___, __) => Container(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              anime.attributes.canonicalTitle,
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
