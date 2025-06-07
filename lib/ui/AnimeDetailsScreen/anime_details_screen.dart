import 'package:animelagoom/ui/AnimeDetailsScreen/summary_screen.dart';
import 'package:animelagoom/utils/app_colors.dart';
import 'package:animelagoom/utils/app_styles.dart';
import 'package:animelagoom/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Core/api/api_manager.dart';
import '../../models/anime_and_manga_model.dart';
import '../HomeScreen/Cubit/anime details/anime_details_bloc.dart';
import '../HomeScreen/Cubit/anime details/anime_details_states.dart';
import 'char_screen.dart';
import 'episode_screen.dart';
import 'reaction_screen.dart';

class AnimeDetailsScreen extends StatefulWidget {
  static String animeDetailsRoute = "animeDetailsRoute";
  // final String animeId;
  final MediaItem anime;
  const AnimeDetailsScreen({super.key, required this.anime});

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
    return BlocProvider(
        create: (_) => MediaDetailsBloc(KitsuApiManager())
          ..add(FetchMediaDetails(widget.anime.id, MediaType.anime)),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    widget.anime.attributes.coverImage?.large != null
                        ? Image.network(
                            widget.anime.attributes.coverImage?.large ?? '',
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
                        buildTab("Episodes"),
                        buildSeparator(),
                        buildTab("Characters"),
                        buildSeparator(),
                        buildTab("Reactions"),
                        buildSeparator(),
                        buildTab("Franchise"),
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
                              child:
                                  widget.anime.attributes.posterImage?.large !=
                                          null
                                      ? Image.network(
                                          widget.anime.attributes.posterImage
                                                  ?.large ??
                                              '',
                                          width: 200,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: 200,
                                          height: 300,
                                          color: Colors.grey,
                                          child: const Center(
                                              child: Text('No Poster')),
                                        ),
                            ),
                          ]),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                buildActionButton(
                                  "Completed",
                                  Colors.teal,
                                ),
                                const SizedBox(height: 8),
                                buildActionButton("Want to Watch", Colors.blue),
                                const SizedBox(height: 8),
                                buildActionButton(
                                    "Started Watching", Colors.purple),
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

  //
  // Widget buildTabContent() {
  //   switch (selectedTab) {
  //     case "Summary":
  //       return SummaryScreen(anime: widget.anime,);
  //     case "Episodes":
  //       return EpisodeScreen();
  //     case "Characters":
  //       return CharacterScreen();
  //     case "Reactions":
  //       return ReactionScreen();
  //     case "Franchise":
  //       return Container(
  //         color: Colors.orange,
  //         height: 500,
  //       );
  //     default:
  //       return Container(
  //         color: Colors.blue,
  //       );
  //   }
  // }
  Widget buildTabContent() {
    return BlocBuilder<MediaDetailsBloc, MediaDetailsState>(
      builder: (context, state) {
        if (state is MediaDetailsLoaded) {
          switch (selectedTab) {
            case "Summary":
              return SummaryScreen(anime:widget.anime ,);
            case "Episodes":
              // For anime, extraData = episodes; for manga, extraData = chapters
              return EpisodeScreen();
            case "Characters":
              return CharacterScreen(
                animeId: state.mediaItem.id,
              );
            case "Reactions":
              return ReactionScreen();
            case "Franchise":
              return Container(
                color: Colors.orange,
                height: 500,
              );
            default:
              return Container(
                color: Colors.blue,
              );
          }
        } else if (state is MediaDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MediaDetailsError) {
          return Center(child: Text("Error loading media: ${state.message}"));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
