import 'package:animelagoom/ui/AnimeDetailsScreen/reaction_screen.dart';
import 'package:animelagoom/utils/app_colors.dart';
import 'package:animelagoom/utils/app_styles.dart';
import 'package:animelagoom/utils/assets_manager.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget{

  final List<String> tags = [
    'Action', 'Adventure', 'Alternative Past', 'Angst', 'Drama',
    'Fantasy', 'Horror', 'Military', 'Post Apocalypse',
    'Shounen', 'Super Power', 'Violence'
  ];

   SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return  Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           children:[
     Text(
     'Attack on Titan',
       style: AppStyles.bold24BlockRoboto,
     ),
             SizedBox(width: 10,),
             Text(
               '2013',
               style: AppStyles.regular16greyColorRoboto),
     ]),

         SizedBox(height: 12),
         Stack(
           children: [
             Container(
               height: 100,
               width: double.infinity,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage(AssetsManager.test),
                   fit: BoxFit.cover,
                 ),
                 borderRadius: BorderRadius.circular(4),
               ),
             ),
             Positioned.fill(
               child: Center(
                 child: ElevatedButton.icon(
                   onPressed: () {},
                   icon: Icon(Icons.play_arrow),
                   label: Text("Play Trailer"),
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
           "content.........",
           style:AppStyles.regular16greyColorRoboto,
         ),
         SizedBox(height: 4),
         InkWell(
           onTap: () {},
           child: Text(
             "read more",
             style: TextStyle(color: Colors.red, fontSize: 16),
           ),
         ),
         SizedBox(height: 12),
         Wrap(
           spacing: 8,
           runSpacing: 8,
           children: tags
               .map((tag) => Chip(
             label: Text(tag),
             backgroundColor: Colors.grey[200],
           ))
               .toList(),
         ),
         SizedBox(height: 15),

         // ⭐ Anime Ranks
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   Icon(Icons.favorite, color: Colors.red, size: 20),
                   SizedBox(width: 4),
                   Text('Rank #1 (Most Popular Anime)',style: AppStyles.regular16greyRoboto,),
                 ],
               ),
               SizedBox(height: 4),
               Row(
                 children: [
                   Icon(Icons.star, color: Colors.orange, size: 20),
                   SizedBox(width: 4),
                   Text('Rank #30 (Highest Rated Anime)', style: AppStyles.regular16greyRoboto,),
                 ],
               ),
             ],
           ),
         ),

         const SizedBox(height: 20),

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
                   'Anime Details',
                   style:AppStyles.bold20BlockRoboto ,
                 ),
                 const SizedBox(height: 12),
                 Wrap(
                   runSpacing: 10,
                   spacing: 40,
                   children: [
                     detailItem('English', 'Attack on Titan'),
                     detailItem('English (American)', 'Attack on Titan'),
                     detailItem('Japanese', '進撃の巨人'),
                     detailItem('Japanese (Romaji)', 'Shingeki no Kyojin'),
                     detailItem('Synonyms', 'AoT'),
                     detailItem('Type', 'TV'),
                     detailItem('Episodes', '25'),
                     detailItem('Status', 'Finished'),
                     detailItem('Aired', 'Apr 7, 2013 to Sep 29, 2013'),
                     detailItem('Season', 'Spring 2013'),
                   ],
                 ),
               ],
             ),
           ),
         ),

         const SizedBox(height: 15),

         // 👥 Characters
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16),
           child:  Text(
             'Characters',
             style: AppStyles.bold20BlockRoboto,
           ),
         ),
         const SizedBox(height: 12),

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16),
           child: SizedBox(
             height: 350,
             child: SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   buildCharacterImage(AssetsManager.test),
                   buildCharacterImage(AssetsManager.test),
                   buildCharacterImage(AssetsManager.test),
                   buildCharacterImage(AssetsManager.test),

                 ],
               ),
             ),
           ),
         ),

         const SizedBox(height: 8),

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16),
           child: TextButton(
             onPressed: () {
               // Navigate or expand full character list
             },
             child: const Text('View all characters'),
           ),
         ),

         const SizedBox(height: 20),

         ReactionScreen(),

       ],
     ),
   );

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