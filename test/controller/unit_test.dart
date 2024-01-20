import 'package:flutter_test/flutter_test.dart';
import 'package:mflix/controller/bookmark-screen-controller.dart';
import 'package:http/http.dart' as http;
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/models/media-model.dart';
import 'package:mflix/sql_helper.dart';
import 'package:mflix/utils/api-endpoint.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockDatabaseHelper extends Mock implements SqlDatabaseHelper {}

class MockHttpClient extends Mock implements http.Client {}

@GenerateMocks([http.Client])
void main() {
  late MockHttpClient mockHttpClient;
  late HomeScreenController homeScreenController;

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

  group("HomeScreenController", () {

    setUp(() {
      mockHttpClient = MockHttpClient();
      homeScreenController = HomeScreenController(httpClient: mockHttpClient);
    });

    test('Success - getTrendingMoviesDay', () async {
      // Arrange
      const mockResponse = '{"results": [{"id": 1, "title": "Movie 1"}]}';
      when(mockHttpClient.get(Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.apiPath.trendingMoviesDay + ApiEndPoints.apiKey))).
      thenAnswer((_) async =>
          http.Response(mockResponse, 200));

      // Act
      final result = await homeScreenController.getTrendingMoviesDay(mockHttpClient);

      // Assert
      expect(result, isA<List<MediaModel>>());
      expect(result.length, 1);
    });


  });
}
