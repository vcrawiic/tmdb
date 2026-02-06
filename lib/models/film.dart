import 'package:json_annotation/json_annotation.dart';

part 'film.g.dart';

@JsonSerializable()
class Film {
  final int id;
  final String title;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'vote_average', fromJson: _toDouble)
  final double voteAverage;

  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final String? overview;

  @JsonKey(name: 'original_language')
  final String originalLanguage;

  Film({
    required this.id,
    required this.title,
    this.posterPath,
    required this.voteAverage,
    this.releaseDate,
    this.overview,
    required this.originalLanguage,
  });

  factory Film.fromJson(Map<String, dynamic> json) => _$FilmFromJson(json);
  Map<String, dynamic> toJson() => _$FilmToJson(this);

  String getFullPosterPath() {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  static double _toDouble(dynamic value) => (value as num).toDouble();
}
