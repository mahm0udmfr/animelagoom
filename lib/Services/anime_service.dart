import 'package:animelagoom/core/api/api_manager.dart';

import '../models/anime_model.dart';

class AnimeService {
  final KitsuApiManager _apiManager;

  AnimeService(this._apiManager);

  Future<List<Anime>> fetchTrendingAnime({int limit = 10, int offset = 0}) async {
    final json = await _apiManager.get('/trending/anime?page[limit]=$limit&page[offset]=$offset');
    return _extractAnimeList(json);
  }

  Future<List<Anime>> fetchUpcomingAnime({int limit = 10, int offset = 0}) async {
    final json = await _apiManager.get('/anime?sort=startDate&page[limit]=$limit&page[offset]=$offset');
    return _extractAnimeList(json);
  }

  Future<List<Anime>> fetchHighestRatedAnime({int limit = 10, int offset = 0}) async {
    final json = await _apiManager.get('/anime?sort=-averageRating&page[limit]=$limit&page[offset]=$offset');
    return _extractAnimeList(json);
  }

  Future<List<Anime>> fetchMostPopularAnime({int limit = 10, int offset = 0}) async {
    final json = await _apiManager.get('/anime?sort=-popularityRank&page[limit]=$limit&page[offset]=$offset');
    return _extractAnimeList(json);
  }

Future<List<Anime>> searchAnime(String query, {int limit = 10, int offset = 0}) async {
  final json = await _apiManager.get(
    '/anime',
    queryParams: {
      'filter[text]': query,
      'page[limit]': '$limit',
      'page[offset]': '$offset',
    },
  );

  return _extractAnimeList(json);
}


  List<Anime> _extractAnimeList(Map<String, dynamic> json) {
    return (json['data'] as List).map((e) => Anime.fromJson(e)).toList();
  }
}

