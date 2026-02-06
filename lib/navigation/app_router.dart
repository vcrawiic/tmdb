import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/pages/films_page.dart';
import 'package:tmdb/pages/favorites_page.dart';
import 'package:tmdb/pages/film_details_page.dart';
import 'package:tmdb/pages/main_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: MainRoute.page,
      children: [
        AutoRoute(path: 'films', page: FilmsRoute.page),
        AutoRoute(path: 'favorites', page: FavoritesRoute.page),
      ],
    ),
    CustomRoute(
      path: '/film-details',
      page: FilmDetailsRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
  ];
}
