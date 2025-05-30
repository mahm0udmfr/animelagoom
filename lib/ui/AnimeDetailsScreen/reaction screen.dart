import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

class ReactionScreen extends StatefulWidget{
  @override
  State<ReactionScreen> createState() => _ReactionScreenState();
}

class _ReactionScreenState extends State<ReactionScreen> {
  String selectedSort = 'Popular';

  final List<Map<String, dynamic>> popularReactions = [
    {
      "username": "Sam",
      "votes": 100,
      "text":
      "comment1........."
    },
    {
      "username": "JonathNell",
      "votes": 85,
      "text":
      "comment2..."
    },
    {
      "username": "Doaks",
      "votes": 72,
      "text":
      "comment3......."
    },
    {
      "username": "jojovonjo (Parody)",
      "votes": 61,
      "text":
      "comment4....."
    }
  ];

  final List<Map<String, dynamic>> recentReactions = [
    {
      "username": "jojovonjo (Parody)",
      "votes": 61,
      "text":
      "comment1.."
    },
    {
      "username": "AnimeFan123",
      "votes": 40,
      "text":
      "comment"
    },
    {
      "username": "MimiChan",
      "votes": 33,
      "text":
      "comment.."
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> reactions = selectedSort == 'Popular'
        ? popularReactions
        : recentReactions;

   return  Padding(
     padding: const EdgeInsets.all(15),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Row(
           children: [
              Text(
               "Reactions",
               style: AppStyles.bold20BlockRoboto,
             ),
             const SizedBox(width: 10),
             DropdownButton<String>(
               value: selectedSort,
               icon: const Icon(Icons.arrow_drop_down),
               elevation: 16,
               style: const TextStyle(color: Colors.black),
               underline: Container(height: 0),
               onChanged:(String? newValue) {
                if (newValue != null) {
                   setState(() {
                  selectedSort = newValue;
      });
      }
      },
               items: <String>['Popular', 'Recent']
                   .map<DropdownMenuItem<String>>((String value) {
                 return DropdownMenuItem<String>(
                   value: value,
                   child: Text(value ),
                 );
               }).toList(),
             ),
           ],
         ),
         const SizedBox(height: 8),
         ListView.separated(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemCount: reactions.length,
           separatorBuilder: (_, __) => const Divider(),
           itemBuilder: (context, index) {
             final reaction = reactions[index];
             return ListTile(
               leading: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Icon(Icons.arrow_drop_up, size: 20),
                   Text(reaction["votes"].toString(),
                       style:  AppStyles.bold20BlockRoboto),
                 ],
               ),
               title: Text(
                 reaction["username"],
                 style: const TextStyle(
                     fontWeight: FontWeight.bold, color: Colors.grey),
               ),
               subtitle: Padding(
                 padding: const EdgeInsets.only(top: 4.0),
                 child: Text(
                   reaction["text"],
                   style: AppStyles.bold20BlockRoboto,
                 ),
               ),
             );
           },
         )
       ],
     ),
   );
  }
}