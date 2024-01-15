import 'package:get/get.dart';
import 'package:mflix/sql_helper.dart';

class BookmarkController extends GetxController {
  RxList<Map<String, dynamic>> moviesList = <Map<String, dynamic>>[].obs;

  Future<void> fetchMovies() async {
    List<Map<String, dynamic>> movies = await SqlDatabaseHelper.getMovies();
    moviesList.assignAll(movies);
  }

  void deleteMovie(int docId) async {
    await SqlDatabaseHelper.deleteMovie(docId);
    fetchMovies();
  }

  Future<void> saveToDatabase(String title, String posterPath) async {
    await SqlDatabaseHelper.insertMovie(title, posterPath);
    fetchMovies();
  }

}

final BookmarkController bookmarkController = BookmarkController();
