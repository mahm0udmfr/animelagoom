class Character {
  final String id;
  final String name;
  final String? imageUrl;
  final String? role;
  final String? voiceActor;

  Character({
    required this.id,
    required this.name,
    this.imageUrl,
    this.role,
    this.voiceActor,
  });

  factory Character.fromJson(Map<String, dynamic> json, Map<String, dynamic> included) {
    final attributes = json['attributes'];
    final characterImage = attributes['image']?['original'];

    // Map related casting and person if included
    String? role;
    String? voiceActor;

    if (included.isNotEmpty) {
      final castings = included['castings'] as List<dynamic>?;
      final people = included['people'] as List<dynamic>?;

      if (castings != null && castings.isNotEmpty) {
        role = castings.first['attributes']['role'];
        final personId = castings.first['relationships']['person']['data']['id'];

        if (people != null) {
          final person = people.firstWhere(
            (p) => p['id'] == personId,
            orElse: () => null,
          );
          if (person != null) {
            voiceActor = person['attributes']['name'];
          }
        }
      }
    }

    return Character(
      id: json['id'],
      name: attributes['name'] ?? 'Unknown',
      imageUrl: characterImage,
      role: role,
      voiceActor: voiceActor,
    );
  }
}
