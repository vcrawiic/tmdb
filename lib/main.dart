import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb/dependencies/global_dependencies.dart';
import 'package:tmdb/navigation/app_router.dart';

  Future<void> main() async {
    await dotenv.load(fileName: ".env");
    GlobalDependencies.filmStore.loadPopularFilms();
    GlobalDependencies.filmStore.getFavorites();
    runApp(const MyApp());
}

  final _appRouter = AppRouter();

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp.router(
        title: 'TMDB',
        theme: ThemeData.dark(),
        routerConfig: _appRouter.config(),
      );
    }
  }