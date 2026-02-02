import 'package:tmdb/film_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> films = [
    {
      'title': 'Интерстеллар',
      'image': 'https://upload.wikimedia.org/wikipedia/ru/c/c3/Interstellar_2014.jpg',
    },
    {
      'title': 'Брат',
      'image': 'https://upload.wikimedia.org/wikipedia/ru/2/2e/Brat_1997.jpg',
    },
    {
      'title': 'Амели',
      'image': 'https://upload.wikimedia.org/wikipedia/ru/3/3d/Amelie_poster.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
          itemCount: films.length,
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemBuilder: (context, index) {
            final film = films[index];
            return FilmWidget(
              title: film['title'],
              image: film['image'],
            );
          },
        ),
      ),
    );
  }
}
