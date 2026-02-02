import 'package:dio/dio.dart';
import '../models/film.dart';
import 'api_config.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      queryParameters: {'api_key': ApiConfig.apiKey, 'language': 'ru-RU'},
    ),
  );

  Future<List<Film>> getPopularFilms({int page = 1}) async {
    try {
      final response = await _dio.get(
        'movie/popular',
        queryParameters: {'page': page},
      );
      final List<dynamic> results = response.data['results'];
      return results.map((json) => Film.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Ошибка загрузки фильмов: $e');
    }
  }

  Future<List<Film>> searchFilms(String query, {int page = 1}) async {
    try {
      final response = await _dio.get(
        'search/movie',
        queryParameters: {query: query, 'page': page},
      );
      final List<dynamic> results = response.data['results'];

      return results.map((json) => Film.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Ошибка поиска: $e');
    }
  }

  Future<Film> getFilmDetails(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      return Film.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка загрузки деталей: $e');
    }
  }
}
