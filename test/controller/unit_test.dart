import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/mock/http_request_mock.dart';
import 'package:mflix/controller/bookmark-screen-controller.dart';
import 'package:http/http.dart' as http;
import 'package:mflix/controller/home-screen-controller.dart';
import 'package:mflix/models/media-model.dart';
import 'package:mflix/sql_helper.dart';
import 'package:mflix/utils/api-endpoint.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockDatabaseHelper extends Mock implements SqlDatabaseHelper {}

@GenerateMocks([http.Client])
void main(){

  group("BookmarkController", () {
    MockDatabaseHelper mockDatabaseHelper = MockDatabaseHelper();
    BookmarkController bookmarkController = BookmarkController(dbHelper: mockDatabaseHelper);

    setUp(() => {
      bookmarkController = BookmarkController(dbHelper: mockDatabaseHelper)
    });
    tearDown(() => {
      bookmarkController.dispose()
    });

    test("Initialize Empty", () {
      expect(bookmarkController.moviesList.length, 0);
    });
    // test("Mock AddToDatabase", () async{
    //
    //   when(mockDatabaseHelper.getMovies()).thenAnswer((_) async => []);
    //
    //   expect(bookmarkController.moviesList.length,0);
    //
    // });
  });

  group("HomeScreenController", () {
      test("GetTrendingMoviesDay", () async{
        final client = MockClient((request) async {

          return Response('{"key": "value"}', 200);
        });

        expect(await gettrendingMoviesDay(client), isA<List<MediaModel>>());

      });


  });



}