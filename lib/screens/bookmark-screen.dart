import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mflix/controller/bookmark-screen-controller.dart';
import '../widgets/bookmark-card.dart';

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
                          return BookMarkCard(moviesListX: moviesListX);
                        }),
                  ),
                )
            ],
          )
      ),
    );
  }
}


