class Genre {
  final String id;
  final String name; // Can be 'name' or 'title' in API
  final String description;
  final String slug; // Optional, for manga mostly

  Genre({
    required this.id,
    required this.name,
    required this.description,
    this.slug = '',
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'] ?? {};
    return Genre(
      id: json['id'] ?? '',
      name: attr['name'] ?? attr['title'] ?? '',
      description: attr['description'] ?? '',
      slug: attr['slug'] ?? '',
    );
  }
}
class GenreListResponse {
  final List<Genre> data;

  GenreListResponse({required this.data});

  factory GenreListResponse.fromJson(Map<String, dynamic> json) {
    return GenreListResponse(
      data: List<Genre>.from(json['data'].map((x) => Genre.fromJson(x))),
    );
  }
}
