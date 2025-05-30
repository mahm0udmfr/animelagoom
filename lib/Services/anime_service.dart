import 'package:animelagoom/Core/api/api_manager.dart';

import '../models/anime_model.dart';

class AnimeService {
  final KitsuApiManager _apiManager;

  AnimeService(this._apiManager);

  Future<List<Anime>> fetchTrendingAnime() async {
    final json = await _apiManager.get('/trending/anime');
    return (json['data'] as List).map((e) => Anime.fromJson(e)).toList();
  }

  Future<List<Anime>> fetchUpcomingAnime() async {
    final json = await _apiManager.get('/anime?sort=startDate');
    return (json['data'] as List).map((e) => Anime.fromJson(e)).toList();
  }

  Future<List<Anime>> fetchHighestRatedAnime() async {
    final json = await _apiManager.get('/anime?sort=-averageRating&page[limit]=10');
    return (json['data'] as List).map((e) => Anime.fromJson(e)).toList();
  }

  Future<List<Anime>> fetchMostPopularAnime() async {
    final json = await _apiManager.get('/anime?sort=-popularityRank&page[limit]=10');
    return (json['data'] as List).map((e) => Anime.fromJson(e)).toList();
  }

  Future<List<Anime>> searchAnime(String query) async {
    final json = await _apiManager.get('/anime?filter[text]=$query');
    return (json['data'] as List).map((e) => Anime.fromJson(e)).toList();
  }
}
