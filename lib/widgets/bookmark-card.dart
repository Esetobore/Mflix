import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/bookmark-screen-controller.dart';
import '../utils/api-endpoint.dart';

class BookMarkCard extends StatelessWidget {
  const BookMarkCard({
    super.key,
    required this.moviesListX,
  });

  final Map<String, dynamic> moviesListX;

  @override
  Widget build(BuildContext context) {
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
              bookmarkController.deleteMovie(moviesListX['id']);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Removed From List')),
              );
            },
            icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}