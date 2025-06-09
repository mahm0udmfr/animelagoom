import 'package:animelagoom/models/episode_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animelagoom/core/api/api_manager.dart';
import 'package:animelagoom/Services/anime_service.dart';
import 'package:animelagoom/Services/manga_service.dart';

// This widget is ready to be placed directly into a TabBarView.
class EpisodesScreen extends StatefulWidget {
  final String mediaId;
  final String mediaType; // 'anime' or 'manga'
  final String mediaImage;
  const EpisodesScreen({
    super.key,
    required this.mediaId,
    required this.mediaType,
    required this.mediaImage,
  });

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  late Future<List<Episode>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    final apiManager = KitsuApiManager();
    final animeService = AnimeService(apiManager);
    final mangaService = MangaService(apiManager);

    if (widget.mediaType == 'anime') {
      _itemsFuture = animeService.fetchAnimeEpisodes(widget.mediaId);
    } else {
      _itemsFuture = mangaService.fetchMangaChapters(widget.mediaId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Episode>>(
      future: _itemsFuture,
      builder: (context, snapshot) {
        // 1. Handle Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Handle Error State
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // 3. Handle Empty or Null Data
        final items = snapshot.data;
        if (items == null || items.isEmpty) {
          return const Center(child: Text('No episodes or chapters found.'));
        }
        return _buildItemsList(items);
      },
    );
  }

  /// A helper method to build the list view for better code organization.
  Widget _buildItemsList(List<Episode> items) {
    final itemLabel = widget.mediaType == 'anime' ? 'Episode' : 'Chapter';
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final number = item.number ?? index + 1;

        return ListTile(
          title: Text('$itemLabel $number'),

          subtitle: CachedNetworkImage(
            imageUrl:  item.thumbnail?.original ?? widget.mediaImage,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => Container(
              width: 50,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
