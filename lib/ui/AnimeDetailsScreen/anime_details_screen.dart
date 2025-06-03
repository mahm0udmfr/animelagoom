import 'package:animelagoom/ui/AnimeDetailsScreen/char%20screen.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/episode%20screen.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/reaction%20screen.dart';
import 'package:animelagoom/ui/AnimeDetailsScreen/summary_screen.dart';
import 'package:animelagoom/utils/app_colors.dart';
import 'package:animelagoom/utils/app_styles.dart';
import 'package:animelagoom/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Core/api/api_manager.dart';
import '../../models/AnimeDetails.dart';
import '../HomeScreen/Cubit/anime details/anime states.dart';
import '../HomeScreen/Cubit/anime details/anime view model.dart';

class AnimeDetailsScreen extends StatefulWidget {
  final String animeId;
  const AnimeDetailsScreen({required this.animeId, Key? key}) : super(key: key);
      static String animeDetailsRoute = "animeDetailsRoute";

  @override
  State<AnimeDetailsScreen> createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  final KitsuApiManager apiManager = KitsuApiManager();
  AnimeDetails? anime;
  bool loading = true;

  String selectedTab = "Summary";

  void selectTab(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  void initState() {
    super.initState();
    apiManager.fetchAnimeDetails(widget.animeId).then((value) {
      setState(() {
        anime = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnimeCubit(KitsuApiManager())..fetchAnime(widget.animeId),
      child: Scaffold(
        body: SingleChildScrollView(
          child:Column(
            children: [
    BlocBuilder<AnimeCubit, AnimeState>(
    builder: (context, state) {
    if (state is AnimeLoading) {
    return const Center(child: CircularProgressIndicator());
    } else if (state is AnimeError) {
    return Center(child: Text(state.message));
    } else if (state is AnimeLoaded) {
          final anime = state.anime;


          return Column(
          children: [
          Stack(
          children: [
          Image.network(
            anime.data?.attributes?.coverImage?.original ?? '',
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
          ),
          Container(
          width: double.infinity,
          height: 250,
          color: AppColors.transparent,
          padding: const EdgeInsets.all(16),
          child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
          'comments',
          style:AppStyles.regular14WhiteRoboto,
          ),
          ),
          )
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
          Stack(
          children: [
          ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            anime.data?.attributes?.coverImage?.original ?? '',
          width: 200,
          height: 300,
          fit: BoxFit.cover,
          ),
          ),
          Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(4)
          ),
          ),
          child: IconButton(
          icon: const Icon(Icons.favorite_border),
          color: AppColors.greyColor,
          onPressed: () {},
          ),
          ),
          ]
          ),
          const SizedBox(width: 16),
          Expanded(
          child: Column(
          children: [
          buildActionButton("Completed", Colors.teal, ),
          const SizedBox(height: 8),
          buildActionButton("Want to Watch", Colors.blue),
          const SizedBox(height: 8),
          buildActionButton("Started Watching", Colors.purple),
          SizedBox(height: 40,),
          Text('Watch Online ',style: AppStyles.regular16greyRoboto,),
          SizedBox(height: 10,),
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
          );
          }
          return Container();
          },
    ),

    ],
          )




        ),
      ),
    );
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


  Widget buildActionButton(String text, Color color,) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: (){},
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
            color: AppColors.whiteColor ,
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
        return SummaryScreen();
      case "Episodes":
        return EpisodeScreen();
      case "Characters":
        return CharacterScreen();
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
  }

}