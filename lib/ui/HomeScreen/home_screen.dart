import 'package:animelagoom/ui/HomeScreen/search_screen.dart';
import 'package:animelagoom/ui/HomeScreen/widgets/manga_section.dart';
import 'package:animelagoom/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'widgets/anime_section.dart';

class HomeScreen extends StatefulWidget {
  static const String homeRoute = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String contentType = 'anime'; // or 'manga'

  final TextEditingController searchController = TextEditingController();

  void _onSearchSubmitted(String value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchScreen(
            contentType: contentType, initialQuery: searchController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitsu'),
        actions: [
          ToggleButtons(
            isSelected: [contentType == 'anime', contentType == 'manga'],
            borderRadius: BorderRadius.circular(12),
            borderColor: Colors.grey,
            fillColor: Colors.transparent,
            color: Colors.grey,
            selectedBorderColor: AppColors.orangeColor,
            selectedColor: AppColors.orangeColor,
            onPressed: (int index) {
              setState(() {
                contentType = index == 0 ? 'anime' : 'manga';
              });
            },
            children: [
              Container(
                width: 80,
                alignment: Alignment.center,
                child: const Text('Anime'),
              ),
              Container(
                width: 80,
                alignment: Alignment.center,
                child: const Text('Manga'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search $contentType...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSubmitted: _onSearchSubmitted,
          ),
          const SizedBox(height: 16),
          if (contentType == 'anime') ...[
            AnimeSection(title: 'Trending This Week', category: 'trending'),
            AnimeSection(title: 'Top Upcoming', category: 'upcoming'),
            AnimeSection(title: 'Highest Rated', category: 'highestRated'),
            AnimeSection(title: 'Most Popular', category: 'mostPopular'),
          ] else ...[
            MangaSection(title: "Trending Manga", category: "trending"),
            MangaSection(title: "Upcoming Manga", category: "upcoming"),
            MangaSection(
                title: "Highest Rated Manga", category: "highestRated"),
            MangaSection(title: "Most Popular Manga", category: "mostPopular"),
          ],
        ],
      ),
    );
  }
}
