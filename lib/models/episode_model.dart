// lib/models/episode_model.dart (or episodes_model.dart)

class Episode { // Renamed from Episodes for common practice, but functionally same
  final String id; // Add id, as it's part of the API response and useful
  final String? synopsis;
  final String? description;
  final Map<String, dynamic>? titles;
  final String? canonicalTitle;
  final int? number;
  final KitsuThumbnail? thumbnail;
  // Potentially add airdate, length, etc., as per Kitsu API

  Episode({
    required this.id, // ID is crucial for JSON:API
    this.synopsis,
    this.description,
    this.titles,
    this.canonicalTitle,
    this.number,
    this.thumbnail,
  });

  // Manual factory constructor for deserialization (JSON to Dart object)
  factory Episode.fromJson(Map<String, dynamic> json) {
    // Kitsu API data is always nested under 'attributes'
    final attributes = json['attributes'] as Map<String, dynamic>;

    return Episode(
      id: json['id'] as String, // ID is at the top level, not in attributes
      synopsis: attributes['synopsis'] as String?,
      description: attributes['description'] as String?,
      titles: attributes['titles'] as Map<String, dynamic>?,
      canonicalTitle: attributes['canonicalTitle'] as String?,
      number: attributes['number'] as int?,
      thumbnail: attributes['thumbnail'] != null
          ? KitsuThumbnail.fromJson(attributes['thumbnail'] as Map<String, dynamic>)
          : null,
    );
  }

  // --- Helper Getters for display ---

  String get displayTitle {
    if (canonicalTitle != null && canonicalTitle!.isNotEmpty) {
      return canonicalTitle!;
    }
    if (titles != null) {
      if (titles!['en_jp'] != null && titles!['en_jp'].isNotEmpty) {
        return titles!['en_jp'];
      }
      if (titles!['en'] != null && titles!['en'].isNotEmpty) {
        return titles!['en'];
      }
      if (titles!['ja_jp'] != null && titles!['ja_jp'].isNotEmpty) {
        return titles!['ja_jp'];
      }
    }
    return 'No Title';
  }

  String get displayDescription {
    if (synopsis != null && synopsis!.isNotEmpty) {
      return synopsis!;
    }
    if (description != null && description!.isNotEmpty) {
      return description!;
    }
    return 'No Description';
  }
}

// KitsuThumbnail model remains correct as is
class KitsuThumbnail {
  final String? tiny;
  final String? small;
  final String? medium;
  final String? large;
  final String? original;

  KitsuThumbnail({
    this.tiny,
    this.small,
    this.medium,
    this.large,
    this.original,
  });

  factory KitsuThumbnail.fromJson(Map<String, dynamic> json) {
    return KitsuThumbnail(
      tiny: json['tiny'] as String?,
      small: json['small'] as String?,
      medium: json['medium'] as String?,
      large: json['large'] as String?,
      original: json['original'] as String?,
    );
  }
}