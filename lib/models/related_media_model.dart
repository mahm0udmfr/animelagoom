// File: lib/models/franchise_model.dart

/// Represents a Franchise model from the Kitsu API.
/// A franchise groups related media (e.g., all Naruto anime, manga, and movies).
class Franchise {
  final String id;
  final String slug;
  final Map<String, dynamic> titles; // E.g., {'en': 'Naruto', 'ja_jp': 'ナルト'}
  final DateTime createdAt;
  final DateTime updatedAt;

  Franchise({
    required this.id,
    required this.slug,
    required this.titles,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a [Franchise] instance from a JSON map.
  /// It expects the JSON structure directly from the 'data' part of a franchise resource.
  ///
  /// Example JSON structure for a franchise:
  /// ```json
  /// {
  ///   "id": "1", // Example ID
  ///   "type": "franchises",
  ///   "attributes": {
  ///     "createdAt": "2013-05-24T05:27:06.666Z",
  ///     "updatedAt": "2023-01-01T00:00:00.000Z",
  ///     "slug": "naruto",
  ///     "titles": {
  ///       "en": "Naruto",
  ///       "en_jp": "Naruto",
  ///       "ja_jp": "ナルト"
  ///     }
  ///   }
  ///   // Relationships (like "anime", "manga") would be here but aren't parsed in this simple model
  /// }
  /// ```
  factory Franchise.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;

    return Franchise(
      id: json['id'] as String,
      slug: attributes['slug'] as String,
      titles: attributes['titles'] as Map<String, dynamic>,
      createdAt: DateTime.parse(attributes['createdAt'] as String),
      updatedAt: DateTime.parse(attributes['updatedAt'] as String),
    );
  }
}
