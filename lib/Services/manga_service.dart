import 'dart:convert';
import 'package:animelagoom/models/anime_and_manga_main_model.dart';
import 'package:animelagoom/models/character_model.dart';
import 'package:animelagoom/models/episode_model.dart';
import 'package:animelagoom/models/genere_model.dart';
import 'package:animelagoom/models/reaction_model.dart';
import 'package:animelagoom/models/related_media_model.dart';
import 'package:http/http.dart' as http;
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
      '/manga/$mangaId/characters',
      queryParams: {
        'page[limit]': '$limit',
        'page[offset]': '$offset',
        'include': 'character.castings.person',
      },
    );

    final includedList = json['included'] as List<dynamic>? ?? [];

    final Map<String, List<dynamic>> included = {
      'castings': includedList.where((e) => e['type'] == 'castings').toList(),
      'people': includedList.where((e) => e['type'] == 'people').toList(),
      'characters':
          includedList.where((e) => e['type'] == 'characters').toList(),
    };

    return (json['data'] as List).map((entry) {
      final characterRel = entry['relationships']['character']['data'];
      final characterId = characterRel?['id'];

      final characterData = included['characters']?.firstWhere(
        (e) => e['id'] == characterId,
        orElse: () => null,
      );

      if (characterData != null) {
        final castings = included['castings']
            ?.where((e) =>
                e['relationships']['character']['data']['id'] == characterId)
            .toList();

        final people = included['people'];

        return Character.fromJson(characterData, {
          'castings': castings ?? [],
          'people': people ?? [],
        });
      }

      return Character(
        id: characterId ?? 'unknown',
        name: 'Unknown',
      );
    }).toList();
  }

  Future<List<Reaction>> fetchMangaReactions(
    String mediaId,
  ) async {
    final json = await _api.get(
      '/reviews?filter[mediaId]=$mediaId&include=user',
    );

    final included = (json['included'] as List<dynamic>?) ?? [];
    final Map<String, List<dynamic>> inc = {
      'user': included.where((e) => e['type'] == 'users').toList()
    };
    return (json['data'] as List)
        .map((e) => Reaction.fromJson(e as Map<String, dynamic>, inc))
        .toList();
  }

  Future<List<Franchise>> fetchMangaFranchise(String mangaId) async {
    final json = await _api.get('/manga/$mangaId/relationships/mappings');
    return (json['data'] as List).map((e) => Franchise.fromJson(e)).toList();
  }

  List<MediaItem> _extractMangaList(Map<String, dynamic> json) {
    return (json['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }

  static Future<List<Genre>> fetchGenresByMangaId(String mangaid) async {
    final url = Uri.parse("https://kitsu.io/api/edge/manga/$mangaid/categories");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return GenreListResponse.fromJson(jsonBody).data;
    } else {
      throw Exception("Failed to load genres for anime ID: $mangaid");
    }
  }
}
