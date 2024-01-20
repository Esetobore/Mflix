import 'package:get/get.dart';
import 'package:mflix/sql_helper.dart';

class BookmarkController extends GetxController {

  RxList<Map<String, dynamic>> moviesList = <Map<String, dynamic>>[].obs;
  SqlDatabaseHelper dbHelper = SqlDatabaseHelper();

  BookmarkController({required this.dbHelper});

  Future<void> fetchMovies() async {
    List<Map<String, dynamic>> movies = await dbHelper.getMovies();
    moviesList.assignAll(movies);
  }

  void deleteMovie(int docId) async {
    await dbHelper.deleteMovie(docId);
    fetchMovies();
  }

  Future<void> saveToDatabase(String title, String posterPath) async {
    await dbHelper.insertMovie(title, posterPath);
    fetchMovies();
  }

}

final BookmarkController bookmarkController = BookmarkController(dbHelper: SqlDatabaseHelper());
