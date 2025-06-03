
// Main model for a media item (anime or manga)
class MediaItem {
  String id;
  String type; // 'anime' or 'manga'
  MediaLinks links;
  MediaAttributes attributes;
  final MediaRelationships? relationships;

  MediaItem({
    required this.id,
    required this.type,
    required this.links,
    required this.attributes,
    this.relationships,
  });

  // Factory constructor to create a MediaItem from JSON
  factory MediaItem.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null || json['type'] == null || json['attributes'] == null) {
      throw FormatException("Required fields (id, type, attributes) are missing in MediaItem JSON");
    }
    return MediaItem(
      id: json['id'] as String,
      type: json['type'] as String,
      links: MediaLinks.fromJson(json['links'] as Map<String, dynamic>? ?? {}),
      // Pass the 'type' to MediaAttributes.fromJson to handle type-specific fields
      attributes: MediaAttributes.fromJson(json['attributes'] as Map<String, dynamic>, json['type'] as String),
      relationships: json['relationships'] != null
          ? MediaRelationships.fromJson(json['relationships'])
          : null,
    );
  }

  // Method to convert MediaItem instance to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'links': links.toJson(),
        'attributes': attributes.toJson(type), // Pass type for conditional serialization
      };
}

// Model for links related to the media item
class MediaLinks {
  String? self;

  MediaLinks({this.self});

