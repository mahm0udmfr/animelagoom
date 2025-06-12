import 'package:animelagoom/models/reaction_model.dart';
import 'package:flutter/material.dart';
import 'package:animelagoom/core/api/api_manager.dart';
import 'package:animelagoom/services/anime_service.dart';
import 'package:animelagoom/services/manga_service.dart';

class ReactionScreen extends StatefulWidget {
  final String mediaId;
  final bool isAnime; // true for anime, false for manga

  const ReactionScreen({
    required this.mediaId,
    required this.isAnime,
    super.key,
  });

  @override
  State<ReactionScreen> createState() => _ReactionScreenState();
}

bool isExpanded = false;

class _ReactionScreenState extends State<ReactionScreen> {
  @override
  Widget build(BuildContext context) {
    // Initialize services directly in build, or better, pass them in if possible
    final KitsuApiManager apiManager = KitsuApiManager();
    final AnimeService animeService = AnimeService(apiManager);
    final MangaService mangaService = MangaService(apiManager);
    final maxLines = isExpanded ? null : 3;
    final Future<List<Reaction>> reactionsFuture = widget.isAnime
        ? animeService.fetchAnimeReactions(widget.mediaId)
        : mangaService.fetchMangaReactions(widget.mediaId);

    return FutureBuilder<List<Reaction>>(
      future: reactionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final reactions = snapshot.data ?? [];
        if (reactions.isEmpty) {
          return const Center(child: Text('No Reactions found.'));
        }
        return ListView.builder(
          itemCount: reactions.length,
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final reaction = reactions[index];
            return Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rating: ${reaction.rating}/5',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        reaction.content,
                        maxLines: maxLines,
                        overflow: isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded ? "read less" : "read more",
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      if (reaction.user != null)
                        Row(
                          children: [
                            if (reaction.user!.avatarUrl != null)
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(reaction.user!.avatarUrl!),
                                radius: 15,
                              ),
                            SizedBox(width: 8.0),
                            Text('By: ${reaction.user!.name}'),
                          ],
                        ),
                      Text(
                        'Created: ${reaction.createdAt.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }
}
