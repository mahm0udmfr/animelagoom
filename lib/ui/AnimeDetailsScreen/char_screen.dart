import 'package:animelagoom/utils/app_styles.dart';
import 'package:animelagoom/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../Core/api/api_manager.dart';
import '../../models/anime_and_manga_model.dart';
import 'char_card.dart';

class CharacterScreen extends StatefulWidget {
  final String animeId;
  const CharacterScreen({super.key, required this.animeId});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late Future<List<CharacterClass>> char;

  @override
  void initState() {
    super.initState();
    char = fetchCharactersAsCharacterClass(widget.animeId);
  }

  Future<List<CharacterClass>> fetchCharactersAsCharacterClass(String animeId) async {
    final apiCharacters = await KitsuApiManager().fetchCharactersForAnime(animeId);

    return apiCharacters.map((c) {
      return CharacterClass(
        name: c.name ?? 'Unknown',
        japaneseVoiceActor: c.voiceActorsAsString ?? 'Unknown',
        imageUrl: c.imageUrl ?? '',
      );
    }).toList();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: FutureBuilder<List<CharacterClass>>(
        future: char,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final characters = snapshot.data ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Characters', style: AppStyles.bold20BlockRoboto),
              const SizedBox(height: 8),
              Text('List of characters and their Japanese voice actors.',
                  style: AppStyles.regular16greyColorRoboto),
              const SizedBox(height: 16),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return CharacterCard(character: characters[index]);
                },
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}

class CharacterClass {
  final String name;
  final String japaneseVoiceActor;
  final String imageUrl;

  const CharacterClass({
    required this.name,
    required this.japaneseVoiceActor,
    required this.imageUrl,
  });
}


