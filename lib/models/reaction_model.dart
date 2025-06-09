class Reaction {
  final String id;
  final String? reactionText;
  final String? createdAt;
  final String? userName;
  final String? userAvatar;

  Reaction({
    required this.id,
    this.reactionText,
    this.createdAt,
    this.userName,
    this.userAvatar,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'] ?? {};
    return Reaction(
      id: json['id'],
      reactionText: attr['reaction'],
      createdAt: attr['createdAt'],
      // userName and userAvatar need another API call to fetch `/users/{id}`
      userName: null,
      userAvatar: null,
    );
  }
}
