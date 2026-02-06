// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [FavoritesPage]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesPage();
    },
  );
}

/// generated route for
/// [FilmDetailsPage]
class FilmDetailsRoute extends PageRouteInfo<FilmDetailsRouteArgs> {
  FilmDetailsRoute({
    Key? key,
    required int filmId,
    List<PageRouteInfo>? children,
  }) : super(
         FilmDetailsRoute.name,
         args: FilmDetailsRouteArgs(key: key, filmId: filmId),
         initialChildren: children,
       );

  static const String name = 'FilmDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilmDetailsRouteArgs>();
      return FilmDetailsPage(key: args.key, filmId: args.filmId);
    },
  );
}

class FilmDetailsRouteArgs {
  const FilmDetailsRouteArgs({this.key, required this.filmId});

  final Key? key;

  final int filmId;

  @override
  String toString() {
    return 'FilmDetailsRouteArgs{key: $key, filmId: $filmId}';
  }
}

/// generated route for
/// [FilmsPage]
class FilmsRoute extends PageRouteInfo<void> {
  const FilmsRoute({List<PageRouteInfo>? children})
    : super(FilmsRoute.name, initialChildren: children);

  static const String name = 'FilmsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FilmsPage();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}
