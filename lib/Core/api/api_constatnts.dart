
class KitsuApiConstants {
  /// Core base URL conforming to JSON:API specifications
  static const String baseUrl = 'https://kitsu.io/api/edge';

  /// Authentication endpoint for OAuth 2.0
  static const String tokenEndpoint = 'https://kitsu.io/api/oauth/token';

  /// Core resource endpoints
  static const String anime = '/anime';
  static const String manga = '/manga';
  static const String users = '/users';
  static const String libraryEntries = '/library-entries';

  /// Filtered endpoints (dynamically constructed)
  static String searchAnime(String query) =>
      '$anime?filter[text]=$query';

  static String animeById(String id) => '$anime/$id';

  static String mangaById(String id) => '$manga/$id';

  /// Pagination and sorting (optional abstraction)
  static String paginatedAnime(int offset, int limit) =>
      '$anime?page[offset]=$offset&page[limit]=$limit';

  /// Canonical headers (you’ll use this in your HTTP client abstraction)
  static const Map<String, String> defaultHeaders = {
    'Accept': 'application/vnd.api+json',
    'Content-Type': 'application/vnd.api+json',
  };
}
