// File: lib/models/reaction_user_models.dart

/// Represents a User model from the 'included' section of the Kitsu API response.
/// This class defines the structure for a user's ID, name, and optional avatar URL.
class User {
  final String id;
  final String name;
  final String? avatarUrl; // Nullable as it might not always be present

  User({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  /// Factory constructor to create a [User] instance from a JSON map.
  /// It expects the JSON structure directly from the 'attributes' part of a user resource.
  ///
  /// Example JSON structure for a user:
  /// ```json
  /// {
  ///   "id": "12345",
  ///   "type": "users",
  ///   "attributes": {
  ///     "name": "AnimeLover22",
  ///     "slug": "animelover22",
  ///     "avatar": {
  ///       "tiny": "...",
  ///       "small": "...",
  ///       "medium": "...",
  ///       "large": "[https://media.kitsu.io/users/avatars/12345/large.jpeg](https://media.kitsu.io/users/avatars/12345/large.jpeg)"
  ///     }
  ///     // ... other user attributes
  ///   }
  /// }
  /// ```
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['attributes']['name'] as String,
      // Safely access nested 'avatar' and 'large' fields.
      // If 'avatar' or 'large' are missing, avatarUrl will be null.
      avatarUrl: json['attributes']['avatar']?['large'] as String?,
    );
  }
}

/// Represents a Reaction (Review) model from the Kitsu API.
/// This model encapsulates the review's content, rating, timestamps,
/// and an optional associated user.
class Reaction {
  final String id;
  final String content;
  final double rating;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user; // The associated user, can be null if not included or found

  Reaction({
    required this.id,
    required this.content,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory Reaction.fromJson(Map<String, dynamic> json, Map<String, dynamic> inc) {
    final attributes = json['attributes'] as Map<String, dynamic>;
    final relationships = json['relationships'] as Map<String, dynamic>;

    User? associatedUser;
    // Get the user ID from the relationships section of the review.
    final userId = relationships['user']?['data']?['id'] as String?;

    // If a user ID is found and the 'inc' map contains a list of users,
    // try to find the corresponding user object in that list.
    if (userId != null && inc['user'] is List<dynamic>) {
      // Find the user in the included list based on their ID.
      // `firstWhere` is used with `orElse` to safely handle cases where the user
      // might not be found in the `included` array (though it should be if `&include=user` is used).
      final userJson = (inc['user'] as List<dynamic>).firstWhere(
        (u) => u['id'] == userId,
        orElse: () => null, // Returns null if the user isn't found
      );
      if (userJson != null) {
        associatedUser = User.fromJson(userJson as Map<String, dynamic>);
      }
    }

    return Reaction(
      id: json['id'] as String,
      content: attributes['content'] as String,
      // Convert rating to double, as Kitsu might return it as an int sometimes.
      rating: (attributes['rating'] as num).toDouble(),
      createdAt: DateTime.parse(attributes['createdAt'] as String),
      updatedAt: DateTime.parse(attributes['updatedAt'] as String),
      user: associatedUser, // Assign the found user (or null)
    );
  }
}
