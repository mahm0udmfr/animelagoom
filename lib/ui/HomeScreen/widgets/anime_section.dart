import 'package:animelagoom/Core/api/api_manager.dart';
import 'package:animelagoom/Services/anime_service.dart';
import 'package:animelagoom/models/anime_model.dart';
import 'package:animelagoom/ui/HomeScreen/widgets/anime_card.dart';
import 'package:flutter/material.dart';

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
  final List<Anime> _animes = [];
  final ScrollController _scrollController = ScrollController();

  final int _limit = 10;
  int _offset = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  late final AnimeService _animeService;

  @override
  void initState() {
    super.initState();
    final api = KitsuApiManager();
    _animeService = AnimeService(api);

    _scrollController.addListener(_onScroll);
    _fetchAnimes();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoading &&
        _hasMore) {
      _fetchAnimes();
    }
  }

  Future<void> _fetchAnimes() async {
    setState(() {
      _isLoading = true;
    });

    final List<Anime> newAnimes = switch (widget.category) {
      'trending' => await _animeService.fetchTrendingAnime(offset: _offset, limit: _limit),
      'upcoming' => await _animeService.fetchUpcomingAnime(offset: _offset, limit: _limit),
      'highestRated' => await _animeService.fetchHighestRatedAnime(offset: _offset, limit: _limit),
      'mostPopular' => await _animeService.fetchMostPopularAnime(offset: _offset, limit: _limit),
      _ => [],
    };
if (!mounted) return;
    setState(() {
      _animes.addAll(newAnimes);
      _offset += _limit;
      _isLoading = false;
      _hasMore = newAnimes.length == _limit;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          child: _animes.isEmpty && _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _animes.length + (_hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= _animes.length) {
                      return const SizedBox(
                        width: 60,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return AnimeCard(anime: _animes[index]);
                  },
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
