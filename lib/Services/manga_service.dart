import 'package:animelagoom/models/anime_and_manga_main_model.dart';
import 'package:animelagoom/models/character_model.dart';
import 'package:animelagoom/models/episode_model.dart';
import 'package:animelagoom/models/reaction_model.dart';
import 'package:animelagoom/models/related_media_model.dart';
import '../core/api/api_manager.dart';

class MangaService {
  final KitsuApiManager _api;

  MangaService(this._api);

  Future<List<MediaItem>> fetchTrendingManga({
    int offset = 0,
    int limit = 10,
  }) async {
    final data = await _api.get(
      '/trending/manga',
      queryParams: {
        'page[limit]': '$limit',
        'page[offset]': '$offset',
      },
    );

    return (data['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }

  Future<List<MediaItem>> fetchUpcomingManga({
    int offset = 0,
    int limit = 10,
  }) async {
    final data = await _api.get(
      '/manga',
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

  Future<List<MediaItem>> searchManga(String query,
      {int limit = 10, int offset = 0}) async {
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

  Future<List<Episode>> fetchMangaChapters(String mangaId,
      {int limit = 20, int offset = 0}) async {
    final json = await _api.get(
      '/manga/$mangaId/chapters',
      queryParams: {
        'page[limit]': '$limit',
        'page[offset]': '$offset',
        'sort': 'number',
      },
    );

    return (json['data'] as List).map((e) => Episode.fromJson(e)).toList();
  }

  Future<List<Character>> fetchMangaCharacters(String mangaId,
      {int limit = 20, int offset = 0}) async {
    final json = await _api.get(
      '/manga/$mangaId/manga-characters?include=character',
      queryParams: {
        'page[limit]': '$limit',
        'page[offset]': '$offset',
        'sort': 'role',
      },
    );

    final dataList = json['data'] as List<dynamic>;
    final included = json['included'] as List<dynamic>? ?? [];

    // Match character data by ID
    final includedCharacters = {
      for (var item in included)
        if (item['type'] == 'characters') item['id']: item
    };

    return dataList.map((mangaChar) {
      final characterId = mangaChar['relationships']['character']['data']['id'];
      final characterJson = includedCharacters[characterId];
      return Character.fromKitsuJson(mangaChar, characterJson);
    }).toList();
  }

  Future<List<Reaction>> fetchMangaReactions(String mangaId,
      {int limit = 20, int offset = 0}) async {
    final json = await _api.get(
      '/manga/$mangaId/media-reactions',
      queryParams: {
        'page[limit]': '$limit',
        'page[offset]': '$offset',
        'sort': '-createdAt',
      },
    );

    return (json['data'] as List).map((e) => Reaction.fromJson(e)).toList();
  }

  Future<List<FranchiseRelation>> fetchMangaFranchise(String mangaId) async {
    final json = await _api.get('/manga/$mangaId/relationships/mappings');
    return (json['data'] as List)
        .map((e) => FranchiseRelation.fromJson(e))
        .toList();
  }

  List<MediaItem> _extractMangaList(Map<String, dynamic> json) {
    return (json['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }
}
