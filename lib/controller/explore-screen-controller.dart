import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mflix/utils/api-endpoint.dart';
import '../models/media-model.dart';


class ExploreScreenController extends GetxController{
  var isLoading = false.obs;
  TextEditingController searchController = TextEditingController();

      Future<List<MediaModel>>getPopularSeries() async{
          final response = await http.get(Uri.parse(
              ApiEndPoints.baseUrl + ApiEndPoints.apiPath.popularSeres + ApiEndPoints.apiKey));
          if(response.statusCode == 200){
            final decodeData = jsonDecode(response.body)["results"] as List;
            return decodeData.map((series) => MediaModel.fromJson(series)).toList();
          }else{
            throw Exception('PopularSeries Failed to Retrieve');
          }
      }
      Future<List<MediaModel>>getPopularMovies() async{
        final response = await http.get(Uri.parse(
            ApiEndPoints.baseUrl + ApiEndPoints.apiPath.popularMovies + ApiEndPoints.apiKey));
        if(response.statusCode == 200){
          final decodeData = jsonDecode(response.body)["results"] as List;
          return decodeData.map((movies) => MediaModel.fromJson(movies)).toList();
        }else{
          throw Exception('PopularMovies Failed to Retrieve');
        }
      }

      Future<List<MediaModel>>getSearchResult(String query, http.Client client) async{
        final response = await client.get(Uri.parse(
          "${ApiEndPoints.baseUrl}${ApiEndPoints.apiPath.search}${ApiEndPoints.apiKey}&query=$query"
        ));
        if(response.statusCode == 200){
          final decodeData = jsonDecode(response.body)["results"] as List;
          searchController.clear();
          return decodeData.map((search) => MediaModel.fromJson(search)).toList();
        }else{
          throw Exception("SearchResult Failed to Retrieve");
        }
      }

  Future<void> refreshData() async {
    await getPopularMovies(); // Implement your data refresh logic
    await getPopularSeries(); // Implement your data refresh logic for series
  }
}