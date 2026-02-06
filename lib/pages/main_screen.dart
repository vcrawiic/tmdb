import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/navigation/app_router.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes:  [
        FilmsRoute(),
        FavoritesRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Фильмы'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
            ],
          ),
        );
      },
    );
  }
}