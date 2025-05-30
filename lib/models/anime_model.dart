class Anime {
  final String id;
  final String title;
  final String? imageUrl;

  Anime({
    required this.id,
    required this.title,
    this.imageUrl,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    final titles = attributes['titles'] ?? {};
    final posterImage = attributes['posterImage'] ?? {};

    return Anime(
      id: json['id'] ?? '',
      title: titles['en'] ?? titles['en_jp'] ?? titles['ja_jp'] ?? 'Untitled',
      imageUrl: posterImage['small'] ?? posterImage['original'],
    );
  }
}
