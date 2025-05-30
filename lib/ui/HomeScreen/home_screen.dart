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
    // navigate to search screen or display results
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
            children: const [
              Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('Anime')),
              Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('Manga')),
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onSubmitted: _onSearchSubmitted,
          ),
          const SizedBox(height: 16),

          AnimeSection(title: 'Trending This Week', category: 'trending'),
          AnimeSection(title: 'Top Upcoming', category: 'upcoming'),
          AnimeSection(title: 'Highest Rated', category: 'highestRated'),
          AnimeSection(title: 'Most Popular', category: 'mostPopular'),
        ],
      ),
    );
  }
}