  factory MediaLinks.fromJson(Map<String, dynamic> json) {
    return MediaLinks(self: json['self'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'self': self,
      };
}

// Model for titles in different languages
class Titles {
  String? en;
  String? enJp;
  String? jaJp;
  String? enUs; // Added based on movie example

  Titles({this.en, this.enJp, this.jaJp, this.enUs});

  factory Titles.fromJson(Map<String, dynamic> json) {
    return Titles(
      en: json['en'] as String?,
      enJp: json['en_jp'] as String?,
      jaJp: json['ja_jp'] as String?,
      enUs: json['en_us'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'en': en,
        'en_jp': enJp,
        'ja_jp': jaJp,
        'en_us': enUs,
      };
}

// Model for image URLs (poster, cover)
class ImageInfo {
  String? tiny;
  String? large;
  String? small;
  String? medium;
  String? original;
  // Meta field could be parsed into a dedicated class if dimensions are always needed
  // Map<String, dynamic>? meta;

  ImageInfo({this.tiny, this.large, this.small, this.medium, this.original});

  factory ImageInfo.fromJson(Map<String, dynamic> json) {
    return ImageInfo(
      tiny: json['tiny'] as String?,
      large: json['large'] as String?,
      small: json['small'] as String?,
      medium: json['medium'] as String?,
      original: json['original'] as String?,
      // meta: json['meta'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'tiny': tiny,
        'large': large,
        'small': small,
        'medium': medium,
        'original': original,
        // 'meta': meta,
      };
}

// Model for the attributes of a media item
class MediaAttributes {
  // Common attributes
  DateTime? createdAt;
  DateTime? updatedAt;
  String slug;
  String? synopsis;
  String? description;
  int? coverImageTopOffset;
  Titles titles;
  String canonicalTitle;
  List<String>? abbreviatedTitles;
  String? averageRating; // Consider parsing to double
  int? userCount;
  int? favoritesCount;
  String? startDate; // Consider parsing to DateTime
  String? endDate;   // Consider parsing to DateTime
  int? popularityRank;
  int? ratingRank;
  String? ageRating;
  String? ageRatingGuide;
  String subtype; // e.g., TV, movie, manga, OVA, ONA, special, music, oneshot, novel, manhua, manhwa, doujin
  String status;  // e.g., finished, current, upcoming, tba, unreleased, an
  String? tba;    // Text for "To Be Announced" status
  ImageInfo? posterImage;
  ImageInfo? coverImage;
  bool? nsfw;

  // Anime-specific attributes
  int? episodeCount;
  int? episodeLength; // in minutes
  int? totalLength;   // total length of all episodes in minutes (sum of episodeLength)
  String? youtubeVideoId;
  // String? showType; // Often redundant with subtype, Kitsu API uses 'subtype' more consistently.

  // Manga-specific attributes
  int? chapterCount;
  int? volumeCount;
  String? serialization; // e.g., "Weekly Shonen Jump"

  MediaAttributes({
    this.createdAt,
    this.updatedAt,
    required this.slug,
    this.synopsis,
    this.description,
    this.coverImageTopOffset,
    required this.titles,
    required this.canonicalTitle,
    this.abbreviatedTitles,
    this.averageRating,
    this.userCount,
    this.favoritesCount,
    this.startDate,
    this.endDate,
    this.popularityRank,
    this.ratingRank,
    this.ageRating,
    this.ageRatingGuide,
    required this.subtype,
    required this.status,
    this.tba,
    this.posterImage,
    this.coverImage,
    this.nsfw,
    // Anime-specific
    this.episodeCount,
    this.episodeLength,
    this.totalLength,
    this.youtubeVideoId,
    // Manga-specific
    this.chapterCount,
    this.volumeCount,
    this.serialization,
  });

  factory MediaAttributes.fromJson(Map<String, dynamic> json, String mediaItemType) {
    // Helper to safely parse int
    int? parseInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    return MediaAttributes(
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'] as String) : null,
      slug: json['slug'] as String? ?? 'unknown-slug',
      synopsis: json['synopsis'] as String?,
      description: json['description'] as String?, // Present in your JSON
      coverImageTopOffset: parseInt(json['coverImageTopOffset']),
      titles: Titles.fromJson(json['titles'] as Map<String, dynamic>? ?? {}),
      canonicalTitle: json['canonicalTitle'] as String? ?? 'Unknown Title',
      abbreviatedTitles: (json['abbreviatedTitles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      averageRating: json['averageRating'] as String?,
      userCount: parseInt(json['userCount']),
      favoritesCount: parseInt(json['favoritesCount']),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      popularityRank: parseInt(json['popularityRank']),
      ratingRank: parseInt(json['ratingRank']),
      ageRating: json['ageRating'] as String?,
      ageRatingGuide: json['ageRatingGuide'] as String?,
      subtype: json['subtype'] as String? ?? 'unknown',
      status: json['status'] as String? ?? 'unknown',
      tba: json['tba'] as String?,
      posterImage: json['posterImage'] != null ? ImageInfo.fromJson(json['posterImage'] as Map<String, dynamic>) : null,
      coverImage: json['coverImage'] != null ? ImageInfo.fromJson(json['coverImage'] as Map<String, dynamic>) : null,
      nsfw: json['nsfw'] as bool?,

      // Anime-specific fields are parsed if mediaItemType is 'anime'
      episodeCount: mediaItemType.toLowerCase() == 'anime' ? parseInt(json['episodeCount']) : null,
      episodeLength: mediaItemType.toLowerCase() == 'anime' ? parseInt(json['episodeLength']) : null,
      totalLength: mediaItemType.toLowerCase() == 'anime' ? parseInt(json['totalLength']) : null,
      youtubeVideoId: mediaItemType.toLowerCase() == 'anime' ? json['youtubeVideoId'] as String? : null,

      // Manga-specific fields (these would be populated if parsing manga JSON)
      // Parsed if mediaItemType is 'manga'. For now, these will be null for anime.
      chapterCount: mediaItemType.toLowerCase() == 'manga' ? parseInt(json['chapterCount']) : null,
      volumeCount: mediaItemType.toLowerCase() == 'manga' ? parseInt(json['volumeCount']) : null,
      serialization: mediaItemType.toLowerCase() == 'manga' ? json['serialization'] as String? : null,
    );
  }

  Map<String, dynamic> toJson(String mediaItemType) {
    final Map<String, dynamic> data = {
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'slug': slug,
      'synopsis': synopsis,
      'description': description,
      'coverImageTopOffset': coverImageTopOffset,
      'titles': titles.toJson(),
      'canonicalTitle': canonicalTitle,
      'abbreviatedTitles': abbreviatedTitles,
      'averageRating': averageRating,
      'userCount': userCount,
      'favoritesCount': favoritesCount,
      'startDate': startDate,
      'endDate': endDate,
      'popularityRank': popularityRank,
      'ratingRank': ratingRank,
      'ageRating': ageRating,
      'ageRatingGuide': ageRatingGuide,
      'subtype': subtype,
      'status': status,
      'tba': tba,
      'posterImage': posterImage?.toJson(),
      'coverImage': coverImage?.toJson(),
      'nsfw': nsfw,
    };

    if (mediaItemType.toLowerCase() == 'anime') {
      data['episodeCount'] = episodeCount;
      data['episodeLength'] = episodeLength;
      data['totalLength'] = totalLength;
      data['youtubeVideoId'] = youtubeVideoId;
    } else if (mediaItemType.toLowerCase() == 'manga') {
      data['chapterCount'] = chapterCount;
      data['volumeCount'] = volumeCount;
      data['serialization'] = serialization;
    }
    return data;
  }
}

class MediaRelationships {
  final RelationshipData? genres;

  MediaRelationships({this.genres});

  factory MediaRelationships.fromJson(Map<String, dynamic> json) {
    return MediaRelationships(
      genres: json['genres'] != null
          ? RelationshipData.fromJson(json['genres'])
          : null,
    );
  }
}

class RelationshipData {
  final List<Map<String, dynamic>> data;

  RelationshipData({required this.data});

  factory RelationshipData.fromJson(Map<String, dynamic> json) {
    return RelationshipData(
      data: List<Map<String, dynamic>>.from(json['data'] ?? []),
    );
  }
}

class Genre {
  final String id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['attributes']['name'] ?? '',
    );
  }
}


