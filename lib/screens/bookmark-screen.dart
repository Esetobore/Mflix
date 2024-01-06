import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mflix/controller/bookmark-screen-controller.dart';
import '../sql_helper.dart';
import '../utils/api-endpoint.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {

  List<Map<String, dynamic>> moviesList = [];

  @override
  void initState() {
    super.initState();
    bookmarkController.fetchMovies();
  }


  void _deleteMovie(int docId) async {
    await SqlDatabaseHelper.deleteMovie(docId);
    bookmarkController.fetchMovies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Column(
            children: [
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                        itemCount: bookmarkController.moviesList.length,
                        itemBuilder: (context, index) {
                          final moviesListX = bookmarkController.moviesList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 150,
                                  child: Image.network(
                                    "${ApiEndPoints.imagePath}${moviesListX['posterPath']}",
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                                 const SizedBox(width: 20,),
                                 SizedBox(
                                   width: 170,
                                   child: Text("${moviesListX['title']}",
                                     style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontSize: 18,
                                         fontFamily: GoogleFonts.rubik().fontFamily,
                                         color: Theme.of(context).colorScheme.primary),),
                                 ),
                                 IconButton(
                                   onPressed: () {
                                    _deleteMovie(moviesListX['id']);
                                   },
                                   icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary),
                                 ),
                              ],
                            ),
                          );
                        }),
                  ),
                )
            ],
          )
      ),
    );
  }
}
