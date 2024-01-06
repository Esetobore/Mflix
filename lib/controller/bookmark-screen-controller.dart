import 'package:get/get.dart';
import 'package:mflix/sql_helper.dart';

class BookmarkController extends GetxController {
  RxList<Map<String, dynamic>> moviesList = <Map<String, dynamic>>[].obs;

  Future<void> fetchMovies() async {
    List<Map<String, dynamic>> movies = await SqlDatabaseHelper.getMovies();
    moviesList.assignAll(movies);
  }
}

final BookmarkController bookmarkController = BookmarkController();
