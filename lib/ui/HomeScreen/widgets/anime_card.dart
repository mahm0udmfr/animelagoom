import 'package:animelagoom/ui/DetailsScreen/anime_details_screen2.dart';
import 'package:flutter/material.dart';
import '../../../models/anime_model.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AnimeDetailsScreen2(anime: anime,),
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
                  anime.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, ___, __) => Container(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              anime.title,
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
