import 'dart:async';

import 'package:drift/drift.dart';
import 'package:tmdb/database/database.dart';
import 'package:tmdb/models/film.dart';
import 'package:tmdb/services/api_service.dart';
import 'package:mobx/mobx.dart';

part 'film_store.g.dart';

class FilmStore = _FilmStore with _$FilmStore;

abstract class _FilmStore with Store {
  final ApiService _filmService;
  final AppDatabase _database;
  Timer? _debounceTimer;

  _FilmStore(this._filmService, this._database);

  @observable
  ObservableList<Film> films = ObservableList<Film>();

  @observable
  ObservableSet<int> favoriteIds = ObservableSet<int>();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  Film? selectedFilm;

  @observable
  bool isLoadingDetails = false;

  @observable
  String searchQuery = '';

  @observable
  int currentPage = 1;

  @observable
  bool hasMorePages = false;

  @observable
  bool isLoadingMore = false;

  @computed
  List<Film> get favoriteFilms =>
      films.where((f) => favoriteIds.contains(f.id)).toList();

  bool isFavorite(int filmId) => favoriteIds.contains(filmId);

  @action
  Future<void> loadPopularFilms() async {
    isLoading = true;
    error = null;
    try {
      final result = await _filmService.getPopularFilms();
      films = ObservableList.of(result);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> searchFilms(String query) async {
    isLoading = true;
    error = null;
    try {
      final result = await _filmService.searchFilms(query);
      films = ObservableList.of(result);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> getFavorites() async {
    final favorites = await _database.getAllFavorites();
    favoriteIds = ObservableSet.of(favorites.map((f) => f.id));
  }

  @action
  Future<void> loadFilmDetails(int id) async {
    if (selectedFilm?.id == id) return;
    isLoadingDetails = true;
    selectedFilm = null;
    try {
      selectedFilm = await _filmService.getFilmDetails(id);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoadingDetails = false;
    }
  }

  @action
  Future<void> toggleFavorite(Film film) async {
    if (favoriteIds.contains(film.id)) {
      await _database.removeFavorite(film.id);
      favoriteIds.remove(film.id);
    } else {
      await _database.addFavorite(
        FavoriteFilmsCompanion.insert(
          id: Value(film.id),
          title: film.title,
          posterPath: Value(film.posterPath),
          voteAverage: film.voteAverage,
          releaseDate: Value(film.releaseDate),
          overview: Value(film.overview),
          oiginalLanguage: Value(film.originalLanguage),
          addedAt: Value(DateTime.now()),
        ),
      );
      favoriteIds.add(film.id);
    }
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
    _debounceTimer?.cancel(); // отменяем предыдущий таймер
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch();
    });
  }

  @action
  Future<void> _performSearch() async {
    currentPage = 1;
    hasMorePages = true;
    isLoading = true;
    error = null;
    try {
      final result = searchQuery.isEmpty
          ? await _filmService.getPopularFilms(page: currentPage)
          : await _filmService.searchFilms(searchQuery, page: currentPage);
      films = ObservableList.of(result);
      hasMorePages = result.isNotEmpty;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadNextPage() async {
    if (isLoadingMore || !hasMorePages) return;
    isLoadingMore = true;
    currentPage++;
    error = null;

    try {
      final result = searchQuery.isEmpty
          ? await _filmService.getPopularFilms(page: currentPage)
          : await _filmService.searchFilms(searchQuery, page: currentPage);
      films.addAll(result);
      hasMorePages = result.isNotEmpty;
    } catch (e) {
      currentPage--;
      error = e.toString();
    } finally {
      isLoadingMore = false;
    }
  }
}
