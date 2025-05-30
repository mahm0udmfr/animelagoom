import 'package:animelagoom/ui/AnimeDetailsScreen/anime_details_screen.dart';
import 'package:animelagoom/ui/HomeScreen/home_screen.dart';
import 'package:animelagoom/utils/app_theme.dart';
import 'package:animelagoom/utils/sheardprefrences.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferenceUtils.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.whiteTheme,
      initialRoute: HomeScreen.homeRoute,
      routes: {
        HomeScreen.homeRoute: (context) => const HomeScreen(),
        AnimeDetailsScreen.animeDetailsRoute:
            (context) => const AnimeDetailsScreen(),
      },
    );
  }
}
