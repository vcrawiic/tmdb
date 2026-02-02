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

  _FilmStore(this._filmService, this._database);

  @observable
  ObservableList<Film> films = ObservableList<Film>();

  @observable
  ObservableSet<int> favoriteIds = ObservableSet<int>();

  @observable
  bool isLoading = false;

  @observable
  String? error;

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
}
