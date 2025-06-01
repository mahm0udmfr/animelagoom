class Manga {
  final String id;
  final String title;
  final String imageUrl;

  Manga({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory Manga.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final image = attributes['posterImage']?['medium'] ?? '';

    return Manga(
      id: json['id'],
      title: attributes['canonicalTitle'] ?? 'No Title',
      imageUrl: image,
    );
  }
}
