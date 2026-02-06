import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb/dependencies/global_dependencies.dart';
import 'package:tmdb/models/film.dart';
import 'package:tmdb/pages/widgets/film_details_skeleton.dart';

@RoutePage()
class FilmDetailsPage extends StatelessWidget {
  final int filmId;
  const FilmDetailsPage({super.key, required this.filmId});

  @override
  Widget build(BuildContext context) {
    final store = GlobalDependencies.filmStore;
    store.loadFilmDetails(filmId);

    return Scaffold(
      body: Observer(
        builder: (_) {
          if (store.isLoadingDetails) {
            return const FilmDetailsSkeleton();
          }
          final film = store.selectedFilm;
          if (film == null) {
            return Center(child: Text(store.error ?? 'Ошибка загрузки'));
          }
          return CustomScrollView(
            slivers: [
              _buildAppBar(context, film, store),
              SliverToBoxAdapter(child: _buildBody(film)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Film film, dynamic store) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: film.posterPath != null
            ? Image.network(
                'https://image.tmdb.org/t/p/w780${film.posterPath}',
                fit: BoxFit.cover,
              )
            : Container(color: Colors.grey),
      ),
      actions: [
        Observer(
          builder: (_) {
            final isFav = store.isFavorite(film.id);
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.white,
              ),
              onPressed: () => store.toggleFavorite(film),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(Film film) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            film.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                film.voteAverage.toStringAsFixed(1),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              if (film.releaseDate != null) ...[
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 4),
                Text(film.releaseDate!),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Chip(label: Text(film.originalLanguage.toUpperCase())),
          const SizedBox(height: 16),
          if (film.overview != null && film.overview!.isNotEmpty) ...[
            const Text(
              'Описание',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              film.overview!,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ],
      ),
    );
  }
}
