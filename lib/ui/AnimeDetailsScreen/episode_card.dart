import 'package:cached_network_image/cached_network_image.dart';
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
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
          ),

          // CachedNetworkImage(
          //  imageUrl:  imageUrl,
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          //   placeholder: (context, url) => const CircularProgressIndicator(),
          //   width: double.infinity,
          //   height: 200,
          //   fit: BoxFit.cover,
          //   // errorBuilder: (context, error, stackTrace) {
          //   //   return const SizedBox(
          //   //     width: double.infinity,
          //   //     height: 150,
          //   //     child: Center(
          //   //       child: Icon(Icons.image_not_supported_outlined),
          //   //     ),
          //   //   );
          //   // },
          // ),

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