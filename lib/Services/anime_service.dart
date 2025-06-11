import 'package:animelagoom/core/api/api_manager.dart';
import 'package:animelagoom/models/anime_and_manga_main_model.dart';
import 'package:animelagoom/models/character_model.dart';
import 'package:animelagoom/models/episode_model.dart';
import 'package:animelagoom/models/reaction_model.dart';
import 'package:animelagoom/models/related_media_model.dart';

class AnimeService {
  final KitsuApiManager _apiManager;

  AnimeService(this._apiManager);

  Future<List<MediaItem>> fetchTrendingAnime(
      {int limit = 10, int offset = 0}) async {
    final json = await _apiManager
        .get('/trending/anime?page[limit]=$limit&page[offset]=$offset');
    return _extractAnimeList(json);
  }

  Future<List<MediaItem>> fetchUpcomingAnime(
      {int limit = 10, int offset = 0}) async {
    final json = await _apiManager
        .get('/anime?sort=startDate&page[limit]=$limit&page[offset]=$offset');
    return _extractAnimeList(json);
  }

  Future<List<MediaItem>> fetchHighestRatedAnime(
      {int limit = 10, int offset = 0}) async {
    final json = await _apiManager.get(
        '/anime?sort=-averageRating&page[limit]=$limit&page[offset]=$offset');
    return _extractAnimeList(json);
  }

  Future<List<MediaItem>> fetchMostPopularAnime(
      {int limit = 10, int offset = 0}) async {
    final json = await _apiManager.get(
        '/anime?sort=-popularityRank&page[limit]=$limit&page[offset]=$offset');
    return _extractAnimeList(json);
  }

  Future<List<MediaItem>> searchAnime(String query,
      {int limit = 10, int offset = 0}) async {
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

  Future<List<Episode>> fetchAnimeEpisodes(String animeId,
      {int limit = 20, int offset = 0}) async {
    final json = await _apiManager.get(
      '/anime/$animeId/episodes',
      queryParams: {
        'page[limit]': '$limit',
        'page[offset]': '$offset',
        'sort': 'number',
      },
    );

    return (json['data'] as List).map((e) => Episode.fromJson(e)).toList();
  }

  Future<List<Character>> fetchAnimeCharacters(String animeId,
      {int limit = 20, int offset = 0}) async {
    final json = await _apiManager.get(
      '/anime/$animeId/characters',
      queryParams: {
        'page[limit]': '$limit',
        'page[offset]': '$offset',
        'include': 'character.castings.person',
      },
    );

    final includedList = json['included'] as List<dynamic>? ?? [];

    // Group included by type for easier access
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
        // Filter castings for this character
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

  Future<List<Reaction>> fetchAnimeReactions(
    String mediaId,
  ) async {
    final json = await _apiManager.get(
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

  Future<List<Franchise>> fetchAnimeFranchise(String animeId) async {
    final json =
        await _apiManager.get('/anime/$animeId/relationships/mappings');
    return (json['data'] as List)
        .map((e) => Franchise.fromJson(e))
        .toList();
  }

  List<MediaItem> _extractAnimeList(Map<String, dynamic> json) {
    return (json['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }
}
