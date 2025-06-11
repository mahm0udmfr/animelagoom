
class Episode {
  final String id;
  final String? synopsis;
  final String? description;
  final Map<String, dynamic>? titles;
  final String? canonicalTitle;
  final int? number;
  final KitsuThumbnail? thumbnail;

  final int? length;      // duration in minutes, nullable
  final String? airdate;  // air date string, nullable

  Episode({
    required this.id,
    this.synopsis,
    this.description,
    this.titles,
    this.canonicalTitle,
    this.number,
    this.thumbnail,
    this.length,
    this.airdate,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;

    return Episode(
      id: json['id'] as String,
      synopsis: attributes['synopsis'] as String?,
      description: attributes['description'] as String?,
      titles: attributes['titles'] as Map<String, dynamic>?,
      canonicalTitle: attributes['canonicalTitle'] as String?,
      number: attributes['number'] as int?,
      thumbnail: attributes['thumbnail'] != null
          ? KitsuThumbnail.fromJson(attributes['thumbnail'] as Map<String, dynamic>)
          : null,
      length: attributes['length'] as int?,
      airdate: attributes['airdate'] as String?,
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

  String get displayDuration {
    if (length != null && length! > 0) {
      return '$length min';
    }
    return 'Unknown duration';
  }

  String get displayAirDate {
    if (airdate != null && airdate!.isNotEmpty) {
      return airdate!;
    }
    return 'Unknown air date';
  }
}

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
