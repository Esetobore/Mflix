import 'dotenv.dart';

class ApiEndPoints {
  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static _ApiPath apiPath = _ApiPath();
  static final String apiKey =  Dotenv.apiKey();
  static const String imagePath = 'https://image.tmdb.org/t/p/w500/';
}

class _ApiPath {
  final String trendingMoviesDay = 'trending/movie/day?';
  final String topRatedMovies = 'movie/top_rated?';
  final String upcomingMovies = 'movie/upcoming?';
  final String topRatedTvSeries = 'tv/top_rated?';
  final String movieGenreList = 'genre/movie/list?';
  final String popularSeres = 'tv/popular?';
  final String popularMovies = 'movie/popular?';
  final String search = 'search/multi?';
}