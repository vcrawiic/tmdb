import 'package:tmdb/database/database.dart';
import 'package:tmdb/services/api_service.dart';
import 'package:tmdb/stores/film_store.dart';

class GlobalDependencies {
  static final ApiService apiService = ApiService();
  static final AppDatabase appDatabase = AppDatabase();
  static final FilmStore filmStore =
      FilmStore(apiService, appDatabase);
}
