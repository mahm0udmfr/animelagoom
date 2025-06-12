import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.imageUrl,
  required this.name,});

  //final CharacterClass character;
  final String imageUrl;
  final String name;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.person, size: 120, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style:AppStyles.regular20BlackRoboto,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),

          ],
        ),
      ),
    );
  }
}