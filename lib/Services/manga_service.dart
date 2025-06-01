import '../core/api/api_manager.dart';
import '../models/manga_model.dart';

class MangaService {
  final KitsuApiManager _api;

  MangaService(this._api);

  Future<List<Manga>> fetchTrendingManga({
    int offset = 0,
    int limit = 10,
  }) async {
    final data = await _api.get('/trending/manga',
    queryParams: {
      'page[limit]': '$limit',
      'page[offset]': '$offset',
    },);

  return (data['data'] as List).map((e) => Manga.fromJson(e)).toList();
  }

  Future<List<Manga>> fetchUpcomingManga({
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
    return (data['data'] as List).map((e) => Manga.fromJson(e)).toList();
  }

  Future<List<Manga>> fetchHighestRatedManga({
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
    return (data['data'] as List).map((e) => Manga.fromJson(e)).toList();
  }

  Future<List<Manga>> fetchMostPopularManga({
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
    return (data['data'] as List).map((e) => Manga.fromJson(e)).toList();
  }

  Future<List<Manga>> searchManga(String query, {int limit = 10, int offset = 0}) async {
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

List<Manga> _extractMangaList(Map<String, dynamic> json) {
  return (json['data'] as List).map((e) => Manga.fromJson(e)).toList();
}

}
