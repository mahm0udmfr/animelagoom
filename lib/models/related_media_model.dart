class FranchiseRelation {
  final String id;
  final String? relationType;
  final String? sourceType;
  final String? destinationId;

  FranchiseRelation({
    required this.id,
    this.relationType,
    this.sourceType,
    this.destinationId,
  });

  factory FranchiseRelation.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'] ?? {};
    final destId = json['relationships']?['destination']?['links']?['related']?.split('/')?.last;

    return FranchiseRelation(
      id: json['id'],
      relationType: attr['role'],
      sourceType: attr['sourceType'],
      destinationId: destId,
    );
  }
}
