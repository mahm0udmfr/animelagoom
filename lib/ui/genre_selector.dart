import 'package:flutter/material.dart';

import '../models/genere_model.dart';

class GenreSelector extends StatefulWidget {
  final List<Genre> genres;

  const GenreSelector({super.key, required this.genres});

  @override
  State<GenreSelector> createState() => _GenreSelectorState();
}

class _GenreSelectorState extends State<GenreSelector> {
  final Set<String> selectedGenreIds = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: widget.genres.map((genre) {
        final isSelected = selectedGenreIds.contains(genre.id);
        return ChoiceChip(
          label: Text(genre.name),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedGenreIds.add(genre.id);
              } else {
                selectedGenreIds.remove(genre.id);
              }
            });
          },
          selectedColor: Colors.blue.shade300,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}
