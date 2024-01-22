import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mflix/controller/bookmark-screen-controller.dart';
import 'package:http/http.dart' as http;
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/models/media-model.dart';
import 'package:mflix/sql_helper.dart';
import 'package:mflix/utils/api-endpoint.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'unit_test.mocks.dart';

class MockDatabaseHelper extends GetxController with Mock implements SqlDatabaseHelper {}

@GenerateMocks([http.Client])
void main() {
  group("BookmarkController", () {
    MockDatabaseHelper mockDatabaseHelper = MockDatabaseHelper();
    BookmarkController bookmarkController = BookmarkController(dbHelper: mockDatabaseHelper);

    setUp(() {
      bookmarkController = BookmarkController(dbHelper: mockDatabaseHelper);
    });


    test("Initialize Empty", () {
      expect(bookmarkController.moviesList.length, 0);
    });

    test("Mock AddToDatabase", () async {
      when(mockDatabaseHelper.getMovies()).thenAnswer((_) async => []);

      expect(bookmarkController.moviesList.length, 0);
    });
  });

  test("Trending Movies Day", () async{
      final client = MockClient();
      when(client.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.apiPath.trendingMoviesDay + ApiEndPoints.apiKey)))
          .thenAnswer((realInvocation)
      async => http.Response('"results": {"original_title": "Wonka", "title": "Wonka", "media_type": "movie"}', 200));

      final result = await homeScreenController.getTrendingMoviesDay(client);

      expect(result, isA<MediaModel>());

    });

}
