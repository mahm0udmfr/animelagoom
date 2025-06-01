import 'package:flutter/material.dart';
import 'package:animelagoom/core/api/api_manager.dart';
import 'package:animelagoom/Services/manga_service.dart';
import 'package:animelagoom/models/manga_model.dart';
import 'manga_card.dart';

class MangaSection extends StatefulWidget {
  final String title;
  final String category;

  const MangaSection({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  State<MangaSection> createState() => _MangaSectionState();
}

class _MangaSectionState extends State<MangaSection> {
  final List<Manga> _mangaList = [];
  final ScrollController _scrollController = ScrollController();

  late final MangaService _service;
  bool _isLoading = false;
  bool _hasMore = true;
  int _offset = 0;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _service = MangaService(KitsuApiManager());
    _scrollController.addListener(_onScroll);
    _fetchManga();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchManga();
    }
  }

  Future<void> _fetchManga() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    List<Manga> newItems = [];

    switch (widget.category) {
      case 'trending':
        newItems = await _service.fetchTrendingManga(offset: _offset, limit: _limit);
        break;
      case 'upcoming':
        newItems = await _service.fetchUpcomingManga(offset: _offset, limit: _limit);
        break;
      case 'highestRated':
        newItems = await _service.fetchHighestRatedManga(offset: _offset, limit: _limit);
        break;
      case 'mostPopular':
        newItems = await _service.fetchMostPopularManga(offset: _offset, limit: _limit);
        break;
      default:
        newItems = [];
    }

    setState(() {
      _mangaList.addAll(newItems);
      _offset += _limit;
      _isLoading = false;
      if (newItems.length < _limit) _hasMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
@override
Widget build(BuildContext context) {
  // If empty and not loading, return an empty container (don't show section)
  if (_mangaList.isEmpty && !_isLoading) {
    return const SizedBox.shrink();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      SizedBox(
        height: 200,
        child: _mangaList.isEmpty && _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: _mangaList.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _mangaList.length) {
                    return const SizedBox(
                      width: 60,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return MangaCard(manga: _mangaList[index]);
                },
                separatorBuilder: (_, _) => const SizedBox(width: 8),
              ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

}
