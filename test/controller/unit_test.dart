import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mflix/controller/bookmark-screen-controller.dart';
import 'package:http/http.dart' as http;
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/models/media-model.dart';
import 'package:mflix/screens/explore-screen.dart';
import 'package:mflix/sql_helper.dart';
import 'package:mflix/utils/api-endpoint.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'unit_test.mocks.dart';

class MockDatabaseHelper extends GetxController with Mock implements SqlDatabaseHelper {}
HomeScreenController homeScreenController = Get.put(HomeScreenController());

@GenerateMocks([http.Client])
void main() {
  group("BookmarkController", () {


    test("Initialize Empty", () {
      expect(bookmarkController.moviesList.length, 0);
    });

  });

group("HomeScreenController", () {
  final client = MockClient();

  test("Trending Movies Day", () async {
    when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.trendingMoviesDay + ApiEndPoints.apiKey)))
        .thenAnswer((realInvocation) async =>
        http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}]}', 200));

    final result = await homeScreenController.getTrendingMoviesDay(client);

    expect(result, isA<List<MediaModel>>());
  });

  test("getTopRatedMovies", () async {
    when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.topRatedMovies + ApiEndPoints.apiKey)))
        .thenAnswer((realInvocation) async =>
        http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka"}]}', 200));

    final result = await homeScreenController.getTopRatedMovies(client);

    expect(result, isA<List<MediaModel>>());
  });

  test("getUpcomingMovies", () async {
    when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.upcomingMovies + ApiEndPoints.apiKey)))
        .thenAnswer((realInvocation) async =>
        http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}]}', 200));

    final result = await homeScreenController.getUpcomingMovies(client);

    expect(result, isA<List<MediaModel>>());
  });

  test("getSimilarMovies", () async {
    var id = 1234;
    when(client.get(Uri.parse("${ApiEndPoints.baseUrl}/movie/$id/similar?${ApiEndPoints.apiKey}")))
        .thenAnswer((realInvocation) async =>
        http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}]}', 200));

    final result = await homeScreenController.getSimilarMovies(id, client);

    expect(result, isA<List<MediaModel>>());
  });

  test("getTopRatedTvSeries", () async {
    when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.topRatedTvSeries + ApiEndPoints.apiKey)))
        .thenAnswer((realInvocation) async =>
        http.Response('{"results": [{"original_title": "BreakingBad", "BreakingBad": "Wonka", "media_type": "series"}]}', 200));

    final result = await homeScreenController.getTopRatedTvSeries(client);

    expect(result, isA<List<MediaModel>>());
  });

  test("getSimilarSeries", () async {
    var id = 1234;
    when(client.get(Uri.parse("${ApiEndPoints.baseUrl}/tv/$id/recommendations?${ApiEndPoints.apiKey}")))
        .thenAnswer((realInvocation) async =>
        http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}]}', 200));

    final result = await homeScreenController.getSimilarSeries(id, client);

    expect(result, isA<List<MediaModel>>());
  });

});

group("ExploreScreenController", () {
  final client = MockClient();

  test("getSearchResult", () async {
    var query = "one piece";
    when(client.get(Uri.parse("${ApiEndPoints.baseUrl}${ApiEndPoints.apiPath.search}${ApiEndPoints.apiKey}&query=$query")))
        .thenAnswer((realInvocation) async =>
        http.Response('{"results": [{"original_title": "One Piece", "title": "One piece", "media_type": "series"}]}', 200));
    final result = await exploreScreenController.getSearchResult(query, client);
    expect(result, isA<List<MediaModel>>());

  });

});

}
