import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mflix/models/cast-model.dart';
import 'package:mflix/models/movie-genre-model.dart';
import 'package:mflix/models/movies-model.dart';
import 'package:mflix/utils/api-endpoint.dart';

import '../models/series-model.dart';

class HomeScreenController extends GetxController{
  var isLoading = false.obs;


      Future<List<MoviesModel>> getTrendingMoviesDay() async {
        final response = await http.get(Uri.parse(ApiEndPoints.baseUrl +
            ApiEndPoints.apiPath.trendingMoviesDay +
            ApiEndPoints.apiKey));
        if (response.statusCode == 200) {
          final decodedData = json.decode(response.body)['results'] as List;
          return decodedData.map((movie) => MoviesModel.fromJson(movie)).toList();
        } else {
          throw Exception('TrendingMoviesDaily Failed to retrieve');
        }
      }

      Future<List<MoviesModel>> getTopRatedMovies() async{
        final weekResponse = await http.get(Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.apiPath.topRatedMovies +
        ApiEndPoints.apiKey));
        if(weekResponse.statusCode == 200){
          final decodedData = json.decode(weekResponse.body)['results'] as List;
          return decodedData.map((movie) => MoviesModel.fromJson(movie)).toList();
        }else{
          throw Exception('TopRatedMovies Failed to retrieve');
        }
      }

      Future<List<MoviesModel>> getUpcomingMovies() async {
        final response = await http.get(Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.apiPath.upcomingMovies + ApiEndPoints.apiKey));
        if(response.statusCode == 200){
          final decodedData = json.decode(response.body)['results'] as List;
          return decodedData.map((movie) => MoviesModel.fromJson(movie)).toList();
        }else {
          throw Exception('UpcomingMovies Failed to retrieve');
        }
      }

      Future<List<SeriesModel>> getLatestTvSeries() async {
        final response = await http.get(Uri.parse(ApiEndPoints.baseUrl +
            ApiEndPoints.apiPath.topRatedTvSeries + ApiEndPoints.apiKey));
        if(response.statusCode == 200){
          final decodedData = json.decode(response.body)['results']as List;
          return decodedData.map((series) => SeriesModel.fromJson(series)).toList();
        }else {
          throw Exception('LatestTvSeries Failed to retrieve');
        }
      }

      Future<List<MovieGenreModel>> getMovieGenreList() async{
        final response = await http.get(Uri.parse(ApiEndPoints.baseUrl +
            ApiEndPoints.apiPath.movieGenreList +
            ApiEndPoints.apiKey));
        if (response.statusCode == 200){
          final decodeData = jsonDecode(response.body)['genres'] as List;
          return decodeData.map((genre) => MovieGenreModel.fromJson(genre)).toList();
        }else{
          throw Exception('MovieGenreList Failed to retrieve');
        }
      }

      Future<List<CastModel>> getCastList(int id) async{
        final response = await http.get(Uri.parse(
            "${ApiEndPoints.baseUrl}/movie/${id}/credits?${ApiEndPoints.apiKey}"));
        if (response.statusCode == 200){
          final decodeData = jsonDecode(response.body)['cast'] as List;

          return decodeData.map((cast) => CastModel.fromJson(cast)).toList();
        }else{
          throw Exception('CastList Failed to retrieve');
        }
      }

      Future<List<CastModel>> getSeriesCastList(int id) async{
        final response = await http.get(Uri.parse(
            "${ApiEndPoints.baseUrl}/tv/${id}/credits?${ApiEndPoints.apiKey}"));
        if (response.statusCode == 200){
          final decodeData = jsonDecode(response.body)['cast'] as List;

          return decodeData.map((cast) => CastModel.fromJson(cast)).toList();
        }else{
          throw Exception('CastList Failed to retrieve');
        }
      }

      Future<List<SeriesModel>> getSimilarSeries(int id) async{
        final response = await http.get(Uri.parse(
            "${ApiEndPoints.baseUrl}/tv/$id/recommendations?${ApiEndPoints.apiKey}"));
        if(response.statusCode == 200){
          final decode = jsonDecode(response.body)['results'] as List;
          return decode.map((similar) => SeriesModel.fromJson(similar)).toList();
        }else{
          throw Exception('SimilarSeries Failed to retrieve');
        }
      }

      Future<List<MoviesModel>> getSimilarMovies(int id) async{
        final response = await http.get(Uri.parse(
            "${ApiEndPoints.baseUrl}/movie/$id/similar?${ApiEndPoints.apiKey}"));
        if(response.statusCode == 200){
          final decode = jsonDecode(response.body)['results'] as List;
          return decode.map((similar) => MoviesModel.fromJson(similar)).toList();
        }else{
          throw Exception('SimilarSeries Failed to retrieve');
        }
      }


}