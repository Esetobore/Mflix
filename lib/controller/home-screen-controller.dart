import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
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
          throw Exception('Something happened');
        }
      }

      Future<List<MoviesModel>> getTrendingMoviesWeekly() async{
        final weekResponse = await http.get(Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.apiPath.popularMovies +
        ApiEndPoints.apiKey));
        if(weekResponse.statusCode == 200){
          final decodedData = json.decode(weekResponse.body)['results'] as List;
          return decodedData.map((movie) => MoviesModel.fromJson(movie)).toList();
        }else{
          throw Exception('Error getting information');
        }
      }

      Future<Object> getUpcomingMovies() async {
        final response = await http.get(Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.apiPath.upcomingMovies + ApiEndPoints.apiKey));
        if(response.statusCode == 200){
          final decodedData = json.decode(response.body)['results'] as List;
          return decodedData.map((movie) => MoviesModel.fromJson(movie)).toList();
        }else {
          return Exception('Error Getting Movies');
        }
      }

      Future<Object> getLatestTvSeries() async {
        final response = await http.get(Uri.parse(ApiEndPoints.baseUrl +
            ApiEndPoints.apiPath.latestTvSeries + ApiEndPoints.apiKey));
        if(response.statusCode == 200){
          final decodedData = json.decode(response.body)['results']as List;
          return decodedData.map((series) => SeriesModel.fromJson(series)).toList();
        }else {
          return Exception('Error Getting Series');
        }
      }


}