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
      'include': 'character.castings.person',
      'page[limit]': '$limit',
      'page[offset]': '$offset',
      'sort': 'role',
    },
  );

  final dataList = json['data'] as List<dynamic>;
  final included = json['included'] as List<dynamic>? ?? [];

  final includedCharacters = {
    for (var item in included)
      if (item['type'] == 'characters') item['id']: item
  };

  final List<Character> characters = [];

  for (final animeChar in dataList) {
    final characterId = animeChar['relationships']?['character']?['data']?['id'];
    if (characterId == null) continue;

    final characterJson = includedCharacters[characterId];
    if (characterJson == null) continue;

    characters.add(Character.fromKitsuJson(animeChar, characterJson));
  }

  return characters;
}


  Future<List<Reaction>> fetchAnimeReactions(String animeId,
      {int limit = 20, int offset = 0}) async {
    final json = await _apiManager.get(
      '/anime/$animeId/media-reactions',
      queryParams: {
        'page[limit]': '$limit',
        'page[offset]': '$offset',
        'sort': '-createdAt',
      },
    );

    return (json['data'] as List).map((e) => Reaction.fromJson(e)).toList();
  }

  Future<List<FranchiseRelation>> fetchAnimeFranchise(String animeId) async {
    final json =
        await _apiManager.get('/anime/$animeId/relationships/mappings');
    return (json['data'] as List)
        .map((e) => FranchiseRelation.fromJson(e))
        .toList();
  }

  List<MediaItem> _extractAnimeList(Map<String, dynamic> json) {
    return (json['data'] as List).map((e) => MediaItem.fromJson(e)).toList();
  }
}
