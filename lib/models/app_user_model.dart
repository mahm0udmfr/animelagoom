class AppUser {
  final String id;
  final String name;
  final String? avatarUrl;
  final String? about;
  final String? location;

  AppUser({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.about,
    this.location,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    return AppUser(
      id: json['id'],
      name: attributes['name'] ?? 'Anonymous',
      avatarUrl: attributes['avatar']?['original'],
      about: attributes['about'],
      location: attributes['location'],
    );
  }
}
