class Genre {
  final String id;
  final String name;
  final String description;

  Genre({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'] ?? {};
    return Genre(
      id: json['id'],
      name: attr['name'] ?? '',
      description: attr['description'] ?? '',
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
