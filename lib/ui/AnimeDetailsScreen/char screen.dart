import 'package:animelagoom/utils/app_styles.dart';
import 'package:animelagoom/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import 'char card.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

  final List<Character> characters = const [
    Character(
      name: 'Armin Arlert',
      japaneseVoiceActor: 'Marina Inoue',
      imageUrl:
      AssetsManager.test,
    ),
    Character(
      name: 'Mikasa Ackerman',
      japaneseVoiceActor: 'Yui Ishikawa',
      imageUrl:
      AssetsManager.test,
    ),
    // Add more characters as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Characters',
            style: AppStyles.bold20BlockRoboto,
            ),
          const SizedBox(height: 8),
          Text(
            'List of characters and their Japanese voice actors.',
            style:AppStyles.regular16greyColorRoboto,
          ),
          const SizedBox(height: 16),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return CharacterCard(character: character);
            },
          ),
          const SizedBox(height: 30), // bottom padding for better spacing
        ],
      ),
    );
  }
}

class Character {
  final String name;
  final String japaneseVoiceActor;
  final String imageUrl;

  const Character({
    required this.name,
    required this.japaneseVoiceActor,
    required this.imageUrl,
  });
}


