import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mflix/controller/bookmark-screen-controller.dart';
import 'package:http/http.dart' as http;
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/models/media-model.dart';
import 'package:mflix/screens/explore-screen.dart';
import 'package:mflix/sql_helper.dart';
import 'package:mflix/utils/api-endpoint.dart';
import 'package:mflix/utils/dotenv.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'unit_test.mocks.dart';

class MockDatabaseHelper extends GetxController with Mock implements SqlDatabaseHelper {}
HomeScreenController homeScreenController = Get.put(HomeScreenController());

@GenerateMocks([http.Client])
void main() {

  late http.Client client;

  setUp(() {
    client = MockClient();
    Dotenv.load();
  });

group("BookmarkController", () {
    test("Initialize Empty", () {
      expect(bookmarkController.moviesList.length, 0);
    });

  });

group("HomeScreenController", () {

  group("Trending Movies Day", (){
    test("Trending Movies Day", () async {
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.trendingMoviesDay + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation) async =>
          http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}]}', 200));

      final result = await homeScreenController.getTrendingMoviesDay(client);

      expect(result, isA<List<MediaModel>>());
    });
    test('Error Exception', () {
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.trendingMoviesDay + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation) async =>
          http.Response('Not Found', 404));
      final result = homeScreenController.getTrendingMoviesDay(client);
      expect(result, throwsException);
    });
  });

  group("getTopRatedMovies", (){
    test("getTopRatedMovies", () async {
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.topRatedMovies + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation) async =>
          http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka"}]}', 200));

      final result = await homeScreenController.getTopRatedMovies(client);

      expect(result, isA<List<MediaModel>>());
    });
    test('Error Exception', () {
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.topRatedMovies + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation) async =>
          http.Response('Not Found', 404));
      final result = homeScreenController.getTopRatedMovies(client);
      expect(result, throwsException);
    });
  });


group("getUpcomingMovies", () {
    test("getUpcomingMovies", () async {
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.upcomingMovies + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation) async =>
          http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}]}', 200));

      final result = await homeScreenController.getUpcomingMovies(client);

      expect(result, isA<List<MediaModel>>());
    });
    test('Error Exception', () {
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.upcomingMovies + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation) async =>
          http.Response('Not Found', 404));
      final result = homeScreenController.getUpcomingMovies(client);
      expect(result, throwsException);
    });
  });

 group("getSimilarMovies", () {
   var id = 1234;
    test("getSimilarMovies", () async {
      when(client.get(Uri.parse("${ApiEndPoints.baseUrl}/movie/$id/similar?${ApiEndPoints.apiKey}")))
          .thenAnswer((realInvocation) async =>
          http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}]}', 200));

      final result = await homeScreenController.getSimilarMovies(id, client);

      expect(result, isA<List<MediaModel>>());
    });
    test('Error Exception', () {
      when(client.get(Uri.parse("${ApiEndPoints.baseUrl}/movie/$id/similar?${ApiEndPoints.apiKey}")))
          .thenAnswer((realInvocation) async =>
          http.Response('Not Found', 404));
      final result = homeScreenController.getSimilarMovies(id, client);
      expect(result, throwsException);
    });
  });

  group("getTopRatedTvSeries", () {
    test("getTopRatedTvSeries", () async {
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.topRatedTvSeries + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation) async =>
          http.Response('{"results": [{"original_title": "BreakingBad", "BreakingBad": "Wonka", "media_type": "series"}]}', 200));

      final result = await homeScreenController.getTopRatedTvSeries(client);

      expect(result, isA<List<MediaModel>>());
    });
    test('Error Exception', () {
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.topRatedTvSeries + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation) async =>
          http.Response('Not Found', 404));
      final result = homeScreenController.getTopRatedTvSeries(client);
      expect(result, throwsException);
    });
  });

  group("getSimilarSeries", (){
    var id = 1234;
    test("getSimilarSeries", () async {
      when(client.get(Uri.parse("${ApiEndPoints.baseUrl}/tv/$id/recommendations?${ApiEndPoints.apiKey}")))
          .thenAnswer((realInvocation) async =>
          http.Response('{"results": [{"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}]}', 200));

      final result = await homeScreenController.getSimilarSeries(id, client);

      expect(result, isA<List<MediaModel>>());
    });
    test('Error Exception', () {
      when(client.get(Uri.parse("${ApiEndPoints.baseUrl}/tv/$id/recommendations?${ApiEndPoints.apiKey}")))
          .thenAnswer((realInvocation) async =>
          http.Response('Not Found', 404));
      final result = homeScreenController.getSimilarSeries(id, client);
      expect(result, throwsException);
    });
  });

});

group("ExploreScreenController", () {
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
