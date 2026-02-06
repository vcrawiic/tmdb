import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb/dependencies/global_dependencies.dart';
import 'package:tmdb/models/film.dart';
import 'package:tmdb/navigation/app_router.dart';

class FilmWidget extends StatelessWidget {
  final Film film;
  const FilmWidget({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final store = GlobalDependencies.filmStore;
    return GestureDetector(
      onTap: () => context.router.push(FilmDetailsRoute(filmId: film.id)),
      child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey, Colors.black],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        film.posterPath != null
                            ? 'https://image.tmdb.org/t/p/w500${film.posterPath}'
                            : 'https://via.placeholder.com/200x300?text=No+Image',
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Text(film.title),
              ],
            ),
            Observer(
              builder: (_) {
                final isFav = store.isFavorite(film.id);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : null,
                      ),
                      onPressed: () => store.toggleFavorite(film),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}
