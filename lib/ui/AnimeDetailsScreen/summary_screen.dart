import 'package:animelagoom/ui/AnimeDetailsScreen/reaction_screen.dart';
import 'package:animelagoom/utils/app_colors.dart';
import 'package:animelagoom/utils/app_styles.dart';
import 'package:animelagoom/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../HomeScreen/Cubit/anime details/anime details bloc.dart';
import '../HomeScreen/Cubit/anime details/anime details states.dart';

class SummaryScreen extends StatefulWidget{
   SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AnimeDetailsBloc>().state;

    if (state is AnimeDetailsLoaded){
      final anime = state.anime;
      final attributes = anime.attributes;

      final maxLines = isExpanded ? null : 3;

      final title = attributes.titles?.en ??
          attributes.titles?.enJp ??
          attributes.titles?.jaJp ??
          "No title";

      final startDate = attributes.startDate ?? "";
      final year = startDate.isNotEmpty ? DateTime.tryParse(startDate)?.year.toString() ?? "" : "";

      final coverImage = attributes.coverImage?.original ?? "";
      final isValidCoverImage = Uri.tryParse(coverImage)?.hasAbsolutePath == true;

      final synopsis = attributes.synopsis ?? "No synopsis available";

      final trailerYoutubeId = attributes.youtubeVideoId;

      final genres = state.genres;
      final characters = state.characters ?? [];

      // For ranks, assuming from attributes:
      final popularityRank = attributes.popularityRank;
      final ratingRank = attributes.ratingRank;



      return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Flexible(
                    child: Text(
                      title,
                      style: AppStyles.bold24BlockRoboto,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 10),
                  if (year.isNotEmpty)
                    Text(
                      year,
                      style: AppStyles.regular16greyColorRoboto,
                    ),
                ]),

            SizedBox(height: 12),
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: isValidCoverImage
                        ? DecorationImage(
                      image: NetworkImage(coverImage),
                      fit: BoxFit.cover,
                    )
                        : null,
                    color: Colors.grey[300],
                  ),
                  child: !isValidCoverImage
                      ? Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  )
                      : null,
                ),

                if (trailerYoutubeId != null && trailerYoutubeId.isNotEmpty)
                  Positioned.fill(
                    child: Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final youtubeAppUrl = Uri.parse("youtube://$trailerYoutubeId");
                          // final youtubeAppUrl = Uri.parse("vnd.youtube://$trailerYoutubeId");
                          final trailerUrl = "https://www.youtube.com/watch?v=$trailerYoutubeId";
                          final url = Uri.parse(trailerUrl);
                         // final youtubeAppUrl = Uri.parse("youtube://www.youtube.com/watch?v=$trailerYoutubeId");

                          if (await canLaunchUrl(youtubeAppUrl)) {
                            await launchUrl(youtubeAppUrl);
                          } else if (await canLaunchUrl(url)) {
                            await launchUrl(url, mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Could not launch trailer")),
                            );
                          }
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Play Trailer"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blackColor,
                          foregroundColor: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              synopsis,
              style:AppStyles.regular16greyColorRoboto,
              maxLines: maxLines,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
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
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: genres.map((genre) {
                final genreName = genre.name ?? "Unknown";  // assuming genre is an object with name
                return Chip(
                  label: Text(genreName),
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),

            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (popularityRank != null)
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red, size: 20),
                        const SizedBox(width: 4),
                        Text('Rank #$popularityRank (Most Popular Anime)', style: AppStyles.regular16greyRoboto),
                      ],
                    ),
                  const SizedBox(height: 4),
                  if (ratingRank != null)
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 20),
                        const SizedBox(width: 4),
                        Text('Rank #$ratingRank (Highest Rated Anime)', style: AppStyles.regular16greyRoboto),
                      ],
                    ),
                ],
              ),
            ),

             SizedBox(height: 20),

            // 📋 Anime Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding:  EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Details',
                      style:AppStyles.bold20BlockRoboto ,
                    ),
                    const SizedBox(height: 12),

                    Wrap(
                      runSpacing: 10,
                      spacing: 40,
                      children: [
                        detailItem(
                          'English',
                          attributes.titles?.en ?? attributes.titles?.enUs ?? attributes.titles?.enJp ?? "Unknown",
                        ),
                        detailItem(
                          'English (American)',
                          attributes.titles?.enUs ?? attributes.titles?.en ?? attributes.titles?.enJp ?? "Unknown",
                        ),
                        detailItem('Japanese', attributes.titles?.jaJp ?? "Unknown"),
                        detailItem(
                          'Japanese (Romaji)',
                          attributes.titles?.enJp ?? attributes.titles?.jaJp ?? "Unknown",
                        ),
                        detailItem('Episodes', attributes.episodeCount?.toString() ?? "N/A"),
                        detailItem('Status', attributes.status ?? "Unknown"),
                        detailItem(
                          'Aired',
                          (attributes.startDate ?? "") +
                              (attributes.endDate != null ? " to ${attributes.endDate}" : ""),
                        ),
                      ],
                    ),


                    // Wrap(
                    //   runSpacing: 10,
                    //   spacing: 40,
                    //   children: [
                    //     detailItem('English', 'Attack on Titan'),
                    //     detailItem('English (American)', 'Attack on Titan'),
                    //     detailItem('Japanese', '進撃の巨人'),
                    //     detailItem('Japanese (Romaji)', 'Shingeki no Kyojin'),
                    //     detailItem('Synonyms', 'AoT'),
                    //     detailItem('Type', 'TV'),
                    //     detailItem('Episodes', '25'),
                    //     detailItem('Status', 'Finished'),
                    //     detailItem('Aired', 'Apr 7, 2013 to Sep 29, 2013'),
                    //     detailItem('Season', 'Spring 2013'),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),

             SizedBox(height: 15),

            ReactionScreen(),

          ],
        ),
      );


    }
    else if (state is AnimeDetailsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AnimeDetailsError) {
      return Center(child: Text('Error: ${state.message}'));
    } else {
      return const SizedBox.shrink();
    }


  }

  Widget detailItem(String title, String value) {
    return SizedBox(
      width: 150,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(
              text: "$title\n",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterImage(String path) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(
          path,
          width: 150,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
