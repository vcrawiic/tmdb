import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tmdb/dependencies/global_dependencies.dart';
import 'package:tmdb/pages/widgets/film_widget.dart';

@RoutePage()
class FilmsPage extends StatefulWidget {
  const FilmsPage({super.key});

  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage>
    with AutomaticKeepAliveClientMixin {
  final _store = GlobalDependencies.filmStore;
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        key: const PageStorageKey('films_scroll'),
        controller: _scrollController,
        slivers: [_buildAppBar(), _buildFilmsGrid()],
      ),
    );
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      _store.loadNextPage();
    }
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      title: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Поиск фильмов...',
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _store.setSearchQuery('');
            },
          ),
        ),
        onChanged: (value) => _store.setSearchQuery(value),
      ),
    );
  }

  Widget _buildFilmsGrid() {
    return Observer(
      builder: (_) {
        if (_store.isLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (_store.error != null) {
          return SliverFillRemaining(child: Center(child: Text(_store.error!)));
        }

        final itemCount = _store.films.length + (_store.hasMorePages ? 1 : 0);

        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index == _store.films.length) {
                return _store.isLoadingMore
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              }
              return FilmWidget(film: _store.films[index]);
            }, childCount: itemCount),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.57,
            ),
          ),
        );
      },
    );
  }
}
