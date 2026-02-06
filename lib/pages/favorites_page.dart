import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb/dependencies/global_dependencies.dart';
import 'package:tmdb/pages/widgets/film_widget.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final store = GlobalDependencies.filmStore;
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: Observer(
        builder: (_) {
          final favorites = store.favoriteFilms;

          if (favorites.isEmpty) {
            return const Center(child: Text('Нет избранных фильмов'));
          } else {
            return GridView.builder(
              key: const PageStorageKey('favorites_scroll'),
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final film = favorites[index];

                return Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: 1,
                  child: FilmWidget(film: film),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.57,
              ),
            );
          }
        },
      ),
    );
  }
}
