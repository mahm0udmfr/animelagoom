import 'package:animelagoom/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import 'episode card.dart';

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Prevents conflict with parent scroll
      padding: const EdgeInsets.all(10),
      children: const <Widget>[
        EpisodeCard(
          imageUrl: AssetsManager.test,
          episodeNumber: 1,
          episodeTitle: 'content about ep1',
        ),
        SizedBox(height: 8.0),
        EpisodeCard(
          imageUrl:  AssetsManager.test,
          episodeNumber: 2,
          episodeTitle: 'That Day',
        ),
        SizedBox(height: 8.0),
        EpisodeCard(
          imageUrl:  AssetsManager.test,
          episodeNumber: 3,
          episodeTitle: '.........',
        ),
      ],
    );
  }
}


