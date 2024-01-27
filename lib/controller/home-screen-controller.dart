import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mflix/models/cast-model.dart';
import 'package:mflix/models/media-model.dart';
import 'package:mflix/models/movie-genre-model.dart';
import 'package:mflix/utils/api-endpoint.dart';

import '../screens/home-screen.dart';
import '../widgets/navbar-screen.dart';
import 'navigation-bar-controller.dart';

class HomeScreenController extends GetxController{
  var isLoading = false.obs;

      Future<List<MediaModel>> getTrendingMoviesDay(http.Client client) async {
        final response = await client.get(Uri.parse(ApiEndPoints.baseUrl +
            ApiEndPoints.apiPath.trendingMoviesDay +
            ApiEndPoints.apiKey));
        if (response.statusCode == 200) {
          final decodedData = json.decode(response.body)['results'] as List;
          return decodedData.map((movie) => MediaModel.fromJson(movie)).toList();
        } else {
          throw Exception('TrendingMoviesDaily Failed to retrieve');
        }
      }

      Future<List<MediaModel>> getTopRatedMovies(http.Client client) async{
        final weekResponse = await client.get(Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.apiPath.topRatedMovies +
        ApiEndPoints.apiKey));
        if(weekResponse.statusCode == 200){
          final decodedData = json.decode(weekResponse.body)['results'] as List;
          return decodedData.map((movie) => MediaModel.fromJson(movie)).toList();
        }else{
          throw Exception('TopRatedMovies Failed to retrieve');
        }
      }

      Future<List<MediaModel>> getUpcomingMovies(http.Client client) async {
        final response = await client.get(Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.apiPath.upcomingMovies + ApiEndPoints.apiKey));
        if(response.statusCode == 200){
          final decodedData = json.decode(response.body)['results'] as List;
          return decodedData.map((movie) => MediaModel.fromJson(movie)).toList();
        }else {
          throw Exception('UpcomingMovies Failed to retrieve');
        }
      }

      Future<List<MediaModel>> getSimilarMovies(int id,http.Client client) async{
        final response = await client.get(Uri.parse(
            "${ApiEndPoints.baseUrl}/movie/$id/similar?${ApiEndPoints.apiKey}"));
        if(response.statusCode == 200){
          final decode = jsonDecode(response.body)['results'] as List;
          return decode.map((similar) => MediaModel.fromJson(similar)).toList();
        }else{
          throw Exception('SimilarSeries Failed to retrieve');
        }
      }

      Future<List<MediaGenreModel>> getMediaGenreList(http.Client client) async{
        final response = await client.get(Uri.parse(ApiEndPoints.baseUrl +
            ApiEndPoints.apiPath.movieGenreList +
            ApiEndPoints.apiKey));
        if (response.statusCode == 200){
          final decodeData = jsonDecode(response.body)['genres'] as List;
          return decodeData.map((genre) => MediaGenreModel.fromJson(genre)).toList();
        }else{
          throw Exception('MovieGenreList Failed to retrieve');
        }
      }

      Future<List<CastModel>> getCastList(int id, http.Client client) async{
        final response = await client.get(Uri.parse(
            "${ApiEndPoints.baseUrl}/movie/$id/credits?${ApiEndPoints.apiKey}"));
        if (response.statusCode == 200){
          final decodeData = jsonDecode(response.body)['cast'] as List;

          return decodeData.map((cast) => CastModel.fromJson(cast)).toList();
        }else{
          throw Exception('CastList Failed to retrieve');
        }
      }

      Future<List<MediaModel>> getTopRatedTvSeries(http.Client client) async {
        final response = await client.get(Uri.parse(ApiEndPoints.baseUrl +
            ApiEndPoints.apiPath.topRatedTvSeries + ApiEndPoints.apiKey));
        if(response.statusCode == 200){
          final decodedData = json.decode(response.body)['results']as List;
          return decodedData.map((series) => MediaModel.fromJson(series)).toList();
        }else {
          throw Exception('LatestTvSeries Failed to retrieve');
        }
      }

      Future<List<CastModel>> getSeriesCastList(int id, http.Client client) async{
        final response = await client.get(Uri.parse(
            "${ApiEndPoints.baseUrl}/tv/$id/credits?${ApiEndPoints.apiKey}"));
        if (response.statusCode == 200){
          final decodeData = jsonDecode(response.body)['cast'] as List;

          return decodeData.map((cast) => CastModel.fromJson(cast)).toList();
        }else{
          throw Exception('CastList Failed to retrieve');
        }
      }

      Future<List<MediaModel>> getSimilarSeries(int id, http.Client client) async{
        final response = await client.get(Uri.parse(
            "${ApiEndPoints.baseUrl}/tv/$id/recommendations?${ApiEndPoints.apiKey}"));
        if(response.statusCode == 200){
          final decode = jsonDecode(response.body)['results'] as List;
          return decode.map((similar) => MediaModel.fromJson(similar)).toList();
        }else{
          throw Exception('SimilarSeries Failed to retrieve');
        }
      }


  final _connectivityResult = ConnectivityResult.none.obs;
  ConnectivityResult get connectivityResult => _connectivityResult.value;
  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _connectivityResult.value = connectivityResult;

    if (_connectivityResult.value == ConnectivityResult.none) {
      showNoInternetDialog();
    }
  }
  void showNoInternetDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('No Internet Connection'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Please check your internet connection.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Try Again'),
            onPressed: () {
              Get.back(); // Close the current dialog
              checkConnectivity();
              navigationBarController.onReady();
              Get.offAll(() => NavBarScreen());
            },
          ),
        ],
      ),
    );
  }


}
