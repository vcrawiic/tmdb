import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class FavoriteFilms extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get posterPath => text().nullable()();
  RealColumn get voteAverage => real()();
  TextColumn get releaseDate => text().nullable()();
  TextColumn get overview => text().nullable()();
  TextColumn get oiginalLanguage => text().nullable()();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [FavoriteFilms])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<FavoriteFilm>> getAllFavorites() => select(favoriteFilms).get();

  Stream<List<FavoriteFilm>> watchAllFavorites() =>
      select(favoriteFilms).watch();

  Future<void> addFavorite(FavoriteFilmsCompanion film) =>
      into(favoriteFilms).insert(film);

  Future<void> removeFavorite(int filmId) =>
      (delete(favoriteFilms)..where((t) => t.id.equals(filmId))).go();

  Future<bool> isFavorite(int filmId) async {
    final query = select(favoriteFilms)..where((t) => t.id.equals(filmId));
    final result = await query.getSingleOrNull();
    return result != null;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'films.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
