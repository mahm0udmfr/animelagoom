class AnimeDetails {
  AnimeDetails({
      this.data,});

  AnimeDetails.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.type, 
      this.links, 
      this.attributes, 
      this.relationships,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    attributes = json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null;
    relationships = json['relationships'] != null ? Relationships.fromJson(json['relationships']) : null;
  }
  String? id;
  String? type;
  Links? links;
  Attributes? attributes;
  Relationships? relationships;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    if (links != null) {
      map['links'] = links?.toJson();
    }
    if (attributes != null) {
      map['attributes'] = attributes?.toJson();
    }
    if (relationships != null) {
      map['relationships'] = relationships?.toJson();
    }
    return map;
  }

}

class Relationships {
  Relationships({
      this.genres, 
      this.categories, 
      this.castings, 
      this.installments, 
      this.mappings, 
      this.reviews, 
      this.mediaRelationships, 
      this.characters, 
      this.staff, 
      this.productions, 
      this.quotes, 
      this.episodes, 
      this.streamingLinks, 
      this.animeProductions, 
      this.animeCharacters, 
      this.animeStaff,});

  Relationships.fromJson(dynamic json) {
    genres = json['genres'] != null ? Genres.fromJson(json['genres']) : null;
    categories = json['categories'] != null ? Categories.fromJson(json['categories']) : null;
    castings = json['castings'] != null ? Castings.fromJson(json['castings']) : null;
    installments = json['installments'] != null ? Installments.fromJson(json['installments']) : null;
    mappings = json['mappings'] != null ? Mappings.fromJson(json['mappings']) : null;
    reviews = json['reviews'] != null ? Reviews.fromJson(json['reviews']) : null;
    mediaRelationships = json['mediaRelationships'] != null ? MediaRelationships.fromJson(json['mediaRelationships']) : null;
    characters = json['characters'] != null ? Characters.fromJson(json['characters']) : null;
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
    productions = json['productions'] != null ? Productions.fromJson(json['productions']) : null;
    quotes = json['quotes'] != null ? Quotes.fromJson(json['quotes']) : null;
    episodes = json['episodes'] != null ? Episodes.fromJson(json['episodes']) : null;
    streamingLinks = json['streamingLinks'] != null ? StreamingLinks.fromJson(json['streamingLinks']) : null;
    animeProductions = json['animeProductions'] != null ? AnimeProductions.fromJson(json['animeProductions']) : null;
    animeCharacters = json['animeCharacters'] != null ? AnimeCharacters.fromJson(json['animeCharacters']) : null;
    animeStaff = json['animeStaff'] != null ? AnimeStaff.fromJson(json['animeStaff']) : null;
  }
  Genres? genres;
  Categories? categories;
  Castings? castings;
  Installments? installments;
  Mappings? mappings;
  Reviews? reviews;
  MediaRelationships? mediaRelationships;
  Characters? characters;
  Staff? staff;
  Productions? productions;
  Quotes? quotes;
  Episodes? episodes;
  StreamingLinks? streamingLinks;
  AnimeProductions? animeProductions;
  AnimeCharacters? animeCharacters;
  AnimeStaff? animeStaff;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres?.toJson();
    }
    if (categories != null) {
      map['categories'] = categories?.toJson();
    }
    if (castings != null) {
      map['castings'] = castings?.toJson();
    }
    if (installments != null) {
      map['installments'] = installments?.toJson();
    }
    if (mappings != null) {
      map['mappings'] = mappings?.toJson();
    }
    if (reviews != null) {
      map['reviews'] = reviews?.toJson();
    }
    if (mediaRelationships != null) {
      map['mediaRelationships'] = mediaRelationships?.toJson();
    }
    if (characters != null) {
      map['characters'] = characters?.toJson();
    }
    if (staff != null) {
      map['staff'] = staff?.toJson();
    }
    if (productions != null) {
      map['productions'] = productions?.toJson();
    }
    if (quotes != null) {
      map['quotes'] = quotes?.toJson();
    }
    if (episodes != null) {
      map['episodes'] = episodes?.toJson();
    }
    if (streamingLinks != null) {
      map['streamingLinks'] = streamingLinks?.toJson();
    }
    if (animeProductions != null) {
      map['animeProductions'] = animeProductions?.toJson();
    }
    if (animeCharacters != null) {
      map['animeCharacters'] = animeCharacters?.toJson();
    }
    if (animeStaff != null) {
      map['animeStaff'] = animeStaff?.toJson();
    }
    return map;
  }

}

