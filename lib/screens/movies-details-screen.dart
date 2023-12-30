import 'package:flutter/material.dart';
import 'package:mflix/models/movies-model.dart';

class MoviesDetailsScreen extends StatelessWidget {
  const MoviesDetailsScreen(
      {
        super.key,
      required this.movies,
      });

  final MoviesModel movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(movies.title)),
    );
  }
}

