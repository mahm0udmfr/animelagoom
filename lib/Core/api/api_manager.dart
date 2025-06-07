import 'dart:convert';
import 'package:animelagoom/core/api/api_constatnts.dart';
import 'package:http/http.dart' as http;

import '../../models/anime_and_manga_model.dart';


class KitsuApiManager {
  final String? accessToken;

  const KitsuApiManager({this.accessToken});

  /// 🔍 Unified GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '${KitsuApiConstants.baseUrl}$endpoint',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: _headers());

    return _handleResponse(response) as Map<String, dynamic>;
  }

  /// ✏️ Unified POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('${KitsuApiConstants.baseUrl}$endpoint');
    final response = await http.post(
      uri,
      headers: _headers(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  /// 🛠 Generic PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('${KitsuApiConstants.baseUrl}$endpoint');
    final response = await http.put(
      uri,
      headers: _headers(),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  /// 🗑 DELETE request
  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse('${KitsuApiConstants.baseUrl}$endpoint');
    final response = await http.delete(uri, headers: _headers());

    return _handleResponse(response);
  }

  /// 🧾 Header Builder
  Map<String, String> _headers() {
    return {
      ...KitsuApiConstants.defaultHeaders,
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
  }

  /// 🎯 Response Validator + Extractor
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final json = jsonDecode(response.body);

    if (statusCode >= 200 && statusCode < 300) {
      return json;
    } else {
      // Optionally wrap this into a custom error class
      throw Exception(
        'API Error [$statusCode]: ${json['errors'] ?? response.reasonPhrase}',
      );
    }
  }


  Future<List<Genre>> fetchGenresForAnime(String animeId) async {
    final response = await http.get(
      Uri.parse('https://kitsu.io/api/edge/anime/$animeId/genres'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List genreList = data['data'];
      return genreList.map((e) => Genre.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }
Future<List<Genre>> fetchGenresForManga(String mangaId) async {
  final response = await http.get(
    Uri.parse('https://kitsu.io/api/edge/manga/$mangaId/genres'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> genreList = data['data'];
    return genreList.map((e) => Genre.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load genres');
  }
}


  Future<List<Episode>> fetchEpisodes(String animeId) async {
    List<Episode> allEpisodes = [];
    int pageOffset = 0;
    const int pageLimit = 20;

    while (true) {
      final response = await get(
        '/anime/$animeId/episodes',
        queryParams: {
          'page[limit]': '$pageLimit',
          'page[offset]': '$pageOffset',
        },
      );

      final List<dynamic> episodeListJson = response['data'] ?? [];

      if (episodeListJson.isEmpty) {
        break; // No more episodes
      }

      allEpisodes.addAll(
        episodeListJson.map((json) => Episode.fromJson(json)).toList(),
      );

      // If fewer episodes were returned than the limit, we're done
      if (episodeListJson.length < pageLimit) {
        break;
      }

      // Move to next page
      pageOffset += pageLimit;
    }

    return allEpisodes;
  }


  Future<List<Character>> fetchCharactersForAnime(String animeId) async {
    final response = await get('/anime/$animeId/characters', queryParams: {
      'include': 'character.castings.person',
    });

    final List<dynamic> characterData = response['data'] ?? [];
    final List<dynamic> included = response['included'] ?? [];

    final List<Character> characters = [];

    for (final characterRelation in characterData) {
      final characterId = characterRelation['relationships']['character']['data']['id'];

      // Get full character data
      final includedCharacter = included.firstWhere(
            (item) => item['id'] == characterId && item['type'] == 'characters',
        orElse: () => null,
      );

      if (includedCharacter == null) continue;

      // Find castings related to this character
      final castings = included.where((item) =>
      item['type'] == 'castings' &&
          item['relationships']['character']['data']?['id'] == characterId
      );

      final List<String> voiceActorNames = [];

      for (final casting in castings) {
        final personRef = casting['relationships']['person']?['data'];
        if (personRef != null) {
          final personId = personRef['id'];

          final person = included.firstWhere(
                (item) => item['id'] == personId && item['type'] == 'people',
            orElse: () => null,
          );

          if (person != null) {
            final name = person['attributes']?['name'];
            if (name != null) {
              voiceActorNames.add(name);
            }
          }
        }
      }

      characters.add(Character.fromJson(includedCharacter, voiceActors: voiceActorNames));
    }

    return characters;
  }

Future<List<Character>> fetchCharactersForManga(String mangaId) async {
  final response = await http.get(
    Uri.parse('https://kitsu.io/api/edge/manga/$mangaId/characters'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> characterList = data['data'];
    return characterList.map((e) => Character.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load characters');
  }
}

Future<List<Chapter>> fetchChapters(String mangaId) async {
  final response = await http.get(
    Uri.parse('https://kitsu.io/api/edge/manga/$mangaId/chapters'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> chapterList = data['data'];
    return chapterList.map((e) => Chapter.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load chapters');
  }
}






}
