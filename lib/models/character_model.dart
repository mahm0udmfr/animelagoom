class Character {
  final String id;
  final String name;
  final String? role;
  final String? description;
  final String? imageUrl;

  Character({
    required this.id,
    required this.name,
    this.role,
    this.description,
    this.imageUrl,
  });

  factory Character.fromKitsuJson(Map<String, dynamic> animeCharJson, Map<String, dynamic>? charJson) {
    final role = animeCharJson['attributes']?['role'];
    final attributes = charJson?['attributes'];

    return Character(
      id: charJson?['id'] ?? '',
      name: attributes?['name'] ?? 'Unknown',
      role: role,
      description: attributes?['description'],
      imageUrl: attributes?['image']?['original'],
    );
  }
}



