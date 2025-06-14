import 'package:animelagoom/Services/anime_service.dart';
import 'package:animelagoom/Services/manga_service.dart';
import 'package:animelagoom/core/api/api_manager.dart';
import 'package:animelagoom/models/anime_and_manga_main_model.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/anime_details_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String contentType;
  final String initialQuery;

  const SearchScreen({
    super.key,
    required this.contentType,
    required this.initialQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final KitsuApiManager _apiManager = KitsuApiManager();

  List<MediaItem> _results = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialQuery;
    _searchContent(widget.initialQuery);
  }

  Future<void> _searchContent(String query) async {
    setState(() => _isLoading = true);
    try {
      if (widget.contentType == 'anime') {
        final animeService = AnimeService(_apiManager);
        final results = await animeService.searchAnime(query);
        setState(() => _results = results);
      } else {
        final mangaService = MangaService(_apiManager);
        final results = await mangaService.searchManga(query);
        setState(() => _results = results);
      }
    } catch (e) {
      debugPrint('Search error: $e');
      setState(() => _results = []);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAnime = widget.contentType == 'anime';

    return Scaffold(
      appBar: AppBar(title: Text('Search ${isAnime ? "Anime" : "Manga"}')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search ${widget.contentType}...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchContent(_searchController.text),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: _searchContent,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _results.isEmpty
                      ? const Center(child: Text('No results found.'))
                      : ListView.separated(
                          itemCount: _results.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = _results[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AnimeDetailsScreen(
                                      mediaItem: item,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                  title: Text(isAnime
                                      ? item.attributes.canonicalTitle
                                      : item.attributes.canonicalTitle),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(item
                                            .attributes.coverImage?.original ??
                                        item.attributes.posterImage?.original ??
                                        'https://via.placeholder.com/150'),
                                    onBackgroundImageError: (_, __) =>
                                        const Icon(Icons.broken_image),
                                  ),
                                  subtitle: Text(isAnime
                                      ? (item).attributes.titles.en ??
                                          item.attributes.titles.enJp ??
                                          "unknown"
                                      : (item).attributes.titles.en ??
                                          item.attributes.titles.enJp ??
                                          "unknown")),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
