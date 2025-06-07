import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Core/api/api_manager.dart';
import '../../models/anime_and_manga_model.dart';
import '../HomeScreen/Cubit/anime details/anime_details_bloc.dart';
import '../HomeScreen/Cubit/anime details/anime_details_states.dart';
import 'episode_card.dart';
import 'episode_details.dart';

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MediaDetailsBloc>().state;
    if (state is MediaDetailsLoaded) {
      final animeId = state.mediaItem.id; // Required for fetching episodes
      final api = KitsuApiManager();

      return FutureBuilder<List<Episode>>(
        future: api.fetchEpisodes(animeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading episodes: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No episodes found.'));
          }

          final episodes = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episode = episodes[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: AppBar(
                                title:
                                    Text('Episode ${episode.number} Details')),
                            body: EpisodeDetailsCard(
                              imageUrl: episode.thumbnail ?? '',
                              episodeNumber: 'Episode ${episode.number ?? 0}',
                              title: episode.canonicalTitle ?? 'Untitled',
                              //duration: episode.episodeLength != null ? '${episode.episodeLength} minutes' : 'No duration available',

                              duration: (episode.episodeLength != null &&
                                      episode.episodeLength! > 0)
                                  ? '${(episode.episodeLength! / 60).round()} minutes'
                                  : 'Unknown duration',

                              airDate: episode.airDate ?? 'Unknown date',
                              description: episode.synopsis ??
                                  'No description available.',
                            ),
                          ),
                        ),
                      );
                    },
                    child: EpisodeCard(
                      imageUrl: episode.thumbnail ?? '',
                      episodeNumber: episode.number ?? 0,
                      episodeTitle: episode.canonicalTitle ?? 'Untitled',
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          );
        },
      );
    } else if (state is MediaDetailsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MediaDetailsError) {
      return Center(child: Text('Error: ${state.message}'));
    } else {
      return const SizedBox.shrink();
    }
  }
}