class AnimeStaff {
  AnimeStaff({
      this.links,});

  AnimeStaff.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Links {
  Links({
      this.self, 
      this.related,});

  Links.fromJson(dynamic json) {
    self = json['self'];
    related = json['related'];
  }
  String? self;
  String? related;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['self'] = self;
    map['related'] = related;
    return map;
  }

}

class AnimeCharacters {
  AnimeCharacters({
      this.links,});

  AnimeCharacters.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class AnimeProductions {
  AnimeProductions({
      this.links,});

  AnimeProductions.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class StreamingLinks {
  StreamingLinks({
      this.links,});

  StreamingLinks.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Episodes {
  Episodes({
      this.links,});

  Episodes.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Quotes {
  Quotes({
      this.links,});

  Quotes.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Productions {
  Productions({
      this.links,});

  Productions.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Staff {
  Staff({
      this.links,});

  Staff.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Characters {
  Characters({
      this.links,});

  Characters.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class MediaRelationships {
  MediaRelationships({
      this.links,});

  MediaRelationships.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Reviews {
  Reviews({
      this.links,});

  Reviews.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Mappings {
  Mappings({
      this.links,});

  Mappings.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Installments {
  Installments({
      this.links,});

  Installments.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Castings {
  Castings({
      this.links,});

  Castings.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Categories {
  Categories({
      this.links,});

  Categories.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}


class Genres {
  Genres({
      this.links,});

  Genres.fromJson(dynamic json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
  Links? links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.toJson();
    }
    return map;
  }

}

class Attributes {
  Attributes({
      this.createdAt, 
      this.updatedAt, 
      this.slug, 
      this.synopsis, 
      this.description, 
      this.coverImageTopOffset, 
      this.titles, 
      this.canonicalTitle, 
      this.abbreviatedTitles, 
      this.averageRating,
      this.userCount, 
      this.favoritesCount, 
      this.startDate, 
      this.endDate, 
      this.nextRelease, 
      this.popularityRank, 
      this.ratingRank, 
      this.ageRating, 
      this.ageRatingGuide, 
      this.subtype, 
      this.status, 
      this.tba, 
      this.posterImage, 
      this.coverImage, 
      this.episodeCount, 
      this.episodeLength, 
      this.totalLength, 
      this.youtubeVideoId, 
      this.showType, 
      this.nsfw,});

  Attributes.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    slug = json['slug'];
    synopsis = json['synopsis'];
    description = json['description'];
    coverImageTopOffset = json['coverImageTopOffset'];
    titles = json['titles'] != null ? Titles.fromJson(json['titles']) : null;
    canonicalTitle = json['canonicalTitle'];
    abbreviatedTitles = json['abbreviatedTitles'] != null ? json['abbreviatedTitles'].cast<String>() : [];
    averageRating = json['averageRating'];
    userCount = json['userCount'];
    favoritesCount = json['favoritesCount'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    nextRelease = json['nextRelease'];
    popularityRank = json['popularityRank'];
    ratingRank = json['ratingRank'];
    ageRating = json['ageRating'];
    ageRatingGuide = json['ageRatingGuide'];
    subtype = json['subtype'];
    status = json['status'];
    tba = json['tba'];
    posterImage = json['posterImage'] != null ? PosterImage.fromJson(json['posterImage']) : null;
    coverImage = json['coverImage'] != null ? CoverImage.fromJson(json['coverImage']) : null;
    episodeCount = json['episodeCount'];
    episodeLength = json['episodeLength'];
    totalLength = json['totalLength'];
    youtubeVideoId = json['youtubeVideoId'];
    showType = json['showType'];
    nsfw = json['nsfw'];
  }
  String? createdAt;
  String? updatedAt;
  String? slug;
  String? synopsis;
  String? description;
  int? coverImageTopOffset;
  Titles? titles;
  String? canonicalTitle;
  List<String>? abbreviatedTitles;
  String? averageRating;
  int? userCount;
  int? favoritesCount;
  String? startDate;
  String? endDate;
  dynamic nextRelease;
  int? popularityRank;
  int? ratingRank;
  String? ageRating;
  String? ageRatingGuide;
  String? subtype;
  String? status;
  dynamic tba;
  PosterImage? posterImage;
  CoverImage? coverImage;
  int? episodeCount;
  int? episodeLength;
  int? totalLength;
  String? youtubeVideoId;
  String? showType;
  bool? nsfw;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['slug'] = slug;
    map['synopsis'] = synopsis;
    map['description'] = description;
    map['coverImageTopOffset'] = coverImageTopOffset;
    if (titles != null) {
      map['titles'] = titles?.toJson();
    }
    map['canonicalTitle'] = canonicalTitle;
    map['abbreviatedTitles'] = abbreviatedTitles;
    map['averageRating'] = averageRating;
    map['userCount'] = userCount;
    map['favoritesCount'] = favoritesCount;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['nextRelease'] = nextRelease;
    map['popularityRank'] = popularityRank;
    map['ratingRank'] = ratingRank;
    map['ageRating'] = ageRating;
    map['ageRatingGuide'] = ageRatingGuide;
    map['subtype'] = subtype;
    map['status'] = status;
    map['tba'] = tba;
    if (posterImage != null) {
      map['posterImage'] = posterImage?.toJson();
    }
    if (coverImage != null) {
      map['coverImage'] = coverImage?.toJson();
    }
    map['episodeCount'] = episodeCount;
    map['episodeLength'] = episodeLength;
    map['totalLength'] = totalLength;
    map['youtubeVideoId'] = youtubeVideoId;
    map['showType'] = showType;
    map['nsfw'] = nsfw;
    return map;
  }

}

class CoverImage {
  CoverImage({
      this.tiny, 
      this.large, 
      this.small, 
      this.original, 
      this.meta,});

  CoverImage.fromJson(dynamic json) {
    tiny = json['tiny'];
    large = json['large'];
    small = json['small'];
    original = json['original'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  String? tiny;
  String? large;
  String? small;
  String? original;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tiny'] = tiny;
    map['large'] = large;
    map['small'] = small;
    map['original'] = original;
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }

}

class Meta {
  Meta({
      this.dimensions,});

  Meta.fromJson(dynamic json) {
    dimensions = json['dimensions'] != null ? Dimensions.fromJson(json['dimensions']) : null;
  }
  Dimensions? dimensions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dimensions != null) {
      map['dimensions'] = dimensions?.toJson();
    }
    return map;
  }

}

class Dimensions {
  Dimensions({
      this.tiny, 
      this.large, 
      this.small,});

  Dimensions.fromJson(dynamic json) {
    tiny = json['tiny'] != null ? Tiny.fromJson(json['tiny']) : null;
    large = json['large'] != null ? Large.fromJson(json['large']) : null;
    small = json['small'] != null ? Small.fromJson(json['small']) : null;
  }
  Tiny? tiny;
  Large? large;
  Small? small;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tiny != null) {
      map['tiny'] = tiny?.toJson();
    }
    if (large != null) {
      map['large'] = large?.toJson();
    }
    if (small != null) {
      map['small'] = small?.toJson();
    }
    return map;
  }

}

class Small {
  Small({
      this.width, 
      this.height,});

  Small.fromJson(dynamic json) {
    width = json['width'];
    height = json['height'];
  }
  int? width;
  int? height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    return map;
  }

}

class Large {
  Large({
      this.width, 
      this.height,});

  Large.fromJson(dynamic json) {
    width = json['width'];
    height = json['height'];
  }
  int? width;
  int? height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    return map;
  }

}

class Tiny {
  Tiny({
      this.width, 
      this.height,});

  Tiny.fromJson(dynamic json) {
    width = json['width'];
    height = json['height'];
  }
  int? width;
  int? height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    return map;
  }

}

class PosterImage {
  PosterImage({
      this.tiny, 
      this.large, 
      this.small, 
      this.medium, 
      this.original, 
      this.meta,});

  PosterImage.fromJson(dynamic json) {
    tiny = json['tiny'];
    large = json['large'];
    small = json['small'];
    medium = json['medium'];
    original = json['original'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  String? tiny;
  String? large;
  String? small;
  String? medium;
  String? original;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tiny'] = tiny;
    map['large'] = large;
    map['small'] = small;
    map['medium'] = medium;
    map['original'] = original;
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }

}

class Medium {
  Medium({
      this.width, 
      this.height,});

  Medium.fromJson(dynamic json) {
    width = json['width'];
    height = json['height'];
  }
  int? width;
  int? height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    return map;
  }

}

class Titles {
  Titles({
      this.en, 
      this.enJp, 
      this.jaJp,});

  Titles.fromJson(dynamic json) {
    en = json['en'];
    enJp = json['en_jp'];
    jaJp = json['ja_jp'];
  }
  String? en;
  String? enJp;
  String? jaJp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = en;
    map['en_jp'] = enJp;
    map['ja_jp'] = jaJp;
    return map;
  }

}
