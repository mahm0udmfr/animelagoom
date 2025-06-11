import 'package:animelagoom/Services/anime_service.dart';
import 'package:animelagoom/models/anime_and_manga_main_model.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/char_screen.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/episode_screen.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/reaction_screen.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/summary_screen.dart';
import 'package:animelagoom/utils/app_colors.dart';
import 'package:animelagoom/utils/app_styles.dart';
import 'package:animelagoom/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AnimeDetailsScreen extends StatefulWidget {
  static String animeDetailsRoute = "animeDetailsRoute";
  // final String animeId;
  final MediaItem mediaItem;
  const AnimeDetailsScreen({super.key, required this.mediaItem});

  @override
  State<AnimeDetailsScreen> createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {

  String selectedTab = "Summary";

  void selectTab(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              widget.mediaItem.attributes.coverImage != null
                  ? Image.network(
                      widget.mediaItem.attributes.coverImage!.original ?? '',
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 400,
                      color: Colors.grey,
                      child: const Center(child: Text('No Cover Image')),
                    ),
            ],
          ),
          Container(
            color: Colors.white,
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildTab("Summary"),
                  buildSeparator(),
                  buildTab(widget.mediaItem.type == "anime"
                      ? "Episodes"
                      : "Chapters"),
                  buildSeparator(),
                  buildTab("Characters"),
                  buildSeparator(),
                  buildTab("Reactions"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: widget.mediaItem.attributes.posterImage != null
                            ? Image.network(
                                widget.mediaItem.attributes.posterImage!
                                        .original ??
                                    '',
                                width: 200,
                                height: 300,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 200,
                                height: 300,
                                color: Colors.grey,
                                child: const Center(child: Text('No Poster')),
                              ),
                      ),
                    ]),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [

                          buildActionButton("Watch List", Colors.teal),

                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Watch Online ',
                            style: AppStyles.regular16greyRoboto,
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildServiceBox(AssetsManager.netflix),
                              const SizedBox(width: 8),
                              buildServiceBox(AssetsManager.hulu),
                              const SizedBox(width: 8),
                              buildServiceBox(AssetsManager.crunchyroll),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          buildTabContent(),
        ],
      ),
    ));
  }

  Widget buildTab(String title) {
    final isSelected = selectedTab == title;
    return GestureDetector(
      onTap: () => selectTab(title),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildSeparator() {
    return Container(
      width: 1,
      height: 20,
      color: AppColors.greyColor,
      margin: EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget buildActionButton(
    String text,
    Color color,
  ) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildServiceBox(String imagePath) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget buildTabContent() {
    switch (selectedTab) {
      case "Summary":
        return SummaryScreen(
          anime: widget.mediaItem,
        ); // No anime param needed here
      case "Episodes":
        return EpisodesScreen(
          mediaId: widget.mediaItem.id,
          mediaType: widget.mediaItem.type,
          mediaImage: widget.mediaItem.attributes.posterImage!.original!,
        );
      case "Chapters":
        return EpisodesScreen(
          mediaId: widget.mediaItem.id,
          mediaType: widget.mediaItem.type,
          mediaImage: widget.mediaItem.attributes.posterImage!.original!,
        );

      case "Characters":
        return CharactersScreen(
          isAnime: widget.mediaItem.type == "anime" ? true : false,
          mediaId: widget.mediaItem.id,
        );
      case "Reactions":
      return ReactionScreen(
          isAnime: widget.mediaItem.type == "anime" ? true : false,
          mediaId: widget.mediaItem.id,
      );

      default:
        return Container(
          color: Colors.blue,
        );
    }
  }
}
