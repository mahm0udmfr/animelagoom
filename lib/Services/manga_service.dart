import 'package:animelagoom/models/anime_and_manga_model.dart';

import '../core/api/api_manager.dart';

class MangaService {
  final KitsuApiManager _api;

  MangaService(this._api);

  Future<List<MediaItem>> fetchTrendingManga({
    int offset = 0,
    int limit = 10,
  }) async {
    final data = await _api.get('/trending/manga',
    queryParams: {
      'page[limit]': '$limit',
      'page[offset]': '$offset',
    },);

  return (data['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }

  Future<List<MediaItem>> fetchUpcomingManga({
    int offset = 0,
    int limit = 10,
  }) async {
    final data = await _api.get('/manga', 
      queryParams: {
        'filter[status]': 'upcoming',
        'sort': 'startDate',
        'page[limit]': '$limit',
        'page[offset]': '$offset',
      },
    
    );
    return (data['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }

  Future<List<MediaItem>> fetchHighestRatedManga({
    int offset = 0,
    int limit = 10,
  }) async {
    final data = await _api.get(
      '/manga',
      queryParams: {
        'sort': '-ratingRank',
        'page[limit]': '$limit',
        'page[offset]': '$offset',
      },
    );
    return (data['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }

  Future<List<MediaItem>> fetchMostPopularManga({
    int offset = 0,
    int limit = 10,
  }) async {
    final data = await _api.get(
      '/manga',
      queryParams: {
        'sort': '-popularityRank',
        'page[limit]': '$limit',
        'page[offset]': '$offset',
      },
    );
    return (data['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }

  Future<List<MediaItem>> searchManga(String query, {int limit = 10, int offset = 0}) async {
  final json = await _api.get(
    '/manga',
    queryParams: {
      'filter[text]': query,
      'page[limit]': '$limit',
      'page[offset]': '$offset',
    },
  );

  return _extractMangaList(json);
}

List<MediaItem> _extractMangaList(Map<String, dynamic> json) {
  return (json['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
}

}
